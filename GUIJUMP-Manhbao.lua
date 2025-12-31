-- GUIJUMP DELTA MOBILE by manhbao (FINAL FIX + DRAG MENU)

if not game:IsLoaded() then game.Loaded:Wait() end

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- CONFIG
local FIXED_KEY = "MANHBAO-KEY"
local GETKEY_LINK = "https://link4m.com/6yGePO7"
local LOGO_ID = "96045391302700"
local BG_ID   = "96045391302700"

-- ================= KEY GUI =================
local keyGui = Instance.new("ScreenGui", player.PlayerGui)
keyGui.ResetOnSpawn = false

local kf = Instance.new("Frame", keyGui)
kf.Size = UDim2.new(0,320,0,220)
kf.Position = UDim2.new(0.5,-160,0.5,-110)
kf.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", kf).CornerRadius = UDim.new(0,16)

local kt = Instance.new("TextLabel", kf)
kt.Size = UDim2.new(1,0,0,40)
kt.Position = UDim2.new(0,0,0.05,0)
kt.Text = "GUIJUMP by manhbao"
kt.Font = Enum.Font.GothamBold
kt.TextSize = 18
kt.TextColor3 = Color3.fromRGB(255,60,60)
kt.BackgroundTransparency = 1

local box = Instance.new("TextBox", kf)
box.Size = UDim2.new(0.9,0,0,40)
box.Position = UDim2.new(0.05,0,0.38,0)
box.PlaceholderText = "Nhập key"
box.Font = Enum.Font.Gotham
box.TextSize = 14
Instance.new("UICorner", box).CornerRadius = UDim.new(0,12)

local get = Instance.new("TextButton", kf)
get.Size = UDim2.new(0.42,0,0,36)
get.Position = UDim2.new(0.05,0,0.68,0)
get.Text = "GET KEY"

local check = Instance.new("TextButton", kf)
check.Size = UDim2.new(0.42,0,0,36)
check.Position = UDim2.new(0.53,0,0.68,0)
check.Text = "CHECK"

for _,v in pairs(kf:GetChildren()) do
    if v:IsA("TextButton") then
        v.BackgroundColor3 = Color3.fromRGB(25,25,25)
        v.TextColor3 = Color3.new(1,1,1)
        v.Font = Enum.Font.GothamBold
        v.TextSize = 14
        Instance.new("UICorner", v).CornerRadius = UDim.new(0,12)
    end
end

get.MouseButton1Click:Connect(function()
    box.Text = GETKEY_LINK
    if setclipboard then setclipboard(GETKEY_LINK) end
end)

check.MouseButton1Click:Connect(function()
    if box.Text == FIXED_KEY then
        keyGui:Destroy()
    else
        box.Text = "KEY SAI"
    end
end)

repeat task.wait() until not keyGui.Parent

-- ================= MAIN GUI =================
local fly = false
local speed = 1
local up, down = false, false
local bv, bg

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

-- LOGO (DRAG)
local logo = Instance.new("ImageButton", gui)
logo.Size = UDim2.new(0,42,0,42)
logo.Position = UDim2.new(0,10,0.4,0)
logo.Image = "rbxassetid://"..LOGO_ID
logo.BackgroundTransparency = 1
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

-- LOGO DRAG
do
    local drag, startPos, startInput
    logo.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            startInput = i.Position
            startPos = logo.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.Touch then
            local d = i.Position - startInput
            logo.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
    UIS.InputEnded:Connect(function() drag = false end)
end

