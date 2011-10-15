require 'bundler/capistrano'

set :application, 'traktcal'
set :branch, 'master'
set :deploy_to, "/home/#{application}/app"

role :app, 'tapirgo.com'
role :web, 'tapirgo.com'
role :db,  'tapirgo.com', :primary => true

ssh_options[:username] = application


set :scm, :git
set :repository, "."
set :deploy_via, :copy
set :copy_strategy, :export

set :use_sudo, false
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after 'deploy:update_code', 'deploy:link_api_keys'

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :link_api_keys do
    run "ln -s #{shared_path}/config/api_keys.rb #{release_path}/lib/api_keys.rb"
  end
end
