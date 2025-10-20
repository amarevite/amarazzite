# vim: set ft=make :

# Brew install my personal defaults
install-personal-defaults:
    #!/usr/bin/bash
    HOMEBREW_NO_ENV_HINTS=1 \
    brew install ccat dua-cli lazygit micro mpv oxipng ripgrep-all
