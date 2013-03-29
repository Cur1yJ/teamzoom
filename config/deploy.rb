# On-working new/alternative deploy.rb file:

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
set :deploy_to, "/home/ubuntu/teamzoom_pro_set3"

default_run_options[:pty] = true
set :ssh_options, {:forward_agent => true}
set :ssh_options, {:auth_methods => "publickey"}
set :ssh_options, {:keys => ["~/sites/teamzoom/config/teamzoom-1.pem"]}

#repo details
set :scm, :git
set :repository,  "git@github.com:TKVR/teamzoom.git"
set :scm_username, 'TKVR'
set :keep_releases, 2
set :branch, "master"

after 'deploy:update_code', 'deploy:symlink_db'

namespace :deploy do
  # task :start, :roles => :app, :except => { :no_release => true } do
  #   # not need to restart nginx every time
  #   # run "service nginx start"
  #   run "cd #{release_path} && touch tmp/restart.txt"
  # end

  # after "deploy:start", "deploy:cleanup"
  # after 'deploy:cleanup', 'deploy:symlink_config'

  # You do not need reload nginx every time, eventhought if you use passenger or unicorn
  # task :stop, :roles => :app, :except => { :no_release => true } do
  #   run "service nginx stop"
  # end

  # task :graceful_stop, :roles => :app, :except => { :no_release => true } do
  #   run "service nginx stop"
  # end

  # task :reload, :roles => :app, :except => { :no_release => true } do
  #   run "cd #{release_path} && touch tmp/restart.txt"
  #   run "service nginx restart"
  # end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{release_path} && touch tmp/restart.txt"
  end

  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end

  # If you enable assets/deploy in Capfile, you do not need this
  # task :pipeline_precompile do
  #   # run "cd #{release_path}; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
  #   # precompile assets before deploy and upload them to server 
  #   # run_locally("RAILS_ENV=#{rails_env} rake assets:clean && RAILS_ENV=#{rails_env} rake assets:precompile")
  #   # top.upload "public/assets", "#{release_path}/public/assets", :via =>:scp, :recursive => true
  # end
end

# you do not need to this, because you already add require 'bundler/capistrano'
# before "deploy:assets:precompile", "bundle:install"