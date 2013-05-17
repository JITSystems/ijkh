default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:verbose] = :debug
set :ssh_options, {:auth_methods => "publickey"}
set :ssh_options, {:keys => ["/home/deploy/app_temp/ijkh/aws.pem"]}

set :application, "izkh.ru"
role :app, application
role :web, application
role :db, application

set :domain, "54.214.48.185"
set :user, "ubuntu"
set :deploy_to, "/home/ubuntu/apps/"
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
