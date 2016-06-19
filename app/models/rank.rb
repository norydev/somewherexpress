# frozen_string_literal: true
# == Schema Information
#
# Table name: ranks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  result     :integer          default(0)
#  points     :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  race_id    :integer
#  race_type  :string
#  dsq        :boolean          default(FALSE), not null
#

class Rank < ActiveRecord::Base
  belongs_to :race, polymorphic: true
  belongs_to :user

  after_save :set_competition_ranks

  validates :user, :race, presence: true

  private

    def set_competition_ranks
      if race.is_a?(Track)
        c = race.competition
        c_r = Rank.where(race: c, user: user).first_or_create
        c_r.points = c.t_ranks.where(user: user).map(&:points).reduce(&:+)
        c_r.save

        if c.multiple_tracks?
          # multi track competition: result according to nb of points
          results = Rank.where(race: c).order(points: :desc)
          a = results.map(&:points)
          ranks = a.map { |e| a.index(e) + 1 } # ranks with ex-aequo

          results.each_with_index do |r, i|
            r.result = ranks[i]
            r.save
          end
        else
          # mono track competition: result = track result, dsq if dsq in track
          c_r.result = result
          c_r.dsq = dsq
          c_r.save
        end
      end
    end
end
