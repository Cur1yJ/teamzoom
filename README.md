[TeamZoom](https://teamzoom-stg.herokuapp.com/)
by Ryan Kruizenga & Michael Lungo

----
Co-Founder, Chief Technology Officer, & Architect: Michael Lungo [Cur1yJ](https://Cur1yJ.com/)
 <mike@michaellungo.com>

Requirements:

    ruby 1.9.3
    rvm
	bundler
	homebrew
    rails 3.2.13
	amazon ec2/s3 instances
	wowza media services
	capistrano
	therubyracer
    devise
    cancan
    postgresql (pg)
    simple_form
	nested_form
	activemerchant
	will_paginate
	event_calendar
	watu_table_builder
	paperclip
	aws-sdk
	remotipart
	validates_timeliness
	client_side_validations
    twitter-bootstrap


Repository Notes:

  Add this to your `~/.gitconfig` file

    [branch]
      autosetuprebase = always


  Standard working procedure:

  1. Always maintain fresh copy of `master`

    git fetch origin


  2. Create a new branch per (features/chores/bugs)

    git branch features/<feature_name>
    git checkout features/<feature_name>

  3. On Commit messages

    Always add the PivotalTracker Story ID in the commit message [#ID]
    $ git commit -m "This is my update [#41703835]"

  4. Push the `feature` branch to github

    git push origin features/<feature_name>

  5. Login to github, and make a `pull request` from the repository to
     master

  6. If the merge will be automatically merge with out issues, confirm
     the merge

  7. If the merge will not do clean merge, checkout the repository to
     local machine and do a merge and push it directly to master


Deployment using `capistrano`

  `live` is the main branch for deployment

    git checkout live
    git merge master
    git push origin live
    git checkout master
    cap deploy

  If there's a new migration

    cap production deploy:migrate
    cap production deploy:restart

Setup local development

    # Installing the requirements
	
	# RVM & Gemset
	$ rvm get head && rvm reload
	$ rvm install 1.9.3
	$ rvm use ruby-1.9.3-p327@teamzoom --create

    # Tunnels for SSL redirects to HTTP(80)
    $ rvm reload
    $ gem install tunnels --no-ri --no-rdoc

    # RMagick
	$ brew update
	$ brew upgrade
	$ brew doctor
    $ brew remove imagemagick
    $ brew install imagemagick --disable-openmp
    $ cd /usr/local/Cellar/imagemagick/<latest_version>/lib
    $ ln -s libMagick++-Q16.7.dylib   libMagick++.dylib
    $ ln -s libMagickCore-Q16.7.dylib libMagickCore.dylib
    $ ln -s libMagickWand-Q16.7.dylib libMagickWand.dylib
    $ gem install rmagick --no-ri --no-rdoc

    $ cp config/examples/app_config.yml config/
    $ cp config/examples/database.yml config/
    $ bundle install
    $ rake db:create
    $ rake db:migrate
    $ rake db:seed
    $ rake db:seed:trunklines    

    
Tasks Overview:

###### local database
We recommend using PG for your local database because that is what [Heroku](http://heroku.com) uses, but due to the flexibility of [Rails](http://rubyonrails.org) database configurations, a [SQLite](http://sqlite.org), [MySQL](http://mysql.com) or other database would work as well. If you are using a [Postgres](http://postgresql.com) database, your config/database.yml file might look something like this:

		development:
		  adapter: postgresql
		  host: localhost
		  database: teamzoom_dev
		  port: 5432
		  pool: 5
		  timeout: 5000

		production:
		  <<: *login
		  database: teamzoom_pro
		
		test:
		  <<: *login
		  database: teamzoom_test

For initial installation, a suggested method of loading the database schema is to do it directly instead of running through all the migrations which have different revisions over time. To create the database and load the schema in a single step, use this command:

	rake db:create db:schema:load
	
Alternatively, you could directly import the most recent SQL file located in db/dumps directly to the database using a GUI such as [Navicat](http://navicat.com)
	
###### authentication/roles
The gem [CanCan](github.com/ryanb/cancan) built by Ryan Bates controls our permissions and user authorization. User roles are defined in the models/user.rb file. In the backend these roles are stored as integers, higher numbers representing higher roles (with Admin role being the highest). It is very important to maintain the data abstraction here so that adding more roles in the future is easy and there are no conflicts in storage and representation of roles.
	
###### staging & production server
We are using Heroku to deploy to our [staging environment](http://teamzoom-stg.herokuapp.com/), and [Amazon EC2](aws.amazon.com/ec2) to deploy to our production environment. The Heroku platform uses a Postgres database. EC2 has an instance for Posgres, Wowza, & Rails. We deploy to production with [Capistrano](https://github.com/capistrano/capistrano/wiki). This required heavy customization in our config/deploy.rb script file. We are in the process of writing custom deploy scripts to each environment.
	
###### testing
Tests are written with [RSpec](http://rspec.info/) and model objects are easily built using [FactoryGirl](http://github.com/thoughtbot/factory_girl).

###### seed

	rake db:seed:trunklines # import new seeded trunklines from YAML file
