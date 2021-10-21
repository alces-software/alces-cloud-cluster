# Platform: Azure

## Account Preparation

- Authenticate Azure CLI installation with the account
    ```shell
    az login
    ```

_Note: In some situations (such as when an account is attached to multiple Directories) it may be required to specify the Tenant ID with the login command (`az login --tenant abcdefgh-1234-5678-ab90-ijklmnop`)_

- Ensure correct subscription is being used
    ```shell
    az account set --subscription 'Subscription Name'
    ```

## Image Upload

- Create resource group
    ```shell
    az group create --name clustername --location westeurope
    ```
- Upload image (available here - https://flight-images.s3.eu-west-2.amazonaws.com/CENTOS7-ALCES-2021.3-0410211556_azure.raw)
    ```shell
    az storage account create --name "clusternameimages" --resource-group "clustername"
    az storage container create --name "images" --account-name "clusternameimages" \
                                --resource-group "clustername"
    az storage blob upload --account-name "clusternameimages" \
                           --container-name images \
                           --type page \
                           --file CENTOS7-ALCES-2021.2-0209211140_azure.raw \
                           --name CENTOS7-ALCES-2021.2-0209211140_azure.vhd
    az image create --resource-group "clustername" \
                    --name CENTOS7-ALCES-2021.2-0209211140_azure \
                    --os-type Linux \
                    --source  https://clusternameimages.blob.core.windows.net/images/CENTOS7-ALCES-2021.2-0209211140_azure.vhd
    ```

## Network Preparation

- Create network from remote template
    ```shell
    az group deployment create --name "initial-network" --resource-group "clustername"
                               --template-uri https://raw.githubusercontent.com/alces-software/alces-cloud-cluster/main/templates/azure/network.json
    ```

## Gateway VM Deployment

- Deploy gateway VM from remote template (specifying your ssh public key for gateway access and the path to the image uploaded earlier)
    ```shell
    az group deployment create --name "gateway" \
                               --resource-group "clustername" \
                               --template-uri https://raw.githubusercontent.com/alces-software/alces-cloud-cluster/main/templates/azure/cgw1.json \
                               --parameters ssh-key="ssh-rsa AnSSHpublicKey" \
                               image-path="/subscriptions/SUBSCRIPTION_ID/..../CENTOS7_azure"
    ```
