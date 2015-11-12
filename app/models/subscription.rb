class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :competition

  validates_uniqueness_of :user_id, scope: :competition_id, message: "You already applied to this competition"

  after_create :make_track_ranks
  before_destroy :destroy_ranks

  def points
    competition.t_ranks.where(user: user).map(&:points).reduce(:+)
  end

  def result
    competition.ranks.where(user: user).take.try(:result)
  end

  private

    def make_track_ranks
      competition.tracks.each do |track|
        Rank.create!(user: user, race: track)
      end
    end

    def destroy_ranks
      Rank.where(user:user, race: competition).destroy_all

      competition.tracks.each do |track|
        Rank.where(user: user, race: track).destroy_all
      end
    end
end
