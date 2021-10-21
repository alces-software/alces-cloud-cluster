# Configure: Base/Networking

## Head

- Login to `chead1` and run the base script

```shell
curl http://10.110.1.200/deployment/scripts/HEAD_BASE_profile.bash
```

## Infra

- Login to `cinfra01` and run the base script

```shell
curl http://10.110.1.200/deployment/scripts/INFRA_BASE_profile.bash
```

## Compute

- Login to `cnode01` and run the base script (repeat for each additional node)

```shell
curl http://10.110.1.200/deployment/scripts/COMPUTE_BASE_profile.bash
```

## Admin

- Login to `cadmin0` and run the base script

```shell
curl http://10.110.1.200/deployment/scripts/ADMIN_BASE_profile.bash
```
