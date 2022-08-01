local library = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "Revenant" then
        v:Destroy()
    end
end

function library:Window(Info)
Info.Text = Info.Text or "Revenant"

local Pos = 0.05

for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "Revenant" then
        Pos = Pos + 0.12
    end
end

local insidewindow = {}

local frameSize = 0

local revenant = Instance.new("ScreenGui")
revenant.Name = "Revenant"
revenant.Parent = game:GetService("CoreGui")

local topbar = Instance.new("Frame")
topbar.Name = "Topbar"
topbar.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
topbar.Position = UDim2.fromScale(Pos, 0.1)
topbar.Size = UDim2.fromOffset(225, 38)
topbar.Parent = revenant

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    topbar.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = topbar.Position
        		
        input.Changed:Connect(function()
        	if input.UserInputState == Enum.UserInputState.End then
        		dragging = false
        	end
        end)
    end
end)

topbar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local uICorner = Instance.new("UICorner")
uICorner.Name = "UICorner"
uICorner.CornerRadius = UDim.new(0, 4)
uICorner.Parent = topbar

local backgroundFrame = Instance.new("Frame")
backgroundFrame.Name = "BackgroundFrame"
backgroundFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
backgroundFrame.BorderSizePixel = 0
backgroundFrame.ClipsDescendants = true
backgroundFrame.Position = UDim2.fromScale(0, 1)
backgroundFrame.Size = UDim2.fromOffset(225, 0) -- 38
backgroundFrame.Parent = topbar

local uICorner1 = Instance.new("UICorner")
uICorner1.Name = "UICorner"
uICorner1.CornerRadius = UDim.new(0, 4)
uICorner1.Parent = backgroundFrame

local fixLine = Instance.new("Frame")
fixLine.Name = "FixLine"
fixLine.AnchorPoint = Vector2.new(0.5, 0)
fixLine.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
fixLine.BorderSizePixel = 0
fixLine.Position = UDim2.fromScale(0.5, 0)
fixLine.Size = UDim2.fromOffset(225, 2)
fixLine.ZIndex = -1
fixLine.Parent = backgroundFrame

local itemContainer = Instance.new("Frame")
itemContainer.Name = "ItemContainer"
itemContainer.AnchorPoint = Vector2.new(0.5, 0)
itemContainer.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
itemContainer.BackgroundTransparency = 1
itemContainer.BorderSizePixel = 0
itemContainer.Position = UDim2.fromScale(0.5, 0)
itemContainer.Size = UDim2.fromOffset(225, 0) -- 38
itemContainer.Parent = backgroundFrame

itemContainer.ChildAdded:Connect(function(v)
    if v.ClassName ~= "UIListLayout" then
    backgroundFrame.Size = UDim2.new(0,225,0,itemContainer.Size.Y.Offset + 38)
    itemContainer.Size = UDim2.new(0,225,0,itemContainer.Size.Y.Offset + 38)
    
    frameSize = frameSize + 38
    end
end)

local uIListLayout = Instance.new("UIListLayout")
uIListLayout.Name = "UIListLayout"
uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout.Parent = itemContainer

function insidewindow:Button(Info)
Info.Text = Info.Text or "Button"
Info.Callback = Info.Callback or function() end

local button = Instance.new("Frame")
button.Name = "Button"
button.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
button.Size = UDim2.fromOffset(225, 38)
button.Parent = itemContainer

local uICorner2 = Instance.new("UICorner")
uICorner2.Name = "UICorner"
uICorner2.CornerRadius = UDim.new(0, 4)
uICorner2.Parent = button

local fixLine1 = Instance.new("Frame")
fixLine1.Name = "FixLine"
fixLine1.AnchorPoint = Vector2.new(0.5, 1)
fixLine1.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
fixLine1.BorderSizePixel = 0
fixLine1.Position = UDim2.fromScale(0.5, 0.0526)
fixLine1.Size = UDim2.fromOffset(225, 4)
fixLine1.Parent = button

local buttonTextButton = Instance.new("TextButton")
buttonTextButton.Name = "ButtonTextButton"
buttonTextButton.Font = Enum.Font.GothamBold
buttonTextButton.Text = ""
buttonTextButton.TextColor3 = Color3.fromRGB(214, 214, 214)
buttonTextButton.TextSize = 13
buttonTextButton.AutoButtonColor = false
buttonTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
buttonTextButton.BackgroundTransparency = 1
buttonTextButton.Size = UDim2.fromOffset(225, 38)
buttonTextButton.Parent = button

local buttonTextLabel = Instance.new("TextLabel")
buttonTextLabel.Name = "ButtonTextLabel"
buttonTextLabel.Font = Enum.Font.GothamBold
buttonTextLabel.Text = Info.Text
buttonTextLabel.TextColor3 = Color3.fromRGB(214, 214, 214)
buttonTextLabel.TextSize = 13
buttonTextLabel.TextXAlignment = Enum.TextXAlignment.Left
buttonTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
buttonTextLabel.BackgroundTransparency = 1
buttonTextLabel.Position = UDim2.fromScale(0.0489, 0)
buttonTextLabel.Size = UDim2.fromOffset(214, 38)
buttonTextLabel.Parent = button

button.MouseEnter:Connect(function()
    fixLine1.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    button.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
end)

button.MouseLeave:Connect(function()
    fixLine1.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    button.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
end)

buttonTextButton.MouseButton1Click:Connect(function()
    pcall(Info.Callback)
end)
end

