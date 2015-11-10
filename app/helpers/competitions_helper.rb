module CompetitionsHelper
  def result(rank)
    if rank.result == 1
      '<span class="trophies"><i class="fa fa-trophy"></i></span>'.html_safe
    elsif rank.dsq
      'DSQ'
    else
      rank.result
    end
  end

  def track_result(rank)
    if rank.result == 1
      image_tag 'medal.svg', class: 'medal'
    else
      rank.result
    end
  end

  def place(rank)
    if rank.dsq
      'DSQ'
    else
      "#{rank.result}<sup>#{rank.result.ordinal}</sup> place".html_safe
    end
  end
end
