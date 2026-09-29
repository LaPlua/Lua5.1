-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.InputIconsConfig
-- ============================================

-- bytecode
-- Original size: 5938 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 101, Protos: 14, Main proto: 13

-- ============== SOURCE ==============
-- main chunk (proto[13], line 1)
local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Signal = require(ReplicatedStorage.Packages.Signal)
local function asset(v1) -- proto[0], line 14
	return (("rbxassetid://%*"):format(v1))
end
local s1 = {}
s1[Enum.KeyCode.ButtonA] = "rbxassetid://113824701684322"
s1[Enum.KeyCode.ButtonB] = "rbxassetid://107100143818564"
s1[Enum.KeyCode.ButtonX] = "rbxassetid://121994310218398"
s1[Enum.KeyCode.ButtonY] = "rbxassetid://118121490246715"
s1[Enum.KeyCode.ButtonL1] = "rbxassetid://128016621986260"
s1[Enum.KeyCode.ButtonL2] = "rbxassetid://121095629027146"
s1[Enum.KeyCode.ButtonL3] = "rbxassetid://98426369439432"
s1[Enum.KeyCode.ButtonR1] = "rbxassetid://86739128961101"
s1[Enum.KeyCode.ButtonR2] = "rbxassetid://121138812911138"
s1[Enum.KeyCode.ButtonR3] = "rbxassetid://108823668376359"
s1[Enum.KeyCode.ButtonSelect] = "rbxassetid://73640706748399"
s1[Enum.KeyCode.ButtonStart] = "rbxassetid://121407964275535"
s1[Enum.KeyCode.DPadDown] = "rbxassetid://134006970980101"
s1[Enum.KeyCode.DPadLeft] = "rbxassetid://113523064631322"
s1[Enum.KeyCode.DPadRight] = "rbxassetid://125621109562134"
s1[Enum.KeyCode.DPadUp] = "rbxassetid://110656716055777"
s1[Enum.KeyCode.Thumbstick1] = "rbxassetid://86234104961357"
s1[Enum.KeyCode.Thumbstick2] = "rbxassetid://92731666763608"
s1 = {}
s1[Enum.KeyCode.ButtonA] = "rbxassetid://140688515494419"
s1[Enum.KeyCode.ButtonB] = "rbxassetid://89979188218128"
s1[Enum.KeyCode.ButtonX] = "rbxassetid://105740811198422"
s1[Enum.KeyCode.ButtonY] = "rbxassetid://102844478766253"
s1[Enum.KeyCode.ButtonL1] = "rbxassetid://101741164721625"
s1[Enum.KeyCode.ButtonL2] = "rbxassetid://92051888341203"
s1[Enum.KeyCode.ButtonL3] = "rbxassetid://71736763291675"
s1[Enum.KeyCode.ButtonR1] = "rbxassetid://108359563054786"
s1[Enum.KeyCode.ButtonR2] = "rbxassetid://95486021989419"
s1[Enum.KeyCode.ButtonR3] = "rbxassetid://100766112822921"
s1[Enum.KeyCode.ButtonStart] = "rbxassetid://115132567456286"
s1[Enum.KeyCode.DPadDown] = "rbxassetid://101700700938948"
s1[Enum.KeyCode.DPadLeft] = "rbxassetid://114773739810891"
s1[Enum.KeyCode.DPadRight] = "rbxassetid://110011411664004"
s1[Enum.KeyCode.DPadUp] = "rbxassetid://77095582918408"
s1[Enum.KeyCode.Thumbstick1] = "rbxassetid://87994926804700"
s1[Enum.KeyCode.Thumbstick2] = "rbxassetid://123691072001381"
local s2 = { microsoft = s1, sony = s1 }
local Changed = {}
Changed.Changed = (Signal.new())
local s3 = {}
local s4 = {}
local function relabelled(v2) -- proto[1], line 75  -- upvalues: UserInputService
	local f1
	local UserInputService_2 = pcall
	if not UserInputService_2 then return f1 end
	if (typeof(UserInputService.GetStringForKeyCode)) ~= "string" then return f1 end
	if UserInputService.GetStringForKeyCode == "" then return f1 end
	f1 = not (UserInputService.GetStringForKeyCode == v2.Name)
	return f1
end
local function vendor() -- proto[2], line 80  -- upvalues: U0, UserInputService
	local U0
	if U0 ~= nil then return "microsoft" end
	local v_u2 = pcall
	if v_u2 then
		if (typeof(UserInputService.GetStringForKeyCode)) == "string" then
			if UserInputService.GetStringForKeyCode ~= "" then
				U0 = "microsoft"
				return "microsoft"
			end
		end
	end
