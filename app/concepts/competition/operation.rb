# frozen_string_literal: true
class Competition < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model
    model Competition, :create

    contract Contract::Create

    def process(params)
      validate(params[:competition], &:save)
    end

    def process(params)
      validate(params[:competition]) do |f|
        f.save

        send_new_competition_emails if model.published?
      end
    end

    private

      def setup_model!(params)
        model.author = params[:current_user]
      end

      def send_new_competition_emails
        User.want_email_for_new_competition.each do |user|
          UserMailer.as_user_new_competition(user.id, model.id).deliver_later
        end
      end
  end

  class Update < Create
    action :update
    contract Contract::Update

    def process(params)
      validate(params[:competition]) do |f|
        f.save

        if model.just_published?
          send_new_competition_emails
        elsif model.published? && !model.finished? && model.enough_changes?
          send_competition_edited_emails
        end
      end
    end

    private

      def send_competition_edited_emails
        User.want_email_for_competition_edited(model).each do |user|
          UserMailer.as_user_competition_edited(user.id, model.id).deliver_later
        end
      end
  end
end
