local library = {}

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local Mouse = Player:GetMouse()

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local UserInputService = game:GetService("UserInputService")

for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "Revenant" then
        v:Destroy()
    end
end

function library:GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

function library:Toggle()
    for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "Revenant" then
            v.Enabled = not v.Enabled
        end
    end
end

if not game:GetService("CoreGui"):FindFirstChild("NotificationLibrary") then
local notificationLibrary = Instance.new("ScreenGui")
notificationLibrary.Name = "NotificationLibrary"
notificationLibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
notificationLibrary.Parent = game:GetService("CoreGui")

local notificationHolder = Instance.new("Frame")
notificationHolder.Name = "NotificationHolder"
notificationHolder.AnchorPoint = Vector2.new(0, 0.5)
notificationHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
notificationHolder.BackgroundTransparency = 1
notificationHolder.Position = UDim2.fromScale(0, 0.5)
notificationHolder.Size = UDim2.fromScale(0.8, 1)
notificationHolder.Parent = notificationLibrary

local notificationUIListLayout = Instance.new("UIListLayout")
notificationUIListLayout.Name = "NotificationUIListLayout"
notificationUIListLayout.FillDirection = Enum.FillDirection.Vertical
notificationUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
notificationUIListLayout.Padding = UDim.new(0, 4)
notificationUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notificationUIListLayout.Parent = notificationHolder

local notificationUIPadding = Instance.new("UIPadding")
notificationUIPadding.Name = "NotificationUIPadding"
notificationUIPadding.PaddingBottom = UDim.new(0, 9)
notificationUIPadding.PaddingLeft = UDim.new(0, 5)
notificationUIPadding.Parent = notificationHolder
end

local NotificationLib = game:GetService("CoreGui"):FindFirstChild("NotificationLibrary")
local Holder = NotificationLib:FindFirstChild("NotificationHolder")

function library:Notification(NotificationInfo)
NotificationInfo.Text = NotificationInfo.Text or "This is a notification."
NotificationInfo.Duration = NotificationInfo.Duration or 5
NotificationInfo.Color = NotificationInfo.Color or Color3.fromRGB(56, 207, 154)

local notificationText = Instance.new("TextLabel")
notificationText.Name = "NotificationText"
notificationText.ClipsDescendants = true
notificationText.Font = Enum.Font.GothamBold
notificationText.Text = NotificationInfo.Text
notificationText.TextColor3 = Color3.fromRGB(214, 214, 214)
notificationText.TextSize = 14
notificationText.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
notificationText.BorderSizePixel = 0
notificationText.Position = UDim2.fromScale(0, 0.954)
notificationText.Size = UDim2.fromOffset(0, 38)
notificationText.Parent = Holder

local outerFrame = Instance.new("Frame")
outerFrame.Name = "OuterFrame"
outerFrame.AnchorPoint = Vector2.new(0, 1)
outerFrame.BackgroundColor3 = NotificationInfo.Color
outerFrame.BorderSizePixel = 0
outerFrame.Position = UDim2.fromScale(0, 1)
outerFrame.Size = UDim2.new(1, 0, 0, 3)
outerFrame.ZIndex = 2
outerFrame.Parent = notificationText

local notificationUICorner = Instance.new("UICorner")
notificationUICorner.Name = "NotificationUICorner"
notificationUICorner.CornerRadius = UDim.new(0, 4)
notificationUICorner.Parent = notificationText

local innerFrame = Instance.new("Frame")
innerFrame.Name = "InnerFrame"
innerFrame.AnchorPoint = Vector2.new(0, 1)
innerFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
innerFrame.BorderSizePixel = 0
innerFrame.Position = UDim2.fromScale(0, 1)
innerFrame.Size = UDim2.new(1, 0, 0, 3)
innerFrame.Parent = notificationText

local NotifText = notificationText
local TextBounds = NotifText.TextBounds

coroutine.wrap(function()
local InTween = TweenService:Create(NotifText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, TextBounds.X + 20, 0, 38)})
InTween:Play()
InTween.Completed:Wait()

