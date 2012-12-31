# Intoduction

# Getting Started

1. Install Vagrant
1. Clone repository
1. `bundle install`
1. `vagrant up`
1. `vagrant ssh-config --host chef_cap_vagrant >> ~/.ssh/config`

# Chef

1. `cd chef-repo`
1. `bundle exec knife bootstrap -p 2222 -x vagrant chef_cap_vagrant`
1. `bundle exec knife cook vagrant@chef_cap_vagrant`

# Capistrano

# Proof

