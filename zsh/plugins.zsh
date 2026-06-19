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
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'          # grey; raise number if too dim
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
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=cyan,fg=black,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_FUZZY=1            # match words in any order
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1    # no duplicate matches
_zplugin_load zsh-users zsh-history-substring-search
