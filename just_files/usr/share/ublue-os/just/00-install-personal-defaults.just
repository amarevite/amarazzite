# vim: set ft=make :

# Brew install my personal defaults
install-personal-defaults:
    #!/usr/bin/bash
    HOMEBREW_NO_ENV_HINTS=1 \
    brew install ccat dua-cli lazygit micro mpv oxipng ripgrep-all

# Finish setting up yggdrasil network
setup-yggdrasil:
    #!/usr/bin/bash
    sudo groupadd --system yggdrasil
    systemctl start yggdrasil-default-config.service
    systemctl enable yggdrasil.service
    systemctl start yggdrasil.service
