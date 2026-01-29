
local VIM = game:GetService("VirtualInputManager")
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CG = game:GetService("CoreGui") or LP:WaitForChild("PlayerGui")

-- [TÍNH NĂNG: ANTI-AFK CHẠY NGẦM]
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
Main.Size = UDim2.new(0, 350, 0, 300) -- Tăng chiều cao để thêm nút mới
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
Title.Size, Title.Text, Title.TextColor3, Title.Font, Title.TextSize, Title.BackgroundTransparency = UDim2.new(1,0,0,50), "TDZ ULTIMATE VIP V2", Color3.new(1,1,1), 10, 16, 1

local Content = Instance.new("Frame", Main)
Content.Size, Content.Position, Content.BackgroundTransparency = UDim2.new(1,0,1,-50), UDim2.new(0,0,0,50), 1

local function CreateBtn(name, pos, color)
    local btn = Instance.new("TextButton", Content)
    btn.Size, btn.Position, btn.BackgroundColor3, btn.Text, btn.TextColor3, btn.Font, btn.TextSize = UDim2.new(0, 160, 0, 35), pos, color or Color3.fromRGB(30, 30, 35), name, Color3.new(1,1,1), 10, 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6); return btn
end

-- UI Chức năng
local DelayInput = Instance.new("TextBox", Content)
DelayInput.Size, DelayInput.Position, DelayInput.BackgroundColor3, DelayInput.Text, DelayInput.TextColor3 = UDim2.new(0, 330, 0, 30), UDim2.new(0, 10, 0, 5), Color3.fromRGB(20, 20, 25), "0.1", Color3.new(1,1,1)
Instance.new("UICorner", DelayInput).CornerRadius = UDim.new(0, 6)

local AutoBtn = CreateBtn("AUTO CLICK: OFF", UDim2.new(0, 10, 0, 45))
local EspBtn = CreateBtn("ESP PLAYER: OFF", UDim2.new(0, 10, 0, 90))
local SpeedBtn = CreateBtn("SPEED HACK: OFF", UDim2.new(0, 10, 0, 135))
local JumpBtn = CreateBtn("INF JUMP: OFF", UDim2.new(0, 180, 0, 45))
local NoclipBtn = CreateBtn("NOCLIP: OFF", UDim2.new(0, 180, 0, 90))
local DashBtn = CreateBtn("FLASH DASH", UDim2.new(0, 180, 0, 135), Color3.fromRGB(80, 40, 160))

-- [NÚT MỚI: DỰ ĐOÁN CÁ CẮN]
local PredictBtn = CreateBtn("PREDICT BITE: OFF", UDim2.new(0, 10, 0, 180), Color3.fromRGB(200, 150, 0))
PredictBtn.Size = UDim2.new(0, 330, 0, 35)

local SellBtn = CreateBtn("REMOTE SELL ALL", UDim2.new(0, 10, 0, 225), Color3.fromRGB(0, 110, 190))
SellBtn.Size = UDim2.new(0, 330, 0, 35)

-- Logic Dự đoán cá cắn
local predictOn = false
PredictBtn.MouseButton1Click:Connect(function()
    predictOn = not predictOn
    PredictBtn.Text = predictOn and "PREDICT BITE: ON" or "PREDICT BITE: OFF"
    PredictBtn.BackgroundColor3 = predictOn and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(200, 150, 0)
    
    if predictOn then
        task.spawn(function()
            while predictOn do
                -- Kiểm tra dấu hiệu cá cắn (Ví dụ: bong bóng hoặc rung cần)
                local character = LP.Character
                if character and character:FindFirstChildOfClass("Tool") then
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool:FindFirstChild("Bobber") then -- Tìm phao câu
                        local bobber = tool.Bobber
                        -- Nếu phao di chuyển bất thường (giá trị Velocity thay đổi)
                        if bobber.Velocity.Magnitude > 0.5 then 
                            Title.Text = "⚠️ FISH BITE DETECTED! ⚠️"
                            Title.TextColor3 = Color3.new(1, 0, 0)
                            task.wait(1)
                            Title.Text = "TDZ ULTIMATE VIP V2"
                            Title.TextColor3 = Color3.new(1, 1, 1)
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)

-- Giữ nguyên các Logic cũ (AutoClick, Speed, ESP, v.v...) bên dưới
-- [Phần này bạn tự giữ lại các logic cũ từ bản V1 nhé]
