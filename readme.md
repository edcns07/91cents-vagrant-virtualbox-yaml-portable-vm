# 91cents Vagrant Project

This is a portable and modular Vagrant-based project designed to easily provision VirtualBox virtual machines using clean YAML-based configuration.

All VM attributes, disks, ISOs, network ports, and sync folders are defined externally using YAML files, making the setup very flexible and easy to maintain.

## 📦 Project Structure


91cents/\n 
├── Vagrantfile\n
├── vm_config.yml # VM name, hostname, OS box, private IP, sync folder \n
├── network.yml # Forwarded ports (optional, can be empty or omitted) \n
├── isos.yml # ISO files to attach (path, port, device) \n
├── disks.yml # Virtual disks to create and attach (filename, size, port) \n
├── iso/ # ISO files (ignored from git) \n
└── disks/ # Generated disks (ignored from git) \n


## ✅ Features

- Modular and clean YAML-based configuration
- Supports automatic disk creation and cleanup
- ISO file attachment at boot (CentOS DVD, VBoxGuestAdditions, etc)
- Configurable private IP and hostname
- Configurable forwarded ports (via network.yml)
- Sync folder from host to guest (via rsync)

## 🚀 Usage

### 1️⃣ Prepare the directory structure

Clone or copy this repo, and make sure you have:

- The `iso/` folder with your ISOs (this is ignored from git)
- The YAML config files filled as needed (samples are provided)

### 2️⃣ Start the VM
vagrant up

Vagrant will:
  - Create the VM
  - Attach disks
  - Attach ISOs
  - Configure network and ports
  - Sync your host folder

#### SSH into the VM:
vagrant ssh

#### Stop the VM:
vagrant halt

#### Destroy and cleanup:
vagrant destroy

This will also automatically delete generated virtual disks.

🚧 Notes
iso/ and disks/ folders are ignored from git (see .gitignore)

If network.yml is missing or empty → forwarded ports are simply skipped

The VM syncs files from G:/Users/edsan/projects/VagrantSyncDir (configurable in vm_config.yml)

Version Control
Only configuration and control files are in version control.
Heavy and dynamically generated content (ISOs and disks) are excluded.


