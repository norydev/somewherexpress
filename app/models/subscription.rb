# frozen_string_literal: true
# == Schema Information
#
# Table name: subscriptions
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  competition_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :integer          default("pending"), not null
#
# Indexes
#
#  index_subscriptions_on_competition_id  (competition_id)
#  index_subscriptions_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (competition_id => competitions.id)
#  fk_rails_...  (user_id => users.id)
#

class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :competition

  after_update :status_changed
  after_create :make_track_ranks, if: :accepted?
  before_destroy :destroy_ranks

  enum status: { pending: 0, accepted: 1, refused: 2 }

  def name
    "#{user.name} => #{competition.name}"
  end

  def to_s
    name
  end

  def points
    competition.t_ranks.where(user: user).map(&:points).reduce(:+)
  end

  def result
    competition.ranks.find_by(user: user).try(:result)
  end

  private

    def status_changed
      if changes["status"].try(:any?) && changes["status"].last == "accepted"
        make_track_ranks
      elsif changes["status"].try(:any?) && changes["status"].last != "accepted"
        destroy_ranks
      end
    end

    def make_track_ranks
      competition.tracks.each do |track|
        Rank.create!(user: user, race: track)
      end
    end

    def destroy_ranks
      Rank.where(user: user, race: competition).destroy_all

      competition.tracks.each do |track|
        Rank.where(user: user, race: track).destroy_all
      end
    end
end
