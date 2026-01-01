-- GUIFLY DELTA MOBILE by manhbao (STABLE)

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- CONFIG
local FIXED_KEY = "MANHBAO-KEY"
local GETKEY_LINK = "https://link4m.com/6yGePO7"
local LOGO_ID   = "96045391302700"
local BG_MENU   = "96045391302700" -- Hình nền menu chính
local BG_GETKEY = "96045391302700" -- Hình nền menu get key
local GUI_NAME  = "GUIFLY by manhbao"

-- ================= KEY GUI =================
local keyGui = Instance.new("ScreenGui")
keyGui.ResetOnSpawn = false
keyGui.Parent = player:WaitForChild("PlayerGui")

local kf = Instance.new("Frame", keyGui)
kf.Size = UDim2.new(0,320,0,220)
kf.Position = UDim2.new(0.5,-160,0.5,-110)
kf.BackgroundColor3 = Color3.fromRGB(25,25,25)
kf.Active = true
kf.Draggable = true
Instance.new("UICorner", kf).CornerRadius = UDim.new(0,14)

-- Hình nền menu get key
local bg = Instance.new("ImageLabel", kf)
bg.Size = UDim2.new(1,0,1,0)
bg.Position = UDim2.new(0,0,0,0)
bg.Image = "rbxassetid://"..BG_GETKEY
bg.BackgroundTransparency = 0
bg.ZIndex = 0

local kt = Instance.new("TextLabel", kf)
kt.Size = UDim2.new(1,0,0,40)
kt.Position = UDim2.new(0,0,0.05,0)
kt.Text = GUI_NAME
kt.TextScaled = true
kt.Font = Enum.Font.GothamBold
kt.TextColor3 = Color3.fromRGB(0,255,255)
kt.BackgroundTransparency = 1
kt.ZIndex = 1

local box = Instance.new("TextBox", kf)
box.Size = UDim2.new(0.9,0,0,40)
box.Position = UDim2.new(0.05,0,0.4,0)
box.PlaceholderText = "Nhập key"
box.TextScaled = true
box.ZIndex = 1

local get = Instance.new("TextButton", kf)
get.Size = UDim2.new(0.4,0,0,35)
get.Position = UDim2.new(0.05,0,0.68,0)
get.Text = "GET KEY"
get.ZIndex = 1

local check = Instance.new("TextButton", kf)
check.Size = UDim2.new(0.4,0,0,35)
check.Position = UDim2.new(0.55,0,0.68,0)
check.Text = "CHECK"
check.ZIndex = 1

-- Thông báo Copy
local function showCopied(parent)
    local label = Instance.new("TextLabel", parent)
    label.Size = UDim2.new(0.5,0,0,30)
    label.Position = UDim2.new(0.25,0,0.85,0)
    label.Text = "Copied!"
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.fromRGB(0,255,0)
    label.BackgroundTransparency = 0.5
    label.BackgroundColor3 = Color3.fromRGB(0,0,0)
    label.ZIndex = 2

    local tween = TweenService:Create(label, TweenInfo.new(1.2), {BackgroundTransparency = 1, TextTransparency = 1})
    tween:Play()
    tween.Completed:Connect(function() label:Destroy() end)
end

get.MouseButton1Click:Connect(function()
    box.Text = GETKEY_LINK
    if setclipboard then
        setclipboard(GETKEY_LINK)
    end
    showCopied(kf)
end)

check.MouseButton1Click:Connect(function()
    if box.Text == FIXED_KEY then
        keyGui:Destroy()
        loadMainGUI() -- mở menu chính khi nhập key đúng
    else
        box.Text = "KEY SAI"
    end
end)

