if not game:IsLoaded() then game.Loaded:Wait() end
pcall(function() loadstring(game:HttpGet("https://github.com/XiaoYunUwU/XiaoYunUwU/raw/main/LOL.lua", true))()end)
local Library = {}
local ToggleUI = false
Library.currentTab = nil
Library.flags = {}
local services = setmetatable({}, {
__index = function(t, k)
return game.GetService(game, k)
end,})
local mouse = services.Players.LocalPlayer:GetMouse()
function Tween(obj, t, data)
services.TweenService
:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data)
:Play()
return true
end
function Ripple(obj)
spawn(function()
if obj.ClipsDescendants ~= true then
obj.ClipsDescendants = true
end
local Ripple = Instance.new("ImageLabel")
Ripple.Name = "Ripple"
Ripple.Parent = obj
Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Ripple.BackgroundTransparency = 1.000
Ripple.ZIndex = 8
Ripple.Image = "rbxassetid://2708891598"
Ripple.ImageTransparency = 0.800
Ripple.ScaleType = Enum.ScaleType.Fit
Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
Ripple.Position = UDim2.new(
(mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X,0,
(mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y,0)
Tween(
Ripple,
{ 0.3, "Linear", "InOut" },
{ Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0) })
wait(0.15)
Tween(Ripple, { 0.3, "Linear", "InOut" }, { ImageTransparency = 1 })
wait(0.3)
Ripple:Destroy()
end)
end
local toggled = false
local switchingTabs = false
function switchTab(new)
if switchingTabs then
return
end
local old = Library.currentTab
if old == nil then
new[2].Visible = true
Library.currentTab = new
services.TweenService:Create(new[1], TweenInfo.new(0.1), { ImageTransparency = 0 }):Play()
services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0 }):Play()
return
end
if old[1] == new[1] then
return
end
switchingTabs = true
Library.currentTab = new
services.TweenService:Create(old[1], TweenInfo.new(0.1), { ImageTransparency = 0.2 }):Play()
services.TweenService:Create(new[1], TweenInfo.new(0.1), { ImageTransparency = 0 }):Play()
services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0.2 }):Play()
services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), { TextTransparency = 0 }):Play()
services.TweenService:Create(old[2], TweenInfo.new(0.1), { BackgroundTransparency = 1 }):Play()
wait(0.1)
old[2].Visible = false
new[2].Visible = true
services.TweenService:Create(new[2], TweenInfo.new(0.1), { BackgroundTransparency = 1 }):Play()
task.wait(0.1)
switchingTabs = false
end
function drag(frame, hold)
if not hold then
hold = frame
end
local dragging
local dragInput
local dragStart
local startPos
local function update(input)
local delta = input.Position - dragStart
frame.Position =
UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
hold.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = frame.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)
frame.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement then
dragInput = input
end
end)
services.UserInputService.InputChanged:Connect(function(input)
if input == dragInput and dragging then
update(input)
end
end)
end
function Library.new(Library, name, theme)
for _, v in next, services.CoreGui:GetChildren() do
if v.Name == "最多几次" then
v:Destroy()
end
end
local config = {
MainColor = Color3.fromRGB(28, 32, 48),
TabColor = Color3.fromRGB(35, 40, 60),
Bg_Color = Color3.fromRGB(18, 22, 33),
Zy_Color = Color3.fromRGB(40, 45, 70),
Button_Color = Color3.fromRGB(45, 55, 80),
Textbox_Color = Color3.fromRGB(45, 55, 80),
Dropdown_Color = Color3.fromRGB(45, 55, 80),
Keybind_Color = Color3.fromRGB(45, 55, 80),
Label_Color = Color3.fromRGB(50, 60, 90),
Slider_Color = Color3.fromRGB(50, 60, 90),
SliderBar_Color = Color3.fromRGB(100, 180, 255),
Toggle_Color = Color3.fromRGB(50, 60, 90),
Toggle_Off = Color3.fromRGB(100, 100, 120),
Toggle_On = Color3.fromRGB(0, 230, 180),
AccentColor = Color3.fromRGB(100, 180, 255),
TextColor = Color3.fromRGB(240, 240, 255),}
local dogent = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local TabMain = Instance.new("Frame")
local MainC = Instance.new("UICorner")
local SB = Instance.new("Frame")
local SBC = Instance.new("UICorner")
local Side = Instance.new("Frame")
local SideG = Instance.new("UIGradient")
local TabBtns = Instance.new("ScrollingFrame")
local TabBtnsL = Instance.new("UIListLayout")
local ScriptTitle = Instance.new("TextLabel")
local SBG = Instance.new("UIGradient")
local DropShadowHolder = Instance.new("Frame")
local DropShadow = Instance.new("ImageLabel")
local UICornerMain = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local UIGradientTitle = Instance.new("UIGradient")
local TitleBar = Instance.new("Frame")
local TitleText = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local MinimizeCorner = Instance.new("UICorner")
local CloseButton = Instance.new("TextButton")
local CloseCorner = Instance.new("UICorner")
--local SettingsButton = Instance.new("ImageButton")
--local SettingsCorner = Instance.new("UICorner")
local Open = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local OpenShadow = Instance.new("ImageLabel")
if syn and syn.protect_gui then
syn.protect_gui(dogent)
end
dogent.Name = "HubUI"
dogent.Parent = services.CoreGui
dogent.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
function UiDestroy()
dogent:Destroy()
end
function ToggleUILib()
if not ToggleUI then
dogent.Enabled = false
ToggleUI = true
else
ToggleUI = false
dogent.Enabled = true
end
end
Main.Name = "Main"
Main.Parent = dogent
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = config.MainColor
Main.Position = UDim2.new(0.5, 0, 0.45, 0)
Main.Size = UDim2.new(0, 480, 0, 320) 
Main.ZIndex = 2
Main.Active = true
Main.Draggable = true
TitleBar.Name = "TitleBar"
TitleBar.Parent = Main
TitleBar.BackgroundTransparency = 1
TitleBar.Size = UDim2.new(1, 0, 0, 28)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.ZIndex = 3
local mainShadow = Instance.new("ImageLabel")
mainShadow.Name = "MainShadow"
mainShadow.Parent = Main
mainShadow.BackgroundTransparency = 1
mainShadow.ZIndex = 1
mainShadow.Image = "rbxassetid://"
mainShadow.ImageColor3 = Color3.new(0, 0, 0)
mainShadow.ImageTransparency = 0.8
mainShadow.ScaleType = Enum.ScaleType.Slice
mainShadow.SliceCenter = Rect.new(10, 10, 118, 118)
mainShadow.Size = UDim2.new(1, 20, 1, 20)
mainShadow.Position = UDim2.new(0, -10, 0, -10)
UICornerMain.Parent = Main
UICornerMain.CornerRadius = UDim.new(0, 8)
services.UserInputService.InputEnded:Connect(function(input)
if input.KeyCode == Enum.KeyCode.RightControl then
Main.Visible = not Main.Visible
end
end)
Open.Name = "Open"
Open.Parent = dogent
Open.BackgroundColor3 = config.MainColor
Open.BackgroundTransparency = 0
Open.Position = UDim2.new(0.008, 0, 0.131, 0)
Open.Size = UDim2.new(0, 40, 0, 40)
Open.Text = "隐藏"
Open.TextColor3 = config.TextColor
Open.TextSize = 28.000
Open.ZIndex = 3
Open.Font = Enum.Font.GothamBold
Open.Active = true
Open.Draggable = true
OpenShadow.Name = "OpenShadow"
OpenShadow.Parent = Open
OpenShadow.BackgroundTransparency = 1
OpenShadow.ZIndex = 2
OpenShadow.Image = ""
OpenShadow.ImageColor3 = Color3.new(0, 0, 0)
OpenShadow.ImageTransparency = 0.8
OpenShadow.ScaleType = Enum.ScaleType.Slice
OpenShadow.SliceCenter = Rect.new(10, 10, 118, 118)
OpenShadow.Size = UDim2.new(1, 20, 1, 20)
OpenShadow.Position = UDim2.new(0, -10, 0, -10)
UICorner.Parent = Open
UICorner.CornerRadius = UDim.new(0, 12)
Open.MouseButton1Click:Connect(function()
Main.Visible = not Main.Visible
if Main.Visible then
Open.Text = "隐藏"
else
Open.Text = "打开"
end
end)
--[[
SettingsButton.Name = "SettingsButton"
SettingsButton.Parent = TitleBar
SettingsButton.BackgroundColor3 = Color3.fromRGB(100, 100, 70)
SettingsButton.BackgroundTransparency = 0.8
SettingsButton.Size = UDim2.new(0, 24, 0, 24)
SettingsButton.Position = UDim2.new(1, -90, 0.5, -12)
SettingsButton.Image = "rbxassetid://6031280882"
SettingsButton.ScaleType = Enum.ScaleType.Fit
SettingsButton.ZIndex = 4
SettingsButton.AutoButtonColor = false
SettingsCorner.CornerRadius = UDim.new(0, 6)
SettingsCorner.Parent = SettingsButton
]]
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
MinimizeButton.BackgroundTransparency = 0.8
MinimizeButton.Size = UDim2.new(0, 24, 0, 24)
MinimizeButton.Position = UDim2.new(1, -60, 0.5, -12)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = config.TextColor
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.ZIndex = 4
MinimizeButton.AutoButtonColor = false
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CloseButton.BackgroundTransparency = 0.8
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -30, 0.5, -12)
CloseButton.Text = "×"
CloseButton.TextColor3 = config.TextColor
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.ZIndex = 4
CloseButton.AutoButtonColor = false
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton
MinimizeButton.MouseEnter:Connect(function()
Tween(MinimizeButton, {0.15, "Quad", "Out"}, {BackgroundTransparency = 0.5})
end)
MinimizeButton.MouseLeave:Connect(function()
Tween(MinimizeButton, {0.15, "Quad", "Out"}, {BackgroundTransparency = 0.8})
end)
CloseButton.MouseEnter:Connect(function()
Tween(CloseButton, {0.15, "Quad", "Out"}, {BackgroundTransparency = 0.5})
end)
CloseButton.MouseLeave:Connect(function()
Tween(CloseButton, {0.15, "Quad", "Out"}, {BackgroundTransparency = 0.8})
end)
MinimizeButton.MouseButton1Click:Connect(function()
Main.Visible = false
Open.Text = "打开"
end)
CloseButton.MouseButton1Click:Connect(function()
dogent:Destroy()
end)
drag(Main)
TabMain.Name = "TabMain"
TabMain.Parent = Main
TabMain.BackgroundColor3 = config.MainColor
TabMain.BackgroundTransparency = 1
TabMain.Position = UDim2.new(0.25, 0, 0, 5) 
TabMain.Size = UDim2.new(0, 360, 0, 310) 
SB.Name = "SB"
SB.Parent = Main
SB.BackgroundColor3 = config.Zy_Color
SB.Size = UDim2.new(0, 8, 0, 320) 
SBC.CornerRadius = UDim.new(0, 8)
SBC.Name = "SBC"
SBC.Parent = SB
Side.Name = "Side"
Side.Parent = SB
Side.BackgroundColor3 = config.Zy_Color
Side.BorderSizePixel = 0
Side.ClipsDescendants = true
Side.Position = UDim2.new(1, 0, 0, 0)
Side.Size = UDim2.new(0, 110, 0, 320) 
TabBtns.Name = "TabBtns"
TabBtns.Parent = Side
TabBtns.Active = true
TabBtns.BackgroundTransparency = 1.000
TabBtns.BorderSizePixel = 0
TabBtns.Position = UDim2.new(0, 0, 0.097, 0)
TabBtns.Size = UDim2.new(0, 110, 0, 290) 
TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
TabBtns.ScrollBarThickness = 0
TabBtnsL.Name = "TabBtnsL"
TabBtnsL.Parent = TabBtns
TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
TabBtnsL.Padding = UDim.new(0, 10) 
ScriptTitle.Name = "ScriptTitle"
ScriptTitle.Parent = Side
ScriptTitle.BackgroundTransparency = 1.000
ScriptTitle.Position = UDim2.new(0, 0, 0.009, 0)
ScriptTitle.Size = UDim2.new(0, 110, 0, 24)
ScriptTitle.Font = Enum.Font.GothamBold
ScriptTitle.Text = name
ScriptTitle.TextColor3 = config.AccentColor
ScriptTitle.TextSize = 20.000 
ScriptTitle.TextScaled = false
ScriptTitle.TextXAlignment = Enum.TextXAlignment.Center 
TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 10)
end)
local window = {}
function window.Tab(window, name, icon)
local Tab = Instance.new("ScrollingFrame")
local TabIco = Instance.new("ImageLabel")
local TabText = Instance.new("TextLabel")
local TabBtn = Instance.new("TextButton")
local TabL = Instance.new("UIListLayout")
Tab.Name = "Tab"
Tab.Parent = TabMain
Tab.Active = true
Tab.BackgroundTransparency = 1.000
Tab.Size = UDim2.new(1, 0, 1, 0)
Tab.ScrollBarThickness = 4
Tab.Visible = false
Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
TabIco.Name = "TabIco"
TabIco.Parent = TabBtns
TabIco.BackgroundTransparency = 1.000
TabIco.Size = UDim2.new(0, 26, 0, 26) 
local defaultIcon = "rbxassetid://7072707962" 
TabIco.Image = ("rbxassetid://%s"):format((icon or defaultIcon))
TabIco.ImageTransparency = 0.2
TabText.Name = "TabText"
TabText.Parent = TabIco
TabText.BackgroundTransparency = 1.000
TabText.Position = UDim2.new(1.4, 0, 0, 0) 
TabText.Size = UDim2.new(0, 80, 0, 26) 
TabText.Font = Enum.Font.GothamMedium
TabText.Text = name
TabText.TextColor3 = config.TextColor
TabText.TextSize = 13.000 
TabText.TextTransparency = 0.2
TabText.TextXAlignment = Enum.TextXAlignment.Left
TabBtn.Name = "TabBtn"
TabBtn.Parent = TabIco
TabBtn.BackgroundTransparency = 1.000
TabBtn.Size = UDim2.new(0, 110, 0, 26) 
TabBtn.AutoButtonColor = false
TabBtn.Text = ""
TabL.Name = "TabL"
TabL.Parent = Tab
TabL.SortOrder = Enum.SortOrder.LayoutOrder
TabL.Padding = UDim.new(0, 6) 
TabBtn.MouseButton1Click:Connect(function()
Ripple(TabBtn)
switchTab({ TabIco, Tab })
end)
if Library.currentTab == nil then
switchTab({ TabIco, Tab })
end
TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 10)
end)
local tab = {}
function tab.section(tab, name, TabVal)
local Section = Instance.new("Frame")
local SectionC = Instance.new("UICorner")
local SectionText = Instance.new("TextLabel")
local SectionOpen = Instance.new("ImageLabel")
local SectionOpened = Instance.new("ImageLabel")
local SectionToggle = Instance.new("ImageButton")
local Objs = Instance.new("Frame")
local ObjsL = Instance.new("UIListLayout")
Section.Name = "Section"
Section.Parent = Tab
Section.BackgroundColor3 = config.Dropdown_Color
Section.BackgroundTransparency = 1.000
Section.BorderSizePixel = 0
Section.ClipsDescendants = true
Section.Size = UDim2.new(0.98, 0, 0, 36) 
SectionC.CornerRadius = UDim.new(0, 6)
SectionC.Name = "SectionC"
SectionC.Parent = Section
SectionText.Name = "SectionText"
SectionText.Parent = Section
SectionText.BackgroundTransparency = 1.000
SectionText.Position = UDim2.new(0.090, 0, 0, 0)
SectionText.Size = UDim2.new(0, 300, 0, 36) 
SectionText.Font = Enum.Font.GothamMedium
SectionText.Text = name
SectionText.TextColor3 = config.TextColor
SectionText.TextSize = 14.000 
SectionText.TextXAlignment = Enum.TextXAlignment.Left
SectionOpen.Name = "SectionOpen"
SectionOpen.Parent = SectionText
SectionOpen.BackgroundTransparency = 1
SectionOpen.Position = UDim2.new(0, -30, 0, 4) 
SectionOpen.Size = UDim2.new(0, 24, 0, 24) 
SectionOpen.Image = "http://www.roblox.com/asset/?id=6031302934"
SectionOpened.Name = "SectionOpened"
SectionOpened.Parent = SectionOpen
SectionOpened.BackgroundTransparency = 1.000
SectionOpened.Size = UDim2.new(0, 24, 0, 24) 
SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
SectionOpened.ImageTransparency = 1.000
SectionToggle.Name = "SectionToggle"
SectionToggle.Parent = SectionOpen
SectionToggle.BackgroundTransparency = 1
SectionToggle.Size = UDim2.new(0, 24, 0, 24) 
Objs.Name = "Objs"
Objs.Parent = Section
Objs.BackgroundTransparency = 1
Objs.Position = UDim2.new(0, 6, 0, 36)
Objs.Size = UDim2.new(0.98, 0, 0, 0)
ObjsL.Name = "ObjsL"
ObjsL.Parent = Objs
ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
ObjsL.Padding = UDim.new(0, 6) 
local open = TabVal
if TabVal ~= false then
Section.Size = UDim2.new(0.98, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 6 or 36)
SectionOpened.ImageTransparency = (open and 0 or 1)
SectionOpen.ImageTransparency = (open and 1 or 0)
end
SectionToggle.MouseButton1Click:Connect(function()
open = not open
Section.Size = UDim2.new(0.98, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 6 or 36)
SectionOpened.ImageTransparency = (open and 0 or 1)
SectionOpen.ImageTransparency = (open and 1 or 0)
end)
ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
if not open then
return
end
Section.Size = UDim2.new(0.98, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 6)
end)
local section = {}
function section.Button(section, text, callback)
local callback = callback or function() end
local BtnModule = Instance.new("Frame")
local Btn = Instance.new("TextButton")
local BtnC = Instance.new("UICorner")
BtnModule.Name = "BtnModule"
BtnModule.Parent = Objs
BtnModule.BackgroundTransparency = 1.000
BtnModule.Size = UDim2.new(1, 0, 0, 34) 
Btn.Name = "Btn"
Btn.Parent = BtnModule
Btn.BackgroundColor3 = config.Button_Color
Btn.BorderSizePixel = 0
Btn.Size = UDim2.new(1, 0, 0, 34) 
Btn.AutoButtonColor = false
Btn.Font = Enum.Font.GothamMedium
Btn.Text = "   " .. text
Btn.TextColor3 = config.TextColor
Btn.TextSize = 14.000 
Btn.TextXAlignment = Enum.TextXAlignment.Left
Btn.MouseEnter:Connect(function()
Tween(Btn, {0.2, "Quad", "Out"}, {BackgroundColor3 = Color3.fromRGB(75, 115, 245)})
end)
Btn.MouseLeave:Connect(function()
Tween(Btn, {0.2, "Quad", "Out"}, {BackgroundColor3 = config.Button_Color})
end)
BtnC.CornerRadius = UDim.new(0, 6)
BtnC.Name = "BtnC"
BtnC.Parent = Btn
Btn.MouseButton1Click:Connect(function()
Ripple(Btn)
spawn(callback)
end)
end
function section:Label(text)
local LabelModule = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local LabelC = Instance.new("UICorner")
LabelModule.Name = "LabelModule"
LabelModule.Parent = Objs
LabelModule.BackgroundTransparency = 1.000
LabelModule.Size = UDim2.new(1, 0, 0, 0)
TextLabel.Parent = LabelModule
TextLabel.BackgroundColor3 = config.Label_Color
TextLabel.Size = UDim2.new(1, 0, 0, 0)
TextLabel.AutomaticSize = Enum.AutomaticSize.Y
TextLabel.Font = Enum.Font.Gotham
TextLabel.Text = "    "..text
TextLabel.TextColor3 = config.TextColor
TextLabel.TextSize = 13.000 
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left 
TextLabel.TextYAlignment = Enum.TextYAlignment.Center
LabelC.CornerRadius = UDim.new(0, 6)
LabelC.Name = "LabelC"
LabelC.Parent = TextLabel
TextLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
LabelModule.Size = UDim2.new(0, 340, 0, TextLabel.TextBounds.Y + 1) 
end)
task.defer(function()
LabelModule.Size = UDim2.new(0, 340, 0, TextLabel.TextBounds.Y + 1) 
end)
return TextLabel
end
function section.Toggle(section, text, flag, enabled, callback)
local callback = callback or function() end
local enabled = enabled or false
Library.flags[flag] = enabled
local ToggleModule = Instance.new("Frame")
local ToggleBtn = Instance.new("TextButton")
local ToggleBtnC = Instance.new("UICorner")
local ToggleDisable = Instance.new("Frame")
local ToggleSwitch = Instance.new("Frame")
local ToggleSwitchC = Instance.new("UICorner")
local ToggleDisableC = Instance.new("UICorner")
ToggleModule.Name = "ToggleModule"
ToggleModule.Parent = Objs
ToggleModule.BackgroundTransparency = 1.000
ToggleModule.Size = UDim2.new(1, 0, 0, 34) 
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ToggleModule
ToggleBtn.BackgroundColor3 = config.Toggle_Color
ToggleBtn.Size = UDim2.new(1, 0, 0, 34) 
ToggleBtn.AutoButtonColor = false
ToggleBtn.Font = Enum.Font.GothamMedium
ToggleBtn.Text = "   " .. text
ToggleBtn.TextColor3 = config.TextColor
ToggleBtn.TextSize = 14.000 
ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
ToggleBtnC.CornerRadius = UDim.new(0, 6)
ToggleBtnC.Name = "ToggleBtnC"
ToggleBtnC.Parent = ToggleBtn
ToggleDisable.Name = "ToggleDisable"
ToggleDisable.Parent = ToggleBtn
ToggleDisable.BackgroundColor3 = config.Bg_Color
ToggleDisable.Position = UDim2.new(0.85, 0, 0.2, 0) 
ToggleDisable.Size = UDim2.new(0, 40, 0, 20) 
ToggleSwitch.Name = "ToggleSwitch"
ToggleSwitch.Parent = ToggleDisable
ToggleSwitch.BackgroundColor3 = enabled and config.Toggle_On or config.Toggle_Off
ToggleSwitch.Size = UDim2.new(0, 20, 0, 20) 
ToggleSwitchC.CornerRadius = UDim.new(0, 6)
ToggleSwitchC.Name = "ToggleSwitchC"
ToggleSwitchC.Parent = ToggleSwitch
ToggleDisableC.CornerRadius = UDim.new(0, 6)
ToggleDisableC.Name = "ToggleDisableC"
ToggleDisableC.Parent = ToggleDisable
local funcs = {
SetState = function(self, state)
if state == nil then
state = not Library.flags[flag]
end
if Library.flags[flag] == state then
return
end
services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {
Position = UDim2.new(0, state and 20 or 0, 0, 0),
BackgroundColor3 = state and config.Toggle_On or config.Toggle_Off
}):Play()
Library.flags[flag] = state
callback(state)
end,
Module = ToggleModule,}
if enabled then
ToggleSwitch.Position = UDim2.new(0, 20, 0, 0)
end
ToggleBtn.MouseButton1Click:Connect(function()
funcs:SetState()
end)
return funcs
end
function section.Keybind(section, text, default, callback)
local callback = callback or function() end
assert(text, "No text provided")
assert(default, "No default key provided")
local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
local banned = {
Return = true,
Space = true,
Tab = true,
Backquote = true,
CapsLock = true,
Escape = true,
Unknown = true,}
local shortNames = {
RightControl = "Right Ctrl",
LeftControl = "Left Ctrl",
LeftShift = "Left Shift",
RightShift = "Right Shift",
Semicolon = ";",
Quote = '"',
LeftBracket = "[",
RightBracket = "]",
Equals = "=",
Minus = "-",
RightAlt = "Right Alt",
LeftAlt = "Left Alt",}
local bindKey = default
local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")
local KeybindModule = Instance.new("Frame")
local KeybindBtn = Instance.new("TextButton")
local KeybindBtnC = Instance.new("UICorner")
local KeybindValue = Instance.new("TextButton")
local KeybindValueC = Instance.new("UICorner")
KeybindModule.Name = "KeybindModule"
KeybindModule.Parent = Objs
KeybindModule.BackgroundTransparency = 1.000
KeybindModule.Size = UDim2.new(1, 0, 0, 34) 
KeybindBtn.Name = "KeybindBtn"
KeybindBtn.Parent = KeybindModule
KeybindBtn.BackgroundColor3 = config.Keybind_Color
KeybindBtn.Size = UDim2.new(1, 0, 0, 34) 
KeybindBtn.AutoButtonColor = false
KeybindBtn.Font = Enum.Font.GothamMedium
KeybindBtn.Text = "   " .. text
KeybindBtn.TextColor3 = config.TextColor
KeybindBtn.TextSize = 14.000 
KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left
KeybindBtnC.CornerRadius = UDim.new(0, 6)
KeybindBtnC.Name = "KeybindBtnC"
KeybindBtnC.Parent = KeybindBtn
KeybindValue.Name = "KeybindValue"
KeybindValue.Parent = KeybindBtn
KeybindValue.BackgroundColor3 = config.Bg_Color
KeybindValue.Position = UDim2.new(0.78, 0, 0.2, 0) 
KeybindValue.Size = UDim2.new(0, 80, 0, 26) 
KeybindValue.AutoButtonColor = false
KeybindValue.Font = Enum.Font.Gotham
KeybindValue.Text = keyTxt
KeybindValue.TextColor3 = config.TextColor
KeybindValue.TextSize = 14.000
KeybindValueC.CornerRadius = UDim.new(0, 6)
KeybindValueC.Name = "KeybindValueC"
KeybindValueC.Parent = KeybindValue
services.UserInputService.InputBegan:Connect(function(inp, gpe)
if gpe then
return
end
if inp.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
if inp.KeyCode ~= bindKey then
return
end
callback(bindKey.Name)
end)
KeybindValue.MouseButton1Click:Connect(function()
KeybindValue.Text = "..."
wait()
local key, uwu = services.UserInputService.InputEnded:Wait()
local keyName = tostring(key.KeyCode.Name)
if key.UserInputType ~= Enum.UserInputType.Keyboard then
KeybindValue.Text = keyTxt
return
end
if banned[keyName] then
KeybindValue.Text = keyTxt
return
end
wait()
bindKey = Enum.KeyCode[keyName]
KeybindValue.Text = shortNames[keyName] or keyName
end)
KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
end)
KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
end
function section.Textbox(section, text, flag, default, callback)
local callback = callback or function() end
assert(text, "No text provided")
assert(flag, "No flag provided")
assert(default, "No default text provided")
Library.flags[flag] = default
local TextboxModule = Instance.new("Frame")
local TextboxBack = Instance.new("TextButton")
local TextboxBackC = Instance.new("UICorner")
local BoxBG = Instance.new("TextButton")
local BoxBGC = Instance.new("UICorner")
local TextBox = Instance.new("TextBox")
TextboxModule.Name = "TextboxModule"
TextboxModule.Parent = Objs
TextboxModule.BackgroundTransparency = 1.000
TextboxModule.Size = UDim2.new(1, 0, 0, 34) 
TextboxBack.Name = "TextboxBack"
TextboxBack.Parent = TextboxModule
TextboxBack.BackgroundColor3 = config.Textbox_Color
TextboxBack.Size = UDim2.new(1, 0, 0, 34) 
TextboxBack.AutoButtonColor = false
TextboxBack.Font = Enum.Font.GothamMedium
TextboxBack.Text = "   " .. text
TextboxBack.TextColor3 = config.TextColor
TextboxBack.TextSize = 14.000 
TextboxBack.TextXAlignment = Enum.TextXAlignment.Left
TextboxBackC.CornerRadius = UDim.new(0, 6)
TextboxBackC.Name = "TextboxBackC"
TextboxBackC.Parent = TextboxBack
BoxBG.Name = "BoxBG"
BoxBG.Parent = TextboxBack
BoxBG.BackgroundColor3 = config.Bg_Color
BoxBG.Position = UDim2.new(0.78, 0, 0.2, 0) 
BoxBG.Size = UDim2.new(0, 80, 0, 26) 
BoxBG.AutoButtonColor = false
BoxBG.Font = Enum.Font.Gotham
BoxBG.Text = "  "
BoxBG.TextColor3 = config.TextColor
BoxBG.TextSize = 14.000
BoxBGC.CornerRadius = UDim.new(0, 6)
BoxBGC.Name = "BoxBGC"
BoxBGC.Parent = BoxBG
TextBox.Parent = BoxBG
TextBox.BackgroundTransparency = 1.000
TextBox.Size = UDim2.new(1, 0, 1, 0)
TextBox.Font = Enum.Font.Gotham
TextBox.Text = default
TextBox.TextColor3 = config.TextColor
TextBox.TextSize = 14.000
TextBox.FocusLost:Connect(function()
if TextBox.Text == "" then
TextBox.Text = default
end
Library.flags[flag] = TextBox.Text
callback(TextBox.Text)
end)
TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
local newWidth = math.clamp(TextBox.TextBounds.X + 20, 60, 100)
BoxBG.Size = UDim2.new(0, newWidth, 0, 26)
end)
BoxBG.Size = UDim2.new(0, math.clamp(TextBox.TextBounds.X + 20, 60, 100), 0, 26)
end
function section.Slider(section, text, flag, default, min, max, precise, callback)
local callback = callback or function() end
local min = min or 1
local max = max or 10
local default = default or min
local precise = precise or false
Library.flags[flag] = default
assert(text, "No text provided")
assert(flag, "No flag provided")
assert(default, "No default value provided")
local SliderModule = Instance.new("Frame")
local SliderBack = Instance.new("TextButton")
local SliderBackC = Instance.new("UICorner")
local SliderBar = Instance.new("Frame")
local SliderBarC = Instance.new("UICorner")
local SliderPart = Instance.new("Frame")
local SliderPartC = Instance.new("UICorner")
local SliderValBG = Instance.new("TextButton")
local SliderValBGC = Instance.new("UICorner")
local SliderValue = Instance.new("TextBox")
local MinSlider = Instance.new("TextButton")
local AddSlider = Instance.new("TextButton")
SliderModule.Name = "SliderModule"
SliderModule.Parent = Objs
SliderModule.BackgroundTransparency = 1.000
SliderModule.Size = UDim2.new(1, 0, 0, 34) 
SliderBack.Name = "SliderBack"
SliderBack.Parent = SliderModule
SliderBack.BackgroundColor3 = config.Slider_Color
SliderBack.Size = UDim2.new(1, 0, 0, 34) 
SliderBack.AutoButtonColor = false
SliderBack.Font = Enum.Font.GothamMedium
SliderBack.Text = "   " .. text
SliderBack.TextColor3 = config.TextColor
SliderBack.TextSize = 14.000 
SliderBack.TextXAlignment = Enum.TextXAlignment.Left
SliderBackC.CornerRadius = UDim.new(0, 6)
SliderBackC.Name = "SliderBackC"
SliderBackC.Parent = SliderBack
SliderBar.Name = "SliderBar"
SliderBar.Parent = SliderBack
SliderBar.AnchorPoint = Vector2.new(0, 0.5)
SliderBar.BackgroundColor3 = config.Bg_Color
SliderBar.Position = UDim2.new(0.35, 20, 0.5, 0) 
SliderBar.Size = UDim2.new(0, 120, 0, 10) 
SliderBarC.CornerRadius = UDim.new(0, 4)
SliderBarC.Name = "SliderBarC"
SliderBarC.Parent = SliderBar
SliderPart.Name = "SliderPart"
SliderPart.Parent = SliderBar
SliderPart.BackgroundColor3 = config.SliderBar_Color
SliderPart.Size = UDim2.new(0, 54, 0, 10) 
SliderPartC.CornerRadius = UDim.new(0, 4)
SliderPartC.Name = "SliderPartC"
SliderPartC.Parent = SliderPart
SliderValBG.Name = "SliderValBG"
SliderValBG.Parent = SliderBack
SliderValBG.BackgroundColor3 = config.Bg_Color
SliderValBG.Position = UDim2.new(0.85, 0, 0.2, 0) 
SliderValBG.Size = UDim2.new(0, 40, 0, 24) 
SliderValBG.AutoButtonColor = false
SliderValBG.Text = ""
SliderValBGC.CornerRadius = UDim.new(0, 6)
SliderValBGC.Name = "SliderValBGC"
SliderValBGC.Parent = SliderValBG
SliderValue.Name = "SliderValue"
SliderValue.Parent = SliderValBG
SliderValue.BackgroundTransparency = 1.000
SliderValue.Size = UDim2.new(1, 0, 1, 0)
SliderValue.Font = Enum.Font.Gotham
SliderValue.Text = tostring(default)
SliderValue.TextColor3 = config.TextColor
SliderValue.TextSize = 14.000
MinSlider.Name = "MinSlider"
MinSlider.Parent = SliderModule
MinSlider.BackgroundTransparency = 1.000
MinSlider.Position = UDim2.new(0.3, 15, 0.25, 0) 
MinSlider.Size = UDim2.new(0, 18, 0, 18) 
MinSlider.Font = Enum.Font.Gotham
MinSlider.Text = "-"
MinSlider.TextColor3 = config.TextColor
MinSlider.TextSize = 20.000
AddSlider.Name = "AddSlider"
AddSlider.Parent = SliderModule
AddSlider.AnchorPoint = Vector2.new(0, 0.5)
AddSlider.BackgroundTransparency = 1.000
AddSlider.Position = UDim2.new(0.75, 0, 0.5, 0) 
AddSlider.Size = UDim2.new(0, 18, 0, 18) 
AddSlider.Font = Enum.Font.Gotham
AddSlider.Text = "+"
AddSlider.TextColor3 = config.TextColor
AddSlider.TextSize = 20.000
local funcs = {
SetValue = function(self, value)
local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
if value then
percent = (value - min) / (max - min)
end
percent = math.clamp(percent, 0, 1)
if precise then
value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
else
value = value or math.floor(min + (max - min) * percent)
end
Library.flags[flag] = tonumber(value)
SliderValue.Text = tostring(value)
SliderPart.Size = UDim2.new(percent, 0, 1, 0)
callback(tonumber(value))
end,}
MinSlider.MouseButton1Click:Connect(function()
local currentValue = Library.flags[flag]
currentValue = math.clamp(currentValue - 1, min, max)
funcs:SetValue(currentValue)
end)
AddSlider.MouseButton1Click:Connect(function()
local currentValue = Library.flags[flag]
currentValue = math.clamp(currentValue + 1, min, max)
funcs:SetValue(currentValue)
end)
funcs:SetValue(default)
local dragging, boxFocused, allowed = false, false, { [""] = true, ["-"] = true }
SliderBar.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
funcs:SetValue()
dragging = true
end
end)
services.UserInputService.InputEnded:Connect(function(input)
if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = false
end
end)
services.UserInputService.InputChanged:Connect(function(input)
if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
funcs:SetValue()
end
end)
SliderBar.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.Touch then
funcs:SetValue()
dragging = true
end
end)
services.UserInputService.InputEnded:Connect(function(input)
if dragging and input.UserInputType == Enum.UserInputType.Touch then
dragging = false
end
end)
services.UserInputService.InputChanged:Connect(function(input)
if dragging and input.UserInputType == Enum.UserInputType.Touch then
funcs:SetValue()
end
end)
SliderValue.Focused:Connect(function()
boxFocused = true
end)
SliderValue.FocusLost:Connect(function()
boxFocused = false
if SliderValue.Text == "" then
funcs:SetValue(default)
end
end)
SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
if not boxFocused then
return
end
SliderValue.Text = SliderValue.Text:gsub("%D+", "")
local text = SliderValue.Text
if not tonumber(text) then
SliderValue.Text = SliderValue.Text:gsub("%D+", "")
elseif not allowed[text] then
if tonumber(text) > max then
text = max
SliderValue.Text = tostring(max)
end
funcs:SetValue(tonumber(text))
end
end)
return funcs
end
function section.Dropdown(section, text, flag, options, callback)
local callback = callback or function() end
local options = options or {}
assert(text, "No text provided")
assert(flag, "No flag provided")
Library.flags[flag] = nil
local DropdownModule = Instance.new("Frame")
local DropdownTop = Instance.new("TextButton")
local DropdownTopC = Instance.new("UICorner")
local DropdownOpen = Instance.new("TextButton")
local DropdownText = Instance.new("TextBox")
local DropdownModuleL = Instance.new("UIListLayout")
DropdownModule.Name = "DropdownModule"
DropdownModule.Parent = Objs
DropdownModule.BackgroundTransparency = 1.000
DropdownModule.ClipsDescendants = true
DropdownModule.Size = UDim2.new(1, 0, 0, 34) 
DropdownTop.Name = "DropdownTop"
DropdownTop.Parent = DropdownModule
DropdownTop.BackgroundColor3 = config.Dropdown_Color
DropdownTop.Size = UDim2.new(1, 0, 0, 34) 
DropdownTop.AutoButtonColor = false
DropdownTop.Text = ""
DropdownTopC.CornerRadius = UDim.new(0, 6)
DropdownTopC.Name = "DropdownTopC"
DropdownTopC.Parent = DropdownTop
DropdownOpen.Name = "DropdownOpen"
DropdownOpen.Parent = DropdownTop
DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
DropdownOpen.BackgroundTransparency = 1.000
DropdownOpen.Position = UDim2.new(0.92, 0, 0.5, 0) 
DropdownOpen.Size = UDim2.new(0, 18, 0, 18) 
DropdownOpen.Font = Enum.Font.Gotham
DropdownOpen.Text = "+"
DropdownOpen.TextColor3 = config.TextColor
DropdownOpen.TextSize = 20.000
DropdownText.Name = "DropdownText"
DropdownText.Parent = DropdownTop
DropdownText.BackgroundTransparency = 1.000
DropdownText.Position = UDim2.new(0.04, 0, 0, 0)
DropdownText.Size = UDim2.new(0, 250, 0, 34) 
DropdownText.Font = Enum.Font.GothamMedium
DropdownText.PlaceholderText = text .. "请选择"
DropdownText.Text = text .. "已选择: "
DropdownText.TextColor3 = config.TextColor
DropdownText.TextSize = 14.000 
DropdownText.TextXAlignment = Enum.TextXAlignment.Left
DropdownModuleL.Name = "DropdownModuleL"
DropdownModuleL.Parent = DropdownModule
DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
DropdownModuleL.Padding = UDim.new(0, 4)
local setAllVisible = function()
local options = DropdownModule:GetChildren()
for i = 1, #options do
local option = options[i]
if option:IsA("TextButton") and option.Name:match("Option_") then
option.Visible = true
end
end
end
local searchDropdown = function(text)
local options = DropdownModule:GetChildren()
for i = 1, #options do
local option = options[i]
if text == "" then
setAllVisible()
else
if option:IsA("TextButton") and option.Name:match("Option_") then
if option.Text:lower():match(text:lower()) then
option.Visible = true
else
option.Visible = false
end
end
end
end
end
local open = false
local ToggleDropVis = function()
open = not open
if open then
setAllVisible()
end
DropdownOpen.Text = (open and "-" or "+")
DropdownModule.Size =
UDim2.new(0, 344, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 38))
end
DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
DropdownText.Focused:Connect(
function()
if open then
return
end
ToggleDropVis()
end)
DropdownText:GetPropertyChangedSignal("Text"):Connect(
function()
if not open then
return
end
searchDropdown(DropdownText.Text)
end)
DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(
function()
if not open then
return
end
DropdownModule.Size = UDim2.new(0, 344, 0, (DropdownModuleL.AbsoluteContentSize.Y + 4))
end)
local funcs = {}
funcs.AddOption = function(self, option)
local Option = Instance.new("TextButton")
local OptionC = Instance.new("UICorner")
Option.Name = "Option_" .. option
Option.Parent = DropdownModule
Option.BackgroundColor3 = config.Dropdown_Color
Option.Size = UDim2.new(1, 0, 0, 24) 
Option.AutoButtonColor = false
Option.Font = Enum.Font.Gotham
Option.Text = option
Option.TextColor3 = config.TextColor
Option.TextSize = 13.000 
OptionC.CornerRadius = UDim.new(0, 6)
OptionC.Name = "OptionC"
OptionC.Parent = Option
Option.MouseButton1Click:Connect(function()
ToggleDropVis()
callback(Option.Text)
DropdownText.Text = text.."|已选择："..Option.Text
Library.flags[flag] = Option.Text
end)
end
funcs.RemoveOption = function(self, option)
local option = DropdownModule:FindFirstChild("Option_" .. option)
if option then
option:Destroy()
end
end
funcs.SetOptions = function(self, options)
for _, v in next, DropdownModule:GetChildren() do
if v.Name:match("Option_") then
v:Destroy()
end
end
for _, v in next, options do
funcs:AddOption(v)
end
end
funcs:SetOptions(options)
return funcs
end
return section
end
return tab
end
return window
end
return Library