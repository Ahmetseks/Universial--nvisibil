-- [[ ScriptMDL - UNIVERSAL GHOST MODE ]] --
-- Credits: ScriptMDL
-- Language: English (Code & UI)

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local BrandLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

-- UI Configuration
ScreenGui.Name = "ScriptMDL_GhostUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 70)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

UIStroke.Color = Color3.fromRGB(0, 255, 127)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Branding: ScriptMDL
BrandLabel.Name = "BrandLabel"
BrandLabel.Parent = MainFrame
BrandLabel.BackgroundTransparency = 1
BrandLabel.Size = UDim2.new(1, 0, 0, 20)
BrandLabel.Font = Enum.Font.GothamBold
BrandLabel.Text = "ScriptMDL"
BrandLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BrandLabel.TextSize = 12.0
BrandLabel.TextTransparency = 0.4

-- Control Button
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundTransparency = 1
ToggleButton.Position = UDim2.new(0, 0, 0.3, 0)
ToggleButton.Size = UDim2.new(1, 0, 0.7, 0)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "ACTIVATE GHOST"
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 127)
ToggleButton.TextSize = 15.0

-- Ghost Logic
local Player = game.Players.LocalPlayer
local GhostActive = false

local function ToggleGhostMode()
    local Character = Player.Character
    if not Character then return end
    
    GhostActive = not GhostActive
    
    -- Iterate through character parts
    for _, item in pairs(Character:GetDescendants()) do
        -- Transparency Logic
        if item:IsA("BasePart") or item:IsA("Decal") then
            if item.Name ~= "HumanoidRootPart" then
                item.Transparency = GhostActive and 1 or 0
            end
        end
        
        -- Disable Nametags / BillboardGuis
        if item:IsA("BillboardGui") or item:IsA("SurfaceGui") then
            item.Enabled = not GhostActive
        end
    end
    
    -- UI Update Logic
    if GhostActive then
        ToggleButton.Text = "REAPPEAR"
        ToggleButton.TextColor3 = Color3.fromRGB(255, 50, 50)
        UIStroke.Color = Color3.fromRGB(255, 50, 50)
    else
        ToggleButton.Text = "ACTIVATE GHOST"
        ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 127)
        UIStroke.Color = Color3.fromRGB(0, 255, 127)
    end
end

-- Button Listener
ToggleButton.MouseButton1Click:Connect(function()
    ToggleGhostMode()
end)

-- Respawn Handler
Player.CharacterAdded:Connect(function()
    GhostActive = false
    ToggleButton.Text = "ACTIVATE GHOST"
    ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 127)
    UIStroke.Color = Color3.fromRGB(0, 255, 127)
end)

print("ScriptMDL: Ghost Mode script successfully executed.")