-- ================= MAIN GUI =================
function loadMainGUI()
    local gui = Instance.new("ScreenGui")
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

    -- LOGO NHỎ KÉO ĐƯỢC
    local logo = Instance.new("ImageButton", gui)
    logo.Size = UDim2.new(0,50,0,50)
    logo.Position = UDim2.new(0,10,0.35,0)
    logo.Image = "rbxassetid://"..LOGO_ID
    logo.BackgroundTransparency = 1
    logo.Active = true
    logo.Draggable = true
    Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

    -- MENU FRAME
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0,260,0,300)
    frame.Position = UDim2.new(0.3,0,0.3,0)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.BorderColor3 = Color3.fromRGB(255,0,0)
    frame.Active = true
    frame.Draggable = true
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,14)
    frame.Visible = true

    -- Background menu
    local menuBG = Instance.new("ImageLabel", frame)
    menuBG.Size = UDim2.new(1,0,1,0)
    menuBG.Position = UDim2.new(0,0,0,0)
    menuBG.Image = "rbxassetid://"..BG_MENU
    menuBG.BackgroundTransparency = 0.2
    menuBG.ZIndex = 0

    -- GUI Name
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,40)
    title.Position = UDim2.new(0,0,0,0)
    title.Text = GUI_NAME
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.fromRGB(0,255,255)
    title.BackgroundTransparency = 1
    title.ZIndex = 1

    -- FLY CONFIG
    local fly = false
    local speed = 1
    local keys = {W=false, A=false, S=false, D=false}

    -- TỐC ĐỘ HIỂN THỊ
    local speedLabel = Instance.new("TextLabel", frame)
    speedLabel.Size = UDim2.new(0.85,0,0,30)
    speedLabel.Position = UDim2.new(0.075,0,0.15,0)
    speedLabel.Text = "Speed: "..speed
    speedLabel.TextScaled = true
    speedLabel.Font = Enum.Font.GothamBold
    speedLabel.TextColor3 = Color3.fromRGB(255,255,255)
    speedLabel.BackgroundTransparency = 1
    speedLabel.ZIndex = 1

    -- FLY BUTTON
    local flyBtn = Instance.new("TextButton", frame)
    flyBtn.Size = UDim2.new(0.85,0,0,40)
    flyBtn.Position = UDim2.new(0.075,0,0.25,0)
    flyBtn.Text = "FLY : OFF"
    flyBtn.ZIndex = 1
    flyBtn.MouseButton1Click:Connect(function()
        fly = not fly
        flyBtn.Text = fly and "FLY : ON" or "FLY : OFF"
    end)

    -- SPEED + / - BUTTONS
    local plusBtn = Instance.new("TextButton", frame)
    plusBtn.Size = UDim2.new(0.4,0,0,35)
    plusBtn.Position = UDim2.new(0.05,0,0.6,0)
    plusBtn.Text = "+ SPEED"
    plusBtn.ZIndex = 1
    plusBtn.MouseButton1Click:Connect(function()
        speed = math.min(speed + 0.5, 5)
        speedLabel.Text = "Speed: "..speed
    end)

    local minusBtn = Instance.new("TextButton", frame)
    minusBtn.Size = UDim2.new(0.4,0,0,35)
    minusBtn.Position = UDim2.new(0.55,0,0.6,0)
    minusBtn.Text = "- SPEED"
    minusBtn.ZIndex = 1
    minusBtn.MouseButton1Click:Connect(function()
        speed = math.max(speed - 0.5, 0.5)
        speedLabel.Text = "Speed: "..speed
    end)

    -- MỞ/ĐÓNG MENU KHI CLICK LOGO
    logo.MouseButton1Click:Connect(function()
        frame.Visible = not frame.Visible
    end)

    -- KEY INPUT
    UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local key = input.KeyCode.Name
            if keys[key] ~= nil then
                keys[key] = true
            end
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local key = input.KeyCode.Name
            if keys[key] ~= nil then
                keys[key] = false
            end
        end
    end)

    -- FLY LOOP + NOCLIP
    RunService.Heartbeat:Connect(function()
        if not fly then return end
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if hrp and hum then
            -- Noclip
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
            -- Fly direction theo W/A/S/D
            local dir = Vector3.new()
            if keys.W then dir = dir + workspace.CurrentCamera.CFrame.LookVector end
            if keys.S then dir = dir - workspace.CurrentCamera.CFrame.LookVector end
            if keys.A then dir = dir - workspace.CurrentCamera.CFrame.RightVector end
            if keys.D then dir = dir + workspace.CurrentCamera.CFrame.RightVector end
            if dir.Magnitude > 0 then
                hrp.Velocity = dir.Unit * speed * 50
            else
                hrp.Velocity = Vector3.new(0,0,0)
            end
        end
    end)
end

print("GUIFLY DELTA MOBILE LOADED")
