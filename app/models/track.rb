class Track < ActiveRecord::Base
  belongs_to :competition
  has_many :ranks, as: :race, dependent: :destroy
  accepts_nested_attributes_for :ranks

  has_one :start_city, -> { where order: 'start' }, class_name: 'City', as: :localizable, dependent: :destroy
  has_one :end_city, -> { where order: 'end' }, class_name: 'City', as: :localizable, dependent: :destroy
  accepts_nested_attributes_for :start_city, allow_destroy: true
  accepts_nested_attributes_for :end_city, allow_destroy: true

  after_create :make_track_ranks

  validates_presence_of :start_city, :end_city, :start_time

  def name
    "#{start_city.locality} (#{start_city.country_short}) – #{end_city.locality} (#{end_city.country_short})"
  end

  def to_s
    name
  end

  private

    def make_track_ranks
      competition.accepted_users.each do |user|
        Rank.create!(user: user, race: self)
      end
    end
end