local LineTween = TweenService:Create(outerFrame, TweenInfo.new(NotificationInfo.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 3)})
LineTween:Play()
LineTween.Completed:Wait()

local OutTween = TweenService:Create(NotifText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 38)})
OutTween:Play()
OutTween.Completed:Wait()
notificationText:Destroy()
end)()
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
backgroundFrame.ClipsDescendants = false
backgroundFrame.Position = UDim2.fromScale(0, 1)
backgroundFrame.Size = UDim2.fromOffset(225, 0)
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
fixLine.Parent = backgroundFrame
fixLine.ZIndex = 2

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
    end
end)

itemContainer.ChildRemoved:Connect(function(v)
    if v.ClassName ~= "UIListLayout" then
    backgroundFrame.Size = UDim2.new(0,225,0,itemContainer.Size.Y.Offset - 38)
    itemContainer.Size = UDim2.new(0,225,0,itemContainer.Size.Y.Offset - 38)
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

function insidewindow:Prompt(Info)
Info.Text = Info.Text or "Prompt"
Info.OnConfirm = Info.OnConfirm or function() end
Info.OnCancel = Info.OnCancel or function() end
    
local prompt = Instance.new("Frame")
prompt.Name = "Prompt"
prompt.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
prompt.Size = UDim2.fromOffset(225, 38)
prompt.Parent = game:GetService("CoreGui")

local promptUICorner = Instance.new("UICorner")
promptUICorner.Name = "PromptUICorner"
promptUICorner.CornerRadius = UDim.new(0, 4)
promptUICorner.Parent = prompt

local promptFixLine = Instance.new("Frame")
promptFixLine.Name = "PromptFixLine"
promptFixLine.AnchorPoint = Vector2.new(0.5, 1)
promptFixLine.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
promptFixLine.BorderSizePixel = 0
promptFixLine.Position = UDim2.fromScale(0.5, 0.0526)
promptFixLine.Size = UDim2.fromOffset(225, 4)
promptFixLine.Parent = prompt

local promptTextLabel = Instance.new("TextLabel")
promptTextLabel.Name = "PromptTextLabel"
promptTextLabel.Font = Enum.Font.GothamBold
promptTextLabel.Text = "Prompt"
promptTextLabel.TextColor3 = Color3.fromRGB(214, 214, 214)
promptTextLabel.TextSize = 13
promptTextLabel.TextXAlignment = Enum.TextXAlignment.Left
promptTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
promptTextLabel.BackgroundTransparency = 1
promptTextLabel.Position = UDim2.fromScale(0.0489, 0)
promptTextLabel.Size = UDim2.fromOffset(214, 38)
promptTextLabel.Parent = prompt

local cancelPromptButton = Instance.new("ImageButton")
cancelPromptButton.Name = "CancelPromptButton"
cancelPromptButton.Image = "http://www.roblox.com/asset/?id=6031094678"
cancelPromptButton.ImageColor3 = Color3.fromRGB(214, 214, 214)
cancelPromptButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
cancelPromptButton.BackgroundTransparency = 1
cancelPromptButton.Position = UDim2.fromScale(0.862, 0.263)
cancelPromptButton.Size = UDim2.fromOffset(17, 17)
cancelPromptButton.Parent = prompt

local confirmPromptButton = Instance.new("ImageButton")
confirmPromptButton.Name = "ConfirmPromptButton"
confirmPromptButton.Image = "rbxassetid://7733715400"
confirmPromptButton.ImageColor3 = Color3.fromRGB(214, 214, 214)
confirmPromptButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
confirmPromptButton.BackgroundTransparency = 1
confirmPromptButton.Position = UDim2.fromScale(0.75, 0.263)
confirmPromptButton.Size = UDim2.fromOffset(17, 17)
confirmPromptButton.Parent = prompt

cancelPromptButton.MouseButton1Click:Connect(function()
    pcall(Info.OnCancel)
    prompt:Destroy()
end)

confirmPromptButton.MouseButton1Click:Connect(function()
    pcall(Info.OnConfirm)
    prompt:Destroy()
end)
end

function insidewindow:Label(Info)
Info.Text = Info.Text or "Label"
Info.Color = Info.Color or Color3.fromRGB(214, 214, 214)

local insidelabel = {}

local label = Instance.new("Frame")
label.Name = "Label"
label.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
label.Size = UDim2.fromOffset(225, 38)
label.Parent = itemContainer

local labelUICorner = Instance.new("UICorner")
labelUICorner.Name = "LabelUICorner"
labelUICorner.CornerRadius = UDim.new(0, 4)
labelUICorner.Parent = label

local labelFixLine = Instance.new("Frame")
labelFixLine.Name = "LabelFixLine"
labelFixLine.AnchorPoint = Vector2.new(0.5, 1)
labelFixLine.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
labelFixLine.BorderSizePixel = 0
labelFixLine.Position = UDim2.fromScale(0.5, 0.0526)
labelFixLine.Size = UDim2.fromOffset(225, 4)
labelFixLine.Parent = label

local labelTextLabel = Instance.new("TextLabel")
labelTextLabel.Name = "LabelTextLabel"
labelTextLabel.Text = Info.Text
labelTextLabel.Font = Enum.Font.GothamBold
labelTextLabel.TextColor3 = Info.Color
labelTextLabel.TextSize = 13
labelTextLabel.TextXAlignment = Enum.TextXAlignment.Left
labelTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
labelTextLabel.BackgroundTransparency = 1
labelTextLabel.Position = UDim2.fromScale(0.0489, 0)
labelTextLabel.Size = UDim2.fromOffset(214, 38)
labelTextLabel.Parent = label

label.MouseEnter:Connect(function()
    labelFixLine.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    label.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
end)

label.MouseLeave:Connect(function()
    labelFixLine.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    label.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
end)

function insidelabel:Set(InsideInfo)
    InsideInfo.Text = InsideInfo.Text or labelTextLabel.Text
    InsideInfo.Color = InsideInfo.Color or labelTextLabel.TextColor3
    
    labelTextLabel.Text = InsideInfo.Text
    labelTextLabel.TextColor3 = InsideInfo.Color
end

return insidelabel
end

function insidewindow:Toggle(Info)
Info.Text = Info.Text or "Toggle"
Info.Callback = Info.Callback or function() end

local insidetoggle = {}

local Toggled = false
    
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
innerFrame.BackgroundColor3 = Color3.fromRGB(214, 214, 214)
innerFrame.Position = UDim2.fromOffset(3, 2)
innerFrame.Size = UDim2.fromOffset(13, 13)
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

function insidetoggle:Set(ToggleInfo)
ToggleInfo.Bool = ToggleInfo.Bool or false
Toggled = ToggleInfo.Bool

pcall(Info.Callback, ToggleInfo.Bool)
    TweenService:Create(innerFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),{Position = ToggleInfo.Bool and UDim2.new(0, 22,0, 2) or UDim2.new(0, 3,0, 2)}):Play()
    TweenService:Create(outerFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),{BackgroundColor3 = ToggleInfo.Bool and Color3.fromRGB(56, 207, 154) or Color3.fromRGB(62, 62, 62)}):Play()
