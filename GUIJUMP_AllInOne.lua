-- GUIJUMP ALL IN ONE by manhbao
-- Key random 72h + Link4m + Avatar ID + Hold Jump = Fly

local Players = game:GetService("Players")
local DSS = game:GetService("DataStoreService")
local RS = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

-- ===== CONFIG =====
local GETKEY_LINK = "https://link4m.com/OGahCDo"
local AVATAR_ID = "96045391302700"
local KEY_HOURS = 72
-- ==================

local Store = DSS:GetDataStore("GUIJUMP_KEY_72H")

-- Remote
local CheckKey = Instance.new("RemoteEvent")
CheckKey.Name = "GUIJUMP_CheckKey"
CheckKey.Parent = RS

local GetTime = Instance.new("RemoteFunction")
GetTime.Name = "GUIJUMP_GetTime"
GetTime.Parent = RS

local function genKey()
	return "GUIJUMP-" .. string.upper(string.sub(HttpService:GenerateGUID(false),1,24))
end

-- SERVER LOGIC
Players.PlayerAdded:Connect(function(plr)
	local data
	pcall(function()
		data = Store:GetAsync(plr.UserId)
	end)

	if not data or os.time() >= (data.expire or 0) then
		data = {
			key = genKey(),
			expire = os.time() + KEY_HOURS*3600
		}
		Store:SetAsync(plr,data)
		print("🔑 GUIJUMP KEY:",plr.Name,data.key)
	else
		local v = Instance.new("BoolValue",plr)
		v.Name = "GUIJUMP_OK"
	end
end)

CheckKey.OnServerEvent:Connect(function(plr,input)
	local data
	pcall(function()
		data = Store:GetAsync(plr.UserId)
	end)

	if data and input == data.key and os.time() < data.expire then
		if not plr:FindFirstChild("GUIJUMP_OK") then
			local v = Instance.new("BoolValue",plr)
			v.Name = "GUIJUMP_OK"
		end
	end
end)

GetTime.OnServerInvoke = function(plr)
	local data
	pcall(function()
		data = Store:GetAsync(plr.UserId)
	end)
	if data then
		return math.max(0,data.expire - os.time())
	end
	return 0
end

-- ===== CLIENT SCRIPT (AUTO INJECT) =====
Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Wait()

	local ls = Instance.new("LocalScript")
	ls.Name = "GUIJUMP_CLIENT"
	ls.Parent = plr:WaitForChild("PlayerGui")

	ls.Source = [[
		local Players = game:GetService("Players")
		local RS = game:GetService("ReplicatedStorage")
		local UIS = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")

		local player = Players.LocalPlayer
		local CheckKey = RS:WaitForChild("GUIJUMP_CheckKey")
		local GetTime = RS:WaitForChild("GUIJUMP_GetTime")

		local GETKEY_LINK = "]]..GETKEY_LINK..[["
		local AVATAR_ID = "]]..AVATAR_ID..[["

		local function hasKey()
			return player:FindFirstChild("GUIJUMP_OK") ~= nil
		end

		-- ===== KEY GUI =====
		if not hasKey() then
			local gui = Instance.new("ScreenGui",player.PlayerGui)
			local f = Instance.new("Frame",gui)
			f.Size = UDim2.new(0,360,0,260)
			f.Position = UDim2.new(0.5,-180,0.5,-130)
			f.BackgroundColor3 = Color3.fromRGB(25,25,25)
			Instance.new("UICorner",f).CornerRadius = UDim.new(0,16)

			local av = Instance.new("ImageLabel",f)
			av.Size = UDim2.new(0,70,0,70)
			av.Position = UDim2.new(0.05,0,0.08,0)
			av.BackgroundTransparency = 1
			av.Image = "rbxassetid://"..AVATAR_ID
			Instance.new("UICorner",av).CornerRadius = UDim.new(1,0)

			local t = Instance.new("TextLabel",f)
			t.Text = "GUIJUMP by manhbao"
			t.Size = UDim2.new(0.65,0,0,40)
			t.Position = UDim2.new(0.3,0,0.12,0)
			t.BackgroundTransparency = 1
			t.TextColor3 = Color3.fromRGB(0,255,255)
			t.Font = Enum.Font.GothamBold
			t.TextScaled = true

			local box = Instance.new("TextBox",f)
			box.Size = UDim2.new(0.9,0,0,40)
			box.Position = UDim2.new(0.05,0,0.45,0)
			box.PlaceholderText = "Dán key vào đây"
			box.TextScaled = true

			local g = Instance.new("TextButton",f)
			g.Size = UDim2.new(0.4,0,0,36)
			g.Position = UDim2.new(0.05,0,0.7,0)
			g.Text = "GET KEY"

			local c = Instance.new("TextButton",f)
			c.Size = UDim2.new(0.4,0,0,36)
			c.Position = UDim2.new(0.55,0,0.7,0)
			c.Text = "CHECK KEY"

			g.MouseButton1Click:Connect(function()
				box.Text = GETKEY_LINK
			end)

			c.MouseButton1Click:Connect(function()
				CheckKey:FireServer(box.Text)
			end)

			player.ChildAdded:Connect(function(ch)
				if ch.Name == "GUIJUMP_OK" then
					gui:Destroy()
				end
			end)
		end

		repeat task.wait() until hasKey()

		-- ===== TIME LEFT =====
		local gui = Instance.new("ScreenGui",player.PlayerGui)
		local lbl = Instance.new("TextLabel",gui)
		lbl.Size = UDim2.new(0,260,0,35)
		lbl.Position = UDim2.new(0,10,0,10)
		lbl.BackgroundColor3 = Color3.fromRGB(20,20,20)
		lbl.TextColor3 = Color3.fromRGB(0,255,255)
		lbl.Font = Enum.Font.GothamBold
		lbl.TextScaled = true
		Instance.new("UICorner",lbl).CornerRadius = UDim.new(0,12)

		task.spawn(function()
			while true do
				local t = GetTime:InvokeServer()
				if t <= 0 then
					player:Kick("Key hết hạn")
					break
				end
				lbl.Text = "KEY CÒN: "..math.floor(t/3600).."h"
				task.wait(1)
			end
		end)

		-- ===== HOLD JUMP = FLY =====
		local char = player.Character or player.CharacterAdded:Wait()
		local fly = false

		UIS.JumpRequest:Connect(function()
			fly = true
		end)

		UIS.InputEnded:Connect(function(i)
			if i.KeyCode == Enum.KeyCode.Space then
				fly = false
			end
		end)

		RunService.Heartbeat:Connect(function()
			if fly then
				char:TranslateBy(Vector3.new(0,0.8,0))
			end
		end)
	]]
end)
