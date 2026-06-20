return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
	debounce = 75,
        auto_trigger = false,
	trigger_on_accept = true,
	hide_during_completions = true,
	keymap = {
	    accept = "<M-l>",
	    next = "<M-]>",
	    prev = "<M-[>",
	    dismiss = "<C-]>",
	},
      },
      panel = {
        enabled = false,
      },
      filetypes = {
        markdown = true,
        help = true,
	gitcommit = true,
      },
    },
  },
}
