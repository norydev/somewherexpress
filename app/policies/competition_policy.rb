# frozen_string_literal: true
class CompetitionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(published: true)
    end
  end

  def show?
    true
  end

  def event?
    s = Subscription.find_by(competition: record, user: user)
    s && s.status == "accepted"
  end

  def create?
    user && (user.organizer || user.admin)
  end

  def update?
    user && (record.author == user || user.admin)
  end

  def apply?
    record.registrations_open?
  end

  def destroy?
    record.id && user && record.author == user && record.users.none?
  end
end
