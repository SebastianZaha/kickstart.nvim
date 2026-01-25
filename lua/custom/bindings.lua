vim.keymap.set({'n', 'v'}, ';', ':')
vim.keymap.set({'n', 'v'}, ':', ';')

-- Floating cheatsheet
vim.keymap.set('n', '<leader>?', function()
  local lines = {
    ' Keybindings Cheatsheet ',
    '',
    ' LSP ──────────────────────────────',
    ' gd  definition    gr  references',
    ' gD  declaration   gI  implementation',
    ' K   hover         <C-k> signature',
    ' <leader>rn rename    <leader>ca code action',
    ' <leader>cf format    <leader>D  type def',
    ' <leader>ds doc symbols  <leader>ws workspace symbols',
    '',
    ' Diagnostics ─────────────────────',
    ' [d / ]d  prev/next diagnostic',
    ' <leader>e  float    <leader>q  list',
    '',
    ' Git Hunks ───────────────────────',
    ' [c / ]c  prev/next hunk',
    ' <leader>hs stage    <leader>hr reset',
    ' <leader>hp preview  <leader>hb blame',
    ' <leader>tb toggle blame  <leader>td toggle deleted',
    '',
    ' Git ─────────────────────────────',
    ' <leader>gs status   <leader>gd diff',
    ' <leader>ga blame    <leader>gl log',
    ' <leader>gp push     <leader>gw browse',
    '',
    ' Search (Telescope) ──────────────',
    ' <leader>sf files    <leader>sg git files',
    ' <leader>s/ grep     <leader>sw grep word',
    ' <leader>sb buffers  <leader>s? recent',
    ' <leader>sd diagnostics  <leader>sh help',
    '',
    ' Treesitter ──────────────────────',
    ' af/if function  ac/ic class  aa/ia param',
    ' ]m / [m  next/prev function',
    ' ]] / [[  next/prev class',
    ' <leader>a / A  swap param next/prev',
    '',
    ' Windows ─────────────────────────',
    ' <C-w>s  split horizontal   <C-w>v  split vertical',
    ' <A-h/j/k/l>  switch window (from any mode)',
    ' <C-\\><C-n>  exit terminal mode',
    '',
    ' Yank ────────────────────────────',
    ' <leader>yp  relative path   <leader>yP  full path',
    ' <leader>yl  path:line (visual: path:start-end)',
    '',
    ' Misc ────────────────────────────',
    ' <leader>ai  AI layout (claude + codex)',
    '',
    ' Press q or <Esc> to close ',
  }

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = 60
  local height = #lines
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = 'minimal',
    border = 'rounded',
  })

  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = 'wipe'
  vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })
end, { desc = 'Keybindings cheatsheet' })

-- <c-s> saves the buffer, optionally exiting insert mode too
vim.keymap.set('n', '<c-s>', ':update<cr>')
vim.keymap.set('i', '<c-s>', '<c-o>:update<cr><esc>')

-- q closes widows
vim.keymap.set('n', 'Q', 'q')
vim.keymap.set('n', 'q', '<esc>:q<cr>')
-- closing the buffer without messing up the window layout
vim.keymap.set('n', '<c-w>b', ':Bdelete<cr>')

-- FIXME: not sure yet if this is useful, or it would be simpler
-- to just bdelete (<c-w>b)
vim.keymap.set('n', '<c-a-o>', function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_exec2('normal \\<C-O>', {})
  vim.cmd.bdelete(bufnr)
end)

-- To use ALT+{h,j,k,l} to navigate window layout from any mode
vim.keymap.set({'i', 't', 'n'}, '<a-h>', '<c-\\><c-N><c-W>h')
vim.keymap.set({'i', 't', 'n'}, '<a-j>', '<c-\\><c-N><c-W>j')
vim.keymap.set({'i', 't', 'n'}, '<a-k>', '<c-\\><c-N><c-W>k')
vim.keymap.set({'i', 't', 'n'}, '<a-l>', '<c-\\><c-N><c-W>l')

-- [G]it
vim.keymap.set('n', '<Leader>gd', ':Gvdiffsplit<CR>')
vim.keymap.set('n', '<Leader>ga', ':Git blame<CR>')
vim.keymap.set('n', '<Leader>gl', ':Git l<CR><C-w>T')
vim.keymap.set('n', '<Leader>gp', ':Git push<CR>')
vim.keymap.set('n', '<leader>gs', ':G<CR><C-w>T')
vim.keymap.set('n', '<leader>gw', ':GBrowse<CR>')

-- file browser
vim.keymap.set('n', '<leader>E', ':Neotree reveal<cr>')

-- AI coding layout: left=editor, right-top=claude, right-bottom=codex
vim.keymap.set('n', '<leader>ai', function()
  vim.cmd('vsplit')           -- split vertical, move to right pane
  vim.cmd('terminal claude')  -- open claude in terminal
  vim.cmd('split')            -- split horizontal, move to bottom pane
  vim.cmd('terminal codex')   -- open codex in terminal
  vim.cmd('wincmd h')         -- return to left pane
end, { desc = 'AI layout: claude + codex' })

-- [Y]ank path
vim.keymap.set('n', '<leader>yp', function()
  vim.fn.setreg('+', vim.fn.expand('%'))
end, { desc = '[Y]ank relative [p]ath' })

vim.keymap.set('n', '<leader>yP', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, { desc = '[Y]ank full [P]ath' })

vim.keymap.set('n', '<leader>yl', function()
  vim.fn.setreg('+', vim.fn.expand('%') .. ':' .. vim.fn.line('.'))
end, { desc = '[Y]ank path with [l]ine' })

vim.keymap.set('v', '<leader>yl', function()
  local start_line = vim.fn.line('v')
  local end_line = vim.fn.line('.')
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  vim.fn.setreg('+', vim.fn.expand('%') .. ':' .. start_line .. '-' .. end_line)
end, { desc = '[Y]ank path with [l]ine range' })

-- [C]ode [F]ormat (using conform.nvim)
vim.keymap.set({'n', 'v'}, '<leader>cf', function()
  require('conform').format({ async = true, lsp_fallback = true })
end, { desc = '[C]ode [F]ormat' })

-- telescope = [S]earch
-- See `:help telescope.builtin`
local builtin = require('telescope.builtin')
local themes  = require('telescope.themes')

vim.keymap.set('n', '<leader>s.',
  function() builtin.current_buffer_fuzzy_find(themes.get_dropdown({previewer = false})) end,
  { desc = 'Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>s/', require("telescope").extensions.live_grep_args.live_grep_args)
vim.keymap.set('n', '<leader>s;', builtin.command_history, { desc = '[S]earch Commands' })
vim.keymap.set('n', '<leader>s?', builtin.oldfiles, { desc = 'Find recently opened files' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[Search] existing [B]uffers' })
vim.keymap.set('n', '<leader>sc', builtin.colorscheme, { desc = 'Colorschemes' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', builtin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })

-- gitsigns [H]unk bindings
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
