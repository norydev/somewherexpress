class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :competition

  def points
    competition.t_ranks.select {|rank| rank.user == user}.map { |r| r.points }.reduce(:+)
  end

  def result
    competition.ranks.where(user: user).take.result
  end
end