end

toggleTextButton.MouseButton1Click:Connect(function()
    Toggled = not Toggled
    pcall(Info.Callback, Toggled)
    TweenService:Create(innerFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),{Position = Toggled and UDim2.new(0, 22,0, 2) or UDim2.new(0, 3,0, 2)}):Play()
    TweenService:Create(outerFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),{BackgroundColor3 = Toggled and Color3.fromRGB(56, 207, 154) or Color3.fromRGB(62, 62, 62)}):Play()
end)

return insidetoggle
end

function insidewindow:Dropdown(Info)
Info.Text = Info.Text or "Dropdown"
Info.List = Info.List or {}
Info.Callback = Info.Callback or function() end

local insidedropdown = {}
    
local dropdown = Instance.new("Frame")
dropdown.Name = "Dropdown"
dropdown.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
dropdown.Size = UDim2.fromOffset(225, 38)
dropdown.Parent = itemContainer

local dropdownUICorner = Instance.new("UICorner")
dropdownUICorner.Name = "DropdownUICorner"
dropdownUICorner.CornerRadius = UDim.new(0, 4)
dropdownUICorner.Parent = dropdown

local dropdownFixLine = Instance.new("Frame")
dropdownFixLine.Name = "DropdownFixLine"
dropdownFixLine.AnchorPoint = Vector2.new(0.5, 1)
dropdownFixLine.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
dropdownFixLine.BorderSizePixel = 0
dropdownFixLine.Position = UDim2.fromScale(0.5, 0.04)
dropdownFixLine.ZIndex = 2
dropdownFixLine.Size = UDim2.fromOffset(225, 4)
dropdownFixLine.Parent = dropdown

