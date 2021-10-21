# Prepare Gateway: Azure

- Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=dnf)
- Authenticate Azure CLI installation with the account
    ```shell
    az login
    ```

_Note: In some situations (such as when an account is attached to multiple Directories) it may be required to specify the Tenant ID with the login command (`az login --tenant abcdefgh-1234-5678-ab90-ijklmnop`)_

- Ensure correct subscription is being used
    ```shell
    az account set --subscription 'Subscription Name'
    ```
