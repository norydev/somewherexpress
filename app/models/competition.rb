# frozen_string_literal: true
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
#  video                       :string
#  start_city_id               :integer
#  end_city_id                 :integer
#  default_registration_status :integer          default("pending"), not null
#
# Indexes
#
#  index_competitions_on_start_city_id_and_end_city_id  (start_city_id,end_city_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (end_city_id => cities.id)
#  fk_rails_...  (start_city_id => cities.id)
#

class Competition < ApplicationRecord
  scope :published, -> { where(published: true) }
  scope :finished, -> { where(finished: true).order(start_date: :desc) }
  scope :not_finished, -> { where(finished: false).order(:start_date) }

  has_many :subscriptions, dependent: :destroy
  has_many :pending_subscriptions, -> { pending.order(:created_at) },
           class_name: "Subscription", inverse_of: :competition
  has_many :users, through: :subscriptions
  has_many :accepted_users, -> { merge(Subscription.accepted) },
           through: :subscriptions,
           source: :user
  has_many :pending_users, -> { merge(Subscription.pending) },
           through: :subscriptions,
           source: :user
  has_many :refused_users, -> { merge(Subscription.refused) },
           through: :subscriptions,
           source: :user

  has_many :tracks, -> { order :start_time }, dependent: :destroy,
                                              inverse_of: :competition

  has_many :ranks, as: :race, dependent: :destroy, inverse_of: :race
  has_many :t_ranks, through: :tracks, source: :ranks

  belongs_to :start_city, class_name: "City", foreign_key: "start_city_id",
                          inverse_of: :start_of_competitions
  belongs_to :end_city, class_name: "City", foreign_key: "end_city_id",
                        inverse_of: :end_of_competitions

  has_many :tracks_start_cities, through: :tracks, source: :start_city
  has_many :tracks_end_cities, through: :tracks, source: :end_city

  belongs_to :author, class_name: "User", inverse_of: :creations

  enum default_registration_status: { pending: 0, accepted: 1 },
       _prefix: :default

  def to_s
    name
  end

  def locations
    "#{start_city.locality} (#{start_city.country_short}) – #{end_city.locality} (#{end_city.country_short})"
  end

  def route
    rte = "#{start_city.locality} (#{start_city.country_short}) – "
    tracks.sort_by(&:start_time).each do |t|
      next if t.end_city.locality == end_city.locality
      rte += "#{t.end_city.locality} (#{t.end_city.country_short}) – "
    end
    rte += "#{end_city.locality} (#{end_city.country_short})"
  end

  def multiple_tracks?
    tracks.size > 1
  end

  def just_published?
    previous_changes["published"]&.last
  end

  def enough_changes?
    previous_changes.except("created_at", "updated_at", "finished", "published",
                            "start_registration", "end_registration", "author_id",
                            "default_registration_status").present?
  end

  def registrations_open?
    return false if finished || start_registration.blank?

    if end_registration
      Time.current.between?(start_registration, end_registration)
    elsif start_date
      Time.current.between?(start_registration, start_date - 1.day)
    else
      false
    end
  end

  def after_registrations?
    if start_registration && end_registration
      Time.current > end_registration && Time.current < start_date
    else
      false
    end
  end

  def before_registrations?
    if start_registration
      Time.current < start_registration
    else
      false
    end
  end

  def status
    return :finished if finished
    return :open if registrations_open?
    :closed
  end

  def self.open_for_registration
    all.select(&:registrations_open?)
  end

  def self.not_open_for_registration
    all.reject(&:registrations_open?)
  end

  def ical_event
    require "icalendar"

    cal = Icalendar::Calendar.new

    cal.event do |e|
      e.dtstart     = Icalendar::Values::Date.new(start_date)
      e.dtend       = Icalendar::Values::Date.new(end_date)
      e.summary     = name
      e.location    = "#{start_city.locality} (#{start_city.country_short})"
      e.description = "#{name}\n#{route}\n\n#{description}"
      e.url         = "https://www.somewherexpress.com/competitions/#{id}"
      e.status      = "CONFIRMED"
    end

    cal.to_ical
  end
end
