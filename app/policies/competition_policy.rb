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
    user && user.organizer
  end

  def update?
    user && record.author == user
  end

  def apply?
    record.registrations_open?
  end

  def destroy?
    record.id && user && record.author == user && record.users.none?
  end
end