local dropdownButton = Instance.new("TextButton")
dropdownButton.Name = "DropdownButton"
dropdownButton.Font = Enum.Font.GothamBold
dropdownButton.Text = ""
dropdownButton.TextColor3 = Color3.fromRGB(214, 214, 214)
dropdownButton.TextSize = 13
dropdownButton.AutoButtonColor = false
dropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dropdownButton.BackgroundTransparency = 1
dropdownButton.Size = UDim2.fromOffset(225, 38)
dropdownButton.Parent = dropdown

local dropdownText = Instance.new("TextLabel")
dropdownText.Name = "DropdownText"
dropdownText.Font = Enum.Font.GothamBold
dropdownText.Text = Info.Text
dropdownText.TextColor3 = Color3.fromRGB(214, 214, 214)
dropdownText.TextSize = 13
dropdownText.TextXAlignment = Enum.TextXAlignment.Left
dropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dropdownText.BackgroundTransparency = 1
dropdownText.Position = UDim2.fromScale(0.0489, 0)
dropdownText.Size = UDim2.fromOffset(214, 38)
dropdownText.Parent = dropdown

local dropdownContainerButton = Instance.new("ImageLabel")
dropdownContainerButton.Name = "DropdownContainerButton"
dropdownContainerButton.Image = "rbxassetid://7733717447"
dropdownContainerButton.ImageColor3 = Color3.fromRGB(129, 129, 129)
dropdownContainerButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dropdownContainerButton.BackgroundTransparency = 1
dropdownContainerButton.Position = UDim2.fromScale(0.867, 0.263)
dropdownContainerButton.Size = UDim2.fromOffset(17, 17)
dropdownContainerButton.Parent = dropdown

local dropdownContainerBackground = Instance.new("Frame")
dropdownContainerBackground.Visible = false
dropdownContainerBackground.Name = "DropdownContainerBackground"
dropdownContainerBackground.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
dropdownContainerBackground.BorderSizePixel = 0
dropdownContainerBackground.Position = UDim2.fromScale(0, 1)
dropdownContainerBackground.Size = UDim2.fromOffset(225, 0) -- 27 addition
dropdownContainerBackground.ZIndex = -1
dropdownContainerBackground.Parent = dropdown

local dropdownFixLine1 = Instance.new("Frame")
dropdownFixLine1.Name = "DropdownFixLine"
dropdownFixLine1.AnchorPoint = Vector2.new(0.5, 0)
dropdownFixLine1.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
dropdownFixLine1.BorderSizePixel = 0
dropdownFixLine1.Position = UDim2.new(0.5, 0, 0, -2)
dropdownFixLine1.Size = UDim2.fromOffset(225, 4)
dropdownFixLine1.ZIndex = 2
dropdownFixLine1.Visible = false
dropdownFixLine1.Parent = dropdownContainerBackground

local dropdownUICorner1 = Instance.new("UICorner")
dropdownUICorner1.Name = "DropdownUICorner"
dropdownUICorner1.CornerRadius = UDim.new(0, 4)
dropdownUICorner1.Parent = dropdownContainerBackground

