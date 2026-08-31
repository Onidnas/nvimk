-- Opciones básicas de Neovim
local opt = vim.opt

-- Números de línea
opt.number = true           -- Mostrar número de línea actual
opt.relativenumber = true   -- Números relativos (útil para motions como 5j, 10k)

-- Tabulación e indentación
opt.tabstop = 2             -- Tamaño visual de un tab
opt.shiftwidth = 2          -- Tamaño de indentación automática
opt.expandtab = true        -- Convertir tabs a espacios
opt.smartindent = true      -- Indentación inteligente al saltar línea

-- Búsqueda
opt.ignorecase = true       -- Ignorar mayúsculas en búsqueda
opt.smartcase = true        -- Pero si pones MAYÚSCULA, busca case-sensitive
opt.hlsearch = true         -- Resaltar coincidencias
opt.incsearch = true        -- Buscar mientras escribes

-- UI / Visual
opt.termguicolors = true    -- Colores 24-bit (necesario para temas modernos)
opt.signcolumn = "yes"      -- Siempre mostrar columna de signos (git, diagnósticos)
opt.cursorline = true       -- Resaltar línea actual
opt.scrolloff = 8           -- Mantener 8 líneas arriba/abajo al hacer scroll
opt.sidescrolloff = 8       -- Lo mismo horizontal
opt.wrap = false            -- No envolver líneas largas
opt.showmode = false        -- No mostrar --INSERT--, --VISUAL-- (lo hace la statusline)

-- Archivos / Backups
opt.swapfile = false        -- No crear .swp files
opt.backup = false          -- No crear backups
opt.undofile = true         -- Guardar historial de undo entre sesiones
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Portapapeles
opt.clipboard = "unnamedplus"  -- Usar portapapeles del sistema (+ y *)

-- Ratón
opt.mouse = "a"             -- Habilitar ratón en todos los modos

-- Split
opt.splitbelow = true       -- Splits horizontales abajo
opt.splitright = true       -- Splits verticales a la derecha

-- Rendimiento
opt.updatetime = 250        -- Tiempo para trigger CursorHold (diagnósticos, etc.)
opt.timeoutlen = 300        -- Tiempo para mapeos en secuencia (ej: <leader>ff)

-- Completado
opt.completeopt = { "menuone", "noselect", "preview" }

-- Folding (plegado de código)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99          -- Abierto por defecto
opt.foldenable = true

-- Diagnostic signs en la signcolumn
vim.diagnostic.config({
  signs = true,
  underline = true,
  virtual_text = { spacing = 4, prefix = "●" },
  float = { border = "rounded" },
})