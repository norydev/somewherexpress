# frozen_string_literal: true
module ApplicationHelper
  def date_format(date)
    l(date, format: "%d %B %Y") if date.present?
  end

  def datetime_format(datetime)
    return datetime if datetime.blank? || datetime.is_a?(String)

    case I18n.locale
    when :fr
      l(datetime, format: "%d %B %Y à %H:%M")
    else
      l(datetime, format: "%d %B %Y at %H:%M")
    end
  end

  def datetime_value(datetime)
    return datetime if datetime.blank? || datetime.is_a?(String)

    l(datetime, format: "%Y-%m-%d %H:%M")
  end
end
