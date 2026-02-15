# dotfiles

## Principoj

- Esti malpeza  
- Uzi minimuman nombron da aldonaĵoj  
- Fari tion per normaj funkcioj kiam eblas  
- Resti prizorgebla por mi post unu jaro  
- Ebligi reinstalon el tute malplena medio  

Ne tro dependi de aldonaĵoj.

---

## Instalado

Ruli `install.sh`.

---

## Dependecoj

### Eksteraj programoj

- **Neovim**
  - Oficiala retejo: https://neovim.io/  
  - Oficiala opcio-listo: https://neovim.io/doc/user/options.html  

- **Git**
  - Oficiala retejo: https://git-scm.com/  
  - Oficiala dokumentaro: https://git-scm.com/docs  

- **Jujutsu (jj)**
  - Oficiala retejo: https://github.com/jj-vcs/jj  
  - Oficiala dokumentaro: https://github.com/jj-vcs/jj/tree/main/docs  

- **Starship**
  - Oficiala retejo: https://starship.rs/  
  - Oficiala opcio-listo: https://starship.rs/config/  

- **fzf**
  - Oficiala retejo: https://github.com/junegunn/fzf  
  - Oficiala dokumentaro: https://github.com/junegunn/fzf#usage  

- **WezTerm**
  - Oficiala retejo: https://wezfurlong.org/wezterm/  
  - Oficiala opcio-listo: https://wezfurlong.org/wezterm/config/files.html  

---

### Tiparo

- **UDEV Gothic 35NFLG**
  - Elŝutejo: https://github.com/yuru7/udev-gothic  

Oni supozas Nerd Font-kongruajn glifojn.

---

## Neovim

### Dosier-strukturo

- `nvim/init.lua`  
  Kerna agordo (opcioj, klavmapoj ktp.)

- `nvim/lua/plugins/plugin_init.lua`  
  Difino de aldonaĵoj (per lazy.nvim)

---

## Aldonaĵoj

### Administrilo de aldonaĵoj

- **lazy.nvim**
  - Oficiala retejo: https://github.com/folke/lazy.nvim  
  - Oficiala dokumentaro: https://lazy.folke.io/  

### Kolorskemo
- **gruvbox-material**
  - Oficiala retejo: https://github.com/sainnhe/gruvbox-material
  - Se vi deziras fari ŝanĝojn, `:colorscheme gruvbox-material`
 
- **gruvbox-baby**
  - Oficiala retejo: https://github.com/luisiacc/gruvbox-baby  
  - Se vi deziras fari ŝanĝojn, `:colorscheme gruvbox-baby`
  - Ĉefa kolorskemo

- **catppuccin**
  - Oficiala retejo: https://github.com/catppuccin/nvim
  - Helkolora temo: catppuccin-Latte
  - Malhelaj temoj: catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
  - Se vi volas ŝanĝi la temon, uzu `:colorscheme catppuccin-frappe`

### UI / Montrado

- **nvim-web-devicons**
  - Oficiala retejo: https://github.com/nvim-tree/nvim-web-devicons  

- **lualine.nvim**
  - Oficiala retejo: https://github.com/nvim-lualine/lualine.nvim  

- **which-key.nvim**
  - Oficiala retejo: https://github.com/folke/which-key.nvim  

- **hlchunk.nvim**
  - Oficiala retejo: https://github.com/shellRaining/hlchunk.nvim  

### Dosier-manipulado

- **oil.nvim**
  - Oficiala retejo: https://github.com/stevearc/oil.nvim  

### Serĉo / Fuzzy

- **fzf-lua**
  - Oficiala retejo: https://github.com/ibhagwan/fzf-lua  

### Terminalo

- **toggleterm.nvim**
  - Oficiala retejo: https://github.com/akinsho/toggleterm.nvim  

### Treesitter

- **nvim-treesitter**
  - Oficiala retejo: https://github.com/nvim-treesitter/nvim-treesitter  

### LSP / Evolu-helpo

- **mason.nvim**
  - Oficiala retejo: https://github.com/williamboman/mason.nvim  
  - Per Mason oni instalas la jenajn ilojn:
    - gopls
    - golangci-lint
    - tree-sitter-cli
  
- **mason-lspconfig.nvim**
  - Oficiala retejo: https://github.com/williamboman/mason-lspconfig.nvim  

- **nvim-lspconfig**
  - Oficiala retejo: https://github.com/neovim/nvim-lspconfig  

- **lsp_signature.nvim**
  - Oficiala retejo: https://github.com/ray-x/lsp_signature.nvim  

- **fidget.nvim**
  - Oficiala retejo: https://github.com/j-hui/fidget.nvim  

### Aŭtomata kompletigo

- **blink.cmp**
  - Oficiala retejo: https://github.com/saghen/blink.cmp
  - Oficiala dokumentaro: https://cmp.saghen.dev/

### Formatado

- **conform.nvim**
  - Oficiala retejo: https://github.com/stevearc/conform.nvim  

### Eniga helpo

- **nvim-autopairs**
  - Oficiala retejo: https://github.com/windwp/nvim-autopairs

### Lint

- **nvim-lint**
  - Oficiala retejo: https://github.com/mfussenegger/nvim-lint  

### Git

- **gitsigns.nvim**
  - Oficiala retejo: https://github.com/lewis6991/gitsigns.nvim  
