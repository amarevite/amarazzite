#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Disable COPRs so they don't end up enabled on the final image

dnf5 -y makecache --refresh

dnf5 config-manager setopt terra.enabled=1
dnf5 -y install espanso-wayland
dnf5 config-manager setopt terra.enabled=0

dnf5 -y install /ctx/kwin-glass.rpm

dnf5 -y copr enable matinlotfali/KDE-Rounded-Corners
dnf5 -y install kwin-effect-roundcorners
dnf5 -y copr disable matinlotfali/KDE-Rounded-Corners

dnf5 -y copr enable neilalexander/yggdrasil-go
dnf5 -y install yggdrasil
dnf5 -y copr disable neilalexander/yggdrasil-go

dnf5 -y install intel-compute-runtime
dnf5 -y install intel-level-zero-gpu-raytracing
dnf5 -y install embree

dnf5 -y install earlyoom
dnf5 -y install kvantum

dnf5 -y install ptyxis
dnf5 -y remove konsole

dnf5 -y remove xwaylandvideobridge


#### Preparation
systemctl enable podman.socket
systemctl enable earlyoom.service

setcap "cap_dac_override+p" "$(which espanso)"

# fix intel compute runtime https://github.com/intel/compute-runtime/issues/922#issuecomment-4675326568
ldconfig


### Cleanup to remove `bootc container lint` warnings
# cleanup transient files in /run and /var from installing packages
dnf5 clean all
rm --recursive --force /run/dnf
rm --recursive --force /var/lib/dnf

# bootc linter explicitly looks for a group definition, but it's only implied by ta user definition.
# explicitly set a group definition to satisfy the linter. systemd-sysusers is handling everything anyway
echo 'g yggdrasil - -' >> /usr/lib/sysusers.d/yggdrasil.conf
