-- PRELUDE
set = vim.opt

-- DISPLAY SETTINGS
set.background = 'dark'
set.scrolloff = 2
set.showmatch = true
set.showmode = true
set.showcmd = true
set.ruler = true
set.title = true
set.wildmenu = true
set.wildignore = {'*.o', '*.obj', '*.bak', '*.exe', '*.py[co]', '*.swp', '*~', '*.pyc', '*.svn'}
set.laststatus = 2
set.cmdheight = 1
set.matchtime = 2
set.matchpairs = set.matchpairs + '<:>'
set.hlsearch = true
set.incsearch = true
set.wrap = false
set.number = true
set.relativenumber = true
set.syntax = 'on'
set.list = true
set.listchars = 'tab:| ,trail:-,nbsp:+'

vim.cmd('colorscheme gruvbox')

-- EDITOR SETTINGS
set.shortmess = vim.o.shortmess .. 'c'
set.updatetime = 300
set.signcolumn = 'number'
set.encoding = 'utf-8'
set.ignorecase = true
set.smartcase = true
set.smartindent = true
set.smarttab = true
set.magic = true
set.backspace = set.backspace + {'indent', 'eol', 'start'}
set.tabstop = 4
set.shiftwidth = 4

vim.cmd('filetype plugin on')
vim.cmd('filetype plugin indent on')

-- SYSTEM SETTINGS
set.hidden = true
set.mouse = 'a'

-- TAB SETTINGS

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  desc = 'Set correct current directory for active window',
  command = 'lcd %:p:h'
})

local indents = vim.api.nvim_create_augroup('FileIndents', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'xslt,xml,css,html,xhtml,javascript,typescript,sh,config,c,cpp,cs,julia,lisp,asm,lua,crystal,svelte',
  desc = 'Adjust tab settings for specific file types',
  group = indents,
  command = 'set smartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab'
})
vim.api.nvim_create_autocmd('filetype', {
  pattern = 'tex',
  desc = 'adjust tab settings for specific file types',
  group = indents,
  command = 'set smartindent shiftwidth=2 softtabstop=2 expandtab wrap'
})
vim.api.nvim_create_autocmd('filetype', {
  pattern = 'python',
  desc = 'adjust tab settings for specific file types',
  group = indents,
  command = 'set smartindent tabstop=4 shiftwidth=4 softtabstop=4 cinwords=if,elif,else,for,while,try,except,finally,def,class,match expandtab'
})
vim.api.nvim_create_autocmd('filetype', {
  pattern = 'rust',
  desc = 'adjust tab settings for specific file types',
  group = indents,
  command = 'set smartindent tabstop=4 shiftwidth=4 softtabstop=4 expandtab'
})
vim.api.nvim_create_autocmd('filetype', {
  pattern = 'godot',
  desc = 'adjust tab settings for specific file types',
  group = indents,
  command = 'set smartindent tabstop=4 shiftwidth=4 softtabstop=4 expandtab foldmethod=expr'
})
vim.api.nvim_create_autocmd('filetype', {
  pattern = 'make',
  desc = 'adjust tab settings for specific file types',
  group = indents,
  command = 'set smartindent shiftwidth=4 softtabstop=4 noexpandtab'
})

-- PLUGINS

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
  Plug 'rust-lang/rust.vim'
  Plug('jmckiern/vim-shoot', {['do'] = '\"./install.py\" -U geckodriver' })
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tpope/vim-fugitive'
  Plug 'christoomey/vim-system-copy'
  Plug 'tpope/vim-surround'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'tpope/vim-dispatch'
  Plug 'habamax/vim-godot'
  Plug 'vim-crystal/vim-crystal'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'Raimondi/delimitMate'
  Plug 'evanleck/vim-svelte'
  Plug 'windwp/nvim-autopairs'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'onsails/lspkind.nvim'
  Plug 'folke/trouble.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'simrat39/rust-tools.nvim'
  Plug 'lvimuser/lsp-inlayhints.nvim'
vim.call('plug#end')

