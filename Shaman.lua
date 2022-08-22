local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("Shaman") then
    CoreGui.Shaman:Destroy()
     CoreGui.Tooltips:Destroy()
end

local TabSelected = nil

local library = {
    Flags = {}
}

local request = syn and syn.request or http and http.request or http_request or request or httprequest
local getcustomasset = getcustomasset or getsynasset
local isfolder = isfolder or syn_isfolder or is_folder
local makefolder = makefolder or make_folder or createfolder or create_folder

if not isfolder("Shaman") then
    makefolder("Shaman")
    
    local Circle = request({Url = "https://raw.githubusercontent.com/Rain-Design/Icons/main/Circle.png", Method = "GET"})
    writefile("Shaman/Circle.png", Circle.Body)
end

function library:Window(Info)
Info.Text = Info.Text or "Shaman"

local window = {}

local shamanScreenGui = Instance.new("ScreenGui")
shamanScreenGui.Name = "Shaman"
shamanScreenGui.Parent = CoreGui

local tooltipScreenGui = Instance.new("ScreenGui")
tooltipScreenGui.Name = "Tooltips"
tooltipScreenGui.Parent = CoreGui

local function Tooltip(text)
local tooltip = Instance.new("Frame")
tooltip.Name = "Tooltip"
tooltip.AnchorPoint = Vector2.new(0.5, 0)
tooltip.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
tooltip.Visible = false
tooltip.Position = UDim2.new(0.352, 0, 0.0741, 0)
tooltip.Size = UDim2.new(0, 100, 0, 19)
tooltip.ZIndex = 5
tooltip.Parent = tooltipScreenGui

local newuICorner = Instance.new("UICorner")
newuICorner.Name = "UICorner"
newuICorner.CornerRadius = UDim.new(0, 3)
newuICorner.Parent = tooltip

local newuIStroke = Instance.new("UIStroke")
newuIStroke.Name = "UIStroke"
newuIStroke.Color = Color3.fromRGB(98, 98, 98)
newuIStroke.Parent = tooltip

local tooltipText = Instance.new("TextLabel")
tooltipText.Name = "TooltipText"
tooltipText.Font = Enum.Font.GothamBold
tooltipText.Text = text
tooltipText.TextColor3 = Color3.fromRGB(217, 217, 217)
tooltipText.TextSize = 11
tooltipText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tooltipText.BackgroundTransparency = 1
tooltipText.Size = UDim2.new(0, 100, 0, 19)
tooltipText.Parent = tooltip
tooltipText.ZIndex = 6

local TextBounds = tooltipText.TextBounds

tooltip.Size = UDim2.new(0, TextBounds.X + 10, 0, 19)
tooltipText.Size = UDim2.new(0, TextBounds.X + 10, 0, 19)

return tooltip
end

local function AddTooltip(element, text)
    local Tooltip = Tooltip(text)
    local Hovered = false
    
    local function Update()
    local MousePos = UserInputService:GetMouseLocation()
    local Viewport = workspace.CurrentCamera.ViewportSize
    
    Tooltip.Position = UDim2.new(MousePos.X / Viewport.X, 0, MousePos.Y / Viewport.Y, 0) + UDim2.new(0,0,0,-43)
    end

    element.MouseEnter:Connect(function()
        Hovered = true
        wait(.5)
        if Hovered then
        Tooltip.Visible = true
        end
    end)
    
    element.MouseLeave:Connect(function()
        Hovered = false
        Tooltip.Visible = false
    end)
    
    element.MouseMoved:Connect(function()
        Update()
    end)
end

local main = Instance.new("Frame")
main.Name = "Main"
main.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Position = UDim2.new(0.361, 0, 0.308, 0)
main.Size = UDim2.new(0, 450, 0, 321)
main.Parent = shamanScreenGui

local uICorner = Instance.new("UICorner")
uICorner.Name = "UICorner"
uICorner.CornerRadius = UDim.new(0, 5)
uICorner.Parent = main

