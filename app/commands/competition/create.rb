# frozen_string_literal: true
class Competition < ApplicationRecord
  class Create < ApplicationCommand
    attr_reader :form, :model

    def call
      authorize Competition, :create?

      @form = Competition::Contract::Create.new(Competition.new(author: current_user))

      return unless @form.validate(params[:competition])

      @form.save
      @model = @form.model
      send_new_competition_emails(@model)
    end

    private

      def send_new_competition_emails(model)
        User.want_email_for_new_competition.each do |user|
          UserMailer.as_user_new_competition(user.id, model.id).deliver_later
        end
      end
  end
end
