-- GUIJUMP DELTA MOBILE by manhbao (REDZ FINAL)

if not game:IsLoaded() then game.Loaded:Wait() end

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
local keyGui = Instance.new("ScreenGui", player.PlayerGui)
keyGui.ResetOnSpawn = false

local kf = Instance.new("Frame", keyGui)
kf.Size = UDim2.new(0,320,0,220)
kf.Position = UDim2.new(0.5,-160,0.5,-110)
kf.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner", kf).CornerRadius = UDim.new(0,14)

local kt = Instance.new("TextLabel", kf)
kt.Size = UDim2.new(1,0,0,40)
kt.Position = UDim2.new(0,0,0.05,0)
kt.Text = "GUIJUMP"
kt.Font = Enum.Font.GothamBold
kt.TextScaled = true
kt.TextColor3 = Color3.fromRGB(255,60,60)
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
    if setclipboard then setclipboard(GETKEY_LINK) end
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

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false

-- LOGO (DRAG)
local logo = Instance.new("ImageButton", gui)
logo.Size = UDim2.new(0,45,0,45)
logo.Position = UDim2.new(0,10,0.35,0)
logo.Image = "rbxassetid://"..LOGO_ID
logo.BackgroundTransparency = 1
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

local dragging, dragStart, startPos
logo.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = logo.Position
    end
end)
logo.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = i.Position - dragStart
        logo.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- MENU FRAME
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,240)
frame.Position = UDim2.new(0,65,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Visible = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

logo.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- REDZ STROKE
local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(255,60,60)
stroke.Thickness = 1.5
stroke.Transparency = 0.1

-- HEADER
local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1,0,0,36)
header.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", header).CornerRadius = UDim.new(0,16)

local headerStroke = Instance.new("UIStroke", header)
headerStroke.Color = Color3.fromRGB(255,60,60)
headerStroke.Thickness = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-20,1,0)
title.Position = UDim2.new(0,10,0,0)
title.Text = "GUIJUMP by manhbao"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Left
title.TextColor3 = Color3.fromRGB(255,60,60)
title.BackgroundTransparency = 1

-- FLY SYSTEM
local fly = false
local speed = 1
local up, down = false, false
local bv, bgx

local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(0.85,0,0,36)
flyBtn.Position = UDim2.new(0.075,0,0.22,0)
flyBtn.Text = "FLY : OFF"

local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Size = UDim2.new(0.85,0,0,28)
speedLabel.Position = UDim2.new(0.075,0,0.4,0)
speedLabel.Text = "SPEED : 1"
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.fromRGB(255,60,60)
speedLabel.TextScaled = true

local plus = Instance.new("TextButton", frame)
plus.Size = UDim2.new(0.4,0,0,34)
plus.Position = UDim2.new(0.075,0,0.52,0)
plus.Text = "+"

local minus = Instance.new("TextButton", frame)
minus.Size = UDim2.new(0.4,0,0,34)
minus.Position = UDim2.new(0.525,0,0.52,0)
minus.Text = "-"

local upBtn = Instance.new("TextButton", frame)
upBtn.Size = UDim2.new(0.4,0,0,34)
upBtn.Position = UDim2.new(0.075,0,0.7,0)
upBtn.Text = "⬆ UP"

local downBtn = Instance.new("TextButton", frame)
downBtn.Size = UDim2.new(0.4,0,0,34)
downBtn.Position = UDim2.new(0.525,0,0.7,0)
downBtn.Text = "⬇ DOWN"

-- STYLE BUTTONS (REDZ)
for _,v in pairs(frame:GetChildren()) do
    if v:IsA("TextButton") then
        v.BackgroundColor3 = Color3.fromRGB(25,25,25)
        v.TextColor3 = Color3.fromRGB(255,255,255)
        v.Font = Enum.Font.GothamBold
        v.TextSize = 14
        Instance.new("UICorner", v).CornerRadius = UDim.new(0,12)
        local s = Instance.new("UIStroke", v)
        s.Color = Color3.fromRGB(255,60,60)
        s.Thickness = 1
        s.Transparency = 0.3
    end
end

flyBtn.MouseButton1Click:Connect(function()
    fly = not fly
    flyBtn.Text = fly and "FLY : ON" or "FLY : OFF"
end)

plus.MouseButton1Click:Connect(function()
    speed = math.min(speed + 0.5, 10)
    speedLabel.Text = "SPEED : "..speed
end)

minus.MouseButton1Click:Connect(function()
    speed = math.max(speed - 0.5, 0.5)
    speedLabel.Text = "SPEED : "..speed
end)

upBtn.MouseButton1Down:Connect(function() up = true end)
upBtn.MouseButton1Up:Connect(function() up = false end)
downBtn.MouseButton1Down:Connect(function() down = true end)
downBtn.MouseButton1Up:Connect(function() down = false end)

-- FLY LOOP
RunService.RenderStepped:Connect(function()
    if not fly then
        if bv then bv:Destroy(); bv=nil end
        if bgx then bgx:Destroy(); bgx=nil end
        return
    end

    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local cam = workspace.CurrentCamera
    if not hrp then return end

    if not bv then
        bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)
    end
    if not bgx then
        bgx = Instance.new("BodyGyro", hrp)
        bgx.MaxTorque = Vector3.new(9e9,9e9,9e9)
        bgx.P = 9e4
    end

    bgx.CFrame = cam.CFrame
    local move = cam.CFrame.LookVector * (speed * 40)
    if up then move += Vector3.new(0, speed*40, 0) end
    if down then move -= Vector3.new(0, speed*40, 0) end
    bv.Velocity = move
end)

print("GUIJUMP REDZ FINAL LOADED")
