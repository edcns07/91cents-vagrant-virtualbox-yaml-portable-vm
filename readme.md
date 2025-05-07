
# 91cents Vagrant Project

This is a portable and modular Vagrant-based project designed to easily provision VirtualBox virtual machines using clean YAML-based configuration.

All VM attributes, disks, ISOs, network ports, and sync folders are defined externally using YAML files, making the setup very flexible and easy to maintain.

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
- Supports automatic disk creation and cleanup
- ISO file attachment at boot (CentOS DVD, VBoxGuestAdditions, etc)
- Configurable private IP and hostname
- Configurable forwarded ports (via `network.yml`)
- Sync folder from host to guest (via rsync)
- Manual sync from guest to host (`rsync-pull.sh`)

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
