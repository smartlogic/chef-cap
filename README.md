# Intoduction

# Getting Started

1. Install Vagrant
1. `git clone git@github.com:smartlogic/chef-cap.git`
1. `cd chef-cap`
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

1. `cd ..`
1. `bundle exec cap chef_cap_vagrant deploy:setup deploy:migrations`

# Proof

1. Open [http://localhost:8080](http://localhost:8080)
1. See the messages left by Chef and Capistrano
1. `cd chef-repo`
1. `bundle exec knife cook vagrant@chef_cap_vagrant`
1. Refresh [http://localhost:8080](http://localhost:8080)
1. Observe a new message from the Chef run
1. `cd ..`
1. `bundle exec cap chef_cap_vagrant deploy`
1. Refresh [http://localhost:8080](http://localhost:8080)
1. Observe a new message from the Capistrano run

# Starting over

1. `vagrant destroy`
1. `vagrant up`
1. Back the the Chef section
