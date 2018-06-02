# frozen_string_literal: true
class ApplicationCommand
  include Pundit

  def initialize(params = {})
    @current_user = params[:current_user]
    @params = params.except(:current_user)
  end

  def self.call(options = {})
    new(options).tap(&:call)
  end

  def call
    raise "You need to describe #call in inherited class"
  end

  private

    attr_reader :current_user, :params
end
