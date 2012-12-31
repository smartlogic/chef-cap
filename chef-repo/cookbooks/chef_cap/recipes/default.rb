#
# Cookbook Name:: chef_cap
# Recipe:: default
#
# Copyright 2012, SmartLogic Solutions
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

rbenv_ruby node['chef_cap']['ruby_version']

rbenv_gem "bundler" do
  ruby_version node['chef_cap']['ruby_version']
end

directory "#{node['chef_cap']['cap_base']}" do
  action :create
  owner 'deploy'
  group 'deploy'
  mode '0755'
end

directory "#{node['chef_cap']['deploy_to']}" do
  action :create
  owner 'deploy'
  group 'deploy'
  mode '0755'
end

directory "#{node['chef_cap']['deploy_to']}/shared" do
  action :create
  owner 'deploy'
  group 'deploy'
  mode '0755'
end

template "#{node['chef_cap']['deploy_to']}/shared/database.yml" do
  source 'database.yml.erb'
  owner 'deploy'
  group 'deploy'
  mode '0644'
end

postgresql_database node['chef_cap']['database'] do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :create
end

postgresql_database "create chef table" do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :query
  database_name node['chef_cap']['database']
  sql "CREATE TABLE IF NOT EXISTS chef_entries ( message text, created_at timestamp )"
end

postgresql_database "insert singleton chef table row" do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :query
  database_name node['chef_cap']['database']
  sql "INSERT INTO chef_entries (message, created_at) values ('I am the singleton chef run message!', CURRENT_TIMESTAMP)"
  not_if %Q{psql #{node['chef_cap']['database']} -c "SELECT * FROM chef_entries where message like '%singleton%'" | grep singleton}, :user => :postgres
end

postgresql_database "insert chef run chef table row" do
  connection ({:host => "127.0.0.1", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :query
  database_name node['chef_cap']['database']
  sql "INSERT INTO chef_entries (message, created_at) values ('I was created by a chef run!', CURRENT_TIMESTAMP)"
end
