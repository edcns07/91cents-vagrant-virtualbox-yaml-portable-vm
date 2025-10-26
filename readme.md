
# 91cents Vagrant Project

This is a portable and modular Vagrant-based lab platform designed to provision and manage VirtualBox virtual machines using clean, YAML-defined configuration files.

Every VM attribute — including CPU, memory, disks, network interfaces, ISO images, and synced folders — is declared externally through modular YAML files, making the environment easy to version-control, share, and extend.

Key Use Cases

🔧 Ansible Automation Testing: Ideal for developing and testing Ansible playbooks, roles, and collections in an isolated environment before deploying to production.

🧱 Provisioning and Infrastructure Labs: Simulates realistic multi-node infrastructure scenarios (DNS, F5, storage, web, and database tiers) for automation and configuration-management practice.

🎓 Certification Practice Environment: Provides a repeatable and disposable lab setup for RHCSA/RHCE, Ansible EX294, and other DevOps or cloud certification exercises.

⚙️ CI/CD and Configuration Experiments: Enables rapid iteration on infrastructure-as-code projects using Vagrant, VirtualBox, and YAML-driven configuration management.

🚀 Portable Deployment: Fully self-contained — can run from a USB or external drive without system installation, making it perfect for secure, portable testing setups.

---

## 📦 Project Structure

```text
91cents/
├── Vagrantfile             # Main Vagrantfile logic
├── vm_config.yml           # VM name, hostname, OS box, private IP, sync folder
├── network.yml             # Forwarded ports (optional, can be empty or omitted)
├── isos.yml                # ISO files to attach (path, port, device)
├── disks.yml               # Virtual disks to create and attach (filename, size, port)
├── rsync-pull.sh           # Manual script to sync guest /vagrant → host
├── iso/                    # ISO files (ignored from git)
└── disks/                  # Generated disks (ignored from git)
```

---

## ✅ Features

- Modular and clean YAML-based configuration
  All VM definitions (CPU, memory, disks, network) are externalized in YAML for clarity and version control.
- Automatic disk creation and cleanup
  Dynamically attaches/removes storage based on YAML definitions.
- ISO file attachment at boot
  Supports CentOS/RHEL installation media, VBoxGuestAdditions, or other ISOs automatically.
- Configurable private IP and hostname
  Ensures predictable networking and consistent hostnames for Ansible inventory mapping.
- Configurable forwarded ports (via network.yml)
  Exposes guest services (SSH, HTTP, etc.) directly to the host.
- Rsync-based folder synchronization
  Host-to-guest sync (via rsync) and optional guest-to-host manual sync (rsync-pull.sh).
- Integrated Portable Git Bash Environment (Windows) 
    - Provides a self-contained Linux-like shell for running  Vagrant, and Git without installation.
    - Includes custom startup scripts (.bashrc, .bash_profile, .git-prompt.sh) for clean prompts and shortcuts.
    - Configures a consistent $HOME (e.g., /home/edsan) to maintain stable paths for SSH keys, inventory files, and Git configs.
    - Compatible with rsync, and Python environments once manually installed.
    - Enables full Ansible automation, VM provisioning, and certification practice labs (e.g., RHCSA/RHCE, EX294, DevOps automation).

---

## 🚀 Usage

### 1️⃣ Prepare the directory

Clone this repo and create `iso/` folder and place your ISOs (ignored by git).  
Edit the YAML files (`vm_config.yml`, `isos.yml`, `disks.yml`, `network.yml`) as needed.

### 2️⃣ Start the VM

```bash
vagrant up
```

Vagrant will:

- Create the VM
- Attach disks and ISOs
- Configure network, hostname, IP
- Sync host folder to guest
- Power up the VM

### 3️⃣ SSH into the VM

```bash
vagrant ssh
```

### 4️⃣ Sync guest → host (optional)

After working inside the VM, you can manually sync files back:

```bash
bash rsync-pull.sh
```

### 5️⃣ Stop or destroy

```bash
vagrant halt
vagrant destroy
```

Destroy will also clean up generated virtual disks.

---

## 📌 Notes

- `iso/` and `disks/` folders are ignored from git (see `.gitignore`)
- `network.yml` is optional → if empty or missing, forwarded ports will not be configured
- The VM syncs files from your defined host sync folder → configurable in `vm_config.yml`

---

## 📦 Version Control Info

| File/Folder | Version Controlled |
|-------------|--------------------|
| Vagrantfile | ✅ |
| YAML Config Files | ✅ |
| rsync-pull.sh | ✅ |
| iso/ (large ISO files) | 🚫 ignored |
| disks/ (generated virtual disks) | 🚫 ignored |
| .vagrant/ (local vagrant state) | 🚫 ignored |

---

## 📜 License

This project is for personal and educational use.  
No license specified → all rights reserved unless otherwise noted.

---

## 🤝 Contributing

Pull requests and suggestions welcome if shared publicly.
