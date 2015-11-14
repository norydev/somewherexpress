class TrackPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    user && record.competition.author == user
  end

  def destroy?
    user && record.competition.author == user
  end
end