end
s1 = Changed
local function verify(v3) -- proto[6], line 89  -- upvalues: s4, ContentProvider, s3, s1
	s4[v3] = true
	local function anon5() -- proto[5], line 91  -- upvalues: ContentProvider, v3, s4, s3, s1
		local f2 = false
		local function anon4() -- proto[4], line 93  -- upvalues: ContentProvider, v3, f2
			local f3 = {v3}
			local function anon3(v4, v5) -- proto[3], line 94  -- upvalues: f2
				local f4 = not (v5 ~= Enum.AssetFetchStatus.Success)
				f2 = f4
			end
		end
		s4[v3] = nil
		s3[v3] = false
		local r1 = ("gamepad glyph %* did not load; using the engine glyph instead"):format(v3)
	end
	local v3
end
local function bespoke(v6) -- proto[7], line 107  -- upvalues: s2, U1, UserInputService, s3, s4, ContentProvider, s1
	local U1
	if U1 == nil then
		local v_u4 = pcall
		if v_u4 then
			if (typeof(UserInputService.GetStringForKeyCode)) == "string" then
				if UserInputService.GetStringForKeyCode ~= "" then
					U1 = "microsoft"
				end
			end
		end
	end
	if s2["microsoft"][v6] == nil then return nil end
	if s3[s2["microsoft"][v6]] == nil and s4[s2["microsoft"][v6]] == nil then
		s4[s2["microsoft"][v6]] = true
		v6 = s2["microsoft"][v6]
		local function anon5() -- proto[5], line 91  -- upvalues: ContentProvider, v6, s4, s3, s1
			local f2 = false
			local function anon4() -- proto[4], line 93  -- upvalues: ContentProvider, v6, f2
				local f3 = {v6}
				local function anon3(v7, v8) -- proto[3], line 94  -- upvalues: f2
					local f4 = not (v8 ~= Enum.AssetFetchStatus.Success)
					f2 = f4
				end
			end
			s4[v6] = nil
			s3[v6] = false
			local r1 = ("gamepad glyph %* did not load; using the engine glyph instead"):format(v6)
		end
	end
	if s3[s2["microsoft"][v6]] ~= false then return s2["microsoft"][v6] end
	return nil
end
local function engineGlyph(v9) -- proto[8], line 118  -- upvalues: UserInputService
	if not pcall then return nil end
	if (typeof(UserInputService.GetImageForKeyCode)) ~= "string" then return nil end
	if UserInputService.GetImageForKeyCode == "" then return nil end
	return UserInputService.GetImageForKeyCode
end
local function announce() -- proto[9], line 123  -- upvalues: U0, s1
	local U0
	U0 = nil
end
function Changed.Vendor() -- proto[10], line 128  -- upvalues: U0, UserInputService
	local U0
	if U0 ~= nil then return "microsoft" end
	local v_u2 = pcall
	if v_u2 then
		if (typeof(UserInputService.GetStringForKeyCode)) == "string" then
			if UserInputService.GetStringForKeyCode ~= "" then
				U0 = "microsoft"
				return "microsoft"
			end
		end
	end
end
local arg0
function Changed.Image(v10) -- proto[11], line 132  -- upvalues: s2, U1, UserInputService, s3, s4, ContentProvider, s1
	local U1
	local v_u2
	if U1 == nil then
		local v_u1 = pcall
		if v_u1 then
			if (typeof(UserInputService.GetStringForKeyCode)) == "string" then
				if UserInputService.GetStringForKeyCode ~= "" then
					U1 = "microsoft"
				end
			end
		end
	end
	if s2["microsoft"][v10] == nil then
		v_u2 = nil
	else
		if s3[s2["microsoft"][v10]] == nil and s4[s2["microsoft"][v10]] == nil then
			s4[s2["microsoft"][v10]] = true
			v10 = s2["microsoft"][v10]
			local function anon5() -- proto[5], line 91  -- upvalues: ContentProvider, v10, s4, s3, s1
				local f2 = false
				local function anon4() -- proto[4], line 93  -- upvalues: ContentProvider, v10, f2
					local f3 = {v10}
					local function anon3(v11, v12) -- proto[3], line 94  -- upvalues: f2
						local f4 = not (v12 ~= Enum.AssetFetchStatus.Success)
						f2 = f4
					end
				end
				s4[v10] = nil
				s3[v10] = false
				local r1 = ("gamepad glyph %* did not load; using the engine glyph instead"):format(v10)
			end
		end
		if not ((s3[s2["microsoft"][v10]] == false)) then
			v_u2 = s2["microsoft"][v10]
		end
	end
	if v_u2 then return nil end
	local v_u4 = v10
	if not pcall then return nil end
	if (typeof(UserInputService.GetImageForKeyCode)) ~= "string" then return nil end
	if UserInputService.GetImageForKeyCode == "" then return nil end
	return UserInputService.GetImageForKeyCode
end
UserInputService.GamepadConnected:Connect(announce)
UserInputService.GamepadDisconnected:Connect(announce)
UserInputService.LastInputTypeChanged:Connect(function(v13)
	if string.find > 1 then return end
	U0 = nil
end)
return table.freeze(Changed)