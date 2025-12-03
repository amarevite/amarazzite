# vim: set ft=make :

# Brew install my personal defaults
install-personal-defaults:
    #!/usr/bin/bash
    HOMEBREW_NO_ENV_HINTS=1 brew install \
        ab-av1 ccat ddrescue dua-cli lazygit micro oxipng pandoc ripgrep-all xh yt-dlp

# Finish setting up yggdrasil network
setup-yggdrasil:
    #!/usr/bin/bash
    sudo groupadd --system yggdrasil
    systemctl start yggdrasil-default-config.service
    systemctl enable yggdrasil.service
    systemctl start yggdrasil.service
