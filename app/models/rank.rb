class Rank < ActiveRecord::Base
  belongs_to :race, polymorphic: true
  belongs_to :user

  after_save :set_competition_ranks

  private

    def set_competition_ranks
      if self.race.is_a? Track
        c = self.race.competition
        r = Rank.where(race: c, user: self.user).first_or_create
        r.points += self.points
        r.save

        results = Rank.where(race: c).order(points: :desc)
        a = results.map(&:points)
        ranks = a.map{ |e| a.index(e) + 1 }

        results.each_with_index do |r, i|
          r.result = ranks[i]
          r.save
        end
      end
    end

end
