require "bundler/capistrano"


# set :whenever_command, "bundle exec whenever"
# require "whenever/capistrano"

# use local key for authentication
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :application, "party"
# set :symlink_name, "15"
set :deploy_to, "/var/www/#{application}"
set :repository,  "git@github.com:zurb/party.git"
set :branch, "master"

server = "zurb.com"
role :app, server
role :web, server

set :deploy_via, :remote_cache
set :scm, "git"
set :use_sudo, false
set :user, "zurb"

set :keep_releases, 3
after "deploy:update", "deploy:cleanup"

namespace :deploy do
  
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
end
