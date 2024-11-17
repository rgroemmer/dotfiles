<a:qdiv align="center">
    <img width="128" src="./static/img/snowflake.png"></img>

![NixOS](https://img.shields.io/badge/os-nixos-%2389dceb?style=for-the-badge&logo=nixos&logoColor=white)
![Hyprland](https://img.shields.io/badge/window_manager-hyprland-%23ffb29d?style=for-the-badge&logo=wayland&logoColor=white)
![Home Manager](https://img.shields.io/badge/package_manager-home_manager-%23f2cdcd?style=for-the-badge&logo=nixos&logoColor=white)
![Alacritty](https://img.shields.io/badge/terminal-alacritty-%23b4befe?style=for-the-badge&logo=alacritty&logoColor=white)
![Neovim](https://img.shields.io/badge/editor-neovim-%23f5e0dc?style=for-the-badge&color=a6e3a1&logo=neovim&logoColor=white)
![Love](https://img.shields.io/static/v1?logoColor=d8dee9&label=Built%20With&message=Love%20%E2%9D%A4%EF%B8%8F&color=cba6f7&style=for-the-badge)

<img width="512" src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png"></img>

This is my ever-evolving dotfiles repository, used to manage my desktop workstation, a MacBook Pro, and any Linux devbox capable of running Nix.
This repository is constantly improved or changed in some way.
It follows a structure to keep related configurations together, but not too much to reduce complexity.

</div>

## 🚀 Usage

### Bootstrap

```bash
nix develop

# NixOS rebuilds (hostname autodetection)
nh os switch .

# HomeManager rebuilds (hostname & username autodetection)
nh home switch .

# NixOs build with custom hostname
nh os build --hostname k3s-m0 .

# HomeManager build with custom hostname
nh home switch -c macbook

# NixOS build installer iso image
nix build .#nixosConfigurations.iso.config.system.build.isoImage
```

<details>
    <summary>💽 Disko</summary>
<br>

Disko is used to provision disks, it creates automatically the `filsystems` configuration.

```bash
# Run disko from an installer
sudo nix run github:nix-community/disko --no-write-lock-file -- --mode zap_create_mount ./hosts/zion/disko.nix

# After this nixos can be installed
sudo nixos-install --flake .#zion
```

</details>

## 🏛️ Structure

- **`flake.nix`** Entrypoint to all:
    - `NixOS` configurations.
    - `HomeManager` configurations.
    - `devShells` to provide `nix develop` environment. (see `shell.nix`)
    - `formatter`.
- **`shell.nix`** Shell config for `nix develop` environment.
    - Leverage git-commit-hooks with enforce of lint, fmt & code checking.
    - Shell environment with all tools needed to switch, build & run the `flake`.
- **`hosts/`** All physical machines managed by `NixOS`.
- **`nixos`** Modules for `NixOS` separated into:
    - `common/` **default** configurations for all `hosts`.
    - `*` optional to import.
- **`home-manager`** Entrypoint for all `home-configurations` per `host`.
    - `common/` contains configuration defaults valid for all `home-configurations`.
    - `*/` contains `NixOS` modules, optional to import.
- `isos/` Configuration for all `NixOS` configurations which build images.
- `static/` Static files mostly not used for nix.
- `nix.nix` Nix & nixpkgs configuration for `NixOS` & `HomeManager`.

## 📜 Style guide & rules

- **`Host`**
  - ⚖️ Every `hosts` entrypoint is a `default.nix`.
    - ⚖️ It imports all `NixOS` modules as `path`.
    - ⚖️ Define *host specific configuration*
    - ⚖️ Imports `hardware-configuration.nix`
  - May has a `disko.nix` configuration to configure `filsystems`.
- **`Home-manager`**
  - ⚖️ Every `host` has its own entrypoint at toplevel.
  - ⚖️ Every `host` entrypoint is a file with the host name which:
    - Imports all `Home` configuration for this `host`.
    - Defines **host specific configuration**
