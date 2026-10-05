-- 排空模拟任务队列，并统计关键对象是否真的构建出来
local n = __drain(400000)
__REPORT = {}
local function say(s) __REPORT[#__REPORT + 1] = s end

say("协程恢复 " .. n .. " 次（残留常驻循环 " .. #__COROS .. " 个，属正常）")
say("Aether：" .. type(Aether) .. " / new：" .. type(Aether and Aether.new) .. " / v" .. tostring(Aether and Aether.Version))

local function count(inst, cls)
	local c = 0
	for _, d in ipairs(inst:GetDescendants()) do if not cls or d.ClassName == cls then c = c + 1 end end
	return c
end
local CG = game:GetService("CoreGui")
say("实例统计 ScreenGui=" .. count(CG, "ScreenGui") .. " Frame=" .. count(CG, "Frame")
	.. " TextLabel=" .. count(CG, "TextLabel") .. " TextButton=" .. count(CG, "TextButton")
	.. " TextBox=" .. count(CG, "TextBox"))