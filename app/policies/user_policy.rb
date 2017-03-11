# frozen_string_literal: true
class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:competitions).group("users.id").all
    end
  end

  def show?
    true
  end

  def update?
    user && user == record
  end
end
