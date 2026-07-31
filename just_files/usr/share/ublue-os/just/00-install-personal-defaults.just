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
    oxipng andoc podlet ripgrep-all silicon xh yt-dlp
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

# setup udev 8bitdo / soomfon
setup-personal-udev-rules:
  #!/usr/bin/bash

  echo "/etc/udev/rules.d/8bitdo-gdu.rules"
  sudo dd of="/etc/udev/rules.d/8bitdo-gdu.rules" << 8BITDO
  # 8BitDo Generic Device
  ## This rule applies to many 8BitDo devices.
  ACTION!="remove", SUBSYSTEM=="usb", ATTR{idProduct}=="3106", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo F30 P1
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo FC30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo F30 P2
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo FC30 II", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo N30
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo NES30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo SF30
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SFC30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo SN30
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SNES30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo F30 Pro
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo FC30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo N30 Pro
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo NES30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo SF30 Pro
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SF30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo SN30 Pro
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SN30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo SN30 Pro+; Bluetooth; USB
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8BitDo SN30 Pro+", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SF30 Pro   8BitDo SN30 Pro+", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo F30 Arcade
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo Joy", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo N30 Arcade
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo NES30 Arcade", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo ZERO
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo Zero GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo Retro-Bit xRB8-64
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8Bitdo N64 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo Pro 2; Bluetooth; USB
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8BitDo Pro 2", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  ACTION!="remove", SUBSYSTEM=="input", ATTR{id/vendor}=="2dc8", ATTR{id/product}=="6006", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  ACTION!="remove", SUBSYSTEM=="input", ATTR{id/vendor}=="2dc8", ATTR{id/product}=="6003", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo Pro 2 Wired; USB
  # X-mode uses the 8BitDo Generic Device rule
  # B-Mode
  ACTION!="remove", SUBSYSTEM=="usb", ATTR{idProduct}=="3010", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  ACTION!="remove", SUBSYSTEMS=="input", ATTRS{id/product}=="3010", ATTRS{id/vendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo Pro 3; Bluetooth; USB/2.4Ghz
  # D-Mode
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8BitDo Pro 3", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  ACTION!="remove", SUBSYSTEM=="input", ATTR{id/vendor}=="2dc8", ATTR{id/product}=="6009", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo Ultimate Wired Controller for Xbox; USB
  ACTION!="remove", SUBSYSTEM=="usb", ATTR{idProduct}=="2003", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo Ultimate 2.4G Wireless  Controller; USB/2.4GHz
  # X-mode uses the 8BitDo Generic Device rule
  # D-mode
  ACTION!="remove", SUBSYSTEM=="usb", ATTR{idProduct}=="3012", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo Ultimate 2C Wireless Controller; USB/2.4GHz
  ACTION!="remove", SUBSYSTEM=="usb", ATTR{idProduct}=="310a", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo Arcade Stick; Bluetooth (X-mode)
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8BitDo Arcade Stick", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  
  # 8BitDo Ultimate 2 Wireless; Bluetooth; USB/2.4GHz
  ACTION!="remove", SUBSYSTEM=="input", ATTRS{name}=="8BitDo Ultimate 2 Wireless", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  ACTION!="remove", SUBSYSTEM=="usb", ATTR{idProduct}=="310b", ATTR{idVendor}=="2dc8", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
  8BITDO


  echo ""
  echo "/etc/udev/rules.d/40-opendeck-akp153.rules"
  sudo dd of="/etc/udev/rules.d/40-opendeck-akp153.rules" << OPENDECK
  SUBSYSTEM=="usb", ATTRS{idVendor}=="6603", ATTRS{idProduct}=="1014", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="6603", ATTRS{idProduct}=="1005", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="5548", ATTRS{idProduct}=="6670", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="5548", ATTRS{idProduct}=="6674", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="0300", ATTRS{idProduct}=="1010", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="0300", ATTRS{idProduct}=="1020", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="0300", ATTRS{idProduct}=="3010", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="0300", ATTRS{idProduct}=="3011", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="0b00", ATTRS{idProduct}=="1000", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="0c00", ATTRS{idProduct}=="1000", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="0a00", ATTRS{idProduct}=="1001", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="0500", ATTRS{idProduct}=="1001", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="1500", ATTRS{idProduct}=="3003", MODE="0660", TAG+="uaccess"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="0600", ATTRS{idProduct}=="1000", MODE="0660", TAG+="uaccess"
  
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="6603", ATTRS{idProduct}=="1014", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="6603", ATTRS{idProduct}=="1005", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="5548", ATTRS{idProduct}=="6670", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="5548", ATTRS{idProduct}=="6674", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0300", ATTRS{idProduct}=="1010", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0300", ATTRS{idProduct}=="1020", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0300", ATTRS{idProduct}=="3010", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0300", ATTRS{idProduct}=="3011", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0b00", ATTRS{idProduct}=="1000", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0c00", ATTRS{idProduct}=="1000", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0a00", ATTRS{idProduct}=="1001", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0500", ATTRS{idProduct}=="1001", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1500", ATTRS{idProduct}=="3003", MODE="0660", TAG+="uaccess"
  KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0600", ATTRS{idProduct}=="1000", MODE="0660", TAG+="uaccess"
  OPENDECK

  echo ""
  echo "Done"
