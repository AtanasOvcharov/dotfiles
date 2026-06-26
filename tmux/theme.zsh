#!/usr/bin/env sh

THEME_FILE="$HOME/dotfiles/tmux/theme.conf"

system_theme="$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null || true)"

if [ "$system_theme" = "'prefer-dark'" ]; then
	flavour="mocha"
else
	flavour="latte"
fi

cat > "$THEME_FILE" <<EOF
set -g @catppuccin_flavour "$flavour"
set -g @catppuccin_flavor "$flavour"
EOF
