class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user_id)
    @user = User.find(user_id)

    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subject: t('.subject'))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.goodbye.subject
  #
  def goodbye(user_id)
    @user = User.find(user_id)

    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.old_email, subject: t('.subject'))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_competition.subject
  #
  def new_competition(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.competition_edited.subject
  #
  def competition_edited(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.competition_edited.subject
  #
  def new_subscription(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.competition_edited.subject
  #
  def new_to_my(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.competition_edited.subject
  #
  def status_changed(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.competition_edited.subject
  #
  def cancelation(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end
  end
end
