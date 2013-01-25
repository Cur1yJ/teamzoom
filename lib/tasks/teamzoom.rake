namespace :db do
  task :bootstrap => [:drop , :create , :migrate ,:seed]
  
  # task :bootstrap => [:reset , :create , :migrate ,:seed]

end
