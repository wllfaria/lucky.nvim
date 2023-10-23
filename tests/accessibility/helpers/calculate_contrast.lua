local M = {}

local RED = 0.2126
local GREEN = 0.7152
local BLUE = 0.0722

local function hex_to_rgb_normalized(hex)
    hex = hex:gsub("#","")
    local r = tonumber("0x" .. hex:sub(1, 2)) / 255
    local g = tonumber("0x" .. hex:sub(3, 4)) / 255
    local b = tonumber("0x" .. hex:sub(5, 6)) / 255
    return r, g, b
end

local function calculate_luminance(foreground_color, background_color)
	local r1, g1, b1 = hex_to_rgb_normalized(foreground_color)
	local r2, g2, b2 = hex_to_rgb_normalized(background_color)

	local luminance1 = (r1 * RED) + (g1 * GREEN) + (b1 * BLUE)
	local luminance2 = (r2 * RED) + (g2 * GREEN) + (b2 * BLUE)

	return luminance1, luminance2
end

local function calculate_contrast_ratio(luminance1, luminance2)
	local lighter_luminance = math.max(luminance1, luminance2)
	local darker_luminance = math.min(luminance1, luminance2)

	local contrast_ratio = (lighter_luminance + 0.05) / (darker_luminance + 0.05)

	return contrast_ratio
end

M.verify_contrast_ratio = function(foreground_color, background_color, background_group, foreground_group)
	local fg_luminance, bg_luminance = calculate_luminance(foreground_color, background_color)
	local contrast_ratio = calculate_contrast_ratio(fg_luminance, bg_luminance)

	if contrast_ratio <= 3.0 then
		print("Contrast ratio between " .. foreground_color .. " (" .. foreground_group .. ") and " .. background_color .. " (" .. background_group .. ") is too low (FAILS)")
		return false
	elseif contrast_ratio > 3.0 and contrast_ratio <= 4.5 then
		print("Contrast ratio between " .. foreground_color .. " (" .. foreground_group .. ") and " .. background_color .. " (" .. background_group .. ") is acceptable (AA-Large)")
		return true
	elseif contrast_ratio > 4.5 and contrast_ratio <= 7.0 then
		print("Contrast ratio between " .. foreground_color .. " (" .. foreground_group .. ") and " .. background_color .. " (" .. background_group .. ") is good (AA)")
		return true
	else
		print("Contrast ratio between " .. foreground_color .. " (" .. foreground_group .. ") and " .. background_color .. " (" .. background_group .. ") is great (AAA)")
		return true
	end
end

return M
