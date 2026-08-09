export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'  

# Ctrl-T uses fd
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# --- fzf UI: layout is shared, colors follow TERM_APPEARANCE ---
_fzf_layout_opts="
  --height=60%
  --layout=reverse
  --border=rounded
  --info=inline
  --prompt='󰱼  '
  --pointer='❯'
  --marker='✓'
  --preview-window=right:65%:wrap:border-left
"

if [[ ${TERM_APPEARANCE:-dark} == light ]]; then
  # Catppuccin Latte
  _fzf_color_opts="
    --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39
    --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78
    --color=marker:#40a02b,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39
    --color=selected-bg:#bcc0cc
    --color=border:#9ca0b0
  "
  export BAT_THEME="Catppuccin Latte"
else
  # Catppuccin Mocha
  _fzf_color_opts="
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
    --color=marker:#a6e3a1,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
    --color=selected-bg:#45475a
    --color=border:#6c7086
  "
  export BAT_THEME="Catppuccin Mocha"
fi

export FZF_DEFAULT_OPTS="${_fzf_layout_opts}${_fzf_color_opts}"
unset _fzf_layout_opts _fzf_color_opts

export _FZF_PREVIEW_CMD='batcat --color=always --style=plain,numbers --line-range=:500 {}'
export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"

# Ctrl+F: file picker excluding hidden files
_fzf_file_no_hidden() {
  local cmd result
  cmd="${FZF_DEFAULT_COMMAND/--hidden /}"
  result=$(eval "${cmd:-find . -type f}" | fzf --preview "$_FZF_PREVIEW_CMD") \
    && LBUFFER+="$result"  # LBUFFER is the text left of the cursor
  zle reset-prompt
}
zle -N _fzf_file_no_hidden
