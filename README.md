## Overview

WIP repository of scripts & templates for deploying a cloud cluster

## How To

- Prepare destination directory
  ```
  mkdir -p /opt/flight
  ```
- Clone repository to new directory
  ```
  git clone https://github.com/alces-software/alces-cloud-cluster /opt/flight/deployment
  ```
- Update `clustername` and `CLUSTERNAME` in all files & scripts (do not prepend `clustername` with a `c`)
  ```
  cd /opt/flight/deployment
  for file in $(grep -Ril clustername files scripts templates tools) ; do
      sed -i 's/clustername/mycluster/g' $file
      sed -i 's/CLUSTERNAME/MYCLUSTER/g' $file
  done
  ```
- _Note: The cloud templates presume that `clustername` is preceeded by `c` for cloud resources (e.g. cmycluster-vnet)_
- Set the `keyData` in the templates to the desired SSH public key (e.g. public key for cgw1)
  ```
  for file in $(grep -Rl 'ssh-rsa REPLACEME' files scripts templates tools) ; do
      sed -i 's,ssh-rsa REPLACEME,ssh-rsa MyPublicSSHkeyHere user@host,g' $file
  done
  ```
- Set the `IPAPASS` in the scripts 
  ```
  for file in $(grep -Rl 'IPAPASS' scripts) ; do
      sed -i 's/IPAPASS/MyIPApassword/g' $file
  done
  ```
- Set a munge key in `files/munge.key`
- Setup repo mirrors in `repo`
