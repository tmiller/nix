{config, pkgs}:
{
  enable = true;
  viAlias = true;
  vimAlias = true;
  defaultEditor = true;

  plugins = with pkgs.vimPlugins; [
    ansible-vim
    copilot-vim
    {
      plugin = fzf-vim;
      config = ''
        nnoremap <c-p> :FZF<cr>
        nnoremap <localleader>b :Buffers<cr>
        let g:fzf_action = {
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit'
        \ }
      '';
    }
    {
      plugin = gruvbox;
      config = ''
        let g:gruvbox_italic=1
        set background=dark
        colorscheme gruvbox
      '';
    }
    {
      plugin = nvim-lspconfig;
      type = "lua";
      config = ''
        local lspconfig = require('lspconfig')
        lspconfig.nixd.setup{}

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<space>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<space>f', function()
              vim.lsp.buf.format { async = true }
            end, opts)
          end,
        })
      '';
    }
    rust-vim
    tabular
    {
      plugin = vim-easy-align;
      config = ''
        xmap ga <Plug>(EasyAlign)
        nmap ga <Plug>(EasyAlign)
      '';
    }
    vim-cue
    vim-dadbod
    vim-dispatch
    vim-elixir
    vim-endwise
    vim-fish
    vim-fugitive
    vim-git
    vim-go
    {
      plugin = vim-markdown;
      config = ''
        let g:vim_markdown_folding_disabled = 1
      '';
    }
    vim-nix
    {
      type = "lua";
      plugin = pkgs.vimUtils.buildVimPlugin {
        name = "vim-oil";
        src = pkgs.fetchFromGitHub {
          owner = "stevearc";
          repo = "oil.nvim";
          rev = "d27bfa1f370e8caddf65890364989b76f9794afb";
          sha256 = "sha256-TTrSbK8TmzbzSGVOU/ASy8bZJ/teFmh9naLLSs2RrAE=";
        };
      };
      config = ''
        require("oil").setup()
      '';
    }
    vim-projectionist
    vim-ragtag
    vim-repeat
    vim-surround
    vim-terraform
  ];

  extraLuaConfig = "\n";

  extraConfig = ''
    " Load plugins
    filetype plugin indent on

    "=============================================
    " Options
    "=============================================

    " Color
    set termguicolors
    syntax on

    set cursorline

    " Search
    set ignorecase
    set smartcase

    " Tab completion
    set wildmode=list:longest,full
    set wildignore=*.swp,*.o,*.so,*.exe,*.dll

    " Scroll
    set scrolloff=3

    " Tab settings
    set ts=2
    set sw=2
    set expandtab

    " Hud
    set ruler
    set number
    set nowrap
    set fillchars=vert:\│
    set colorcolumn=80

    " Buffers
    set hidden

    " Backup Directories
    set backupdir=~/.config/nvim/backups,.
    set directory=~/.config/nvim/swaps,.
    if exists('&undodir')
      set undodir=~/.config/nvim/undo,.
    endif

    "=============================================
    " Remaps
    "=============================================

    let mapleader=','
    let maplocalleader=','

    " No arrow keys
    map <Left>  :echo "ಠ_ಠ"<cr>
    map <Right> :echo "ಠ_ಠ"<cr>
    map <Up>    :echo "ಠ_ಠ"<cr>
    map <Down>  :echo "ಠ_ಠ"<cr>

    " Jump key
    nnoremap ` '
    nnoremap ' `

    " Change pane
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Turn off search highlight
    nnoremap <localleader>/ :nohlsearch<CR>

    " Trim trailing whitespace
    nnoremap <localleader>tw m`:%s/\s\+$//e<CR>``

    "=============================================
    " Other Settings
    "=============================================

    " https://github.com/neovim/neovim/issues/7861
    autocmd VimResized * redraw!

    " set spell on filetypes that it matters
    autocmd FileType gitcommit setlocal spell
    autocmd FileType markdown setlocal spell

  '';

}
