# frozen_string_literal: true
module ApplicationHelper
  def date_format(date)
    l(date, format: "%d %B %Y") if date
  end

  def datetime_format(datetime)
    case I18n.locale
    when :fr
      l(datetime, format: "%d %B %Y à %H:%M") if datetime
    else
      l(datetime, format: "%d %B %Y at %H:%M") if datetime
      end
  end

  def datetime_value(datetime)
    datetime.strftime("%Y-%m-%d %H:%M") if datetime
  end
end
