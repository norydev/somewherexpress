# frozen_string_literal: true
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

      if user.persisted?
        NotificationSetting.create!(user: user, locale: params[:locale] || :fr)
        UserMailer.welcome(user.id).deliver_later

        sign_in_and_redirect user, event: :authentication
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end
end
