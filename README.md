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
- Set the variables at the top of `support/setup_files.sh`
- Run the setup script
  ```
  bash support/setup_files.sh
  ```

## Repo Setup

This details the steps taken by the repo setup script. These steps can be performed manually instead of with the setup script if desired.

- Update `clustername` and `CLUSTERNAME` in all files & scripts (do not prepend `clustername` with a `c`)
  ```
  cd /opt/flight/deployment
  for file in $(grep -Ril clustername files scripts templates tools) ; do
      sed -i 's/clustername/mycluster/g' $file
      sed -i 's/CLUSTERNAME/MYCLUSTER/g' $file
  done
  ```
- _Note: The cloud templates presume that `clustername` is preceeded by `c` for cloud resources (e.g. cmycluster-vnet)_
- Set the image resource path to the location of the image in the destination cloud account
  ```
  for file in $(grep -Ril IMAGE_PATH templates) ; do
      sed -i 's,IMAGE_PATH,/subscriptions/SUBSCRIPTION_ID/resourceGroups/cclustername/providers/Microsoft.Compute/images/CENTOS7-ALCES-VERSION_azure,g' $file
  done
  ```
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

## Flight Setup

The scripts `MASTER00-flight-setup.bash` and `SLAVE00-flight-setup.bash` add a systemd service which runs _before_ SLURM is allowed to start to prewarm the node. 

This exists to address issues with Azure `/tmp` disk mounting and Nvidia device loading. 
