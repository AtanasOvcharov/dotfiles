zvm_after_init() {
  # History substring search on arrows.
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down

  # Same for vi insert/main maps, because zsh-vi-mode can reset maps.
  bindkey -M viins '^[[A' history-substring-search-up
  bindkey -M viins '^[[B' history-substring-search-down
  bindkey -M main '^[[A' history-substring-search-up
  bindkey -M main '^[[B' history-substring-search-down

  # Vim-like history scroll in NORMAL mode.
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down

  # Autosuggestion accept: Ctrl+Space.
  bindkey '^ ' autosuggest-accept
  bindkey -M viins '^ ' autosuggest-accept

  # fzf widgets.
  bindkey '^F' _fzf_file_no_hidden
  bindkey -M viins '^F' _fzf_file_no_hidden

  # Ctrl-R: fzf history search.
  # fzf must be loaded first by .zshrc, otherwise fzf-history-widget will not exist.
  if (( $+widgets[fzf-history-widget] )); then
    bindkey '^R' fzf-history-widget
    bindkey -M viins '^R' fzf-history-widget
    bindkey -M vicmd '^R' fzf-history-widget
  fi
}
