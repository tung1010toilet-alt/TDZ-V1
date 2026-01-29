local VIM = game:GetService("VirtualInputManager")
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CG = game:GetService("CoreGui") or LP:WaitForChild("PlayerGui")

-- [1. ANTI-AFK]
task.spawn(function()
    local VU = game:GetService("VirtualUser")
    LP.Idled:Connect(function() VU:CaptureController() VU:ClickButton2(Vector2.new()) end)
end)

local Screen = Instance.new("ScreenGui", CG)
Screen.Name = "TDZ_V2_FIXED"

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 350, 0, 300)
Main.Position = UDim2.new(0.5, -175, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Main)
Title.Size, Title.Text, Title.TextColor3, Title.Font, Title.TextSize, Title.BackgroundTransparency = UDim2.new(1,0,0,50), "TDZ AUTO FARM VIP", Color3.new(1,1,1), 10, 18, 1

local Content = Instance.new("Frame", Main)
Content.Size, Content.Position, Content.BackgroundTransparency = UDim2.new(1,0,1,-50), UDim2.new(0,0,0,50), 1

local function CreateBtn(name, pos, color)
    local btn = Instance.new("TextButton", Content)
    btn.Size, btn.Position, btn.BackgroundColor3, btn.Text, btn.TextColor3, btn.Font, btn.TextSize = UDim2.new(0, 330, 0, 45), pos, color or Color3.fromRGB(35, 35, 40), name, Color3.new(1,1,1), 10, 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- [NÚT AUTO FARM CHÍNH]
local FarmBtn = CreateBtn("AUTO FARM VIP: OFF", UDim2.new(0, 10, 0, 10), Color3.fromRGB(200, 50, 50))

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
        Title.Text = "TDZ AUTO FARM VIP"
    end)
end)

-- [CÁC NÚT PHỤ]
local SpeedBtn = CreateBtn("SPEED HACK", UDim2.new(0, 10, 0, 65))
local SellBtn = CreateBtn("AUTO SELL (10S)", UDim2.new(0, 10, 0, 120), Color3.fromRGB(0, 100, 200))