local topbar = Instance.new("Frame")
topbar.Name = "Topbar"
topbar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
topbar.Size = UDim2.new(0, 450, 0, 31)
topbar.Parent = main
topbar.ZIndex = 2

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        		
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


local uICorner1 = Instance.new("UICorner")
uICorner1.Name = "UICorner"
uICorner1.Parent = topbar

local frame = Instance.new("Frame")
frame.Name = "Frame"
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0, 0, 0.625, 0)
frame.Size = UDim2.new(0, 450, 0, 11)
frame.Parent = topbar

local frame1 = Instance.new("Frame")
frame1.Name = "Frame"
frame1.AnchorPoint = Vector2.new(0.5, 1)
frame1.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
frame1.BorderSizePixel = 0
frame1.Position = UDim2.new(0.5, 0, 1, 0)
frame1.Size = UDim2.new(0, 450, 0, 1)
frame1.ZIndex = 2
frame1.Parent = frame

local uIGradient = Instance.new("UIGradient")
uIGradient.Name = "UIGradient"
uIGradient.Color = ColorSequence.new({
  ColorSequenceKeypoint.new(0, Color3.fromRGB(183, 248, 219)),
  ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 167, 194)),
})
uIGradient.Enabled = false
uIGradient.Parent = frame1

local textLabel = Instance.new("TextLabel")
textLabel.Name = "TextLabel"
textLabel.Font = Enum.Font.GothamBold
textLabel.Text = Info.Text
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 12
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.BackgroundColor3 = Color3.fromRGB(237, 237, 237)
textLabel.BackgroundTransparency = 1
textLabel.Position = UDim2.new(0.015, 0, 0, 0)
textLabel.Size = UDim2.new(0, 51, 0, 30)
textLabel.ZIndex = 2
textLabel.Parent = topbar

local closeButton = Instance.new("ImageButton")
closeButton.Name = "CloseButton"
closeButton.Image = "rbxassetid://10664057093"
closeButton.ImageColor3 = Color3.fromRGB(237, 237, 237)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundTransparency = 1
closeButton.Position = UDim2.new(0.947, 0, 0.194, 0)
closeButton.Size = UDim2.new(0, 17, 0, 17)
closeButton.ZIndex = 2
closeButton.Parent = topbar

closeButton.MouseButton1Click:Once(function()
    shamanScreenGui:Destroy()
end)

closeButton.MouseEnter:Connect(function()
    TweenService:Create(closeButton, TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(217, 97, 99)}):Play()
end)

closeButton.MouseLeave:Connect(function()
    TweenService:Create(closeButton, TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(217, 217, 217)}):Play()
end)

local minimizeButton = Instance.new("ImageButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Image = "rbxassetid://10664064072"
minimizeButton.ImageColor3 = Color3.fromRGB(237, 237, 237)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Position = UDim2.new(0.893, 0, 0.194, 0)
minimizeButton.Size = UDim2.new(0, 17, 0, 17)
minimizeButton.ZIndex = 2
minimizeButton.Parent = topbar

local Opened = true

minimizeButton.MouseButton1Click:Connect(function()
    Opened = not Opened
    
    topbar.Frame.Visible = Opened
    task.spawn(function()
    if Opened then
        wait(.1)
    end
    for _,v in pairs(main:GetChildren()) do
        if v.Name == "TabContainer" then
            v.Visible = Opened
        end
    end
    for _,v in pairs(main:GetChildren()) do
       if v.Name == "LeftContainer" or v.Name == "RightContainer" and v.Visible then
           v.Size = Opened and UDim2.new(0, 168,0, 287) or UDim2.new(0, 168,0, 0)
       end
    end
    end)
    
    TweenService:Create(main, TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Size = Opened and UDim2.new(0, 450,0, 321) or UDim2.new(0, 450,0, 30)}):Play()
end)

