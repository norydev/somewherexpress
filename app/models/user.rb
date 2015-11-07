class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :competitions, through: :subscriptions
  has_many :ranks, dependent: :destroy

  def name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def avatar
    self.picture || ActionController::Base.helpers.asset_path("default_user_picture.svg")
  end
end
