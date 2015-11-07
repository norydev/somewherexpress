class Competition < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :tracks, dependent: :destroy

  has_many :ranks, as: :race, dependent: :destroy

  def to_s
    name
  end

  def t_ranks
    tracks.map{ |t| t.ranks }.flatten
  end
end
