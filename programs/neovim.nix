{config, pkgs}:
{
  enable = true;
  viAlias = true;
  vimAlias = true;
  defaultEditor = true;

  plugins = with pkgs.vimPlugins; [
    ansible-vim
    # copilot-vim
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
    vim-elixir
    vim-endwise
    vim-fish
    vim-fugitive
    vim-git
    vim-go
    vim-markdown
    vim-nix
    vim-projectionist
    vim-ragtag
    vim-repeat
    vim-surround
    vim-terraform
  ];

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
