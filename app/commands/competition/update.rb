# frozen_string_literal: true
class Competition < ApplicationRecord
  class Update < ApplicationCommand
    attr_reader :form, :model

    def call
      set_competition
      authorize @competition, :update?

      @form = Competition::Contract::Update.new(@competition)

      return unless @form.validate(params[:competition])

      @form.save
      @model = @form.model
      send_emails(@model)
    end

    private

      def set_competition
        @competition = Competition.find(params[:id])
      end

      def send_emails(model)
        if model.just_published?
          send_new_competition_emails(model)
        elsif model.published? && !model.finished? && model.enough_changes?
          send_competition_edited_emails(model)
        end
      end

      def send_new_competition_emails(model)
        User.want_email_for_new_competition.each do |user|
          UserMailer.as_user_new_competition(user.id, model.id).deliver_later
        end
      end

      def send_competition_edited_emails(model)
        User.want_email_for_competition_edited(model).each do |user|
          UserMailer.as_user_competition_edited(user.id, model.id).deliver_later
        end
      end
  end
end
