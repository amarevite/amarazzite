# vim: set ft=make :

# Brew install my personal defaults
install-personal-defaults:
    #!/usr/bin/bash
    HOMEBREW_NO_ENV_HINTS=1 brew install \
        ab-av1 ccat ddrescue doggo dua-cli lazygit micro oxipng pandoc ripgrep-all silicon xh yt-dlp \
        fraluc06/ffmpeg-svt-av1-essential

        brew unlink ffmpeg svt-av1
        brew link --overwrite ffmpeg-custom svt-av1-essential

# Finish setting up yggdrasil network
setup-yggdrasil:
    #!/usr/bin/bash
    sudo groupadd --system yggdrasil
    systemctl start yggdrasil-default-config.service
    systemctl enable yggdrasil.service
    systemctl start yggdrasil.service
