local VIM = game:GetService("VirtualInputManager")
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local CG = game:GetService("CoreGui") or LP:WaitForChild("PlayerGui")

local Screen = Instance.new("ScreenGui", CG)
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 300, 0, 200)
Main.Position = UDim2.new(0.5, -150, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "TDZ AUTO FARM FIX"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1

local FarmBtn = Instance.new("TextButton", Main)
FarmBtn.Size = UDim2.new(0, 280, 0, 50)
FarmBtn.Position = UDim2.new(0, 10, 0, 60)
FarmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
FarmBtn.Text = "AUTO FARM VIP: OFF"
FarmBtn.TextColor3 = Color3.new(1, 1, 1)

local autoFarm = false
FarmBtn.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    FarmBtn.Text = autoFarm and "AUTO FARM VIP: ON" or "AUTO FARM VIP: OFF"
    FarmBtn.BackgroundColor3 = autoFarm and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(200, 50, 50)
    
    task.spawn(function()
        while autoFarm do
            local tool = LP.Character and LP.Character:FindFirstChildOfClass("Tool")
            if tool then
                if not tool:FindFirstChild("Bobber") then
                    VIM:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                    task.wait(0.1)
                    VIM:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                    task.wait(2)
                else
                    local b = tool.Bobber
                    if b.Velocity.Magnitude > 0.7 then
                        task.wait(3.1) -- Đợi 3s ngậm mồi
                        VIM:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                        VIM:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                        task.wait(2)
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)
