# K3S HomeLab
TODO: Completet docs!
## ZFS

How to setup ZFS & bind-mounts for k3s.
OpenEBS is used to access a ZFS dataset on the Hypervisor to create PVCs on.

Setup bindmount for k3s:

```bash
```

mp0: /main_pool_z2/k3s_openebs_main,mp=/mnt/k3s_openebs_main 

## Environment

The HomeLab is running on proxmox, it can be installed via the `installer` iso.
There are some settings and prerequisites to do before bootstrap the cluster.

## Prerequisites

Use machine-template to run the `installer` to setup nodes.
The template ensures:

- boot via UEFI

