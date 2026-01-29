
local isPredicting = false
PredictBtn.MouseButton1Click:Connect(function()
    isPredicting = not isPredicting
    PredictBtn.Text = isPredicting and "AUTO WAIT 3S: ON" or "AUTO WAIT 3S: OFF"
    PredictBtn.BackgroundColor3 = isPredicting and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(20, 20, 25)
    
    if isPredicting then
        task.spawn(function()
            while isPredicting do
                local char = LP.Character
                local tool = char and char:FindFirstChildOfClass("Tool")
                
                -- Tìm phao câu (Bobber) để phát hiện tín hiệu cá cắn
                if tool and tool:FindFirstChild("Bobber") then
                    local bobber = tool.Bobber
                    -- Nếu phao rung (Velocity > 0.7) nghĩa là cá bắt đầu rỉa mồi
                    if bobber.Velocity.Magnitude > 0.7 then 
                        Title.Text = "⚠️ CÁ ĐANG RỈA - ĐỢI 3S... ⚠️"
                        Title.TextColor3 = Color3.fromRGB(255, 165, 0) -- Màu cam cảnh báo
                        
                        -- ĐỢI ĐÚNG 3 GIÂY CHO CÁ NGẬM CHẶT (Theo cơ chế game)
                        task.wait(3.1) -- Để 3.1s cho chắc chắn không bị sớm quá
                        
                        -- SAU 3S MỚI BẮT ĐẦU CLICK GIẬT CẦN
                        if isPredicting then
                            VIM:SendMouseButtonEvent(500, 500, 0, true, game, 0)
                            VIM:SendMouseButtonEvent(500, 500, 0, false, game, 0)
                            Title.Text = "✅ ĐÃ GIẬT CẦN THÀNH CÔNG! ✅"
                            Title.TextColor3 = Color3.fromRGB(0, 255, 0)
                        end
                        
                        task.wait(2) -- Nghỉ một chút để chuẩn bị lần câu tiếp theo
                        Title.Text = "TDZ ULTIMATE VIP V2"
                        Title.TextColor3 = Color3.new(1, 1, 1)
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)