local dropdownContainer = Instance.new("Frame")
dropdownContainer.Visible = false
dropdownContainer.Name = "DropdownContainer"
dropdownContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dropdownContainer.BackgroundTransparency = 1
dropdownContainer.ClipsDescendants = true
dropdownContainer.Position = UDim2.fromScale(0, 0)
dropdownContainer.Size = UDim2.fromOffset(225, 0)
dropdownContainer.ZIndex = 2
dropdownContainer.Parent = dropdownContainerBackground

local dropdownUIListLayout = Instance.new("UIListLayout")
dropdownUIListLayout.Name = "DropdownUIListLayout"
dropdownUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
dropdownUIListLayout.Parent = dropdownContainer

dropdown.MouseEnter:Connect(function()
    dropdownFixLine.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    dropdown.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
end)

dropdown.MouseLeave:Connect(function()
    dropdownFixLine.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    dropdown.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
end)

local Opened = false
dropdownButton.MouseButton1Click:Connect(function()
    Opened = not Opened
    
    dropdownContainerButton.Rotation = Opened and 180 or 0
    
    dropdownContainerBackground.Visible = Opened
    dropdownFixLine1.Visible = Opened
    dropdownContainer.Visible = Opened
end)

function insidedropdown:Button(Info2)
Info2.Text = Info2.Text or "Option"

local buttonDropdown = Instance.new("Frame")
buttonDropdown.Name = "ButtonDropdown"
buttonDropdown.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
buttonDropdown.Size = UDim2.fromOffset(225, 27)
buttonDropdown.ZIndex = 3
buttonDropdown.Parent = dropdownContainer

local dropdownButtonTextButton = Instance.new("TextButton")
dropdownButtonTextButton.Name = "DropdownButtonTextButton"
dropdownButtonTextButton.Font = Enum.Font.SourceSans
dropdownButtonTextButton.Text = ""
dropdownButtonTextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
dropdownButtonTextButton.TextSize = 14
dropdownButtonTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dropdownButtonTextButton.BackgroundTransparency = 1
dropdownButtonTextButton.Size = UDim2.fromOffset(225, 27)
dropdownButtonTextButton.ZIndex = 2
dropdownButtonTextButton.Parent = buttonDropdown

local dropdownText = Instance.new("TextLabel")
dropdownText.Name = "DropdownText"
dropdownText.Font = Enum.Font.GothamBold
dropdownText.Text = Info2.Text
dropdownText.TextColor3 = Color3.fromRGB(214, 214, 214)
dropdownText.TextSize = 12
dropdownText.TextXAlignment = Enum.TextXAlignment.Left
dropdownText.Active = true
dropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dropdownText.BackgroundTransparency = 1
dropdownText.Position = UDim2.fromScale(0.0489, 0)
dropdownText.Size = UDim2.fromOffset(214, 27)
dropdownText.ZIndex = 3
dropdownText.Parent = buttonDropdown

local dropdownButtonUICorner = Instance.new("UICorner")
dropdownButtonUICorner.Name = "DropdownButtonUICorner"
dropdownButtonUICorner.CornerRadius = UDim.new(0, 4)
dropdownButtonUICorner.Parent = buttonDropdown

buttonDropdown.MouseEnter:Connect(function()
    buttonDropdown.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
end)

buttonDropdown.MouseLeave:Connect(function()
    buttonDropdown.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
end)

dropdownButtonTextButton.MouseButton1Click:Connect(function()
    pcall(Info.Callback, Info2.Text)
    
    Opened = false
    
    dropdownContainerButton.Rotation = 0
    
    dropdownContainerBackground.Visible = false
    dropdownFixLine1.Visible = false
    dropdownContainer.Visible = false
end)
end

dropdownContainer.ChildAdded:Connect(function(v)
    if v.ClassName ~= "UIListLayout" then
        dropdownContainerBackground.Size = UDim2.new(0,225,0,dropdownContainerBackground.Size.Y.Offset + 27)
        dropdownContainer.Size = UDim2.new(0,225,0,dropdownContainer.Size.Y.Offset + 27)
    end
end)

