class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:competitions).uniq.all
    end
  end

  def show?
    true
  end

  def update?
    user && user == record
  end
end
