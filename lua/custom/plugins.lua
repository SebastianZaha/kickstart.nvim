-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'vim-ruby/vim-ruby',

  'mfussenegger/nvim-lsp-compl',
  'mfussenegger/nvim-jdtls',

  -- [] mappings for args, quickfix, buffers, tabs, locations
  -- [<Space> to add line before cursor, [e to exchange line with line above
  -- yo<char> to toggle some options
  -- :help unimpaired
  'tpope/vim-unimpaired',

  -- :Bdelete and :Bwipeout to not mess up window layout
  'famiu/bufdelete.nvim',

  -- remember last position per file
  { 'vladdoster/remember.nvim', config = [[ require('remember') ]] },

  -- provides widgets for vim.ui.select and vim.ui.input; 
  { 'stevearc/dressing.nvim', opts = {}, },

  -- colorschemes
  { 'rktjmp/lush.nvim', lazy = true }, -- for colorscheme customization
  -- light
  { 'yorickpeterse/nvim-grey' },
  { 'yorickpeterse/vim-paper' },
  { 'chiendo97/intellij.vim' },
  -- dark
  { 'yorickpeterse/happy_hacking.vim' },
  { 'Luxed/ayu-vim' },
  { 'navarasu/onedark.nvim', opts = { style = 'darker' } },
  { 'cocopon/iceberg.vim' },
  { 'rakr/vim-one' },
  { 'rebelot/kanagawa.nvim' },

  { 'SebastianZaha/nvim-solar-paper' },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- The default icons are removed as they were not rendering properly.
  -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/998#issuecomment-1597344948
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      default_component_configs = {
        icon = {
          folder_closed = "+",
          folder_open = "-",
          folder_empty = "%",
          default = ""
        },
        git_status = {
          symbols = {
            deleted = "",
            renamed = "",
            modified = "",
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = ""
          }
        }
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["l"] = "open",
          ["h"] = "open",
        }
      },
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
        },
        components = {
          icon = function(config, node, state)
            if node.type == "file" or node.type == "directory" then
              return {}
            end
            return require("neo-tree.sources.common.components").icon(config,
              node, state)
          end
        }
      },
    },
  }
}

-- vim: ts=2 sts=2 sw=2 et
