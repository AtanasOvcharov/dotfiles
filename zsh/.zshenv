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

# --- Starship ---
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"
eval "$(starship init zsh)"

# --- Batcat theme ---
export BAT_THEME="GitHub"

# --- PATH ---
export PATH="$HOME/.local/bin:$PATH"
