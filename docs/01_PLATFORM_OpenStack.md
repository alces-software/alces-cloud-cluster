# Platform: OpenStack

## Account Preparation

- Authenticate OpenStack CLI installation with the account
    ```shell
    source openstack-v3.sh
    ```

## Image Upload

- Upload image (available here - https://flight-images.s3.eu-west-2.amazonaws.com/CENTOS7-ALCES-2021.3-0410211632_generic-cloudinit.raw)
    ```shell
    openstack image create --file CENTOS7-ALCES-2021.3-0410211632_generic-cloudinit.raw \
                           --disk-format raw --project clustername \
                           CENTOS7-ALCES-2021.3-0410211632_generic-cloudinit
    ```

## Network Preparation

- Create network from remote template 
    ```shell
    openstack stack create -t https://raw.githubusercontent.com/alces-software/alces-cloud-cluster/main/templates/openstack/network.yaml \
                           --parameter ext-network='external' \
                           cluster-network --wait
    ```

## Gateway VM Deployment

- Deploy gateway VM
    ```shell
    openstack create -t https://raw.githubusercontent.com/alces-software/alces-cloud-cluster/main/templates/openstack/cgw1.yaml \ 
                     --parameter ssh-key='ssh-rsa MySSHkey' \
                     --parameter image-id='CENTOS7-ALCES-2021.3-0410211632_generic-cloudinit' \
                     cgw1 --wait
    ```

