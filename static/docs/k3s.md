# K3S HomeLab

## ZFS

How to setup ZFS & bind-mounts for k3s.
OpenEBS is used to access a ZFS dataset on the Hypervisor to create PVCs on.

Setup bindmount for k3s:

```bash

```

## Environment

The HomeLab is running on proxmox, it can be installed via the `installer` iso.
There are some settings and prerequisites to do before bootstrap the cluster.

## Prerequisites

Use machine-template to run the `installer` to setup nodes.
The template ensures:

- boot via UEFI

