# Intoduction

# Getting Started

1. Install Vagrant
1. Clone repository
1. `bundle install`
1. `vagrant up`
1. `vagrant ssh-config --host chef_cap_vagrant >> ~/.ssh/config`

# Chef

1. `cd chef-repo`
1. `bundle install`

Vagrant boxes already have chef installed, but lets install with our own bootstrap
file to provide a good example for when you aren't using Vagrant.
See `chef-repo/.chef/bootstrap/precise32_vagrant.erb` to see how Chef gets installed

1. `bundle exec knife bootstrap -p 2222 -x vagrant -d precise32_vagrant chef_cap_vagrant`
1. `bundle exec knife cook vagrant@chef_cap_vagrant`

Check to see if you can login as the deploy user for the application

`ssh -l deploy chef_cap_vagrant`

# Capistrano

# Proof

