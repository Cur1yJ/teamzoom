# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.creat(name: 'Emanuel', city: cities.first)
User.delete_all
State.delete_all
Conference.delete_all
School.delete_all
Schedule.delete_all
Sport.delete_all
Subteam.delete_all
Team.delete_all
Teamsport.delete_all
#Venue.delete_all
users = [{
             :email => "manager@teamzoom.com",
             :password => "123123",
             :password_confirmation => "123123",
             :role => "Manager",
             :user_type => "Fan"
           },
           {
             :email => "admin@teamzoom.com",
             :password => "123123",
             :password_confirmation => "123123",
             :role => "Admin",
             :user_type => "Fan"
           }]
users.each do |user|
  User.create(user)
end


schools = ["Terra Nova","Aragon", "Burlingame", "Capuchino", "Carlmont","Crystal Springs Uplands", "El Camino", "Half Moon Bay", "Hillsdale", "Jefferson", "Kings Academy", "Menlo-Atherton","Menlo School", "Mercy", "Mills", "Oceana", "Sacred Heart", "San Mateo", "Sequoia", "South San Francisco", "Westmoor","Woodside","Woodside Priory"]

teams = ["Terra Nova Tigers","Aragon Dons", "Burlingame Panthers", "Capuchino Mustangs","Carlmont Scots","Crystal Springs Uplands Gryphons","El Camino Colts", 
          "Half Moon Bay Cougars", "Hillsdale Knights", "Jefferson Indians", "Kings Academy Knights", "Menlo-Atherton Bears","Menlo School Knights",
          "Mercy Crusaders", "Mills Vikings", "Oceana Sharks", "Sacred Heart Gators", "San Mateo Bearcats", 
          "Sequoia Cherokee", "South San Francisco Warriors", "Westmoor Rams","Woodside Wildcats","Woodside Priory Panthers" ]

mascot =["Tigers","Dons","Panthers","Mustangs","Scots","Gryphons","Colts","Cougars","Knights","Indians","Knights","Bears","Knights",
         "Crusaders" ,"Vikings","Sharks" ,"Gators","Bearcats","Cherokee","Warriors","Rams","Wildcats","Panthers"]
teams_attrs = {}

State.create({
              :name => "Other",
              :address => "other",
              :active => true
})
state = State.create({
            :name => "California",
            :active => true
})

conference = state.conferences.create({
            :name => "Peninsula Athletic League",
            :active => true
})

Conference.create(:name => "Other", :active => true)
schools_attrs = schools.map.with_index do |name, i|  
 {
  :name => name,
  :address => Faker::Address.city,
  :teams_attributes =>
    {
      "475846845_#{i}" =>
      {
        :name => teams[i],
        :mascot => mascot[i],
        :subdomain => "www.teamzooms.com"
      }
    }
 }
end

schools_attrs.each do |attr|
  conference.schools.create(attr)
end


sport_names = ["Football","Volleyball","Tennis"]
sport_names.each do |name|
  Sport.create({
               :name => name,
               :description => "123123",
               :active => true
             })
end


arr_team = Team.all
Sport.all.map do |sport|
  arr_team.map do |team| 
    Teamsport.create(:sport_id => sport.id, :team_id => team.id)
  end 
end 
#Teamsport.create(:sport_id => Sport.first.id, :team_id => arr_team[1].id)
#Teamsport.create(:sport_id => Sport.first.id, :team_id => arr_team[2].id)
#Teamsport.create(:sport_id => Sport.first.id, :team_id => arr_team[3].id)

teamsports = Teamsport.all 
subteams = [
  {:name => "Soph" , :team_id => arr_team[0].id, :teamsport_id => teamsports[0].id},
  {:name => "Varsity" , :team_id => arr_team[0].id , :teamsport_id => teamsports[0].id},
  {:name => "Frosh" , :team_id => arr_team[0].id , :teamsport_id => teamsports[0].id},

  {:name => "Team Scrimmage" , :team_id => arr_team[1].id, :teamsport_id => teamsports[1].id},
  {:name => "Saint Ignatius" , :team_id => arr_team[1].id, :teamsport_id => teamsports[1].id},
  {:name => "Sacred Heart Cathedral" , :team_id => arr_team[1].id, :teamsport_id => teamsports[1].id},

  {:name => "Pioneer" , :team_id => arr_team[2].id, :teamsport_id => teamsports[2].id},
  {:name => "Salinas" , :team_id => arr_team[2].id, :teamsport_id => teamsports[2].id},
  {:name => "Palo Alto" , :team_id => arr_team[2].id, :teamsport_id => teamsports[2].id},

  {:name => "Inderkum" , :team_id => arr_team[3].id, :teamsport_id => teamsports[0].id},
  {:name => "Santa Teresa" , :team_id => arr_team[3].id, :teamsport_id => teamsports[0].id},
  {:name => "Sacred Heart Prep" , :team_id => arr_team[3].id, :teamsport_id => teamsports[0].id},

  {:name => "Burlingame" , :team_id => arr_team[4].id, :teamsport_id => teamsports[1].id},
  {:name => "Menlo Atherton" , :team_id => arr_team[4].id, :teamsport_id => teamsports[1].id},
  {:name => "Hillsdale" , :team_id => arr_team[4].id, :teamsport_id => teamsports[1].id}

]
subteams.each do |item|
  Subteam.create(item)
