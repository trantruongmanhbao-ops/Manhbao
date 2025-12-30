-- GUIJUMP DELTA X by manhbao (FULL FINAL)

-- ===== SERVICES =====
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- ===== CONFIG =====
local GETKEY_LINK = "https://link4m.com/CadYuDL"
local FIXED_KEY = "MANHBAO-KEY"
local AVATAR_ID = "96045391302700"
-- ==================

-- ===== ANTI KICK (BASIC) =====
local old
old = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if tostring(method) == "Kick" and self == player then
        warn("[ANTI-KICK] Blocked")
        return
    end
    return old(self, ...)
end)

player.Kick = function()
    warn("[ANTI-KICK] Blocked")
end
-- =============================

-- ===== KEY GUI =====
getgenv().GUIJUMP_OK = false

local keyGui = Instance.new("ScreenGui", player.PlayerGui)

local f = Instance.new("Frame", keyGui)
f.Size = UDim2.new(0,360,0,260)
f.Position = UDim2.new(0.5,-180,0.5,-130)
f.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", f).CornerRadius = UDim.new(0,16)

local av = Instance.new("ImageLabel", f)
av.Size = UDim2.new(0,70,0,70)
av.Position = UDim2.new(0.05,0,0.08,0)
av.BackgroundTransparency = 1
av.Image = "rbxassetid://" .. AVATAR_ID
Instance.new("UICorner", av).CornerRadius = UDim.new(1,0)

local title = Instance.new("TextLabel", f)
title.Text = "GUIJUMP"
title.Size = UDim2.new(0.65,0,0,40)
title.Position = UDim2.new(0.3,0,0.12,0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0,255,255)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local box = Instance.new("TextBox", f)
box.Size = UDim2.new(0.9,0,0,40)
box.Position = UDim2.new(0.05,0,0.45,0)
box.PlaceholderText = "Nhập key vào đây"
box.TextScaled = true

local g = Instance.new("TextButton", f)
g.Size = UDim2.new(0.4,0,0,36)
g.Position = UDim2.new(0.05,0,0.7,0)
g.Text = "GET KEY"

local c = Instance.new("TextButton", f)
c.Size = UDim2.new(0.4,0,0,36)
c.Position = UDim2.new(0.55,0,0.7,0)
c.Text = "CHECK KEY"

g.MouseButton1Click:Connect(function()
    box.Text = GETKEY_LINK
    if setclipboard then
        setclipboard(GETKEY_LINK)
    end
end)

c.MouseButton1Click:Connect(function()
    if box.Text == FIXED_KEY then
        getgenv().GUIJUMP_OK = true
        keyGui:Destroy()
    else
        box.Text = "KEY SAI"
    end
end)

repeat task.wait() until getgenv().GUIJUMP_OK

-- ===== MAIN GUI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)

-- LOGO TOGGLE
local logo = Instance.new("ImageButton", gui)
logo.Size = UDim2.new(0,45,0,45)
logo.Position = UDim2.new(0,10,0.5,-22)
logo.Image = "rbxassetid://" .. AVATAR_ID
logo.BackgroundTransparency = 1
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,260)
frame.Position = UDim2.new(0,65,0.5,-130)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

logo.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- ===== FLY SYSTEM =====
local fly = false
local flySpeed = 0.8
local minSpeed, maxSpeed = 0.3, 3

local flyMode = 1
local flyModes = {"UP","HOVER","WASD"}

local flyBtn = Instance.new("TextButton", frame)
flyBtn.Size = UDim2.new(0.85,0,0,35)
flyBtn.Position = UDim2.new(0.075,0,0.1,0)
flyBtn.Text = "FLY : OFF"

flyBtn.MouseButton1Click:Connect(function()
    fly = not fly
    flyBtn.Text = fly and "FLY : ON" or "FLY : OFF"
end)

local modeBtn = Instance.new("TextButton", frame)
modeBtn.Size = UDim2.new(0.85,0,0,35)
modeBtn.Position = UDim2.new(0.075,0,0.28,0)
modeBtn.Text = "MODE : " .. flyModes[flyMode]

modeBtn.MouseButton1Click:Connect(function()
    flyMode += 1
    if flyMode > #flyModes then flyMode = 1 end
    modeBtn.Text = "MODE : " .. flyModes[flyMode]
end)

-- SPEED LABEL
local speedLabel = Instance.new("TextLabel", frame)
speedLabel.Size = UDim2.new(0.85,0,0,25)
speedLabel.Position = UDim2.new(0.075,0,0.48,0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "SPEED : " .. flySpeed
speedLabel.TextScaled = true

-- SLIDER
local sliderBar = Instance.new("Frame", frame)
sliderBar.Size = UDim2.new(0.85,0,0,10)
sliderBar.Position = UDim2.new(0.075,0,0.6,0)
sliderBar.BackgroundColor3 = Color3.fromRGB(60,60,60)
Instance.new("UICorner", sliderBar).CornerRadius = UDim.new(1,0)

local sliderBtn = Instance.new("Frame", sliderBar)
sliderBtn.Size = UDim2.new((flySpeed-minSpeed)/(maxSpeed-minSpeed),0,1,0)
sliderBtn.BackgroundColor3 = Color3.fromRGB(0,255,255)
Instance.new("UICorner", sliderBtn).CornerRadius = UDim.new(1,0)

local dragging = false
sliderBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local x = math.clamp((i.Position.X-sliderBar.AbsolutePosition.X)/sliderBar.AbsoluteSize.X,0,1)
        sliderBtn.Size = UDim2.new(x,0,1,0)
        flySpeed = math.floor((minSpeed+(maxSpeed-minSpeed)*x)*10)/10
        speedLabel.Text = "SPEED : "..flySpeed
    end
end)

-- ===== FLY LOOP =====
RunService.Heartbeat:Connect(function()
    if not fly then return end
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if flyMode == 1 then
        hrp.Velocity = Vector3.new(0, flySpeed*60, 0)
    elseif flyMode == 2 then
        hrp.Velocity = Vector3.zero
    else
        local cam = workspace.CurrentCamera
        local move = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
        if move.Magnitude > 0 then
            hrp.Velocity = move.Unit * flySpeed * 50
        end
    end
end)
