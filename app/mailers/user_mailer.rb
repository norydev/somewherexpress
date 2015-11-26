class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user

    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subject: t('.subject'))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.goodbye.subject
  #
  def goodbye(user)
    @user = user

    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.old_email, subject: t('.subject'))
  end
end
