default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:verbose] = :debug
set :ssh_options, {:user => "ubuntu"}
set :ssh_options, {:auth_methods => "publickey"}
set :ssh_options, {:keys => ["/home/ubuntu/aws_key/aws.pem"]}

set :application, "izkh.ru"
role :app, application
role :web, application
role :db, application

set :domain, "izkh.ru"
set :user, "ubuntu"
set :deploy_to, "/home/ubuntu/apps/"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production"

set :scm, "git"
set :repository, "git://github.com/JITSystems/ijkh.git"
set :branch, "master"
set :clockwork_roles, :app
set :cw_pid_file, "#{current_path}/tmp/pids/clockwork.pid"

namespace :symlinks do
	desc "Link assets for current deploy to the shared location"
    task :update, :roles => [:app, :web] do
      run "ln -nfs #{shared_path}/images #{release_path}/public/images"
    end
end

namespace :deploy do  
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

after 'deploy:update', 'symlinks:update'

end

namespace :clockwork do
  desc "Restart clockwork"
  task :restart, :roles => clockwork_roles, :on_no_matching_servers => :continue do
    run "ps -ef | grep clockwork | grep -v grep | awk '{print $2}' | xargs kill -9"
    run "cd #{current_path}/lib; RAILS_ENV=#{rails_env} clockworkd -c clock.rb start >> #{current_path}/log/clockwork.log 2>&1 &", :pty => false
    run "ps -eo pid,command | grep clockwork | grep -v grep | awk '{print $1}' > #{cw_pid_file}"
  end
end

after "deploy:restart", "clockwork:restart"
