module ApplicationHelper

  def weekday(date)
    if date.wday == 0
      "日"
    elsif date.wday == 1
      "月"
    elsif date.wday == 2
      "火"
    elsif date.wday == 3
      "水"
    elsif date.wday == 4
      "木"
    elsif date.wday == 5
      "金"
    elsif date.wday == 6
      "土"
    end
  end

end
