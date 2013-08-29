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


after 'deploy:update_code', 'deploy:symlink_uploads'

namespace :deploy do
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/images  #{release_path}/public/images"
  end
  
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

end
