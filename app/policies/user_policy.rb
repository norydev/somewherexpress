class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:competitions).uniq.all
    end
  end

  def show?
    true
  end
end
