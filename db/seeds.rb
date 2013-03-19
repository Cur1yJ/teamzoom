# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

User.delete_all
State.delete_all
Conference.delete_all
School.delete_all
Schedule.delete_all
Sport.delete_all
Subteam.delete_all
Team.delete_all
Teamsport.delete_all
Venue.delete_all
Recording.delete_all

users = [
  {
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
  }
]

users.each do |user|
  User.create(user)
end

schools = ["Terra Nova","Aragon", "Burlingame", "Capuchino", "Carlmont","Crystal Springs Uplands", "El Camino", "Half Moon Bay", "Hillsdale", "Jefferson", "Kings Academy", "Menlo-Atherton","Menlo School", "Mercy", "Mills", "Oceana", "Sacred Heart", "San Mateo", "Sequoia", "South San Francisco", "Westmoor","Woodside","Woodside Priory"]

teams = ["Terra Nova Tigers","Aragon Dons", "Burlingame Panthers", "Capuchino Mustangs","Carlmont Scots","Crystal Springs Uplands Gryphons","El Camino Colts", 
          "Half Moon Bay Cougars", "Hillsdale Knights", "Jefferson Indians", "Kings Academy Knights", "Menlo-Atherton Bears","Menlo School Knights",
          "Mercy Crusaders", "Mills Vikings", "Oceana Sharks", "Sacred Heart Gators", "San Mateo Bearcats", 
          "Sequoia Cherokee", "South San Francisco Warriors", "Westmoor Rams","Woodside Wildcats","Woodside Priory Panthers" ]

mascot = ["Tigers","Dons","Panthers","Mustangs","Scots","Gryphons","Colts","Cougars","Knights","Indians","Knights","Bears","Knights",
         "Crusaders" ,"Vikings","Sharks" ,"Gators","Bearcats","Cherokee","Warriors","Rams","Wildcats","Panthers"]
teams_attrs = {}

other = State.create({
  :name => "Other",
  :address => "other",
  :active => true
})

other_confs = [
  {
    :name => "Other 1",
    :active => true
  },
  {
    :name => "Other 2",
    :active => true
  }
]

other_confs.each do |item|
  other.conferences.create(item)
end

california = State.create({
  :name => "California",
  :active => true
})

cal_confs = [
  {
    :name => "Peninsula Athletic League",
    :active => true
  },
  {
    :name => "California 2",
    :active => true
  }
]

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

cal_confs.each do |item|
  conf = california.conferences.create(item)
  schools_attrs.each do |attr|
    conf.schools.create(attr)
  end
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

venues = [
  {
    :venue => "Terra Nova HS",
    :url => "ec2-54-234-165-115.compute-1.amazonaws.com:1935/vods3/_definst_/"
  },
  {
    :venue => "Inderkum HS",
    :url => "ec2-54-234-165-115.compute-1.amazonaws.com:1935/vods3/_definst_/"
  },
  {
    :venue => "Pioneer HS",
    :url => "ec2-54-234-165-115.compute-1.amazonaws.com:1935/vods3/_definst_/"
  }
]

venues.each do |venue|
  Venue.create(venue)
end 

locations = Venue.all

schedules = [
  {
    :subteam_id => arr_subteam[0].id,
    :opponent_id => arr_subteam[3].id,
    :sport_id => arr_sport[0].id,
    :venue_id => locations[0].id,
    :start_time => DateTime.parse("2013-03-16 16:00:00"),
    :end_time => DateTime.parse("2013-03-16 19:00:00"),
    :event_date => DateTime.parse("2013-03-16")
  },
  {
    :subteam_id => arr_subteam[0].id,
    :opponent_id => arr_subteam[6].id,
    :sport_id => arr_sport[0].id,
    :venue_id => locations[1].id,
    :start_time => DateTime.parse("2013-03-17 12:00:00"),
    :end_time => DateTime.parse("2013-03-17 14:00:00"),
    :event_date => DateTime.parse("2013-03-17")
  },
  {
    :subteam_id => arr_subteam[0].id,
    :opponent_id => arr_subteam[6].id,
    :sport_id => arr_sport[0].id,
    :venue_id => locations[1].id,
    :start_time => DateTime.parse("2013-03-18 12:00:00"),
    :end_time => DateTime.parse("2013-03-18 14:00:00"),
    :event_date => DateTime.parse("2013-03-18")
  },
  {
    :subteam_id => arr_subteam[0].id,
    :opponent_id => arr_subteam[6].id,
    :sport_id => arr_sport[0].id,
    :venue_id => locations[1].id,
    :start_time => DateTime.parse("2013-03-21 12:00:00"),
    :end_time => DateTime.parse("2013-03-21 14:00:00"),
    :event_date => DateTime.parse("2013-03-21")
  }
]

schedules.each do |item|
  schedule = Schedule.create(item)
  Recording.create({
    :schedule_id => schedule.id,
    :stream_name => "6.stream",
    :recording_name => "amazons3/tzarchive/6_02262013_064600.mp4",
    :status => 2
  })
end