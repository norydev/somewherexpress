# == Schema Information
#
# Table name: competitions
#
#  id                          :integer          not null, primary key
#  name                        :string
#  start_date                  :date
#  end_date                    :date
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  finished                    :boolean          default(FALSE), not null
#  published                   :boolean          default(FALSE), not null
#  start_registration          :datetime
#  end_registration            :datetime
#  author_id                   :integer
#  description                 :text
#  default_registration_status :string           default("pending"), not null
#  video                       :string
#

class Competition < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :tracks, dependent: :destroy
  accepts_nested_attributes_for :tracks, allow_destroy: true

  has_many :ranks, as: :race, dependent: :destroy

  belongs_to :start_city, class_name: "City", foreign_key: "start_city_id"
  belongs_to :end_city, class_name: "City", foreign_key: "end_city_id"

  has_many :tracks_start_cities, through: :tracks, source: :start_city
  has_many :tracks_end_cities, through: :tracks, source: :end_city

  accepts_nested_attributes_for :start_city
  accepts_nested_attributes_for :end_city

  belongs_to :author, class_name: "User"

  validates_presence_of :name
  validates_presence_of :start_registration, :start_city, :end_city, :start_date, :end_date, if: :published?

  # status can take: "pending" (default), "accepted", "refused"

  def to_s
    name
  end

  def locations
    "#{start_city.locality} (#{start_city.country_short}) – #{end_city.locality} (#{end_city.country_short})"
  end

  def route
    rte = "#{start_city.locality} (#{start_city.country_short}) – "
    tracks.includes(:end_city).order(:start_time).each do |t|
      unless t.end_city.name == end_city.name
        rte += "#{t.end_city.locality} (#{t.end_city.country_short}) – "
      end
    end
    rte += "#{end_city.locality} (#{end_city.country_short})"
  end

  def multiple_tracks?
    # order to eliminate tracks with no id (used for competition form)
    self.tracks.order(:start_time).size > 1
  end

  def just_published?
    previous_changes["published"] && previous_changes["published"].last
  end

  def t_ranks
    Rank.where(race_id: self.tracks.pluck(:id), race_type: "Track")
  end

  def registrations_open?
    if !finished && start_registration && end_registration
      Time.now.between?(start_registration, end_registration)
    elsif !finished && start_registration
      Time.now.between?(start_registration, start_date - 1)
    else
      false
    end
  end

  def after_registrations?
    if start_registration && end_registration
      Time.now > end_registration && Time.now < start_date
    else
      false
    end
  end

  def before_registrations?
    if start_registration
      Time.now < start_registration
    else
      false
    end
  end

  def accepted_users
    users.includes(:subscriptions).where("subscriptions.status = 'accepted'")
  end

  def pending_users
    users.includes(:subscriptions).where("subscriptions.status = 'pending'")
  end

  def refused_users
    users.includes(:subscriptions).where("subscriptions.status = 'refused'")
  end

  def self.open_for_registration
    self.where(finished: false).order(:start_date).select { |c| c.registrations_open? }
  end

  def self.not_open_for_registration
    self.where(finished: false).order(:start_date).reject { |c| c.registrations_open? }
  end

  def self.finished
    self.where(finished: true).order(start_date: :desc)
  end

  def self.not_finished
    self.where(finished: false).order(:start_date)
  end

  def ical_event
    require 'icalendar'

    cal = Icalendar::Calendar.new

    cal.event do |e|
      e.dtstart     = Icalendar::Values::Date.new(start_date)
      e.dtend       = Icalendar::Values::Date.new(end_date)
      e.summary     = name
      e.location    = "#{start_city.locality} (#{start_city.country_short})"
      e.description = "#{name}\n#{route}\n\n#{description}"
      e.url         = "https://www.somewherexpress.com/competitions/#{id}"
      e.organizer   = Icalendar::Values::CalAddress.new("mailto:#{author.email}", cn: author.name)
      accepted_users.map do |user|
        e.append_attendee Icalendar::Values::CalAddress.new("mailto:#{user.email}", cn: user.name, partstat: "ACCEPTED")
      end
      e.status      = "CONFIRMED"
    end

    cal.to_ical
  end
end
