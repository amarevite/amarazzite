#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux 

dnf5 config-manager setopt terra.enabled=1
dnf5 install -y espanso-wayland
dnf5 config-manager setopt terra.enabled=0

# Disable COPRs so they don't end up enabled on the final image

dnf5 -y copr enable hazel-bunny/ricing
dnf5 -y install --refresh kwin-effects-forceblur
dnf5 -y copr disable hazel-bunny/ricing

dnf5 -y copr enable matinlotfali/KDE-Rounded-Corners
dnf5 -y install kwin-effect-roundcorners
dnf5 -y copr disable matinlotfali/KDE-Rounded-Corners

dnf5 -y config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:luisbocanegra/Fedora_42/home:luisbocanegra.repo
dnf5 -y install kde-material-you-colors

dnf5 -y copr enable neilalexander/yggdrasil-go
dnf5 -y install yggdrasil
dnf5 -y copr disable neilalexander/yggdrasil-go

# dnf5 -y copr enable yalter/niri
# dnf5 -y install niri
# dnf5 -y copr disable yalter/niri

dnf5 -y install intel-compute-runtime
# dnf5 -y install intel-level-zero-gpu
# dnf5 -y install intel-opencl

# echo "import \"/usr/share/ublue-os/just/00-install-personal-defaults.just \"" >> /usr/share/ublue-os/justfile

#### Example for enabling a System Unit File

systemctl enable podman.socket
# systemctl enable yggdrasil.service
setcap "cap_dac_override+p" "$(which espanso)"
# cat /usr/lib/sysusers.d/yggdrasil.conf
