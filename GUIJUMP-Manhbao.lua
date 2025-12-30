-- GUIJUMP DELTA X by manhbao
-- FIXED KEY + Link4m + Avatar + Hold Jump = Fly

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- ===== CONFIG =====
local GETKEY_LINK = "https://link4m.com/CadYuDL"
local FIXED_KEY = "MANHBAO-KEY" -- KEY CỐ ĐỊNH
local AVATAR_ID = "96045391302700"
-- ==================

-- ===== KEY GUI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)

local f = Instance.new("Frame", gui)
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

local t = Instance.new("TextLabel", f)
t.Text = "GUIJUMP by manhbao"
t.Size = UDim2.new(0.65,0,0,40)
t.Position = UDim2.new(0.3,0,0.12,0)
t.BackgroundTransparency = 1
t.TextColor3 = Color3.fromRGB(0,255,255)
t.Font = Enum.Font.GothamBold
t.TextScaled = true

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

-- GET KEY: hiện + copy link
g.MouseButton1Click:Connect(function()
    box.Text = GETKEY_LINK
    if setclipboard then
        setclipboard(GETKEY_LINK)
    end
end)

-- CHECK KEY
c.MouseButton1Click:Connect(function()
    if box.Text == FIXED_KEY then
        gui:Destroy()
    else
        box.Text = "KEY SAI"
    end
end)

-- ===== HOLD JUMP = FLY =====
local char = player.Character or player.CharacterAdded:Wait()
local fly = false

player.CharacterAdded:Connect(function(c)
    char = c
end)

UIS.JumpRequest:Connect(function()
    fly = true
end)

UIS.InputEnded:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.Space then
        fly = false
    end
end)

RunService.Heartbeat:Connect(function()
    if fly and char and char:FindFirstChild("HumanoidRootPart") then
        char:TranslateBy(Vector3.new(0,0.8,0))
    end
end)
