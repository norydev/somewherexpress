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

  def goodbye(user_id)
    @user = User.find(user_id)

    mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.old_email, subject: t('.subject'))
  end

  def as_user_new_competition(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end
  end

  def as_user_competition_edited(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end

  end

  def new_subscription(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end
  end

  def as_author_new_subscription(participant_id, competition_id, author_id)
    @user = User.find(author_id)
    @participant = User.find(participant_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end
  end

  def status_changed(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end
  end

  def cancelation(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(from: "SomewherExpress <info@somewherexpress.com>", to: @user.email, subjet: t('.subject'))
    end
  end
end
