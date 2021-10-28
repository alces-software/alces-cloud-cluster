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

- Create network
    ```shell
    openstack network create --project clustername clustername
    openstack subnet create --project clustername \
                            --subnet-range 10.110.0.0/24 \
                            --network clustername \
                            cluster-dmz
    openstack subnet create --project clustername \
                            --subnet-range 10.110.1.0/24 \
                            --network clustername \
                            cluster-pri1
    ```
- Bridge DMZ to external network
    ```shell
    openstack router create --project clustername clustername-ext-route
    openstack router set --external-gateway external clustername-ext-route
    openstack router add subnet clustername-ext-route clustername-dmz
    ```
- Create security group
    ```shell
    openstack security group create --project clustername cluster-dmz
    openstack security group rule create --project clustername \
                                         --ingress \
                                         --remote-ip 0.0.0.0/0 \
                                         --dst-port 22:22 \
                                         cluster-dmz
    openstack security group rule create --project clustername \
                                         --ingress \
                                         --remote-ip 0.0.0.0/0 \
                                         --dst-port 80:80 \
                                         cluster-dmz
    openstack security group rule create --project clustername \
                                         --ingress \
                                         --remote-ip 0.0.0.0/0 \
                                         --dst-port 443:443 \
                                         cluster-dmz
    openstack security group rule create --project clustername \
                                         --ingress \
                                         --remote-ip 0.0.0.0/0 \
                                         --dst-port 5901:5910 \
                                         cluster-dmz
    ```

## Gateway VM Deployment

- Deploy gateway VM
    ```shell
    openstack port create --network clustername --fixed-ip subnet=cluster-dmz,ip-address=10.110.0.200 cgw1dmz
    openstack port create --network clustername --fixed-ip subnet=cluster-pri1,ip-address=10.110.1.200 cgw1pri
    openstack server create --nic 
    ```
- Attach floating IP for external access
    ```shell
    openstack floating ip create external
    openstack server add floating ip --fixed-ip-address 10.110.0.200 cgw1 FLOATING_IP_ADDRESS_FROM_PREVIOUS_OUTPUT
    ```