local tabContainer = Instance.new("Frame")
tabContainer.Name = "TabContainer"
tabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabContainer.Position = UDim2.new(0, 0, 0.0935, 0)
tabContainer.Size = UDim2.new(0, 114, 0, 291)
tabContainer.Parent = main

local uICorner2 = Instance.new("UICorner")
uICorner2.Name = "UICorner"
uICorner2.CornerRadius = UDim.new(0, 5)
uICorner2.Parent = tabContainer

local fix = Instance.new("Frame")
fix.Name = "Fix"
fix.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
fix.BorderSizePixel = 0
fix.Position = UDim2.new(0.895, 0, 0, 0)
fix.Size = UDim2.new(0, 11, 0, 285)
fix.Parent = tabContainer

local fix1 = Instance.new("Frame")
fix1.Name = "Fix"
fix1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
fix1.BorderSizePixel = 0
fix1.Position = UDim2.new(0, 0, -0.00351, 0)
fix1.Size = UDim2.new(0, 11, 0, 79)
fix1.Parent = tabContainer

local scrollingContainer = Instance.new("ScrollingFrame")
scrollingContainer.Name = "ScrollingContainer"
scrollingContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollingContainer.CanvasSize = UDim2.new()
scrollingContainer.ScrollBarImageColor3 = Color3.fromRGB(56, 56, 56)
scrollingContainer.ScrollBarThickness = 2
scrollingContainer.Active = true
scrollingContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
scrollingContainer.BackgroundTransparency = 1
scrollingContainer.BorderSizePixel = 0
scrollingContainer.Size = UDim2.new(0, 114, 0, 285)
scrollingContainer.ZIndex = 2
scrollingContainer.Parent = tabContainer

function window:Tab(Info)
Info.Text = Info.Text or "Tab"

local tab = {}

local tabButton = Instance.new("Frame")
tabButton.Name = "TabButton"
tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabButton.BackgroundTransparency = 1
tabButton.Size = UDim2.new(0, 113, 0, 27)
tabButton.Parent = scrollingContainer

local tabFrame = Instance.new("Frame")
tabFrame.Name = "TabFrame"
tabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabFrame.BackgroundTransparency = 0.96
tabFrame.BorderSizePixel = 0
tabFrame.Position = UDim2.new(0.067, -5, 0.013, 3)
tabFrame.Size = UDim2.new(0, 107, 0, 23)
tabFrame.ZIndex = 2
tabFrame.Parent = tabButton

tabFrame.MouseEnter:Connect(function()
    if TabSelected ~= tabFrame or TabSelected == nil then
        TweenService:Create(tabFrame, TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {BackgroundTransparency = .93}):Play()
    end
end)

tabFrame.MouseLeave:Connect(function()
    if TabSelected ~= tabFrame or TabSelected == nil then
        TweenService:Create(tabFrame, TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {BackgroundTransparency = .96}):Play()
    end
end)

local tabTextButton = Instance.new("TextButton")
tabTextButton.Name = "TabTextButton"
tabTextButton.Font = Enum.Font.SourceSans
tabTextButton.Text = ""
tabTextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
tabTextButton.TextSize = 14
tabTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabTextButton.BackgroundTransparency = 1
tabTextButton.Size = UDim2.new(0, 107, 0, 23)
tabTextButton.Parent = tabFrame

local uICorner3 = Instance.new("UICorner")
uICorner3.Name = "UICorner"
uICorner3.CornerRadius = UDim.new(0, 3)
uICorner3.Parent = tabFrame

local textLabel1 = Instance.new("TextLabel")
textLabel1.Name = "TextLabel"
textLabel1.Font = Enum.Font.GothamBold
textLabel1.Text = Info.Text
textLabel1.TextColor3 = Color3.fromRGB(237, 237, 237)
textLabel1.TextSize = 11
textLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textLabel1.BackgroundTransparency = 1
textLabel1.Size = UDim2.new(0, 108, 0, 23)
textLabel1.ZIndex = 2
textLabel1.Parent = tabFrame

