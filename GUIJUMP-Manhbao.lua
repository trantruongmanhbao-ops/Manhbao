-- GUIJUMP DELTA MOBILE by manhbao (STABLE)

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- CONFIG
local FIXED_KEY = "MANHBAO-KEY"
local GETKEY_LINK = "https://link4m.com/6yGePO7"
local LOGO_ID = "96045391302700"

-- ================= KEY GUI =================
local keyGui = Instance.new("ScreenGui")
keyGui.ResetOnSpawn = false
keyGui.Parent = player:WaitForChild("PlayerGui")

local kf = Instance.new("Frame", keyGui)
kf.Size = UDim2.new(0,320,0,220)
kf.Position = UDim2.new(0.5,-160,0.5,-110)
kf.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", kf).CornerRadius = UDim.new(0,14)

local kt = Instance.new("TextLabel", kf)
kt.Size = UDim2.new(1,0,0,40)
kt.Position = UDim2.new(0,0,0.05,0)
kt.Text = "GUIJUMP"
kt.TextScaled = true
kt.Font = Enum.Font.GothamBold
kt.TextColor3 = Color3.fromRGB(0,255,255)
kt.BackgroundTransparency = 1

local box = Instance.new("TextBox", kf)
box.Size = UDim2.new(0.9,0,0,40)
box.Position = UDim2.new(0.05,0,0.4,0)
box.PlaceholderText = "Nhập key"
box.TextScaled = true

local get = Instance.new("TextButton", kf)
get.Size = UDim2.new(0.4,0,0,35)
get.Position = UDim2.new(0.05,0,0.68,0)
get.Text = "GET KEY"

local check = Instance.new("TextButton", kf)
check.Size = UDim2.new(0.4,0,0,35)
check.Position = UDim2.new(0.55,0,0.68,0)
check.Text = "CHECK"

get.MouseButton1Click:Connect(function()
    box.Text = GETKEY_LINK
    if setclipboard then
        setclipboard(GETKEY_LINK)
    end
end)

check.MouseButton1Click:Connect(function()
    if box.Text == FIXED_KEY then
        keyGui:Destroy()
    else
        box.Text = "KEY SAI"
    end
end)

-- ================= MAIN GUI =================
repeat task.wait() until not keyGui.Parent

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- LOGO
local logo = Instance.new("ImageButton", gui)
logo.Size = UDim2.new(0,45,0,45)
logo.Position = UDim2.new(0,10,0.35,0)
logo.Image = "rbxassetid://" .. LOGO_ID
logo.BackgroundTransparency = 1
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

-- MENU
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,180)
frame.Position = UDim2.new(0,65,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Visible = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,14)

logo.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- FLY BUTTON
local fly = false
local speed = 1

local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(0.85,0,0,40)
flyBtn.Position = UDim2.new(0.075,0,0.15,0)
flyBtn.Text = "FLY : OFF"

flyBtn.MouseButton1Click:Connect(function()
    fly = not fly
    flyBtn.Text = fly and "FLY : ON" or "FLY : OFF"
end)

-- SPEED BUTTON
local spdBtn = Instance.new("TextButton", frame)
spdBtn.Size = UDim2.new(0.85,0,0,40)
spdBtn.Position = UDim2.new(0.075,0,0.45,0)
spdBtn.Text = "SPEED : 1"

spdBtn.MouseButton1Click:Connect(function()
    speed += 0.5
    if speed > 5 then speed = 0.5 end
    spdBtn.Text = "SPEED : " .. speed
end)

-- FLY LOOP
RunService.Heartbeat:Connect(function()
    if not fly then return end
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.Velocity = Vector3.new(0, speed * 60, 0)
    end
end)

print("GUIJUMP DELTA MOBILE LOADED")
