<div align="center">
    <img width="128" src="./img/snowflake.png"></img>

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

```bash
nix develop

# NixOS rebuilds (hostname is autodetected)
nh os switch

# HomeManager rebuilds (hostname & username is autodetected)
nh home switch

# Build nixos-installer iso
nix build .#nixosConfigurations.iso.config.system.build.isoImage

# Update flake
nix flake update
```
