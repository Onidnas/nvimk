-- 1. Ruta donde se instalará lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 2. Si no existe, clonarlo desde GitHub automáticamente
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- 3. Añadir lazy.nvim al runtimepath de Neovim
vim.opt.rtp:prepend(lazypath)

-- 4. Teclas líderes (Space) antes de cargar plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 5. Inicialización de lazy.nvim
require("lazy").setup({
  spec = {
    -- Carga automáticamente todos los plugins definidos en lua/plugins/
    { import = "plugins" },
  },
  -- Tema que se usará temporalmente mientras instala otros plugins
  install = { colorscheme = { "habamax" } },
  -- Verificar actualizaciones automáticamente en segundo plano
  checker = { enabled = true },
})
