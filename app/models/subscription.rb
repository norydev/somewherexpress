class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :competition

  validates_uniqueness_of :user_id, scope: :competition_id, message: "You already applied to this competition"
  validates_presence_of :user, :competition
  validates_acceptance_of :rules, on: :create, allow_nil: false

  after_update :status_changed
  after_create :make_track_ranks, if: :default_accepted
  before_destroy :destroy_ranks

  def points
    competition.t_ranks.where(user: user).map(&:points).reduce(:+)
  end

  def result
    competition.ranks.find_by(user: user).try(:result)
  end

  private

    def default_accepted
      competition.default_registration_status == "accepted"
    end

    def status_changed
      puts changes['status']
      if changes['status'].any? && changes['status'].last == "accepted"
        make_track_ranks
      elsif changes['status'].any? && changes['status'].last != "accepted"
        destroy_ranks
      end
    end

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
