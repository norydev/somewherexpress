class Rank < ActiveRecord::Base
  belongs_to :race, polymorphic: true
  belongs_to :user

  after_save :set_competition_ranks

  private

    def set_competition_ranks
      if self.race.is_a?(Track)
        c = self.race.competition
        c_r = Rank.where(race: c, user: self.user).first_or_create
        c_r.points = c.t_ranks.where(user: self.user).map(&:points).reduce(&:+)
        c_r.save

        if c.multiple_tracks?
          # multi track competition: result according to nb of points
          results = Rank.where(race: c).order(points: :desc)
          a = results.map(&:points)
          ranks = a.map{ |e| a.index(e) + 1 } # ranks with ex-aequo

          results.each_with_index do |r, i|
            r.result = ranks[i]
            r.save
          end
        else
          # mono track competition: result = track result, dsq if dsq in track
          c_r.result = self.result
          c_r.dsq = self.dsq
          c_r.save
        end
      end
    end

end
