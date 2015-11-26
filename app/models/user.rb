class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :competitions, through: :subscriptions
  has_many :ranks, dependent: :nullify

  has_many :creations, foreign_key: "author_id", class_name: "Competition", dependent: :nullify

  has_many :badges, dependent: :destroy

  validates_presence_of :first_name, :last_name

  after_create :send_welcome_email

  def to_s
    name
  end

  def name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def avatar
    self.picture || ActionController::Base.helpers.asset_path("default_user_picture.svg")
  end

  def sex
    girl? ? 'female' : 'male'
  end

  def finished_competitions
    competitions.finished
  end

  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    update_attributes(deleted_at: Time.current, old_email: email, old_first_name: first_name, old_last_name: last_name, picture: nil)
    update_attributes(first_name: first_name.first, last_name: last_name.first, email: "#{Time.now.to_i}#{rand(100)}#{email}")
    UserMailer.goodbye(self).deliver_now
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  private

    def send_welcome_email
      UserMailer.welcome(self).deliver_now
    end
end
