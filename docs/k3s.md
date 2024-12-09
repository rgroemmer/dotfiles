# K3S

## Initial bootstrap

# TODO: Update new way 

- Installer sops-nix configured
- then install host
- copy-over key

The `k3s` cluster is configured to join automaticaly any master which is accesible behind the loadbalancer.
If the cluster is bootstraped the very first time, some manual steps are necessary.

```bash
# SSH onto node & stop the k3s systemd unit -> it should fail due to inaccsassible kube-api for fetching certs.
sudo systemctl stop k3s

# Get the actual command from the systemd unit
systemctl status k3s | grep "ExecStart=.*"

# Add the --cluster-init flag and remove the server address, it should look something like that:
sudo k3s server --cluster-init  --token-file /run/secrets/k3s_token --config /nix/store/lqjydiympzbw7rfpxj2cb37algfvy171-config.yaml

# Wait till the clusterInit is successfully finished, then reboot node
sudo reboot

# Verify that k3s is runnig
journalctl -u k3s -f

k get no
```

## Join nodes

Install further nodes, one at the time is the best option.
After successfull installed `k3s` nodes with `installer`, ssh onto node and copy public `age-key`.
Add it to the dotfiles repo & remote build the host again.
