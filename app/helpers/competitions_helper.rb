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
      "#{rank.result}<sup>#{rank.result.ordinal}</sup> place".html_safe
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
end
