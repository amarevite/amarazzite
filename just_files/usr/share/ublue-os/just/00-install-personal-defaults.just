# vim: set ft=make :

# install kde-material-you-colors
install-kde-material-you-colors:
  #!/usr/bin/bash
  pip install --user --upgrade kde-material-you-colors pywal16

# Brew install my personal defaults
install-personal-defaults ACTION="":
  #!/usr/bin/bash
  source /usr/lib/ujust/ujust.sh
  OPTION={{ ACTION }}
  if [ "$OPTION" == "help" ]; then
    echo "Usage: ujust install-personal-defaults <option>"
    echo "  Use 'brew' to install brew packages"
    echo "  Use 'flatpak' to install flatpak packages (via brew)"
    echo "  Use 'both' to install both"
    exit 0
  elif [ "$OPTION" == "" ]; then
    OPTION=$(Choose "brew" "flatpak" "both" )
  fi

  if [[ "${OPTION,,}" == "brew" || "${OPTION,,}" == "both" ]]; then
  brew bundle --file - <<BREW
    brew "ab-av1"
    brew "age"
    brew "aria2"
    brew "bottom"
    brew "ccat"
    brew "cmake"
    brew "ddrescue"
    brew "doggo"
    brew "dua-cli"
    brew "dysk"
    brew "elvish"
    brew "fclones"
    brew "fd"
    brew "ffmpeg"
    brew "ffms2"
    brew "hugo"
    brew "ideviceinstaller"
    brew "immich-go"
    brew "lazygit"
    brew "micro"
    brew "murex"
    brew "nim"
    brew "oh-my-posh"
    brew "oxipng"
    brew "pandoc"
    brew "podlet"
    brew "podman-compose"
    brew "ripgrep"
    brew "ripgrep-all"
    brew "rustscan"
    brew "silicon"
    brew "strace"
    brew "svt-av1"
    brew "tealdeer"
    brew "trash-cli"
    brew "ugrep"
    brew "video-compare"
    brew "xh"
    brew "yt-dlp"
    brew "zoxide"
  BREW
  fi

  if [[ "${OPTION,,}" == "flatpak" || "${OPTION,,}" == "both" ]]; then
  brew bundle --file - <<FLATPAK
    flatpak "ai.lmstudio.lm-studio"
    flatpak "app.zen_browser.zen"
    flatpak "com.bitwarden.desktop"
    flatpak "com.chatterino.chatterino"
    flatpak "com.dec05eba.gpu_screen_recorder"
    flatpak "com.github.Matoking.protontricks"
    flatpak "com.github.finefindus.eyedropper"
    flatpak "com.github.johnfactotum.Foliate"
    flatpak "com.github.k4zmu2a.spacecadetpinball"
    flatpak "com.github.taiko2k.tauonmb"
    flatpak "com.github.tchx84.Flatseal"
    flatpak "com.github.wwmm.easyeffects"
    flatpak "com.jaquadro.NBTExplorer"
    flatpak "com.jeffser.Nocturne"
    flatpak "com.makemkv.MakeMKV"
    flatpak "com.obsproject.Studio"
    flatpak "com.protonvpn.www"
    flatpak "com.ranfdev.DistroShelf"
    flatpak "com.usebottles.bottles"
    flatpak "com.vivaldi.Vivaldi"
    flatpak "com.vysp3r.ProtonPlus"
    flatpak "com.yubico.yubioath"
    flatpak "de.leopoldluley.Clapgrep"
    flatpak "dev.ters.LocalTranslate"
    flatpak "fr.handbrake.ghb"
    flatpak "info.mumble.Mumble"
    flatpak "io.github.Faugus.faugus-launcher"
    flatpak "io.github.Foldex.AdwSteamGtk"
    flatpak "io.github.benjamimgois.goverlay"
    flatpak "io.github.cboxdoerfer.FSearch"
    flatpak "io.github.debasish_patra_1987.linuxthemestore"
    flatpak "io.github.dummerle.rare"
    flatpak "io.github.efogdev.mpris-timer"
    flatpak "io.github.flattool.Ignition"
    flatpak "io.github.flattool.Warehouse"
    flatpak "io.github.gaheldev.Millisecond"
    flatpak "io.github.nokse22.minitext"
    flatpak "io.github.radiolamp.mangojuice"
    flatpak "io.github.rfrench3.scopebuddy-gui"
    flatpak "io.github.screwys.Rufin"
    flatpak "io.github.tfuxu.Halftone"
    flatpak "io.github.tobagin.keysmith"
    flatpak "io.github.vikdevelop.SaveDesktop"
    flatpak "io.github.voidforce.qsprawl"
    flatpak "io.gitlab.liferooter.TextPieces"
    flatpak "io.gitlab.news_flash.NewsFlash"
    flatpak "io.mpv.Mpv"
    flatpak "it.mijorus.gearlever"
    flatpak "me.amankhanna.opendeck"
    flatpak "net.ankiweb.Anki"
    flatpak "net.pixieditor.PixiEditor"
    flatpak "net.sourceforge.ddrescueview"
    flatpak "nl.jknaapen.fladder"
    flatpak "no.bragefuglseth.Keypunch"
    flatpak "org.equicord.equibop"
    flatpak "org.feichtmeier.Musicpod"
    flatpak "org.gnome.Boxes"
    flatpak "org.gnome.Brasero"
    flatpak "org.gnome.Mines"
    flatpak "org.gnome.Podcasts"
    flatpak "org.gnome.Reversi"
    flatpak "org.gnome.clocks"
    flatpak "org.gnome.gitlab.cheywood.Buffer"
    flatpak "org.jeffvli.feishin"
    flatpak "org.jellyfin.JellyfinDesktop"
    flatpak "org.kde.filelight"
    flatpak "org.kde.gwenview"
    flatpak "org.kde.haruna"
    flatpak "org.kde.kasts"
    flatpak "org.kde.kcalc"
    flatpak "org.kde.kolourpaint"
    flatpak "org.kde.okular"
    flatpak "org.libreoffice.LibreOffice"
    flatpak "org.localsend.localsend_app"
    flatpak "org.nicotine_plus.Nicotine"
    flatpak "org.openrgb.OpenRGB"
    flatpak "org.pipewire.Helvum"
    flatpak "org.prismlauncher.PrismLauncher"
    flatpak "org.qbittorrent.qBittorrent"
    flatpak "org.rncbc.qpwgraph"
    flatpak "org.signal.Signal"
    flatpak "org.torproject.torbrowser-launcher"
    flatpak "org.virt_manager.virt-manager"
    flatpak "page.codeberg.JakobDev.jdNBTExplorer"
    flatpak "re.fossplant.songrec"

    flatpak "chat.stoat.StoatDesktop", remote: "stoatdesktop-origin"
    flatpak "io.github.ebkr.r2modman", remote: "r2builds", url: "https://r2builds.ebkr.dev/flatpak/r2modman.flatpakrepo"
  FLATPAK
  fi

