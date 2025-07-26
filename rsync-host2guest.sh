#!/bin/bash
# vagrant ssh-config > ssh_config
# Notes: "/g/My Drive/projects/VagrantSyncDir/" -> source (mypc)
# default:/vagrant/ -> target (vbox guest)
# Note: "vagrant rsync" also works , this is one-way sync from host to guest
rsync -avH -e "ssh -F ./ssh_config" "/g/My Drive/projects/VagrantSyncDir/" default:/vagrant/
