# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load rvm's capistrono plugins
require 'rvm/capistrano'

require 'bundler/capistrano'

set :rvm_type, :user

set :user, 'ubuntu'
set :domain, '54.243.30.244'
set :application, "teamzoom_pro"
set :keep_releases, 2 # It keeps on two old releases.

# git repo details
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
set :repository,  "git@github.com:TKVR/teamzoom.git"
set :scm_username, 'TKVR'
set :git_enable_submodules, 1
set :git_shallow_clone, 1
set :branch, 'master'

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`


role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true# 'ec2-23-23-156-118.compute-1.amazonaws.com' This is where Rails migrations will run
# role :db,  "your slave db-server here"

# deply options
default_run_options[:pty] = true
set :ssh_options, {:forward_agent => true}
set :ssh_options, {:auth_methods => "publickey"}
set :ssh_options, {:keys => ["~/Downloads/teamzoom-1.pem"]}
set :deploy_to, "/home/ubuntu/teamzoom_pro_set2"
#set :deploy_via, :remote_cache
set :use_sudo, false

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do
    # run COMMAND="/etc/init.d/nginx restart" invoke SUDO=1
    run "sudo /etc/init.d/nginx restart"
    # exit
  end
  after "deploy:start", "deploy:cleanup"

  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts 'now edit the config file database in #{shared_path}'
  end
  after 'deploy:setup', 'deploy:setup_config'

  desc "Symlink shared resources on each release - not used"
  task :symlink_config, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  
  after 'deploy:finalize_update', 'deploy:symlink_config'

  desc "It helps to seed database with values"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
  task :create_schema do
    run "cd #{current_path}; bundle exec rake db:create RAILS_ENV=#{rails_env} --trace"
  end
end