set :user, 'deploy'
server 'chef_cap_vagrant', :web, :app, :db, :primary => true
set :port, 2222

set :deploy_to, '/home/deploy/apps/chef_cap'
set :rails_env, 'production'
