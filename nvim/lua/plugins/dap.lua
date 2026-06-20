return {
  -- Core DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jedrzejboczar/nvim-dap-cortex-debug",
    },
    config = function()
      local dap = require("dap")
      -- Mason DAP setup
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = {
          "codelldb",
        },
        handlers = {},
      })
      -- DAP UI
      local dapui = require("dapui")

      dapui.setup({
	  layouts = {
	      {
		  elements = {
		      { id = "scopes", size = 0.7 },
		      { id = "watches", size = 0.3 },
		  },
		  size = 40,
		  position = "right",
	      },
	      {
		  elements = {
		      { id = "repl", size = 0.5 },
		      { id = "console", size = 0.5 },
		  },
		  size = 10,
		  position = "bottom",
	      },
	  },
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Virtual text
      require("nvim-dap-virtual-text").setup()

      -- Signs
      vim.fn.sign_define("DapBreakpoint", {
        text = "●",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "▶",
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })

      -- Keymaps
      vim.keymap.set("n", "<F5>", function()
        dap.continue()
      end, { desc = "DAP Continue" })

      vim.keymap.set("n", "<F10>", function()
        dap.step_over()
      end, { desc = "DAP Step Over" })

      vim.keymap.set("n", "<F11>", function()
        dap.step_into()
      end, { desc = "DAP Step Into" })

      vim.keymap.set("n", "<F12>", function()
        dap.step_out()
      end, { desc = "DAP Step Out" })

      vim.keymap.set("n", "<leader>db", function()
        dap.toggle_breakpoint()
      end, { desc = "DAP Toggle Breakpoint" })

      vim.keymap.set("n", "<leader>dr", function()
        dap.repl.open()
      end, { desc = "DAP REPL" })

      vim.keymap.set("n", "<leader>dl", function()
        dap.run_last()
      end, { desc = "DAP Run Last" })

      vim.keymap.set("n", "<leader>du", function()
        dapui.toggle()
      end, { desc = "DAP UI Toggle" })

      vim.keymap.set("n", "<leader>dt", function()
        dap.terminate()
      end, { desc = "DAP Terminate" })

      vim.keymap.set("n", "<leader>dh", function()
	  require("dap.ui.widgets").hover()
      end, { desc = "DAP Hover" })

      vim.keymap.set("n", "<leader>dp", function()
	  require("dap.ui.widgets").preview()
      end, { desc = "DAP Preview" })

      vim.keymap.set("n", "<leader>dw", function()
	  require("dapui").elements.watches.add()
      end, { desc = "DAP Add Watch" })

      -- Local C / C++ debugging with codelldb
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.c = {
        {
          name = "Launch C executable",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      dap.configurations.cpp = dap.configurations.c

      -- STM32 debugging with ST-Link + OpenOCD
      local cortex_debug = require("dap-cortex-debug")

      cortex_debug.setup({})

      table.insert(
        dap.configurations.c,
        cortex_debug.openocd_config({
          name = "STM32F0: ST-Link OpenOCD",
          cwd = "${workspaceFolder}",

          executable = function()
            return vim.fn.input("Path to ELF: ", vim.fn.getcwd() .. "/build/", "file")
          end,

          gdbPath = "gdb-multiarch",
          gdbTarget = "localhost:3333",

          configFiles = {
            "interface/stlink.cfg",
            "target/stm32f0x.cfg",
          },

          runToEntryPoint = "main",
          showDevDebugOutput = false,
        })
      )
    end,
  },
}