for _,item in pairs(Info.List) do
    insidedropdown:Button({
        Text = item
    })
end

return insidedropdown
end

function insidewindow:Slider(Info)
Info.Text = Info.Text or "Slider"
Info.Postfix = Info.Postfix or ""
Info.Minimum = Info.Minimum or 1
Info.Default = Info.Default or 5
Info.Maximum = Info.Maximum or 100
Info.Callback = Info.Callback or function() end
    
if Info.Minimum > Info.Maximum then
local ValueBefore = Info.Minimum
Info.Minimum, Info.Maximum = Info.Maximum, ValueBefore
end

Info.Default = math.clamp(Info.Default, Info.Minimum, Info.Maximum)
local DefaultScale = (Info.Default - Info.Minimum) / (Info.Maximum - Info.Minimum)

local insideslider = {}
    
local slider = Instance.new("Frame")
slider.Name = "Slider"
slider.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
slider.Size = UDim2.fromOffset(225, 38)
slider.Parent = itemContainer

local sliderUICorner = Instance.new("UICorner")
sliderUICorner.Name = "SliderUICorner"
sliderUICorner.CornerRadius = UDim.new(0, 4)
sliderUICorner.Parent = slider

local sliderFixLine = Instance.new("Frame")
sliderFixLine.Name = "SliderFixLine"
sliderFixLine.AnchorPoint = Vector2.new(0.5, 1)
sliderFixLine.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
sliderFixLine.BorderSizePixel = 0
sliderFixLine.Position = UDim2.fromScale(0.5, 0.0526)
sliderFixLine.Size = UDim2.fromOffset(225, 4)
sliderFixLine.Parent = slider

local sliderText = Instance.new("TextLabel")
sliderText.Name = "SliderText"
sliderText.Font = Enum.Font.GothamBold
sliderText.Text = Info.Text
sliderText.TextColor3 = Color3.fromRGB(214, 214, 214)
sliderText.TextSize = 13
sliderText.TextXAlignment = Enum.TextXAlignment.Left
sliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sliderText.BackgroundTransparency = 1
sliderText.Position = UDim2.fromScale(0.0489, 0)
sliderText.Size = UDim2.fromOffset(214, 19)
sliderText.Parent = slider

local sliderFrames = Instance.new("Frame")
sliderFrames.Name = "SliderFrames"
sliderFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sliderFrames.BackgroundTransparency = 1
sliderFrames.Position = UDim2.fromScale(0.0489, 0.5)
sliderFrames.Size = UDim2.fromOffset(199, 10)
sliderFrames.Parent = slider

local outerSlider = Instance.new("Frame")
outerSlider.Name = "OuterSlider"
outerSlider.BackgroundColor3 = Color3.fromRGB(62, 62, 62)
outerSlider.BorderSizePixel = 0
outerSlider.Position = UDim2.fromScale(-0.001, 0.458)
outerSlider.Size = UDim2.new(1, 0, 0, 4)
outerSlider.Parent = sliderFrames

local outerSliderUICorner = Instance.new("UICorner")
outerSliderUICorner.Name = "OuterSliderUICorner"
outerSliderUICorner.CornerRadius = UDim.new(0, 100)
outerSliderUICorner.Parent = outerSlider

local innerSlider = Instance.new("Frame")
innerSlider.Name = "InnerSlider"
innerSlider.BackgroundColor3 = Color3.fromRGB(56, 207, 154)
innerSlider.BorderSizePixel = 0
innerSlider.Position = UDim2.fromScale(-0.001, 0.458)
innerSlider.Size = UDim2.new(DefaultScale, 0, 0, 4)
innerSlider.ZIndex = 2
innerSlider.Parent = sliderFrames