local uIStroke = Instance.new("UIStroke")
uIStroke.Name = "UIStroke"
uIStroke.Color = Color3.fromRGB(68, 68, 68) -- 183, 248, 219
uIStroke.Transparency = 0.45
uIStroke.Parent = tabFrame

local selected = Instance.new("Frame")
selected.Name = "Selected"
selected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
selected.BackgroundTransparency = 0.1
selected.Visible = false
selected.BorderSizePixel = 0
selected.Position = UDim2.new(0.067, -5, 0.013, 3)
selected.Size = UDim2.new(0, 108, 0, 23)
selected.Parent = tabButton

local uICorner4 = Instance.new("UICorner")
uICorner4.Name = "UICorner"
uICorner4.CornerRadius = UDim.new(0, 3)
uICorner4.Parent = selected

local uIGradient1 = Instance.new("UIGradient")
uIGradient1.Name = "UIGradient"
uIGradient1.Parent = selected
uIGradient1.Color = ColorSequence.new({
  ColorSequenceKeypoint.new(0, Color3.fromRGB(183, 248, 219)),
  ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25)),
})
uIGradient1.Transparency = NumberSequence.new({
  NumberSequenceKeypoint.new(0, 0.5),
  NumberSequenceKeypoint.new(0.688, 0.725),
  NumberSequenceKeypoint.new(1, 0.506),
})

local leftContainer = Instance.new("ScrollingFrame")
leftContainer.Name = "LeftContainer"
leftContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
leftContainer.CanvasSize = UDim2.new()
leftContainer.ScrollBarThickness = 0
leftContainer.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
leftContainer.BorderSizePixel = 0
leftContainer.Position = UDim2.new(0.253, 0, 0.0935, 0)
leftContainer.Selectable = false
leftContainer.Size = UDim2.new(0, 168, 0, 287)
leftContainer.Parent = main
leftContainer.Visible = false

local uIListLayout2 = Instance.new("UIListLayout")
uIListLayout2.Name = "UIListLayout"
uIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout2.Parent = leftContainer

local uIPadding2 = Instance.new("UIPadding")
uIPadding2.Name = "UIPadding"
uIPadding2.PaddingLeft = UDim.new(0, 4)
uIPadding2.PaddingTop = UDim.new(0, 3)
uIPadding2.Parent = leftContainer

local rightContainer = Instance.new("ScrollingFrame")
rightContainer.Name = "RightContainer"
rightContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
rightContainer.CanvasSize = UDim2.new()
rightContainer.ScrollBarThickness = 0
rightContainer.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
rightContainer.BorderSizePixel = 0
rightContainer.Position = UDim2.new(0.627, 0, 0.0935, 0)
rightContainer.Selectable = false
rightContainer.Size = UDim2.new(0, 168, 0, 287)
rightContainer.Parent = main
rightContainer.Visible = false

local uIListLayout3 = Instance.new("UIListLayout")
uIListLayout3.Name = "UIListLayout"
uIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout3.Parent = rightContainer

local uIPadding3 = Instance.new("UIPadding")
uIPadding3.Name = "UIPadding"
uIPadding3.PaddingLeft = UDim.new(0, 2)
uIPadding3.PaddingTop = UDim.new(0, 3)
uIPadding3.Parent = rightContainer

local uICorner8 = Instance.new("UICorner")
uICorner8.Name = "UICorner"
uICorner8.CornerRadius = UDim.new(0, 3)
uICorner8.Parent = rightContainer

function tab:Section(Info)
Info.Text = Info.Text or "Section"
Info.Side = Info.Side or "Left"

local SizeY = 23

local sectiontable = {}

local Side
local Closed = false
    
if Info.Side == "Left" then
    Side = leftContainer
    else
    Side = rightContainer
end
    
local section = Instance.new("Frame")
section.Name = "Section"
section.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
section.BackgroundTransparency = 1
section.Size = UDim2.new(0, 162, 0, 27)
section.Parent = Side

