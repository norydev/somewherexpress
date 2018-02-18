# frozen_string_literal: true
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self._exists(scope)
    "EXISTS(#{scope.select(1).to_sql})"
  end

  def self._not_exists(scope)
    "NOT #{_exists(scope)}"
  end
end
