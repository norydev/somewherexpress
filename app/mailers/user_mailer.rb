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

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_competition.subject
  #
  def new_competition(user, competition)
    @user = user
    @competition = competition
    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.competition_edited.subject
  #
  def competition_edited(user, competition)
    @user = user
    @competition = competition
    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.competition_edited.subject
  #
  def new_subscription(subscription)
    @user = subscription.user
    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.competition_edited.subject
  #
  def new_to_my(subscription)
    @user = subscription.competition.author
    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.competition_edited.subject
  #
  def status_changed(subscription)
    @user = subscription.user
    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.competition_edited.subject
  #
  def cancelation(subscription)
    @user = subscription.competition.author
    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
  end
end