-- KEY BINDINGS
vim.g.mapleader = ' '
local opts = { noremap=true, silent=true }

vim.keymap.set('n', '<Space>', '<NOP>', opts)

vim.keymap.set('n', '<C-n>', ':NERDTree<CR>', opts)
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>', opts)
vim.keymap.set('n', '<C-f>', ':NERDTreeFind<CR>', opts)
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  desc = "Checks if a NerdTree is the final window and if so kills it to exit nvim",
  callback = function()
    if vim.fn.winnr('$') == 1 and vim.b.NERDTree and vim.b.NERDTree._type == "tab" then -- why is everything nil???
      vim.cmd('quit')
    end
  end
})

local telescope = require('telescope.builtin')
if telescope then
  vim.keymap.set('n', '<leader>ff', telescope.find_files, opts)
  vim.keymap.set('n', '<leader>fg', telescope.live_grep, opts)
  vim.keymap.set('n', '<leader>fb', telescope.buffers, opts)
  vim.keymap.set('n', '<leader>fh', telescope.help_tags, opts)
end

vim.g.airline_powerline_fonts = 1
vim.g.airline_solarized_bg='dark'
vim.g['airline#extensions#nvimlsp#enabled'] = 1
vim.g['airline#extensions#nvimlsp#show_line_numbers'] = 1
vim.g['airline#extensions#nvimlsp#error_symbol'] = ''
vim.g['airline#extensions#nvimlsp#warning_symbol'] = ''
vim.g['airline#extensions#nvimlsp#open_lnum_symbol'] = ' '
vim.g['airline#extensions#nvimlsp#close_lnum_symbol'] = ''

-- LSP

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local luasnip = require('luasnip')
local cmp = require('cmp')
local autopairs = require('nvim-autopairs.completion.cmp')
local handlers = require('nvim-autopairs.completion.handlers')
local lspkind = require('lspkind')
local trouble = require('trouble')
local rust_tools = require('rust-tools')
local inlayhints = require('lsp-inlayhints')

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_create_autocmd('CursorHold', {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
  })

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { async = false }
        end
    })
  end

  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=gray guibg=#342942
      hi! LspReferenceText cterm=bold ctermbg=gray guibg=#342942
      hi! LspReferenceWrite cterm=bold ctermbg=gray guibg=#342942
    ]]
    vim.api.nvim_create_augroup('lsp_document_highlight', {
    clear = false
    })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = 'lsp_document_highlight',
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = 'lsp_document_highlight',
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local servers = { 'rust_analyzer', 'pyright', 'svelte', 'emmet_ls', 'cssls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- because ts is *speciaw*
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local kind = lspkind.cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, '%s', { trimempty = true })
      kind.kind = ' ' .. (strings[1] or '') .. ' '
      kind.menu = '    (' .. (strings[2] or '') .. ')'

      return kind
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require('vim.lsp.log')
  local api = vim.api

  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, 'No location found')
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command('copen')
        api.nvim_command('wincmd p')
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

vim.lsp.handlers['textDocument/definition'] = goto_definition('split')

inlayhints.setup()
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) or vim.bo.filetype == "rust" then -- rust tools inlay hints reign supreme
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    inlayhints.on_attach(client, bufnr)
  end,
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


cmp.event:on(
  'confirm_done',
  autopairs.on_confirm_done({
    filetypes = {
      ['*'] = {
        ['('] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method,
          },
          handler = handlers['*']
        },
        ['{'] = {
          kind = {
            cmp.lsp.CompletionItemKind.Struct,
          },
          handler = handlers['*']
        }
      },
    }
  })
)

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

trouble.setup()

vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>',
  {silent = true, noremap = true}
)
vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>',
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)

rust_tools.setup({
  server = {
    on_attach = on_attach
  }
})

-- NEOVIDE

if vim.g.neovide then
  vim.g.neovide_transparency = 0.9
  vim.g.neovide_cursor_trail_size = 10
  vim.g.neovide_cursor_vfx_mode = "ripple"
end