-- MENU
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,270,0,210)
frame.Position = UDim2.new(0,65,0.32,0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

logo.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- MENU DRAG (NEW)
do
    local drag, startPos, startInput
    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            startInput = i.Position
            startPos = frame.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and i.UserInputType == Enum.UserInputType.Touch then
            local d = i.Position - startInput
            frame.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
    UIS.InputEnded:Connect(function() drag = false end)
end

-- BACKGROUND
local bgimg = Instance.new("ImageLabel", frame)
bgimg.Size = UDim2.new(1,0,1,0)
bgimg.Image = "rbxassetid://"..BG_ID
bgimg.BackgroundTransparency = 1
bgimg.ZIndex = 1
Instance.new("UICorner", bgimg).CornerRadius = UDim.new(0,16)

local overlay = Instance.new("Frame", frame)
overlay.Size = UDim2.new(1,0,1,0)
overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
overlay.BackgroundTransparency = 0.45
overlay.ZIndex = 2
Instance.new("UICorner", overlay).CornerRadius = UDim.new(0,16)

-- TITLE
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,36)
title.Text = "GUIJUMP by manhbao"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255,60,60)
title.BackgroundTransparency = 1
title.ZIndex = 3

-- BUTTONS
local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(0.8,0,0,40)
flyBtn.Position = UDim2.new(0.1,0,0.28,0)
flyBtn.Text = "FLY : OFF"
flyBtn.ZIndex = 3

local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0.2,0,0,35)
minus.Position = UDim2.new(0.1,0,0.55,0)
minus.Text = "-"

local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0.2,0,0,35)
plus.Position = UDim2.new(0.7,0,0.55,0)
plus.Text = "+"

local spdText = Instance.new("TextLabel", frame)
spdText.Size = UDim2.new(0.3,0,0,35)
spdText.Position = UDim2.new(0.35,0,0.55,0)
spdText.Text = "Speed: 1"
spdText.BackgroundTransparency = 1
spdText.TextColor3 = Color3.new(1,1,1)
spdText.ZIndex = 3

for _,v in pairs(frame:GetChildren()) do
    if v:IsA("TextButton") then
        v.BackgroundColor3 = Color3.fromRGB(25,25,25)
        v.TextColor3 = Color3.new(1,1,1)
        v.Font = Enum.Font.GothamBold
        v.TextSize = 14
        v.ZIndex = 3
        Instance.new("UICorner", v).CornerRadius = UDim.new(0,12)
    end
end

-- BUTTON LOGIC
flyBtn.MouseButton1Click:Connect(function()
    fly = not fly
    flyBtn.Text = fly and "FLY : ON" or "FLY : OFF"
end)

plus.MouseButton1Click:Connect(function()
    speed = math.clamp(speed + 0.5, 0.5, 5)
    spdText.Text = "Speed: "..speed
end)

minus.MouseButton1Click:Connect(function()
    speed = math.clamp(speed - 0.5, 0.5, 5)
    spdText.Text = "Speed: "..speed
end)

-- INPUT
UIS.InputBegan:Connect(function(i,g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.Space then up = true end
    if i.KeyCode == Enum.KeyCode.LeftControl or i.KeyCode == Enum.KeyCode.C then down = true end
end)
UIS.InputEnded:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.Space then up = false end
    if i.KeyCode == Enum.KeyCode.LeftControl or i.KeyCode == Enum.KeyCode.C then down = false end
end)

-- FLY + NOCLIP
RunService.RenderStepped:Connect(function()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not hum or not hrp then return end

    if fly then
        hum.PlatformStand = true
        for _,v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end

        if not bv then
            bv = Instance.new("BodyVelocity", hrp)
            bv.MaxForce = Vector3.new(9e9,9e9,9e9)
        end
        if not bg then
            bg = Instance.new("BodyGyro", hrp)
            bg.MaxTorque = Vector3.new(9e9,9e9,9e9)
            bg.P = 90000
        end

        bg.CFrame = camera.CFrame
        local vel = hum.MoveDirection * (speed * 45)
        if up then vel += Vector3.new(0,speed*45,0) end
        if down then vel -= Vector3.new(0,speed*45,0) end
        bv.Velocity = vel
    else
        hum.PlatformStand = false
        if bv then bv:Destroy() bv=nil end
        if bg then bg:Destroy() bg=nil end
    end
end)

print("GUIJUMP FULL FINAL + DRAG MENU LOADED")
