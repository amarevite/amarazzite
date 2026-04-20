# vim: set ft=make :

# Brew install my personal defaults
install-personal-defaults:
  #!/usr/bin/bash
  HOMEBREW_NO_ENV_HINTS=1

  brew install \
    ab-av1 aria2c bottom ccat ddrescue doggo dua-cli hugo lazygit micro \
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
  sudo cat > /etc/systemd/system/var-mnt-Astradora.mount <<CONTENT
  [Unit]
  Description=Maia NFS network share (mounted as Astradora)
  
  [Mount]
  What=10.0.0.2:/
  Where=/var/mnt/Astradora
  Type=nfs4
  # Options=rw,user,noexec,noauto,x-systemd.automount,x-mount.mkdir,gid=1000,uid=1000,x-gvfs-name=Astradora
  
  [Install]
  WantedBy=multi-user.target
  CONTENT

  systemctl start var-mnt-Astradora.mount
  systemctl enable var-mnt-Astradora.mount
