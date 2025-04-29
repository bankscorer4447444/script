--// Complete Minimal GUI with Rounded Design + Minimize Icon Button (Draggable) //-- 

local player = game.Players.LocalPlayer

-- GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "SimpleGui"

-- Main Frame
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 350, 0, 250)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Unit ID Box
local unitIDBox = Instance.new("TextBox", mainFrame)
unitIDBox.Size = UDim2.new(0, 240, 0, 40)
unitIDBox.Position = UDim2.new(0.5, -120, 0, 20)
unitIDBox.PlaceholderText = "Enter Unit ID"
unitIDBox.Text = ""
unitIDBox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
unitIDBox.TextColor3 = Color3.fromRGB(255, 255, 255)
unitIDBox.TextScaled = true
unitIDBox.BorderSizePixel = 0
Instance.new("UICorner", unitIDBox).CornerRadius = UDim.new(0, 8)

-- Start Button
local startButton = Instance.new("TextButton", mainFrame)
startButton.Size = UDim2.new(0, 120, 0, 40)
startButton.Position = UDim2.new(0.5, -60, 0, 80)
startButton.Text = "Start"
startButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
startButton.TextScaled = true
startButton.BorderSizePixel = 0
Instance.new("UICorner", startButton).CornerRadius = UDim.new(0, 8)

-- Spy Button
local spyButton = Instance.new("TextButton", mainFrame)
spyButton.Size = UDim2.new(0, 120, 0, 40)
spyButton.Position = UDim2.new(0.5, -60, 0, 140)
spyButton.Text = "Spy"
spyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
spyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spyButton.TextScaled = true
spyButton.BorderSizePixel = 0
Instance.new("UICorner", spyButton).CornerRadius = UDim.new(0, 8)

-- Status Label
local statusLabel = Instance.new("TextLabel", mainFrame)
statusLabel.Size = UDim2.new(0, 280, 0, 40)
statusLabel.Position = UDim2.new(0.5, -140, 1, -60)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Text = "Status: Idle"
statusLabel.TextScaled = true
statusLabel.TextStrokeTransparency = 0.5
statusLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

-- Close Button
local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -40, 0, 0)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.BorderSizePixel = 0
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 8)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Minimize Button (Icon)
local toggleIcon = Instance.new("ImageButton", screenGui)
toggleIcon.Size = UDim2.new(0, 40, 0, 40)
toggleIcon.Position = UDim2.new(0, 10, 0, 10)
toggleIcon.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
toggleIcon.Image = "rbxassetid://100365905666986" -- เปลี่ยนเป็นไอคอนที่ใช้ได้จริง
toggleIcon.Visible = false
Instance.new("UICorner", toggleIcon).CornerRadius = UDim.new(0, 8)

-- Minimize logic
local isVisible = true
local minimizeButton = Instance.new("TextButton", mainFrame)
minimizeButton.Size = UDim2.new(0, 40, 0, 40)
minimizeButton.Position = UDim2.new(1, -80, 0, 0)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextScaled = true
minimizeButton.BorderSizePixel = 0
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 8)

minimizeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    toggleIcon.Visible = true
end)

toggleIcon.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    toggleIcon.Visible = false
end)

-- Drag toggle icon
local dragging, dragInput, startPos, startInputPos

toggleIcon.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		startInputPos = input.Position
		startPos = toggleIcon.Position
	end
end)

toggleIcon.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - startInputPos
		toggleIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Blacklist
local blacklist = {
    gems = true,
    raid_token = true,
    siege_token = true,
    gold = true
}

-- Feed Items Function
local function feedItems(unitID)
    for _, v in pairs(game:GetService("ReplicatedStorage").assets.items:GetChildren()) do 
        if v:IsA("Model") and not blacklist[v.Name] then 
            local args = {
                [1] = {
                    ["2"] = {
                        [1] = {
                            [1] = unitID,
                            [2] = {
                                [v.Name] = 0/0
                            },
                            ["n"] = 2
                        }
                    }
                },
                [2] = {}
            }
            game:GetService("ReplicatedStorage"):WaitForChild("ReliableRedEvent"):FireServer(unpack(args))
        end
    end
end

-- Start
startButton.MouseButton1Click:Connect(function()
    local unitID = unitIDBox.Text
    if unitID == "" then
        statusLabel.Text = "Please enter Unit ID!"
        return
    end

    statusLabel.Text = "Status: Running..."
    feedItems(unitID)
    statusLabel.Text = "Status: Completed"
end)

-- Spy
spyButton.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()
    end)
    
    if not success then
        statusLabel.Text = "Spy Error: " .. err
    else
        statusLabel.Text = "Spy Started!"
    end
end)
