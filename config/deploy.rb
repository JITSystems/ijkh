default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:verbose] = :debug
set :ssh_options, {:user => "ubuntu"}
set :ssh_options, {:auth_methods => "publickey"}
set :ssh_options, {:keys => ["aws.pem"]}

set :application, "ec2-54-245-202-30.us-west-2.compute.amazonaws.com"
role :app, application
role :web, application
role :db, application

set :domain, "ec2-54-245-202-30.us-west-2.compute.amazonaws.com"
set :user, "ubuntu"
set :deploy_to, "/home/ubuntu/apps/"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production"

set :scm, "git"
set :repository, "git://github.com/JITSystems/ijkh.git"
set :branch, "staging"

set :shared_assets, %w{public/images/}

namespace :symlinks do
	desc "Setup application symlinks for shared folders"
	task :setup, :roles => [:app, :web] do
		shared_assets.each { |link| run "ln -nfs #{shared_path}/#{link} #{release_path}/#{link}" }
	end

	desc "Link assets for current deploy to the shared location"
    task :update, :roles => [:app, :web] do
      shared_assets.each { |link| run "ln -nfs #{shared_path}/#{link} #{release_path}/#{link}" }
    end
end

namespace :deploy do  
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

before 'deploy:setup', 'symlinks:setup'
before 'deploy:update', 'symlinks:update'

end
