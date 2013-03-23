require 'rvm/capistrano'
require 'bundler/capistrano'

set :rvm_type, :user

set :application, "54.243.30.244"
set :domain, '54.243.30.244'

# Roles
role :web, domain
role :app, domain
role :db,  domain, :primary => true

#deployment details
set :deploy_via, :remote_cache
set :user, "ubuntu"
set :copy_compression, :bz2
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false
set :deploy_to, "/home/ubuntu/teamzoom_pro_set2"

default_run_options[:pty] = true
set :ssh_options, {:forward_agent => true}
set :ssh_options, {:auth_methods => "publickey"}
set :ssh_options, {:keys => ["~/Downloads/teamzoom-1.pem"]}

#repo details
set :scm, :git
set :repository,  "git@github.com:TKVR/teamzoom.git"
set :scm_username, 'TKVR'
set :keep_releases, 2
set :branch, "master"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "service nginx start"
    run "cd #{release_path} && touch tmp/restart.txt"
  end

  after "deploy:start", "deploy:cleanup"

  after 'deploy:cleanup', 'deploy:symlink_config'

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "service nginx stop"
  end

  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "service nginx stop"
  end

  task :reload, :roles => :app, :except => { :no_release => true } do
    run "cd #{release_path} && touch tmp/restart.txt"
    run "service nginx restart"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
  
  task :pipeline_precompile do
    run "cd #{release_path}; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
    # precompile assets before deploy and upload them to server 
    # run_locally("RAILS_ENV=#{rails_env} rake assets:clean && RAILS_ENV=#{rails_env} rake assets:precompile")
    # top.upload "public/assets", "#{release_path}/public/assets", :via =>:scp, :recursive => true
  end
end

before "deploy:assets:precompile", "bundle:install"

# remove old releases
after "deploy", "deploy:cleanup"

after "deploy:update_code", "deploy:pipeline_precompile"