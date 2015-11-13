class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    record.competition.registrations_open?
  end

  def destroy?
    record.competition.registrations_open?
  end
end
