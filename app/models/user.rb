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
end
