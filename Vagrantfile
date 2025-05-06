require 'fileutils'
require 'yaml'

# Root directory
VAGRANT_ROOT = File.dirname(File.expand_path(__FILE__))

# Directories
VAGRANT_DISKS_DIRECTORY = "disks"

# Load configs
vm_config_file = File.join(VAGRANT_ROOT, "vm_config.yml")
vm_config = YAML.load_file(vm_config_file)["vm"]

iso_config_file = File.join(VAGRANT_ROOT, "isos.yml")
isos = YAML.load_file(iso_config_file)["isos"]

disks_config_file = File.join(VAGRANT_ROOT, "disks.yml")
local_disks = YAML.load_file(disks_config_file)["disks"]

network_config_file = File.join(VAGRANT_ROOT, "network.yml")
network_config = File.exist?(network_config_file) ? YAML.load_file(network_config_file) : {}
forwarded_ports = network_config["forwarded_ports"] || []

# Controller definition
VAGRANT_CONTROLLER_NAME = "Virtual I/O Device SCSI controller"
VAGRANT_CONTROLLER_TYPE = "virtio-scsi"

Vagrant.configure("2") do |config|

  # VM basic config
  config.vm.box = vm_config["box"]
  config.vm.hostname = vm_config["hostname"]
  config.vm.network "private_network", ip: vm_config["private_ip"]
  if Vagrant.has_plugin?("vagrant-vbguest") then
          config.vbguest.auto_update = false #set to true for auto_update
          config.vbguest.no_remote = false
        end

  # Forwarded ports
  forwarded_ports.each do |port|
    options = {
      guest: port["guest"],
      host: port["host"],
      host_ip: "127.0.0.1"
    }
    options[:id] = port["id"] if port["id"]
    config.vm.network "forwarded_port", **options
  end

  # Synced folder (host -> guest)
  sync_folder_path = vm_config["sync_folder"]
  config.vm.synced_folder sync_folder_path, "/vagrant", type: "rsync", create: true

  # VirtualBox provider settings
  disks_directory = File.join(VAGRANT_ROOT, VAGRANT_DISKS_DIRECTORY)
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2

    # Mount ISOs
    isos.each do |iso|
      iso_path = File.expand_path(iso["path"], VAGRANT_ROOT)
      v.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', iso["port"], '--device', iso["device"], '--type', 'dvddrive', '--medium', iso_path]
    end
  end

  # Create disks before "up"
  config.trigger.before :up do |trigger|
    trigger.name = "Create disks"
    trigger.ruby do
      unless File.directory?(disks_directory)
        FileUtils.mkdir_p(disks_directory)
      end

      local_disks.each do |local_disk|
        disk_file = File.join(disks_directory, "#{local_disk["filename"]}.vdi")
        unless File.exist?(disk_file)
          puts "Creating disk #{local_disk["filename"]}"
          system("vboxmanage createmedium --filename #{disk_file} --size #{local_disk["size"] * 1024} --format VDI")
        end
      end
    end
  end

  # Create storage controller on first run
  unless File.directory?(disks_directory)
    config.vm.provider "virtualbox" do |storage_provider|
      storage_provider.customize ["storagectl", :id, "--name", VAGRANT_CONTROLLER_NAME, "--add", VAGRANT_CONTROLLER_TYPE, "--hostiocache", "off"]
    end
  end

  # Attach disks
  config.vm.provider "virtualbox" do |storage_provider|
    local_disks.each do |local_disk|
      disk_file = File.join(disks_directory, "#{local_disk["filename"]}.vdi")
      unless File.exist?(disk_file)
        storage_provider.customize ['storageattach', :id, '--storagectl', VAGRANT_CONTROLLER_NAME, '--port', local_disk["port"], '--device', 0, '--type', 'hdd', '--medium', disk_file]
      end
    end
  end

  # Cleanup disks after destroy
  config.trigger.after :destroy do |trigger|
    trigger.name = "Cleanup disks"
    trigger.ruby do
      local_disks.each do |local_disk|
        disk_file = File.join(disks_directory, "#{local_disk["filename"]}.vdi")
        if File.exist?(disk_file)
          puts "Deleting disk #{local_disk["filename"]}"
          system("vboxmanage closemedium disk #{disk_file} --delete")
        end
      end

      if File.exist?(disks_directory)
        FileUtils.rmdir(disks_directory)
      end
    end
  end

end
