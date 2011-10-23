# Vagrant SM

* Vagrant Website: [http://vagrantup.com](http://vagrantup.com)
* Source: [http://github.com/slack/vagrant-sm](http://github.com/slack/vagrant-sm)

Vagrant SM is a Vagrant provisioner which allows you to use  Wayne E. Seguin's [SM Framework](http://github.com/sm/sm).

## Requirements

## Quick Start

Require 'vagrant-sm' in your Vagrantfile and configure the SM provisioner:

```ruby
Vagrant::Config.run do |config|
  config.vm.provision :sm do |sm|
    sm.version = 'head'

    sm.extension_path = 'sm-extensions'

    sm.pre_install_command 'apt-get -y install curl'
    sm.pre_install_command 'apt-get -y install zsh'
    sm.pre_install_command 'apt-get -y install git'

    sm.post_install_command 'sm redis install'
    sm.post_install_command 'sm nginx install'

    sm.add_set :name => 'databases', :uri => 'git@github.com:sm/sm-databases.git'
    sm.add_set :name => 'servers', :uri => 'git@github.com:sm/sm-servers.git', :install => 'nginx install'

    sm.add_extension :name => 'sm_deploy', :uri => 'git@github.com:/sm/sm_deploy.git'
  end
end
```

## Options

### pre\_install\_command

Commands run before SM is installed.

Prepare the VM to be submissive (install SM deps, etc).

### add\_extension
Run after SM is installed. Use add\_extesion to install an extension. Takes
:name and :uri as arguments, optional :install to be run immediately after the
set is installed. All commands specified in :install are run in the context of
SM.

### add\_set
Run after SM is installed. Use add\_set to install a set. Takes :name and :uri
as arguments, optional :install to be run immediately after the set is
installed. All commands specified in :install are run in the context of SM.

### post\_install\_command
SM is now installed! Specify commands to run.
