module CompetitionsHelper
  def result(rank)
    if rank.try(:result) == 1
      '<span class="trophies"><i class="fa fa-trophy"></i></span>'.html_safe
    elsif rank.try(:dsq)
      'DSQ'
    else
      rank.try(:result)
    end
  end

  def track_result(rank)
    if rank.try(:result) == 1
      image_tag 'medal.svg', class: 'medal'
    else
      rank.try(:result)
    end
  end

  def place(rank)
    if rank && rank.dsq
      'DSQ'
    elsif rank
      "#{rank.result}<sup>#{rank.result == 1 ? 're' : 'e'}</sup> place".html_safe
    else
      ""
    end
  end

  def ribon(status)
    case status
    when "open"
      "<div class='ribbon-green'>#{t('open')}</div>".html_safe
    when "finished"
      "<div class='ribbon-gray'>#{t('finished')}</div>".html_safe
    when "closed"
      "<div class='ribbon-blue'>#{t('closed')}</div>".html_safe
    end
  end

  def registrations(competition)
    if competition.registrations_open?
      "<div class='panel-footer text-uppercase small text-center'>#{t('competitions.registrations.end', time: distance_of_time_in_words(competition.end_registration || (competition.start_date - 1), Time.now))}:<br> #{(datetime_format(competition.end_registration) || datetime_format(competition.start_date - 1))}</div>".html_safe
    elsif !competition.registrations_open? && !competition.finished
      "<div class='panel-footer text-uppercase small text-center'>#{t('competitions.registrations.start', time: distance_of_time_in_words(competition.start_registration, Time.now))}:<br>#{datetime_format(competition.start_registration)}</div>".html_safe
    end
  end
end
