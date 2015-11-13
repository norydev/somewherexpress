class CompetitionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(published: true)
    end
  end

  def show?
    true
  end

  def create?
    user.se_committee
  end

  def update?
    record.author == user
  end

  def apply?
    record.registrations_open?
  end
end
