module ApplicationHelper
  def date_format(date)
    l(date, format: "%d %B %Y") if date
  end
end
