local VIM = game:GetService("VirtualInputManager")
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CG = game:GetService("CoreGui") or LP:WaitForChild("PlayerGui")

-- [1. ANTI-AFK CHẠY NGẦM]
task.spawn(function()
    local VirtualUser = game:GetService("VirtualUser")
    LP.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

local Screen = Instance.new("ScreenGui", CG)
Screen.Name = "TDZ_V2_FARM_VIP"

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 350, 0, 300) -- Tăng size để chứa thêm nút
Main.Position = UDim2.new(0.5, -175, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness, Stroke.ApplyStrokeMode = 3, 2
task.spawn(function()
    local h = 0 while task.wait() do h = h + 1/360 Stroke.Color = Color3.fromHSV(h % 1, 0.8, 1) end
end)

local Title = Instance.new("TextLabel", Main)
Title.Size, Title.Text, Title.TextColor3, Title.Font, Title.TextSize, Title.BackgroundTransparency = UDim2.new(1,0,0,50), "TDZ ULTIMATE V2 - AUTO FARM", Color3.new(1,1,1), 10, 16, 1

local Content = Instance.new("Frame", Main)
Content.Size, Content.Position, Content.BackgroundTransparency = UDim2.new(1,0,1,-50), UDim2.new(0,0,0,50), 1

local function CreateBtn(name, pos, color)
    local btn = Instance.new("TextButton", Content)
    btn.Size, btn.Position, btn.BackgroundColor3, btn.Text, btn.TextColor3, btn.Font, btn.TextSize = UDim2.new(0, 160, 0, 35), pos, color or Color3.fromRGB(30, 30, 35), name, Color3.new(1,1,1), 10, 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6); return btn
end

-- [2. CÁC NÚT CHỨC NĂNG]
local FarmBtn = CreateBtn("AUTO FARM VIP: OFF", UDim2.new(0, 10, 0, 10), Color3.fromRGB(200, 50, 50))
FarmBtn.Size = UDim2.new(0, 330, 0, 40)

local SpeedBtn = CreateBtn("SPEED HACK: OFF", UDim2.new(0, 10, 0, 60))
local EspBtn = CreateBtn("ESP PLAYER: OFF", UDim2.new(0, 180, 0, 60))
local JumpBtn = CreateBtn("INF JUMP: OFF", UDim2.new(0, 10, 0, 105))
local NoclipBtn = CreateBtn("NOCLIP: OFF", UDim2.new(0, 180, 0, 105))

local SellBtn = CreateBtn("AUTO REMOTE SELL: OFF", UDim2.new(0, 10, 0, 150), Color3.fromRGB(0, 110, 190))
SellBtn.Size = UDim2.new(0, 330, 0, 40)

-- [3. LOGIC AUTO FARM VIP]
local autoFarm = false
FarmBtn.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    FarmBtn.Text = autoFarm and "AUTO FARM VIP: ON" or "AUTO FARM VIP: OFF"
    FarmBtn.BackgroundColor3 = autoFarm and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(200, 50, 50)
    
    task.spawn(function()
        while autoFarm do
            local char = LP.Character
            local tool = char and char:FindFirstChildOfClass("Tool")
            if tool then
                if not tool:FindFirstChild("Bobber") then
                    Title.Text = "🎣 ĐANG QUĂNG CẦN..."
                    VIM:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                    task.wait(0.1)
                    VIM:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                    task.wait(2)
                else
                    local bobber = tool:FindFirstChild("Bobber")
                    if bobber and bobber.Velocity.Magnitude > 0.7 then
                        Title.Text = "⚠️ CÁ CẮN! ĐỢI 3S..."
                        task.wait(3.1)
                        if autoFarm then
                            VIM:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                            VIM:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                            Title.Text = "✅ GIẬT CẦN THÀNH CÔNG!"
                            task.wait(2)
                        end
                    end
                end
            else
                Title.Text = "❌ HÃY CẦM CẦN CÂU!"
            end
            task.wait(0.5)
        end
        Title.Text = "TDZ ULTIMATE V2"
    end)
end)

-- [4. LOGIC AUTO SELL]
local autoSell = false
SellBtn.MouseButton1Click:Connect(function()
    autoSell = not autoSell
    SellBtn.Text = autoSell and "AUTO SELL: ON" or "AUTO SELL: OFF"
    SellBtn.BackgroundColor3 = autoSell and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(0, 110, 190)
    task.spawn(function()
        while autoSell do
            local remote = RS:FindFirstChild("SellFish", true) or RS:FindFirstChild("Sell", true)
            if remote then remote:FireServer() end
            task.wait(10) -- Tự động bán mỗi 10 giây
        end
    end)
end)

-- [5. GIỮ CÁC LOGIC CŨ]
local speedOn = false
SpeedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    SpeedBtn.Text = speedOn and "SPEED: ON" or "SPEED: OFF"
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
end)
UIS.JumpRequest:Connect(function() if jumpOn then LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)

local espOn = false
EspBtn.MouseButton1Click:Connect(function()
    espOn = not espOn
    EspBtn.Text = espOn and "ESP: ON" or "ESP: OFF"
end)

RunService.Heartbeat:Connect(function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local char = p.Character
            local h = char:FindFirstChild("Highlight")
            if espOn then
                if not h then h = Instance.new("Highlight", char) end
                h.FillColor = Color3.new(1, 0, 0)
            else
                if h then h:Destroy() end
            end
        end
    end
end)
