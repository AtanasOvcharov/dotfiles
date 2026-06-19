zvm_after_init() {
  # history-substring-search on arrows
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down

  # ...and on j/k in NORMAL mode (vim-like history scroll)
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down

  # autosuggestion accept (Ctrl+Space)
  bindkey '^ ' autosuggest-accept
} 