local outerSliderUICorner1 = Instance.new("UICorner")
outerSliderUICorner1.Name = "OuterSliderUICorner"
outerSliderUICorner1.CornerRadius = UDim.new(0, 100)
outerSliderUICorner1.Parent = innerSlider

local dragSlider = Instance.new("Frame")
dragSlider.Name = "DragSlider"
dragSlider.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
dragSlider.Position = UDim2.new(DefaultScale, -4, 0, 2)
dragSlider.Size = UDim2.fromOffset(9, 9)
dragSlider.ZIndex = 2
dragSlider.Parent = sliderFrames

local dragSliderUICorner = Instance.new("UICorner")
dragSliderUICorner.Name = "DragSliderUICorner"
dragSliderUICorner.CornerRadius = UDim.new(0, 100)
dragSliderUICorner.Parent = dragSlider

local dragSliderButton = Instance.new("TextButton")
dragSliderButton.Name = "DragSliderButton"
dragSliderButton.Font = Enum.Font.SourceSans
dragSliderButton.Text = ""
dragSliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
dragSliderButton.TextSize = 14
dragSliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dragSliderButton.BackgroundTransparency = 1
dragSliderButton.Size = UDim2.fromOffset(9, 9)
dragSliderButton.Parent = dragSlider

local sliderValueText = Instance.new("TextLabel")
sliderValueText.Name = "SliderValueText"
sliderValueText.Font = Enum.Font.GothamBold
sliderValueText.Text = tostring(Info.Default)..Info.Postfix
sliderValueText.TextColor3 = Color3.fromRGB(214, 214, 214)
sliderValueText.TextSize = 13
sliderValueText.TextXAlignment = Enum.TextXAlignment.Right
sliderValueText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sliderValueText.BackgroundTransparency = 1
sliderValueText.Position = UDim2.fromScale(0.0489, 0)
sliderValueText.Size = UDim2.fromOffset(198, 19)
sliderValueText.Parent = slider

slider.MouseEnter:Connect(function()
    sliderFixLine.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    slider.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
end)

slider.MouseLeave:Connect(function()
    sliderFixLine.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    slider.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
end)

local MinSize = 0
local MaxSize = 1

local SizeFromScale = (MinSize +  (MaxSize - MinSize)) * DefaultScale
SizeFromScale = SizeFromScale - (SizeFromScale % 2)

dragSliderButton.MouseButton1Down:Connect(function() -- Skidded from material ui hehe, sorry
	local MouseMove, MouseKill
	MouseMove = Mouse.Move:Connect(function()
		local Px = library:GetXY(outerSlider)
		local SizeFromScale = (MinSize +  (MaxSize - MinSize)) * Px
		local Value = math.floor(Info.Minimum + ((Info.Maximum - Info.Minimum) * Px))
		SizeFromScale = SizeFromScale - (SizeFromScale % 2)
		TweenService:Create(innerSlider, TweenInfo.new(0.1), {Size = UDim2.new(Px,0,0,4)}):Play()
		TweenService:Create(dragSlider, TweenInfo.new(0.1), {Position = UDim2.new(Px,-4,0,2)}):Play()
		sliderValueText.Text = tostring(Value)..Info.Postfix
		pcall(Info.Callback, Value)
	end)
	MouseKill = UserInputService.InputEnded:Connect(function(UserInput)
		if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
			MouseMove:Disconnect()
			MouseKill:Disconnect()
		end
	end)
end)
end

local fixLine2 = Instance.new("Frame")
fixLine2.Name = "FixLine"
fixLine2.AnchorPoint = Vector2.new(0.5, 1)
fixLine2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fixLine2.BorderSizePixel = 0
fixLine2.Position = UDim2.fromScale(0.5, 1)
fixLine2.Size = UDim2.fromOffset(225, 2)
fixLine2.ZIndex = 2
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

local WindowOpened = true
close.MouseButton1Click:Connect(function()
    WindowOpened = not WindowOpened
    
    backgroundFrame.Visible = WindowOpened
    close.Rotation = not WindowOpened and 180 or 0
end)

return insidewindow
end
return library
