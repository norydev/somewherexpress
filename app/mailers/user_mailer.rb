class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user_id)
    @user = User.find(user_id)

    mail(to: @user.email, subject: t('.subject'))
  end

  def goodbye(user_id)
    @user = User.find(user_id)

    mail(to: @user.old_email, subject: t('.subject'))
  end

  def as_user_new_competition(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(to: @user.email, subjet: t('.subject'))
    end
  end

  def as_user_competition_edited(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(to: @user.email, subjet: t('.subject'))
    end

  end

  def as_user_new_subscription(user_id, competition_id)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)
    @status = @competition.default_registration_status

    if @status == "accepted"
      attachments["#{@competition.name}.ics"] = { mime_type: 'text/calendar',
                                                  content: ical_event.to_ical }
    end

    I18n.with_locale(@user.notification_setting.locale) do
      mail(to: @user.email, subjet: t('.subject'))
    end
  end

  def as_user_subscription_status_changed(user_id, competition_id, status)
    @user = User.find(user_id)
    @competition = Competition.find(competition_id)
    @status = status

    if status == "accepted"
      attachments["#{@competition.name}.ics"] = { mime_type: 'text/calendar',
                                                  content: ical_event.to_ical }
    end

    I18n.with_locale(@user.notification_setting.locale) do
      mail(to: @user.email, subjet: t('.subject'))
    end
  end

  def as_author_new_subscription(participant_id, competition_id, author_id)
    @user = User.find(author_id)
    @participant = User.find(participant_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(to: @user.email, subjet: t('.subject'))
    end
  end

  def as_author_cancelation(participant_id, competition_id, author_id)
    @user = User.find(author_id)
    @participant = User.find(participant_id)
    @competition = Competition.find(competition_id)

    I18n.with_locale(@user.notification_setting.locale) do
      mail(to: @user.email, subjet: t('.subject'))
    end
  end

  private

    def ical_event
      require 'icalendar'

      cal = Icalendar::Calendar.new

      cal.event do |e|
        e.dtstart     = Icalendar::Values::Date.new(@competition.start_date)
        e.dtend       = Icalendar::Values::Date.new(@competition.end_date)
        e.summary     = @competition.name
        e.location    = "#{@competition.start_city.locality} (#{@competition.start_city.country_short})"
        e.description = @competition.description
        e.url         = "https://www.somewherexpress.com/competitions/#{@competition.id}"
        e.organizer   = Icalendar::Values::CalAddress.new("mailto:#{@competition.author.email}", cn: @competition.author.name)
        @competition.accepted_users.map do |user|
          e.append_attendee Icalendar::Values::CalAddress.new("mailto:#{user.email}", cn: user.name, partstat: "ACCEPTED")
        end
      end

      cal
    end
end
