-- example vim cmd with multiline string
-- vim.cmd [[
--  function! FooBarLuaScript()
--  [...]
--  endfunction
-- ]]

vim.o.autoread = true -- autoload file changes. undo by pressing u
vim.o.scrolloff = 7 -- cursor lines when at the top or bottom of the screen
vim.o.sidescrolloff = 5
vim.o.number = true
vim.o.relativenumber = true
vim.o.diffopt = 'internal,filler,vertical,hiddenoff,closeoff,algorithm:patience'
vim.o.splitbelow = true
vim.o.splitright = true
-- !! this is overwritten from the lualine plugin.
-- I keep it here for when I inevitably change or remove that plugin.
vim.o.laststatus = 3
-- I don't like folds
vim.o.foldenable = false

-- indenting and tabs related
vim.o.expandtab = true -- use spaces for indenting
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = '>>'
vim.o.breakindent = true
vim.o.breakindentopt = 'shift:4'

-- color related
vim.o.termguicolors = true
vim.o.cursorline = true
-- vim.cmd("colorscheme solar-paper")

-- just disable the annoying Ctrl-C bind in sql files.
-- I'm using it to exit edit mode.
vim.cmd [[ let g:ftplugin_sql_omni_key = '<C-ș>' ]]

-- terminal settings, startinsert on enter, Bdelete on exit

vim.api.nvim_create_augroup('TerminalSetup', { clear = true })

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  group = 'TerminalSetup',
  callback = function()
    vim.opt_local.filetype = 'terminal'
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.statuscolumn = ''
    vim.cmd.startinsert()
  end,
})

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
  pattern = 'term://*',
  group = 'TerminalSetup',
  callback = function()
    vim.cmd.startinsert()
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*',
  group = 'TerminalSetup',
  callback = function(event)
    vim.print(event)
    if not event.status then
      vim.cmd 'Bdelete'
    end
  end,
})

-- telescope

vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  callback = function(args)
    vim.wo.wrap = true
  end,
})
