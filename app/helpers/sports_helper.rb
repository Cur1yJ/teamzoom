module SportsHelper
  
  def get_sport_by_id(sport_id)
    Sport.find(sport_id)
  end
  
  def get_sport_name_by_id(sport_id)
    sport_name = ""
    sport = Sport.find(sport_id)
    if sport
      sport_name = sport.name
    end
    return sport_name
  end

end
