module SubteamsHelper

  # get month/day from string or date
  def month_day_of_date(date)
    d = Date.parse date.to_s
    str = d.month.to_s + "-" + d.day.to_s
    return str
  end
end
