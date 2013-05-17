set :application, "izkh.ru"
role :app, application
role :web, application
role :db, application

set :user, "deploy"
set :password, "deploy"
set :deploy_to, "/home/deploy/apps/"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production"

set :scm, "git"
set :repository, "git://github.com/JITSystems/ijkh.git"
set :branch, "master"

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end  
end