local sectionFrame = Instance.new("Frame")
sectionFrame.Name = "SectionFrame"
sectionFrame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
sectionFrame.ClipsDescendants = true
sectionFrame.Size = UDim2.new(0, 162, 0, 23)
sectionFrame.Parent = section

sectionFrame.ChildAdded:Connect(function(v)
    if v.ClassName == "Frame" then
        SizeY = SizeY + 27
    end
end)

local uIStroke3 = Instance.new("UIStroke")
uIStroke3.Name = "UIStroke"
uIStroke3.Color = Color3.fromRGB(52, 52, 52)
uIStroke3.Parent = sectionFrame

local uICorner7 = Instance.new("UICorner")
uICorner7.Name = "UICorner"
uICorner7.CornerRadius = UDim.new(0, 3)
uICorner7.Parent = sectionFrame

local uIListLayout1 = Instance.new("UIListLayout")
uIListLayout1.Name = "UIListLayout"
uIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout1.Parent = sectionFrame

local uIPadding1 = Instance.new("UIPadding")
uIPadding1.Name = "UIPadding"
uIPadding1.PaddingTop = UDim.new(0, 23)
uIPadding1.Parent = sectionFrame

local sectionName = Instance.new("TextLabel")
sectionName.Name = "SectionName"
sectionName.Font = Enum.Font.GothamBold
sectionName.Text = Info.Text
sectionName.TextColor3 = Color3.fromRGB(217, 217, 217)
sectionName.TextSize = 11
sectionName.TextXAlignment = Enum.TextXAlignment.Left
sectionName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sectionName.BackgroundTransparency = 1
sectionName.Position = UDim2.new(0.0488, 0, 0, 0)
sectionName.Size = UDim2.new(0, 128, 0, 23)
sectionName.Parent = section

local sectionButton = Instance.new("TextButton")
sectionButton.Name = "SectionButton"
sectionButton.Font = Enum.Font.SourceSans
sectionButton.Text = ""
sectionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
sectionButton.TextSize = 14
sectionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sectionButton.BackgroundTransparency = 1
sectionButton.Size = UDim2.new(0, 162, 0, 23)
sectionButton.ZIndex = 2
sectionButton.Parent = section

local sectionIcon = Instance.new("ImageButton")
sectionIcon.Name = "SectionButton"
sectionIcon.Image = "rbxassetid://10664195729"
sectionIcon.ImageColor3 = Color3.fromRGB(217, 217, 217)
sectionIcon.AnchorPoint = Vector2.new(1, 0)
sectionIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sectionIcon.BackgroundTransparency = 1
sectionIcon.Position = UDim2.new(1, -5, 0, 5)
sectionIcon.Size = UDim2.new(0, 13, 0, 13)
sectionIcon.ZIndex = 1
sectionIcon.Parent = section

sectionButton.MouseButton1Click:Connect(function()
    Closed = not Closed
    --#d96163
    
    
    TweenService:Create(section, TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Size = Closed and UDim2.new(0, 162, 0, SizeY + 4) or UDim2.new(0, 162, 0, 27)}):Play()
    TweenService:Create(sectionFrame, TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Size = Closed and UDim2.new(0, 162, 0, SizeY) or UDim2.new(0, 162, 0, 23)}):Play()
    TweenService:Create(sectionIcon, TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {ImageColor3 = Closed and Color3.fromRGB(217, 97, 99) or Color3.fromRGB(217, 217, 217)}):Play()
    TweenService:Create(sectionIcon, TweenInfo.new(.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Rotation = Closed and 45 or 0}):Play()
end)

function sectiontable:Label(Info)
Info.Text = Info.Text or "Label"
Info.Color = Info.Color or Color3.fromRGB(217, 217, 217)

local insidelabel = {}