# Finish setting up yggdrasil network
enable-yggdrasil:
  #!/usr/bin/bash
  # sudo groupadd --system yggdrasil
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

# Set up 2TB Games Please
setup-games-please:
  #!/usr/bin/bash
  GAMESPLEASE=$(systemd-escape --path --suffix=mount "/var/mnt/Games Please")
  GAMESPLEASE_FILEPATH=/etc/systemd/system/$GAMESPLEASE

  sudo bash -c "cat >'/etc/systemd/system/$GAMESPLEASE' <<CONTENT
  [Unit]
  Description=Games Please (2TB WD-WXB2A613ADY4)
  
  [Mount]
  What=UUID=574b2aaa-145e-46b6-9809-13eed66d9160
  Where=/var/mnt/Games Please
  Type=ext4
  Options=x-mount.mkdir,x-gvfs-name=Games Please
  
  [Install]
  WantedBy=multi-user.target
  CONTENT"

  sudo systemctl daemon-reload
  sudo systemctl start $GAMESPLEASE
  sudo systemctl enable $GAMESPLEASE

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

  XDG_CONFIG_HOME="$HOME/.config"
  CONFIG

# install fixed fluent-round  # https://github.com/vinceliuice/Fluent-kde/issues/56
install-fixed-fluent-round:
  #!/usr/bin/fish
  set TEMPDIR (mktemp --directory)
  git clone --depth 1 --branch fix/duplicate-stylesheet-blocks https://github.com/tomeyerman/Fluent-kde.git $TEMPDIR
  cp --recursive $TEMPDIR/plasma/desktoptheme/Fluent-round $HOME/.local/share/plasma/desktoptheme/
