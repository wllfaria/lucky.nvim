local breeds = require "lua.lucky.breeds"
local contrast_ratio = require "tests.accessibility.helpers.calculate_contrast"

local function includes(arr, val)
	for i = 1, #arr do
		if arr[i] == val then
			return true
		end
	end
	return false
end

for breed, colors in pairs(breeds) do
	local bg0 = colors.bg0
	local bg1 = colors.bg1
	local bg2 = colors.bg2
	local bg3 = colors.bg3
	local bg4 = colors.bg4

	local is_correct = true

	print("Testing breed: " .. breed)
	for group, color in pairs(colors) do
		if includes({"bg0", "bg1", "bg2", "bg3", "bg4"}, group) == false then
			print("Testing group " .. group)
			local bg0_status = contrast_ratio.verify_contrast_ratio(color, bg0, "bg0", group)
			local bg1_status = contrast_ratio.verify_contrast_ratio(color, bg1, "bg1", group)
			local bg2_status = contrast_ratio.verify_contrast_ratio(color, bg2, "bg2", group)
			local bg3_status = contrast_ratio.verify_contrast_ratio(color, bg3, "bg3", group)
			local bg4_status = contrast_ratio.verify_contrast_ratio(color, bg4, "bg4", group)
			if bg0_status == false or bg1_status == false or bg2_status == false or bg3_status == false or bg4_status == false then
				is_correct = false
			end
		end
	end

	print("Breed " .. breed .. " contrast is " .. (is_correct and "correct" or "incorrect"))
end
