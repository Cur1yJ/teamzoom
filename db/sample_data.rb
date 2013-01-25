#Sample data
sport_names = ["VOLLEYBALL" , "TENNIS" , "FOOTBALL"]
sport_names.each do |name|
  Sport.create({
               :name => name,
               :description => "123123"
             })
end
