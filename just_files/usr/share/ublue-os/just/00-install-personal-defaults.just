# vim: set ft=make :

# install kde-material-you-colors
install-kde-material-you-colors:
  #!/usr/bin/bash
  pip install --user --upgrade kde-material-you-colors pywal16

# Brew install my personal defaults
install-personal-defaults:
  #!/usr/bin/bash
  HOMEBREW_NO_ENV_HINTS=1

  brew install \
    ab-av1 aria2 bottom ccat ddrescue doggo dua-cli hugo lazygit micro \
    oxipng andoc podlet podman-compose ripgrep-all silicon xh yt-dlp
    # fraluc06/ffmpeg-svt-av1-essential

# Brew install svt-av1-essential
install-svt-av1-essential:
  #!/usr/bin/bash
  brew install fraluc06/ffmpeg-svt-av1-essential/svt-av1-essential-lib
  brew install fraluc06/ffmpeg-svt-av1-essential/ffmpeg-custom
  brew install fraluc06/ffmpeg-svt-av1-essential/ffms2-custom
  brew install fraluc06/ffmpeg-svt-av1-essential/svt-av1-essential

    if ! $(brew unlink ffmpeg svt-av1 ffms2); then
      echo "continuing anyway :)" ; fi
  brew link --overwrite svt-av1-essential-lib ffmpeg-custom ffms2-custom svt-av1-essential

# Finish setting up yggdrasil network
setup-yggdrasil:
  #!/usr/bin/bash
  sudo groupadd --system yggdrasil
  systemctl start yggdrasil-default-config.service
  systemctl enable yggdrasil.service
  systemctl start yggdrasil.service

# Set up Maia NFS share as Astradora
setup-maia-nfs:
  #!/usr/bin/bash
  sudo bash -c 'cat >/etc/systemd/system/var-mnt-Astradora.mount <<CONTENT
  [Unit]
  Description=Maia NFS network share (mounted as Astradora)
  
  [Mount]
  What=10.0.0.2:/
  Where=/var/mnt/Astradora
  Type=nfs4
  # Options=rw,user,noexec,noauto,x-systemd.automount,x-mount.mkdir,gid=1000,uid=1000,x-gvfs-name=Astradora
  Options=x-mount.mkdir,x-gvfs-name=Astradora
  
  [Install]
  WantedBy=multi-user.target
  CONTENT'

  sudo systemctl daemon-reload
  sudo systemctl start var-mnt-Astradora.mount
  sudo systemctl enable var-mnt-Astradora.mount

# Fix user flatpak overrides
fix-user-flatpak-overrides:
  #!/usr/bin/bash

  printf '\033[1;34m[INFO]\033[0m ' # https://stackoverflow.com/a/28938235
  printf 'To fix --user flatpaks not theming correctly, run: \033[4;36m'
  echo 'flatpak override --user --filesystem=xdg-config/gtk-3.0:ro --filesystem=xdg-config/gtk-4.0:ro'
  printf '\033[0m\n'

  printf '\033[1;34m[LOG]\033[0m Checking if \033[4;36m'
  printf '~/.local/share/flatpak/overrides/global\033[0m '
  echo 'exists.'
  if [ ! -f ~/.local/share/flatpak/overrides/global ]; then
    printf '\033[1;34m[INFO]\033[0m '
    echo "File does not exist. Automatically copying over."
    printf '\033[1;34m[LOG]\033[0m Running \033[4;36m'
    echo 'cat /var/lib/flatpak/overrides/global | tee ~/.local/share/flatpak/overrides/global'
    printf '\033[0m'
    cat /var/lib/flatpak/overrides/global | tee ~/.local/share/flatpak/overrides/global
    printf '\033[1;34m[INFO]\033[0m '
    echo "Done."
    exit 0
  fi

  printf '\033[1;34m[LOG]\033[0m Running \033[4;36m'
  echo 'diff --color /var/lib/flatpak/overrides/global ~/.local/share/flatpak/overrides/global'
  printf '\033[0m\n'

  diff --color /var/lib/flatpak/overrides/global ~/.local/share/flatpak/overrides/global
  if [[ $? == 0 ]]; then
    printf '\033[1;34m[INFO]\033[0m '
    echo "Files are already identical. Nothing to do."

  elif [[ $? == 1 ]]; then
    printf '\033[1;33m[WRN]\033[0m '
    echo "Files differ. Manually fix."

  else printf '\033[1;91m[ERR]\033[0;31m UNKNOWN ERROR\033[0m\n'
  fi

# setup my personal environment variables
setup-personal-environment-variables:
  #!/usr/bin/bash

  cat >> "/home/$USER/.config/environment.d/00-amarazzite.conf" << CONFIG
  # GSK_RENDERER=ngl
  QT_SCALE_FACTOR_ROUNDING_POLICY=RoundPreferFloor
  HOMEBREW_NO_ENV_HINTS=1
  HOMEBREW_NO_ASK=1
  
  # https://github.com/taj-ny/kwin-effects-forceblur?tab=readme-ov-file#high-cursor-latency-or-stuttering-on-wayland
  # KWIN_DRM_NO_AMS=1
  # KWIN_FORCE_SW_CURSOR=0
  # KWIN_FORCE_SW_CURSOR=1
  # https://github.com/taj-ny/kwin-effects-forceblur/issues/160
  CONFIG
