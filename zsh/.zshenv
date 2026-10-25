export ZDOTDIR="$HOME/.config/zsh"

# --- XDG base directories ---
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# --- Editor ---
export EDITOR="nvim"
export VISUAL="nvim"

# --- Starship ---
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# --- Batcat theme ---
export BAT_THEME="Catppuccin Mocha"

# Source local zshenv if it exists
[[ -r "$ZDOTDIR/.zshenv.local" ]] && source "$ZDOTDIR/.zshenv.local"
