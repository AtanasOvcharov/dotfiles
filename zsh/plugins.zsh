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

# --- Theme palette (follows TERM_APPEARANCE from .wezterm.lua) ---
# Must be defined BEFORE the plugins load, since they read these vars at source time.
if [[ ${TERM_APPEARANCE:-dark} == light ]]; then
  # Catppuccin Latte, darkened where needed for contrast on #eff1f5
  _c_cmd='#1e66f5'   # blue
  _c_path='#2f8a1f'  # green (darkened)
  _c_opt='#b8860b'   # gold  
  _c_str='#2f8a1f'   # green
  _c_var='#8839ef'   # mauve
  _c_dim='#8c8fa1'   # overlay1
  _c_err='#d20f39'   # red
  _c_ghost='#9ca0b0' # overlay0
  _c_hl_fg='#eff1f5' # base (text on highlight bars)
  _c_hl_ok='#1e66f5'
  _c_hl_no='#d20f39'
else
  # Catppuccin Mocha
  _c_cmd='#89b4fa'
  _c_path='#a6e3a1'
  _c_opt='#f9e2af'
  _c_str='#a6e3a1'
  _c_var='#f5c2e7'
  _c_dim='#6c7086'
  _c_err='#f38ba8'
  _c_ghost='#6c7086'
  _c_hl_fg='#1e1e2e'
  _c_hl_ok='#89b4fa'
  _c_hl_no='#f38ba8'
fi

# --- Plugins ---

# --- zsh-autosuggestions ---
ZSH_AUTOSUGGEST_STRATEGY=(history completion)   # history first, then completion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${_c_ghost}"
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
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=${_c_hl_ok},fg=${_c_hl_fg},bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=${_c_hl_no},fg=${_c_hl_fg},bold"
HISTORY_SUBSTRING_SEARCH_FUZZY=1            # match words in any order
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1    # no duplicate matches
_zplugin_load zsh-users zsh-history-substring-search
