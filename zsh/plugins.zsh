# --- Plugins manage functions ---
ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
  local plugin_path="${ZPLUGINDIR}/${2}"
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${2}..."
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo "ERROR: failed to install ${2}" >&2; return 1; }
  fi
  source "${plugin_path}/${2}.plugin.zsh"
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

# --- Plugins ---

# --- zsh-autosuggestions ---
ZSH_AUTOSUGGEST_STRATEGY=(history completion)   # history first, then completion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6c7086' # Catppuccin Overlay0
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20              # skip suggesting on huge pastes
ZSH_AUTOSUGGEST_MANUAL_REBIND=1                 # small speedup
_zplugin_load zsh-users zsh-autosuggestions

# --- fast-syntax-highlighting ---
_zplugin_load zdharma-continuum fast-syntax-highlighting

# --- zsh-vi-mode ---
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT         # start each prompt in insert mode
ZVM_CURSOR_STYLE_ENABLED=true               # enable per-mode cursor shapes
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM     # | beam in insert
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK    # █ block in normal
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
_zplugin_load jeffreytse zsh-vi-mode

# --- zsh-history-substring-search ---
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#89b4fa,fg=#1e1e2e,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#f38ba8,fg=#1e1e2e,bold'
HISTORY_SUBSTRING_SEARCH_FUZZY=1            # match words in any order
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1    # no duplicate matches
_zplugin_load zsh-users zsh-history-substring-search


# --- fast-syntax-highlighting: Catppuccin Mocha-ish colors ---
# These styles are read by fast-syntax-highlighting after it loads.
typeset -gA FAST_HIGHLIGHT_STYLES
FAST_HIGHLIGHT_STYLES[command]='fg=#89b4fa,bold'
FAST_HIGHLIGHT_STYLES[alias]='fg=#89b4fa,bold'
FAST_HIGHLIGHT_STYLES[builtin]='fg=#89b4fa,bold'
FAST_HIGHLIGHT_STYLES[function]='fg=#89b4fa,bold'
FAST_HIGHLIGHT_STYLES[path]='fg=#a6e3a1'
FAST_HIGHLIGHT_STYLES[path_pathseparator]='fg=#6c7086'
FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#f9e2af'
FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#f9e2af'
FAST_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#a6e3a1'
FAST_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#a6e3a1'
FAST_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#a6e3a1'
FAST_HIGHLIGHT_STYLES[variable]='fg=#f5c2e7'
FAST_HIGHLIGHT_STYLES[assign]='fg=#f5c2e7'
FAST_HIGHLIGHT_STYLES[comment]='fg=#6c7086,italic'
FAST_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold'
