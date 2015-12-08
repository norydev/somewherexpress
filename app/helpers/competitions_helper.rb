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
      '<span class="medals"><i class="icomoon icon-medal"></i></span>'.html_safe
    else
      rank.try(:result)
    end
  end

  def place(rank)
    if rank && rank.dsq
      'DSQ'
    elsif rank
      case I18n.locale
      when :fr
        "#{rank.result}<sup>#{rank.result == 1 ? 're' : 'e'}</sup> place".html_safe
      else
        "#{rank.result}<sup>#{rank.result.ordinal}</sup> place".html_safe
      end
    else
      ""
    end
  end

  def ribon(status)
    case status
    when "open"
      "<div class='ribbon-green'>#{t('competitions.open', count: 1)}</div>".html_safe
    when "finished"
      "<div class='ribbon-gray'>#{t('competitions.finished')}</div>".html_safe
    when "closed"
      "<div class='ribbon-blue'>#{t('competitions.closed', count: 1)}</div>".html_safe
    end
  end
end
