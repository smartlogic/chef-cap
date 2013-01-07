require 'bundler/capistrano'
require 'capistrano/ext/multistage'

load 'config/cap_tasks/base'
load 'config/cap_tasks/nginx'
load 'config/cap_tasks/unicorn'
load 'config/cap_tasks/monit'

set :default_environment, {
  'PATH' => '/opt/rbenv/shims:/opt/rbenv/bin:$PATH',
  'RBENV_ROOT' => '/opt/rbenv'
}

set :application, 'chef_cap'

set :scm, :git
set :repository,  'git@github.com:smartlogic/chef-cap.git'
set :branch, :master
set :deploy_via, :remote_cache
set :deploy_to, '/home/deploy/apps/chef_cap'

set :bundle_flags, '--deployment --quiet --binstubs --shebang ruby-local-exec'

set :use_sudo, false

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :target_os, :ubuntu

namespace :custom do
  desc 'Shared storage folders and symlinks to the release'
  task :file_system, :roles => :app do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config"
  end

  desc 'Create the .rbenv-version file'
  task :rbenv_version, :roles => :app do
    run "cd #{release_path} && rbenv local 1.9.3-p327"
  end

  desc 'Install data'
  task :data, :roles => :app do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake cap_data"
  end
end

before 'bundle:install', 'custom:rbenv_version'
after 'deploy:update_code', 'custom:file_system'
after 'deploy:restart', 'custom:data', 'deploy:cleanup'