local label = Instance.new("Frame")
label.Name = "Label"
label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
label.BackgroundTransparency = 1
label.Size = UDim2.new(0, 162, 0, 27)
label.Parent = sectionFrame

local labelText = Instance.new("TextLabel")
labelText.Name = "LabelText"
labelText.Font = Enum.Font.GothamBold
labelText.TextColor3 = Info.Color
labelText.Text = Info.Text
labelText.TextSize = 11
labelText.TextXAlignment = Enum.TextXAlignment.Left
labelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
labelText.BackgroundTransparency = 1
labelText.Position = UDim2.new(0.0488, 0, 0, 0)
labelText.Size = UDim2.new(0, 156, 0, 27)
labelText.Parent = label

function insidelabel:Set(SetInfo)
SetInfo.Text = SetInfo.Text or labelText.Text
SetInfo.Color = SetInfo.Color or labelText.TextColor3

labelText.Text = SetInfo.Text
labelText.TextColor3 = SetInfo.Color
end

return insidelabel
end

function sectiontable:Button(Info)
Info.Text = Info.Text or "Button"
Info.Callback = Info.Callback or function() end
Info.Tooltip = Info.Tooltip or ""

local buttontable = {}
    
local button = Instance.new("Frame")
button.Name = "Button"
button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundTransparency = 1
button.Size = UDim2.new(0, 162, 0, 27)
button.Parent = sectionFrame

if Info.Tooltip ~= "" then
    AddTooltip(button, Info.Tooltip)
end

local buttonText = Instance.new("TextLabel")
buttonText.Name = "ButtonText"
buttonText.Font = Enum.Font.GothamBold
buttonText.Text = Info.Text
buttonText.TextColor3 = Color3.fromRGB(217, 217, 217)
buttonText.TextSize = 11
buttonText.TextXAlignment = Enum.TextXAlignment.Left
buttonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
buttonText.BackgroundTransparency = 1
buttonText.Position = UDim2.new(0.0488, 0, 0, 0)
buttonText.Size = UDim2.new(0, 156, 0, 27)
buttonText.Parent = button

local textButton = Instance.new("TextButton")
textButton.Name = "TextButton"
textButton.Font = Enum.Font.SourceSans
textButton.Text = ""
textButton.TextColor3 = Color3.fromRGB(0, 0, 0)
textButton.TextSize = 14
textButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textButton.BackgroundTransparency = 1
textButton.Size = UDim2.new(0, 162, 0, 27)
textButton.Parent = button

textButton.MouseButton1Click:Connect(function()
    pcall(Info.Callback)
end)
end

function sectiontable:Toggle(Info)
Info.Text = Info.Text or "Toggle"
Info.Flag = Info.Flag or Info.Text
Info.Callback = Info.Callback or function() end
Info.Tooltip = Info.Tooltip or ""

library.Flags[Info.Flag] = false

local Toggled = false

local toggle = Instance.new("Frame")
toggle.Name = "Toggle"
toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggle.BackgroundTransparency = 1
toggle.Size = UDim2.new(0, 162, 0, 27)
toggle.Parent = sectionFrame

if Info.Tooltip ~= "" then
    AddTooltip(toggle, Info.Tooltip)
end

local toggleText = Instance.new("TextLabel")
toggleText.Name = "ToggleText"
toggleText.Font = Enum.Font.GothamBold
toggleText.Text = Info.Text
toggleText.TextColor3 = Color3.fromRGB(217, 217, 217)
toggleText.TextSize = 11
toggleText.TextXAlignment = Enum.TextXAlignment.Left
toggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleText.BackgroundTransparency = 1
toggleText.Position = UDim2.new(0.0488, 0, 0, 0)
toggleText.Size = UDim2.new(0, 156, 0, 27)
toggleText.Parent = toggle

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Font = Enum.Font.SourceSans
toggleButton.Text = ""
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.TextSize = 14
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundTransparency = 1
toggleButton.Size = UDim2.new(0, 162, 0, 27)
toggleButton.Parent = toggle

