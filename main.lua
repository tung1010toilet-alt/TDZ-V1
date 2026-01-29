
local VIM = game:GetService("VirtualInputManager")
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CG = game:GetService("CoreGui") or LP:WaitForChild("PlayerGui")

-- [TÍNH NĂNG MỚI: ANTI-AFK CHẠY NGẦM]
task.spawn(function()
    local VirtualUser = game:GetService("VirtualUser")
    LP.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

local Screen = Instance.new("ScreenGui", CG)
Screen.Name = "TDZ_V1_STABLE"

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 350, 0, 260)
Main.Position = UDim2.new(0.5, -175, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 3
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
task.spawn(function()
    local hue = 0
    while task.wait() do
        hue = hue + 1/360
        Stroke.Color = Color3.fromHSV(hue % 1, 0.8, 1)
    end
end)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "TDZ ULTIMATE VIP V1"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16
Title.BackgroundTransparency = 1

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, 0, 1, -50)
Content.Position = UDim2.new(0, 0, 0, 50)
Content.BackgroundTransparency = 1

local isVisible = true
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -40, 0, 10)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.BackgroundTransparency = 1
MinBtn.TextSize = 22
MinBtn.Font = Enum.Font.GothamBold
MinBtn.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    Content.Visible = isVisible
    Main.Size = isVisible and UDim2.new(0, 350, 0, 260) or UDim2.new(0, 350, 0, 50)
    MinBtn.Text = isVisible and "-" or "+"
end)

local function CreateBtn(name, pos, color)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(0, 160, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = color or Color3.fromRGB(30, 30, 35)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local DelayInput = Instance.new("TextBox", Content)
DelayInput.Size = UDim2.new(0, 330, 0, 30)
DelayInput.Position = UDim2.new(0, 10, 0, 5)
DelayInput.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
DelayInput.Text = "0.1"
DelayInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", DelayInput).CornerRadius = UDim.new(0, 6)

local AutoBtn = CreateBtn("AUTO CLICK: OFF", UDim2.new(0, 10, 0, 45))
local EspBtn = CreateBtn("ESP PLAYER: OFF", UDim2.new(0, 10, 0, 90))
local SpeedBtn = CreateBtn("SPEED HACK: OFF", UDim2.new(0, 10, 0, 135))
local SellBtn = CreateBtn("REMOTE SELL ALL", UDim2.new(0, 10, 0, 180), Color3.fromRGB(0, 110, 190))
SellBtn.Size = UDim2.new(0, 330, 0, 35)

local JumpBtn = CreateBtn("INF JUMP: OFF", UDim2.new(0, 180, 0, 45))
local NoclipBtn = CreateBtn("NOCLIP: OFF", UDim2.new(0, 180, 0, 90))
local DashBtn = CreateBtn("FLASH DASH", UDim2.new(0, 180, 0, 135), Color3.fromRGB(80, 40, 160))

local autoOn = false
AutoBtn.MouseButton1Click:Connect(function()
    autoOn = not autoOn
    AutoBtn.Text = autoOn and "AUTO CLICK: ON" or "AUTO CLICK: OFF"
    AutoBtn.BackgroundColor3 = autoOn and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(30, 30, 35)
    task.spawn(function()
        while autoOn do
            local fishBtn = LP.PlayerGui:FindFirstChild("Fishing", true) or LP.PlayerGui:FindFirstChild("Cast", true)
            local x, y = 500, 500
            if fishBtn and fishBtn.Visible then
                x = fishBtn.AbsolutePosition.X + (fishBtn.AbsoluteSize.X / 2)
                y = fishBtn.AbsolutePosition.Y + (fishBtn.AbsoluteSize.Y / 2) + 36
            end
            VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
            VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
            task.wait(tonumber(DelayInput.Text) or 0.1)
        end
    end)
end)

local espOn = false
EspBtn.MouseButton1Click:Connect(function()
    espOn = not espOn
    EspBtn.Text = espOn and "ESP: ON" or "ESP: OFF"
    EspBtn.BackgroundColor3 = espOn and Color3.fromRGB(150, 130, 0) or Color3.fromRGB(30, 30, 35)
end)

local speedOn = false
SpeedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    SpeedBtn.Text = speedOn and "SPEED: ON" or "SPEED: OFF"
    SpeedBtn.BackgroundColor3 = speedOn and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(30, 30, 35)
    task.spawn(function()
        while speedOn do
            if LP.Character and LP.Character:FindFirstChild("Humanoid") then
                LP.Character.Humanoid.WalkSpeed = 100
            end
            task.wait(0.1)
        end
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.WalkSpeed = 16 end
    end)
end)

local jumpOn = false
JumpBtn.MouseButton1Click:Connect(function()
    jumpOn = not jumpOn
    JumpBtn.Text = jumpOn and "INF JUMP: ON" or "INF JUMP: OFF"
    JumpBtn.BackgroundColor3 = jumpOn and Color3.fromRGB(200, 80, 0) or Color3.fromRGB(30, 30, 35)
end)
UIS.JumpRequest:Connect(function() if jumpOn then LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)

local noclipOn = false
NoclipBtn.MouseButton1Click:Connect(function()
    noclipOn = not noclipOn
    NoclipBtn.Text = noclipOn and "NOCLIP: ON" or "NOCLIP: OFF"
    NoclipBtn.BackgroundColor3 = noclipOn and Color3.fromRGB(200, 40, 120) or Color3.fromRGB(30, 30, 35)
end)
RunService.Stepped:Connect(function()
    if noclipOn and LP.Character then
        for _, part in pairs(LP.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

DashBtn.MouseButton1Click:Connect(function()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -20) end
end)

SellBtn.MouseButton1Click:Connect(function()
    local remote = RS:FindFirstChild("SellFish", true) or RS:FindFirstChild("Sell", true)
    if remote then remote:FireServer() end
end)

RunService.Heartbeat:Connect(function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local char = p.Character
            local h = char:FindFirstChild("Highlight")
            if espOn then
                if not h then h = Instance.new("Highlight", char) end
                h.FillColor = Color3.new(1, 0, 0)
                h.OutlineColor = Color3.new(1, 1, 1)
                local bg = char:FindFirstChild("T_ESP")
                if not bg then
                    bg = Instance.new("BillboardGui", char)
                    bg.Name = "T_ESP"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0, 200, 0, 50); bg.Adornee = char.Head; bg.ExtentsOffset = Vector3.new(0, 3, 0)
                    local tx = Instance.new("TextLabel", bg)
                    tx.Size = UDim2.new(1, 0, 1, 0); tx.BackgroundTransparency = 1; tx.Text = p.Name; tx.TextColor3 = Color3.new(1, 1, 1); tx.Font = Enum.Font.GothamBlack; tx.TextSize = 18
                end
            else
                if h then h:Destroy() end
                if char:FindFirstChild("T_ESP") then char.T_ESP:Destroy() end
            end
        end
    end
end)
