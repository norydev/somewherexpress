class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :competitions, through: :subscriptions
  has_many :ranks, dependent: :destroy

  has_many :creations, foreign_key: "author_id", class_name: "Competition"

  has_many :badges

  validates_presence_of :first_name, :last_name

  def to_s
    name
  end

  def name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def avatar
    self.picture || ActionController::Base.helpers.asset_path("default_user_picture.png")
  end

  def sex
    girl? ? 'female' : 'male'
  end

  def finished_competitions
    competitions.finished
  end
end
