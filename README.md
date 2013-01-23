# Intoduction

This project provides an example of setting up a server with [Chef](http://www.opscode.com/chef/)
and deploying a [Ruby on Rails](http://rubyonrails.org/) application do it with [Capistrano](https://github.com/capistrano/capistrano)

# Getting Started

1. Install [VirtualBox](https://www.virtualbox.org/)
1. Install [Vagrant](http://www.vagrantup.com/)
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

Check to see if you can login as the deploy user and the user for the 
application

`ssh -l deploy chef_cap_vagrant`

`ssh -l chefcapapp chef_cap_vagrant`

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
1. Both Chef and Capistrano created and will maintain a singleton entry that is not duplicated by additional runs

# Starting over

1. `vagrant destroy`
1. `vagrant up`
1. Back to the Chef section