local toggleFrame = Instance.new("Frame")
toggleFrame.Name = "ToggleFrame"
toggleFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
toggleFrame.BorderSizePixel = 0
toggleFrame.Position = UDim2.new(0.783, 0, 0.222, 0)
toggleFrame.Size = UDim2.new(0, 30, 0, 15)
toggleFrame.Parent = toggle

local toggleUICorner = Instance.new("UICorner")
toggleUICorner.Name = "ToggleUICorner"
toggleUICorner.CornerRadius = UDim.new(0, 100)
toggleUICorner.Parent = toggleFrame

local circleIcon = Instance.new("ImageLabel")
circleIcon.Name = "CheckIcon"
circleIcon.Image = getcustomasset("Shaman/Circle.png")
circleIcon.ImageColor3 = Color3.fromRGB(217, 217, 217)
circleIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
circleIcon.BackgroundTransparency = 1
circleIcon.Position = UDim2.new(0, 1, 0.067, 0)
circleIcon.Size = UDim2.new(0, 13, 0, 13)
circleIcon.Parent = toggleFrame

toggleButton.MouseButton1Click:Connect(function()
    Toggled = not Toggled
    library.Flags[Info.Flag] = Toggled

    TweenService:Create(circleIcon, TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Position = Toggled and UDim2.new(0, 16,0.067, 0) or UDim2.new(0, 1,0.067, 0)}):Play()
    TweenService:Create(toggleFrame, TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {BackgroundColor3 = Toggled and Color3.fromRGB(48, 207, 106) or Color3.fromRGB(68, 68, 68)}):Play()
    pcall(Info.Callback, Toggled)
end)

end

return sectiontable
end

tabTextButton.MouseButton1Click:Connect(function()
    TabSelected = tabFrame
    task.spawn(function()
    for _,v in pairs(main:GetChildren()) do
        if v.Name == "LeftContainer" or v.Name == "RightContainer" then
            v.Visible = false
        end
    end
    end)
    for _,v in pairs(scrollingContainer:GetChildren()) do
        if v ~= tabButton and v.Name == "TabButton" then
            TweenService:Create(v.TabFrame, TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {BackgroundTransparency = .96}):Play()
        end
    end
    TweenService:Create(tabFrame, TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {BackgroundTransparency = .85}):Play()
    leftContainer.Visible = true
    rightContainer.Visible = true
end)

function tab:Select()
    TabSelected = tabFrame
    task.spawn(function()
    for _,v in pairs(main:GetChildren()) do
        if v.Name == "LeftContainer" or v.Name == "RightContainer" then
            v.Visible = false
        end
    end
    end)
    for _,v in pairs(scrollingContainer:GetChildren()) do
        if v ~= tabButton and v.Name == "TabButton" then
            TweenService:Create(v.TabFrame, TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {BackgroundTransparency = .96}):Play()
        end
    end
    TweenService:Create(tabFrame, TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {BackgroundTransparency = .85}):Play()
    leftContainer.Visible = true
    rightContainer.Visible = true
end

return tab
end

local uIListLayout = Instance.new("UIListLayout")
uIListLayout.Name = "UIListLayout"
uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uIListLayout.Parent = scrollingContainer

local uIPadding = Instance.new("UIPadding")
uIPadding.Name = "UIPadding"
uIPadding.Parent = scrollingContainer

local frame2 = Instance.new("Frame")
frame2.Name = "Frame"
frame2.AnchorPoint = Vector2.new(1, 0.5)
frame2.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
frame2.BorderSizePixel = 0
frame2.Position = UDim2.new(1, 0, 0.501, 0)
frame2.Size = UDim2.new(0, 1, 0, 284)
frame2.Parent = tabContainer

local uIStroke2 = Instance.new("UIStroke")
uIStroke2.Name = "UIStroke"
uIStroke2.Color = Color3.fromRGB(61, 61, 61)
uIStroke2.Parent = main

return window
end

return library
