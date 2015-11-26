class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    @greeting = "Hi"

    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subject: t('.subject'))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.goodbye.subject
  #
  def goodbye
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
