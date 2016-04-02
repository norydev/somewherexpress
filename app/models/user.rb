class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  attr_accessor :current_password

  has_many :subscriptions, dependent: :destroy
  has_many :competitions, through: :subscriptions
  has_many :ranks, dependent: :nullify

  has_many :creations, foreign_key: "author_id", class_name: "Competition", dependent: :nullify

  has_many :badges, dependent: :destroy

  has_one :notification_setting, dependent: :destroy

  validates_presence_of :first_name, :last_name

  after_create :send_welcome_email

  def to_s
    name
  end

  def name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def image
    self.picture || ActionController::Base.helpers.asset_path("default_user_picture.svg")
  end

  def gravatar_url
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}?s=160"
  end

  def avatar
    if use_gravatar
      gravatar_url
    else
      image
    end
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

  def founder_badge
    badges.find_by(name: "Founder")
  end

  def pending_registrations_for_creations
    creations.not_finished.map{ |c| c.subscriptions.where(status: "pending") }.flatten.size
  end

  def self.find_for_facebook_oauth(auth)
    if find_by(provider: auth.provider, uid: auth.uid)
      find_by(provider: auth.provider, uid: auth.uid)
    elsif find_by(email: auth.info.email)
      find_by(email: auth.info.email).send(:update_from_fb, auth)
    else
      User.new.send(:create_from_fb, auth)
    end
  end

  private

    def send_welcome_email
      UserMailer.welcome(self).deliver_now
    end

    def update_from_fb(auth)
      self.provider = auth.provider
      self.uid = auth.uid
      self.token = auth.credentials.token
      self.token_expiry = Time.at(auth.credentials.expires_at)
      self.picture = auth.info.image
      self.save!
      self
    end

    def create_from_fb(auth)
      self.provider = auth.provider
      self.uid = auth.uid
      self.email = auth.info.email
      self.password = Devise.friendly_token[0,20]  # Fake password for validation
      self.first_name = auth.info.first_name
      self.last_name = auth.info.last_name
      self.picture = auth.info.image
      self.girl = auth.extra.raw_info.gender == 'female'
      self.token = auth.credentials.token
      self.token_expiry = Time.at(auth.credentials.expires_at)
      self.save!
      self
    end
end
