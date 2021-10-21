# Deploy: Azure

Unless otherwise stated, all deployment actions should take place from `cgw1`.

## Head

- Deploy `chead1`
    ```shell
    cd /opt/flight/deployment
    az group deployment create --name 'chead1' --resource-group 'clustername' --template-file templates/azure/chead1.json
    ```

## Infra

- Deploy `cinfra01`
    ```shell
    cd /opt/flight/deployment
    az group deployment create --name 'cinfra01' --resource-group 'clustername' --template-file templates/azure/cinfra01.json
    ```

## Compute

- Deploy `cnode01`
    ```shell
    cd /opt/flight/deployment
    az group deployment create --name 'cnode01' --resource-group 'clustername' --template-file templates/azure/cnode01.json
    ```

## Admin

- Deploy `cadmin01`
    ```shell
    cd /opt/flight/deployment
    az group deployment create --name 'cadmin01' --resource-group 'clustername' --template-file templates/azure/cadmin01.json
    ```
