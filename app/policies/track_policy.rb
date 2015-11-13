class TrackPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    record.competition.author == user
  end

  def destroy?
    record.competition.author == user
  end
end
