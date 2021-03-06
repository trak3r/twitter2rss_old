#############################################################
#	Application
#############################################################

set :application, "twitter2rss"
set :deploy_to, "/home/teflonted/twitter2rss.anachromystic.com"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :scm_verbose, true
set :rails_env, "production"

#############################################################
#	Servers
#############################################################

set :user, "teflonted"
set :domain, "www.anachromystic.com"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Git
#############################################################

set :scm, :git
set :branch, "master"
set :scm_user, 'trak3r'
set :scm_passphrase, "PASSWORD"
set :repository, "git@github.com:trak3r/twitter2rss.git"
set :deploy_via, :remote_cache

#############################################################
#	Passenger
#############################################################

namespace :db do
  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
after "deploy:update_code", "db:symlink"

namespace :deploy do

  after 'db:symlink', 'deploy:migrate'
  after 'deploy:migrate', 'deploy:cleanup'

  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

end
