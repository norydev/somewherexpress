# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  picture                :string
#  admin                  :boolean          default(FALSE), not null
#  organizer              :boolean          default(FALSE), not null
#  deleted_at             :datetime
#  old_first_name         :string
#  old_last_name          :string
#  old_email              :string
#  use_gravatar           :boolean          default(FALSE), not null
#  phone_number           :string
#  whatsapp               :boolean          default(FALSE), not null
#  telegram               :boolean          default(FALSE), not null
#  signal                 :boolean          default(FALSE), not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  scope :want_email_for_new_competition, lambda {
    joins(:notification_setting)
      .where(deleted_at: nil)
      .where(notification_settings: { as_user_new_competition: true })
  }

  scope :want_email_for_competition_edited, lambda { |competition|
    joins(:notification_setting, :competitions)
      .where(deleted_at: nil)
      .where(competitions: { id: competition.id })
      .where(notification_settings: { as_user_competition_edited: true })
  }

  scope :with_competitions, lambda {
    where(_exists(Subscription.where("users.id = subscriptions.user_id")))
  }

  scope :hall_of_fame, lambda {
    with_competitions
      .left_outer_joins(:competition_victories, :track_victories, :badges)
      .order("count(competitions) desc, count(tracks) desc, count(badges) desc")
      .group("users.id")
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attr_accessor :current_password

  has_many :subscriptions, dependent: :destroy

  has_many :competitions, through: :subscriptions
  has_many :finished_competitions, -> { finished },
           through: :subscriptions,
           source: :competition

  has_many :first_ranks, -> { where(result: 1) }, class_name: "Rank",
                                                  inverse_of: :user

  has_many :competition_victories, -> { finished },
           through: :first_ranks, source: :race, source_type: "Competition"
  has_many :track_victories, through: :first_ranks, source: :race,
                             source_type: "Track"

  has_many :ranks, dependent: :nullify

  has_many :creations, foreign_key: "author_id", class_name: "Competition",
                       dependent: :nullify, inverse_of: :author

  has_many :badges, dependent: :destroy

  has_one :notification_setting, dependent: :destroy
  accepts_nested_attributes_for :notification_setting

  validates :first_name, :last_name, presence: true

  after_create :set_notifs_and_welcome

  def to_s
    name
  end

  def name
    [first_name, last_name].reject(&:blank?).join(" ")
  end

  def initials
    [first_name.first, last_name.first].reject(&:blank?).join
  end

  def gravatar_url
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=160"
  end

  def image
    picture || "https://api.adorable.io/avatars/240/#{first_name}@adorable.png"
  end

  def avatar
    use_gravatar ? gravatar_url : image
  end

  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    update(deleted_at: Time.current, old_email: email,
           old_first_name: first_name, old_last_name: last_name,
           picture: nil)

    update(first_name: first_name.first, last_name: last_name.first,
           email: "#{Time.current.to_i}#{rand(100)}#{email}")

    UserMailer.goodbye(id).deliver_later
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  def founder_badge
    badges.find_by(name: "Founder")
  end

  def pending_registrations_for_creations
    Subscription.pending
                .where(competition: creations.not_finished)
                .count
  end

  private

    def set_notifs_and_welcome
      NotificationSetting.create!(user: self, locale: I18n.locale || :fr)
      UserMailer.welcome(id).deliver_later
    end
end
