# K3S

## Sops-nix

Run installer to install of a `k3s-node`.
After it rebooted, ssh into node and copy the public `age-key` to `.sops.yaml`.

Then trigger remote build, this will ensure `k3s` can read the `k3s_token` secret.

```bash

```

## Initial bootstrap

If the `sops-nix` is configured, the `k3s-m0` must be initialized manually by:

```bash
# Stop the actual failing systemd unit
systemctl stop k3s

# Copy k3s command from systemd unit, and add --cluster-init, looks like this:


# Wait 5min to bootstrap the Initial etcd & node, the logs get less when its finished.
# Check if the single master node is ready.
k get nodes

# Then C-c the k3s command & restart systemd again.
systemctl start k3s
```

## Join nodes

Install further nodes, one at the time is the best option.
After successfull installed `k3s` nodes with `installer`, ssh onto node and copy public `age-key`.
Add it to the dotfiles repo & remote build the host again.
