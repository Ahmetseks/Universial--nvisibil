-- UI Creation
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- UI Settings
ScreenGui.Name = "ScareMenu"
ScreenGui.Parent = game:GetService("CoreGui") -- This keeps the UI visible even if the game resets some elements

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 160, 0, 50)
MainFrame.Active = true
MainFrame.Draggable = true -- You can drag the button anywhere on your screen

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
ToggleButton.Size = UDim2.new(1, 0, 1, 0)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "GO INVISIBLE"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 18.0

UICorner.Parent = MainFrame

-- Variables
local player = game.Players.LocalPlayer
local isHidden = false

-- Invisibility Function
local function toggleInvisibility()
    local character = player.Character
    if not character then return end
    
    isHidden = not isHidden
    
    -- Loop through all body parts and accessories
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            -- We don't touch HumanoidRootPart as it's already invisible
            if part.Name ~= "HumanoidRootPart" then
                if isHidden then
                    part.Transparency = 1 -- Make completely transparent
                else
                    part.Transparency = 0 -- Make visible again
                end
            end
        end
    end
    
    -- Update Button Text and Color
    if isHidden then
        ToggleButton.Text = "REAPPEAR"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- Red when invisible
    else
        ToggleButton.Text = "GO INVISIBLE"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- Blue when visible
    end
end

-- Button Click Event
ToggleButton.MouseButton1Click:Connect(function()
    toggleInvisibility()
end)

-- Reset UI state if character dies/respawns
player.CharacterAdded:Connect(function()
    isHidden = false
    ToggleButton.Text = "GO INVISIBLE"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
end)

print("Scaring Script Loaded! Use the button on the left.")

