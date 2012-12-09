Vagrant::Config.run do |config|
  config.vm.box = "lucid32"

  # Enable the Puppet provisioner
  config.vm.provision :puppet, :module_path => "modules"

  # Forward guest port 80 to host port 4567
  config.vm.forward_port 80, 4567
end