function insidewindow:Toggle(Info)
Info.Text = Info.Text or "Toggle"
Info.Callback = Info.Callback or function() end
    
local toggle = Instance.new("Frame")
toggle.Name = "Toggle"
toggle.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
toggle.Size = UDim2.fromOffset(225, 38)
toggle.Parent = itemContainer

local uICorner = Instance.new("UICorner")
uICorner.Name = "UICorner"
uICorner.CornerRadius = UDim.new(0, 4)
uICorner.Parent = toggle

local fixLineToggle = Instance.new("Frame")
fixLineToggle.Name = "FixLine"
fixLineToggle.AnchorPoint = Vector2.new(0.5, 1)
fixLineToggle.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
fixLineToggle.BorderSizePixel = 0
fixLineToggle.Position = UDim2.fromScale(0.5, 0.0526)
fixLineToggle.Size = UDim2.fromOffset(225, 4)
fixLineToggle.Parent = toggle

local toggleTextButton = Instance.new("TextButton")
toggleTextButton.Name = "ToggleTextButton"
toggleTextButton.Font = Enum.Font.GothamBold
toggleTextButton.Text = ""
toggleTextButton.TextColor3 = Color3.fromRGB(214, 214, 214)
toggleTextButton.TextSize = 13
toggleTextButton.AutoButtonColor = false
toggleTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleTextButton.BackgroundTransparency = 1
toggleTextButton.Size = UDim2.fromOffset(225, 38)
toggleTextButton.Parent = toggle

local toggleTextLabel = Instance.new("TextLabel")
toggleTextLabel.Name = "ToggleTextLabel"
toggleTextLabel.Font = Enum.Font.GothamBold
toggleTextLabel.Text = Info.Text
toggleTextLabel.TextColor3 = Color3.fromRGB(214, 214, 214)
toggleTextLabel.TextSize = 13
toggleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
toggleTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleTextLabel.BackgroundTransparency = 1
toggleTextLabel.Position = UDim2.fromScale(0.0489, 0)
toggleTextLabel.Size = UDim2.fromOffset(214, 38)
toggleTextLabel.Parent = toggle

local outerFrame = Instance.new("Frame")
outerFrame.Name = "OuterFrame"
outerFrame.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
outerFrame.BorderSizePixel = 0
outerFrame.Position = UDim2.fromScale(0.782, 0.263)
outerFrame.Size = UDim2.fromOffset(38, 17)
outerFrame.Parent = toggle

local uICorner1 = Instance.new("UICorner")
uICorner1.Name = "UICorner"
uICorner1.CornerRadius = UDim.new(1, 0)
uICorner1.Parent = outerFrame

local innerFrame = Instance.new("Frame")
innerFrame.Name = "InnerFrame"
innerFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
innerFrame.Position = UDim2.fromOffset(2, 2)
innerFrame.Size = UDim2.fromOffset(15, 13)
innerFrame.Parent = outerFrame

local uICorner2 = Instance.new("UICorner")
uICorner2.Name = "UICorner"
uICorner2.CornerRadius = UDim.new(1, 0)
uICorner2.Parent = innerFrame

toggle.MouseEnter:Connect(function()
    fixLineToggle.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    toggle.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
end)

toggle.MouseLeave:Connect(function()
    fixLineToggle.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    toggle.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
end)

local Toggled = false
toggleTextButton.MouseButton1Click:Connect(function()
    Toggled = not Toggled
    pcall(Info.Callback, Toggled)
    TweenService:Create(innerFrame, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In),{Position = Toggled and UDim2.new(0, 21,0, 2) or UDim2.new(0, 2,0, 2)}):Play()
    TweenService:Create(outerFrame, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In),{BackgroundColor3 = Toggled and Color3.fromRGB(7, 183, 168) or Color3.fromRGB(62, 62, 62)}):Play()
end)
end

local fixLine2 = Instance.new("Frame")
fixLine2.Name = "FixLine"
fixLine2.AnchorPoint = Vector2.new(0.5, 1)
fixLine2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fixLine2.BorderSizePixel = 0
fixLine2.Position = UDim2.fromScale(0.5, 1)
fixLine2.Size = UDim2.fromOffset(225, 2)
fixLine2.Parent = topbar

local windowText = Instance.new("TextLabel")
windowText.Name = "WindowText"
windowText.Font = Enum.Font.GothamBold
windowText.Text = Info.Text
windowText.TextColor3 = Color3.fromRGB(214, 214, 214)
windowText.TextSize = 14
windowText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
windowText.BackgroundTransparency = 1
windowText.Size = UDim2.fromOffset(225, 38)
windowText.Parent = topbar

local close = Instance.new("ImageButton")
close.Name = "Close"
close.Image = "rbxassetid://7733717447"
close.Active = true
close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
close.BackgroundTransparency = 1
close.Position = UDim2.fromScale(0.876, 0.263)
close.Selectable = false
close.Size = UDim2.fromOffset(17, 17)
close.Parent = topbar

local Opened = true
close.MouseButton1Click:Connect(function()
    Opened = not Opened
    
    TweenService:Create(backgroundFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),{Size = not Opened and UDim2.new(0,225,0,0) or UDim2.new(0,225,0,frameSize)}):Play()
    TweenService:Create(close, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),{Rotation = not Opened and 180 or 0}):Play()
end)

return insidewindow
end
return library
