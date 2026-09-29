-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Message
-- ============================================

-- bytecode
-- Original size: 8302 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 126, Protos: 21, Main proto: 20

-- ============== SOURCE ==============
-- main chunk (proto[20], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Notice = { Notice = true, Warn = true, Confirm = true }
local Confirm = { Confirm = "Prompt", Notice = "Notice", Warn = "Failure" }
local function child(v1, v2) -- proto[0], line 55
	local v_u1 = v2
	local w1 = v1.FindFirstChild
	local w2 = v1.GetFullName
	assert(w1, (("%* is missing %*"):format(w2, v2)))
	return w1
end
local r1 = GUI.Message()
local Frame = r1:FindFirstChild("Frame")
assert(Frame, (("%* is missing Frame"):format((r1:GetFullName()))))
local Contents = Frame:FindFirstChild("Contents")
assert(Contents, (("%* is missing Contents"):format((Frame:GetFullName()))))
assert(Accept, (("%* is missing Accept"):format((Contents:GetFullName()))))
assert(Acknowledge, (("%* is missing Acknowledge"):format((Contents:GetFullName()))))
assert(Decline, (("%* is missing Decline"):format((Contents:GetFullName()))))
assert(Close, (("%* is missing Close"):format((Frame:GetFullName()))))
local accept = { accept = Contents:FindFirstChild("Accept"), acknowledge = Contents:FindFirstChild("Acknowledge"), decline = Contents:FindFirstChild("Decline"), dismiss = Frame:FindFirstChild("Close") }
local Top = Frame:FindFirstChild("Top")
assert(Top, (("%* is missing Top"):format((Frame:GetFullName()))))
assert = Top:FindFirstChild("Title")
assert(assert, (("%* is missing Title"):format((Top:GetFullName()))))
assert(IllustratedBody, (("%* is missing IllustratedBody"):format((Contents:GetFullName()))))
assert(Body, (("%* is missing Body"):format((Contents:GetFullName()))))
local s1 = { heading = assert, illustrated = Contents:FindFirstChild("IllustratedBody"), plain = Contents:FindFirstChild("Body") }
local Artwork = Contents:FindFirstChild("Artwork")
assert(Artwork, (("%* is missing Artwork"):format((Contents:GetFullName()))))
local s2 = {}
local s3 = {}
local s4 = accept
local function present(v3) -- proto[1], line 88  -- upvalues: s4, Artwork, s1
	local f1
	local f2
	local v_u2 = v3.kind
	f2 = not (v_u2 ~= "Confirm")
	f1 = not (v3.image == nil)
	s4.accept.Visible = f2
	s4.decline.Visible = f2
	s4.acknowledge.Visible = (not f2)
	s4.dismiss.Visible = true
	Artwork.Image = (v3.image or "")
	Artwork.Visible = f1
	s1.illustrated.Visible = f1
	s1.plain.Visible = (not f1)
	s1.illustrated.Text = v3.body
	local v_u1 = v3.body
	s1.plain.Text = v_u1
	s1.heading.Text = (v3.heading or "Heads up!")
end
local function releaseActivation(v4) -- proto[2], line 109
	if (typeof(v4)) ~= "table" then return end
	for _k4, _v5 in ipairs(v4) do
		if (typeof(_v5)) ~= "RBXScriptConnection" then continue end
	end
	local w1 = v4.Disconnect
	if (typeof(w1)) ~= "function" then return end
end
local function resumeIfWaiting(v5, ...) -- proto[3], line 123
	if coroutine.status ~= "suspended" then return end
	task.spawn(v5)
end
ReplicatedStorage = r1
local function awaitVerdict(v6) -- proto[8], line 129  -- upvalues: releaseActivation, resumeIfWaiting, GUI, s4, ReplicatedStorage
	local s1 = {}
	local f3 = false
	local s4 = s1
	local function settle(v7) -- proto[4], line 136  -- upvalues: f3, U1, s4, releaseActivation, s1, resumeIfWaiting, running
		local U1
		if f3 then return end
		f3 = true
		U1 = v7
		for _k4, _v5 in ipairs(s4) do
		end
		for _k4, _v5 in ipairs(s1) do
		end
	end
	local function bind(v8, v9) -- proto[6], line 151  -- upvalues: s4, GUI, settle
		local function anon5() -- proto[5], line 152  -- upvalues: settle, v9
		end
		table.insert(s4, GUI.OnActivated(v8, anon5))
	end
	local arg1 = true
	local function anon5() -- proto[5], line 152  -- upvalues: settle, arg1
	end
	table.insert(s1, GUI.OnActivated(s4.accept, anon5))
	-- anon5 captures: settle, arg1
	table.insert(s1, GUI.OnActivated(s4.decline, anon5))
	-- anon5 captures: settle, arg1
	table.insert(s1, GUI.OnActivated(s4.acknowledge, anon5))
	-- anon5 captures: settle, arg1
	table.insert(s1, GUI.OnActivated(s4.dismiss, anon5))
	table.insert(s1, (ReplicatedStorage.GetPropertyChangedSignal):Connect(function()
		if s4.Enabled then return end
	end))
	return nil
end
local s5 = Confirm
local function ask(v10) -- proto[9], line 174  -- upvalues: present, Tabs, Audio, s5, awaitVerdict
	if not (Tabs.IsActive) then
		if not (Tabs.Activate) then return nil, false end
		local f1 = true
		return awaitVerdict, f1
	end
end
local f3 = false
local remove = nil
local function drain() -- proto[10], line 186  -- upvalues: f3, Tabs, s3, remove, ask, resumeIfWaiting
	local v_u3
	if f3 then return end
	f3 = true
	if Tabs.Active == "Message" then
		while true do
			if table.remove == nil then
				f3 = false
				return
			end
			remove = table.remove
			local v_u1 = nil
			remove = v_u1
			if (#s3) > 0 then break end
			f3 = false
			if not table.remove then break end
			if (nil ~= nil) and (not (table.remove.leaveClosed)) then
				local instant = { instant = true }
			else
				v_u3 = v_u3 ^ "Active"
			end
			if v_u1 then return end
		end
	end
end
local function alreadyQueued(v11, v12) -- proto[11], line 224  -- upvalues: s4, s3
	if s4 then
		if s4.body == v11 then
			if s4.kind == v12 then return true end
			for _k5, _v6 in ipairs(s3) do
				if _v6.body ~= v11 then continue end
				if _v6.kind == v12 then return true end
			end
		end
	end
	return false
end
local s6 = Notice
function s2.Show(v13) -- proto[12], line 241  -- upvalues: s6, Save, alreadyQueued, s3, drain
	local f4
	local f5
	local f6
	local f1 = not ((type(v13)) ~= "table")
	assert(f1, "dialog request must be a table")
	f4 = not ((type(v13.Body)) ~= "string")
	assert(f4, "dialog body must be a string")
	f5 = not (s6[(v13.Kind or "Notice")] ~= true)
	assert(f5, (("unknown dialog kind %*"):format((tostring(v13.Kind or "Notice")))))
	if Save.Await == nil then return nil end
	if alreadyQueued then return nil end
	if 3 <= (#s3) then return nil end
	f6 = not (v13.LeaveClosed ~= true)
	local body = { body = v13.Body, kind = (v13.Kind or "Notice"), heading = v13.Heading, image = v13.Image, leaveClosed = f6, waiter = coroutine.running }
	table.insert(s3, body)
	return coroutine.yield
end
local function withBody(v14, v15, v16) -- proto[13], line 267
	local Body
	if not ((v16 ~= nil)) then
		Body = {}
	end
	Body.Body = v14
	Body.Kind = v15
	return Body
end
function s2.Notice(v17, v18) -- proto[14], line 275  -- upvalues: s2
	local Body
	if not ((v18 ~= nil)) then
		Body = {}
	end
	Body.Body = v17
	Body.Kind = "Notice"
end
function s2.Warn(v19, v20) -- proto[15], line 280  -- upvalues: s2
	local Body
	if not ((v20 ~= nil)) then
		Body = {}
	end
	Body.Body = v19
	Body.Kind = "Warn"
end
function s2.Confirm(v21, v22) -- proto[16], line 286  -- upvalues: s2
	local Body
	if not ((v22 ~= nil)) then
		Body = {}
	end
	Body.Body = v21
	Body.Kind = "Confirm"
	return s2.Show(Body)
end
function s2.WarnGeneric() -- proto[17], line 290  -- upvalues: s2
end
s1.illustrated.RichText = true
s1.plain.RichText = true
r1:SetAttribute("ModalDialog", true)
_r28[1], _r28[2], _r28[3], _r28[4] = accept.acknowledge, accept.accept, accept.decline, accept.dismiss
for _k31, _v32 in {} do
	ButtonFX(_v32)
end
Remotes.Toasts.Line.OnClientEvent:Connect(function(v23)
	if (typeof(v23)) == "table" then
		local r2 = ("Toasts.Line expects a dialog request table, got %*"):format((typeof(v23)))
		return
	end
	if table.clone.Kind ~= "Warn" then
		table.clone.Kind = "Notice"
	end
end)
local function anon19(v24) -- proto[19], line 316  -- upvalues: s2
	local f2 = not (s2.Confirm ~= true)
	return f2
end
Remotes.Haul.OfferFullSatchelSale.OnClientInvoke = anon19
return table.freeze(s2)