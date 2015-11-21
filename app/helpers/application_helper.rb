module ApplicationHelper
  def date_format(date)
    l(date, format: "%d %B %Y") if date
  end

  def datetime_format(datetime)
    l(datetime, format: "%d %B %Y à %H:%M") if datetime
  end

  def datetime_value(datetime)
    datetime.strftime("%Y-%m-%d %H:%M") if datetime
  end
end