end


arr_subteam = Subteam.all
arr_sport = Sport.all

venues = ["Terra Nova HS", "Inderkum HS", "Pioneer HS"]
venues.each do |name|
  Venue.create(:venue => name)
end 

locations = Venue.all

schedule = [
  {
    :subteam_id => arr_subteam[0].id,
    :opponent_id => arr_subteam[3].id,
    :sport_id => arr_sport[0].id,
    :venue_id => locations[0].id,
    :time => "4:00 pm",
    :event_date => "2012-08-10"
  },
  {
    :subteam_id => arr_subteam[0].id,
    :opponent_id => arr_subteam[6].id,
    :sport_id => arr_sport[0].id,
    :venue_id => locations[1].id,
    :time => "5:00 pm",
    :event_date => "2012-08-11"
  },
  {
    :subteam_id => arr_subteam[0].id,
    :opponent_id => arr_subteam[5].id,
    :sport_id => arr_sport[1].id,
    :venue_id => locations[2].id,
    :time => "5:00 pm",
    :event_date => "2012-08-12"
  },
  {
    :subteam_id => arr_subteam[1].id,
    :opponent_id => arr_subteam[4].id,
    :sport_id => arr_sport[1].id,
    :venue_id => locations[0].id,
    :time => "5:00 pm",
    :event_date => "2012-08-20"
  },
  {
    :subteam_id => arr_subteam[1].id,
    :opponent_id => arr_subteam[5].id,
    :sport_id => arr_sport[1].id,
    :venue_id => locations[1].id,
    :time => "5:00 pm",
    :event_date => "2012-08-22"
  },

  {
    :subteam_id => arr_subteam[1].id,
    :opponent_id => arr_subteam[4].id,
    :sport_id => arr_sport[0].id,
    :venue_id => locations[2].id,
    :time => Time.now,
    :event_date => Time.now
  },
  {
    :subteam_id => arr_subteam[0].id,
    :opponent_id => arr_subteam[3].id,
    :sport_id => arr_sport[0].id,
    :venue_id => locations[2].id,
    :time => "4:00 pm",
    :event_date => "2012-08-10"
  },
  {
    :subteam_id => arr_subteam[0].id,
    :opponent_id => arr_subteam[6].id,
    :sport_id => arr_sport[0].id,
    :venue_id => locations[1].id,
    :time => "5:00 pm",
    :event_date => "2012-08-11"
  },
  {
    :subteam_id => arr_subteam[0].id,
    :opponent_id => arr_subteam[5].id,
    :sport_id => arr_sport[1].id,
    :venue_id => locations[0].id,
    :time => "5:00 pm",
    :event_date => "2012-08-12"
  },
  {
    :subteam_id => arr_subteam[1].id,
    :opponent_id => arr_subteam[4].id,
    :sport_id => arr_sport[1].id,
    :venue_id => locations[1].id,
    :time => "5:00 pm",
    :event_date => "2012-08-20"
  },
  {
    :subteam_id => arr_subteam[1].id,
    :opponent_id => arr_subteam[5].id,
    :sport_id => arr_sport[1].id,
    :venue_id => locations[2].id,
    :time => "5:00 pm",
    :event_date => "2012-08-22"
  },

  {
    :subteam_id => arr_subteam[1].id,
    :opponent_id => arr_subteam[4].id,
    :sport_id => arr_sport[0].id,
    :venue_id => locations[1].id,
    :time => "4:00 pm",
    :event_date => "2012-08-25"
  },
  {
    :subteam_id => arr_subteam[1].id,
    :opponent_id => arr_subteam[7].id,
    :sport_id => arr_sport[0].id,
    :venue_id => locations[2].id,
    :time => "5:00 pm",
    :event_date => "2012-08-01"
  },
  {
    :subteam_id => arr_subteam[2].id,
    :opponent_id => arr_subteam[6].id,
    :sport_id => arr_sport[1].id,
    :venue_id => locations[1].id,
    :time => "5:00 pm",
    :event_date => "2012-08-02"
  },
  {
    :subteam_id => arr_subteam[3].id,
    :opponent_id => arr_subteam[1].id,
    :sport_id => arr_sport[1].id,
    :venue_id => locations[2].id,
    :time => "5:00 pm",
    :event_date => "2012-08-03"
  },
  {
    :subteam_id => arr_subteam[3].id,
    :opponent_id => arr_subteam[0].id,
    :sport_id => arr_sport[1].id,
    :venue_id => locations[1].id,
    :time => "5:00 pm",
    :event_date => "2012-08-08"
  }
]

#schedule.each do |item|
 # Schedule.create(item)
#end

