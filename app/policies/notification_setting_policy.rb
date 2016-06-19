# frozen_string_literal: true
class NotificationSettingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    user && user.notification_setting == record
  end
end
