local default_config = require "lucky.config"
local breeds = require "lucky.breeds"

local Lucky = {}
Lucky.config = default_config
Lucky.breeds = breeds

local function get_breed()
	local colors = Lucky.breeds
	local config = Lucky.config

	return colors[config.breed]
end

local function get_groups()
	local config = Lucky.config
	local breed = get_breed()

	local groups = {
		Normal = { fg = breed.fg1, bg = breed.bg0 },

		-- Syntax
		Comment = {fg = breed.gray },
		Conditional = {fg = breed.red},
		Debug = {fg = breed.fg1},
		Delimiter = {fg = breed.fg1},
		Exception = {fg = breed.fg1},
		Function = {fg = breed.orange},
		Identifier = {fg = breed.fg0},
		Keyword = {fg = breed.red},
		Label = {fg = breed.fg1},
		Noise = {fg = breed.fg1},
		Operator = {fg = breed.aqua},
		Repeat = {fg = breed.fg1},
		Statement = {fg = breed.fg1},
		StorageClass = {fg = breed.fg1},
		Structure = {fg = breed.fg1},
		Type = {fg = breed.fg1},
		Typedef = {fg = breed.fg1},

		-- Literals
		Constant = {fg = breed.red},
		String = {fg = breed.orange},
		Character = {fg = breed.orange},
		Number = {fg = breed.yellow},
		Boolean = {fg = breed.red},
		Float = {fg = breed.yellow},

		-- Pre-processor
		Define = { fg = breed.red },
		Include = { fg = breed.red },
		Macro = { fg = breed.red },
		PreCondit = { fg = breed.red },
		PreProc = { fg = breed.red },

		-- Editor UI
		StatusLine = { fg = breed.red, bg = breed.blue },
		StatusLineNC = { fg = breed.red, bg = breed.blue },

		-- Searching
		IncSearch = {bg = breed.purple, fg = breed.bg0, nocombine = true},
		Search = {fg = breed.purple, underline = true},
	}

	return groups
end

Lucky.setup = function(config)
	Lucky.config = vim.tbl_deep_extend("force", Lucky.config, config or {})
end

Lucky.load = function()
	if vim.g.colors_name then
    vim.cmd.hi("clear")
  end

	vim.g.colors_name = "lucky"
  vim.o.termguicolors = true

  local groups = get_groups()

  for group, color in pairs(groups) do
    vim.api.nvim_set_hl(0, group, color)
  end
end

Lucky.load()

return Lucky
