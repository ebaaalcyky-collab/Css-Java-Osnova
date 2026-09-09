--// CSS JAVA - Native Balanced Scale
--// Window size: 850 x 520

local RAW_BASE = "https://raw.githubusercontent.com/ebaaalcyky-collab/Css-Java-Osnova/main/assets/"

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local CONFIG = {
    WindowSize = Vector2.new(850, 520),
    SidebarWidth = 210,
    AnimationTime = 0.18,
    MaxEspDistance = 250
}

local COLORS = {
    BgB = Color3.fromRGB(14, 16, 24),
    Side = Color3.fromRGB(6, 7, 11),
    Card = Color3.fromRGB(20, 23, 33),
    CardInner = Color3.fromRGB(26, 30, 42),
    Accent = Color3.fromRGB(124, 82, 255),
    Accent2 = Color3.fromRGB(176, 146, 255),
    Text = Color3.fromRGB(255, 255, 255),
    Dim = Color3.fromRGB(158, 164, 180),
    Mute = Color3.fromRGB(96, 102, 118),
    Line = Color3.fromRGB(255, 255, 255),
    Off = Color3.fromRGB(40, 44, 58),
    Plus = Color3.fromRGB(80, 220, 140),
    Minus = Color3.fromRGB(255, 92, 108),

    SecondaryText = Color3.fromRGB(158, 164, 180),
    ToggleOff = Color3.fromRGB(40, 44, 58),
    ToggleOn = Color3.fromRGB(124, 82, 255),
    White = Color3.fromRGB(255, 255, 255),
    Health = Color3.fromRGB(46, 204, 113),
    Armor = Color3.fromRGB(52, 152, 219)
}

local FONT = Enum.Font.GothamBold

local function Create(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function Corner(parent, r)
    return Create("UICorner", { CornerRadius = UDim.new(0, r) }, parent)
end

local function Stroke(parent, color, tr, th)
    return Create("UIStroke", {
        Color = color,
        Transparency = tr or 0,
        Thickness = th or 1
    }, parent)
end

local function Tween(obj, props, t)
    if not obj then return end
    TweenService:Create(obj, TweenInfo.new(t or CONFIG.AnimationTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play()
end

local function Pixel(parent, pos, size, color, z)
    local f = Create("Frame", {
        Position = pos,
        Size = size,
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        ZIndex = z or 20
    }, parent)
    Corner(f, 1)
    return f
end

local function RecolorIcon(box, newColor)
    for _, child in ipairs(box:GetDescendants()) do
        if child:IsA("Frame") and child.BackgroundTransparency < 1 then
            child.BackgroundColor3 = newColor
        end
        if child:IsA("UIStroke") then
            child.Color = newColor
        end
    end
end

local function PaintIcon(parent, kind, color)
    local box = Create("Frame", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(20, 20),
        ZIndex = 12
    }, parent)

    if kind == "home" then
        Pixel(box, UDim2.fromOffset(2, 9), UDim2.fromOffset(16, 9), color, 13)
        local roof = Create("Frame", {
            Position = UDim2.fromOffset(1, 5),
            Size = UDim2.fromOffset(16, 7),
            Rotation = 45,
            BackgroundColor3 = color,
            BorderSizePixel = 0,
            ZIndex = 12
        }, box)
        Corner(roof, 2)
        Pixel(box, UDim2.fromOffset(8, 11), UDim2.fromOffset(4, 7), COLORS.Side, 14)

    elseif kind == "aim" then
        local ring = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(14, 14),
            BackgroundTransparency = 1,
            ZIndex = 12
        }, box)
        Stroke(ring, color, 0, 2)
        Corner(ring, 7)

    elseif kind == "wh" then
        local eye = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(16, 8),
            BackgroundTransparency = 1,
            ZIndex = 12
        }, box)
        Stroke(eye, color, 0, 2)
        Corner(eye, 6)

    elseif kind == "move" then
        Pixel(box, UDim2.fromOffset(3, 14), UDim2.fromOffset(3, 3), color, 13)
        Pixel(box, UDim2.fromOffset(8, 9), UDim2.fromOffset(3, 8), color, 13)
        Pixel(box, UDim2.fromOffset(13, 4), UDim2.fromOffset(3, 13), color, 13)

    elseif kind == "other" then
        for i = 0, 2 do
            for j = 0, 2 do
                if not (i == 1 and j == 1) then
                    Pixel(box, UDim2.fromOffset(2 + i * 6, 2 + j * 6), UDim2.fromOffset(3, 3), color, 13)
                end
            end
        end

    elseif kind == "settings" then
        local gear = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(12, 12),
            BackgroundTransparency = 1,
            ZIndex = 12
        }, box)
        Stroke(gear, color, 0, 2)
        Corner(gear, 6)

    elseif kind == "close" then
        local a = Pixel(box, UDim2.fromOffset(4, 9), UDim2.fromOffset(12, 2), color, 13)
        a.Rotation = 45
        local b = Pixel(box, UDim2.fromOffset(4, 9), UDim2.fromOffset(12, 2), color, 13)
        b.Rotation = -45

    elseif kind == "drag" then
        for y = 4, 12, 4 do
            for x = 4, 12, 4 do
                Pixel(box, UDim2.fromOffset(x, y), UDim2.fromOffset(2, 2), color, 13)
            end
        end
    end

    return box
end

--// RESET OLD GUI
pcall(function()
    local old = CoreGui:FindFirstChild("CSS_JAVA_GUI")
    if old then old:Destroy() end
end)

local ScreenGui = Create("ScreenGui", {
    Name = "CSS_JAVA_GUI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999
}, CoreGui)

--// MAIN WINDOW (Базовый оптимальный размер 850x520)
local MainFrame = Create("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(CONFIG.WindowSize.X, CONFIG.WindowSize.Y),
    BackgroundColor3 = COLORS.BgB,
    BackgroundTransparency = 0.04,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 3
}, ScreenGui)

Corner(MainFrame, 18)
Stroke(MainFrame, COLORS.Accent, 0.72, 1)

--// SIDEBAR
local Sidebar = Create("Frame", {
    Size = UDim2.new(0, CONFIG.SidebarWidth, 1, 0),
    BackgroundColor3 = COLORS.Side,
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ZIndex = 5
}, MainFrame)

local Brand = Create("Frame", {
    Position = UDim2.fromOffset(18, 18),
    Size = UDim2.new(1, -36, 0, 44),
    BackgroundTransparency = 1,
    ZIndex = 6
}, Sidebar)

Create("TextLabel", {
    Position = UDim2.fromOffset(0, 0),
    Size = UDim2.new(1, 0, 0, 22),
    BackgroundTransparency = 1,
    Text = "CSS JAVA",
    TextColor3 = COLORS.Text,
    TextSize = 17,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 7
}, Brand)

Create("TextLabel", {
    Position = UDim2.fromOffset(0, 22),
    Size = UDim2.new(1, 0, 0, 14),
    BackgroundTransparency = 1,
    Text = "CONTROL",
    TextColor3 = COLORS.Accent2,
    TextSize = 11,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 7
}, Brand)

local MenuContainer = Create("Frame", {
    Position = UDim2.fromOffset(14, 76),
    Size = UDim2.new(1, -28, 0, 380),
    BackgroundTransparency = 1,
    ZIndex = 7
}, Sidebar)

Create("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder
}, MenuContainer)

local Content = Create("Frame", {
    Position = UDim2.fromOffset(CONFIG.SidebarWidth, 0),
    Size = UDim2.new(1, -CONFIG.SidebarWidth, 1, 0),
    BackgroundTransparency = 1,
    ZIndex = 4
}, MainFrame)

local TopBar = Create("Frame", {
    Position = UDim2.fromOffset(24, 16),
    Size = UDim2.new(1, -48, 0, 44),
    BackgroundTransparency = 1,
    ZIndex = 8
}, Content)

local CurrentTitle = Create("TextLabel", {
    Size = UDim2.new(1, -80, 0, 24),
    BackgroundTransparency = 1,
    Text = "Home",
    TextColor3 = COLORS.Text,
    TextSize = 22,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, TopBar)

local CurrentSubtitle = Create("TextLabel", {
    Position = UDim2.fromOffset(0, 24),
    Size = UDim2.new(1, -80, 0, 14),
    BackgroundTransparency = 1,
    Text = "SESSION",
    TextColor3 = COLORS.Dim,
    TextSize = 11,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, TopBar)

local function HeaderBtn(name, kind, x)
    local b = Create("TextButton", {
        Name = name,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, x, 0, 4),
        Size = UDim2.fromOffset(32, 32),
        BackgroundColor3 = COLORS.Card,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 10
    }, TopBar)
    Corner(b, 10)

    local icon = PaintIcon(b, kind, COLORS.Dim)
    icon.Position = UDim2.fromOffset(6, 6)
    return b
end

local CloseButton = HeaderBtn("Close", "close", 0)
local DragButton = HeaderBtn("Drag", "drag", -38)

--// PAGES CONTAINER
local PagesFolder = Create("Folder", { Name = "Pages" }, Content)

local function Card(parent, name, pos, size)
    local c = Create("Frame", {
        Name = name,
        Position = pos,
        Size = size,
        BackgroundColor3 = COLORS.Card,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 8
    }, parent)
    Corner(c, 14)
    Stroke(c, COLORS.Line, 0.9, 1)
    return c
end

local function CreateToggle(parent, text, yOffset, callback)
    local Row = Create("Frame", {
        Name = text .. "Row",
        Position = UDim2.fromOffset(20, yOffset),
        Size = UDim2.new(1, -40, 0, 40),
        BackgroundTransparency = 1,
        ZIndex = 10
    }, parent)

    Create("TextLabel", {
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(1, -70, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 11
    }, Row)

    local Toggle = Create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.fromOffset(48, 24),
        BackgroundColor3 = COLORS.ToggleOff,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 11
    }, Row)

    Corner(Toggle, 12)

    local Circle = Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 3, 0.5, 0),
        Size = UDim2.fromOffset(18, 18),
        BackgroundColor3 = COLORS.SecondaryText,
        BorderSizePixel = 0,
        ZIndex = 12
    }, Toggle)

    Corner(Circle, 9)

    local State = false
    Toggle.Activated:Connect(function()
        State = not State
        if State then
            Tween(Toggle, { BackgroundColor3 = COLORS.ToggleOn })
            Tween(Circle, { Position = UDim2.new(1, -21, 0.5, 0), BackgroundColor3 = COLORS.White })
        else
            Tween(Toggle, { BackgroundColor3 = COLORS.ToggleOff })
            Tween(Circle, { Position = UDim2.new(0, 3, 0.5, 0), BackgroundColor3 = COLORS.SecondaryText })
        end
        if callback then callback(State) end
    end)

    return Row
end

--// PAGES
local HomePage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = true }, PagesFolder)
local ProfileCard = Card(HomePage, "ProfileCard", UDim2.fromOffset(24, 70), UDim2.new(1, -48, 0, 120))

local Avatar = Create("ImageLabel", {
    Position = UDim2.fromOffset(16, 16), Size = UDim2.fromOffset(88, 88),
    BackgroundColor3 = COLORS.CardInner, BorderSizePixel = 0, ZIndex = 10
}, ProfileCard)
Corner(Avatar, 14)

Create("TextLabel", { Position = UDim2.fromOffset(120, 22), Size = UDim2.new(1, -130, 0, 14), BackgroundTransparency = 1, Text = "HOME", TextColor3 = COLORS.Accent2, TextSize = 11, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 }, ProfileCard)
Create("TextLabel", { Position = UDim2.fromOffset(120, 40), Size = UDim2.new(1, -130, 0, 26), BackgroundTransparency = 1, Text = Player and Player.Name or "Player", TextColor3 = COLORS.Text, TextSize = 20, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 }, ProfileCard)
Create("TextLabel", { Position = UDim2.fromOffset(120, 70), Size = UDim2.new(1, -130, 0, 16), BackgroundTransparency = 1, Text = "ID " .. tostring(Player and Player.UserId or 0), TextColor3 = COLORS.Dim, TextSize = 12, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 }, ProfileCard)

local StatsCard = Card(HomePage, "StatsCard", UDim2.fromOffset(24, 204), UDim2.new(1, -48, 0, 280))

local AimPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)
local WhPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)
local WhCard = Card(WhPage, "WhCard", UDim2.fromOffset(24, 70), UDim2.new(1, -48, 0, 410))
CreateToggle(WhCard, "ESP / WH", 24, function(s) end)

local MovementPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)
local MovementCard = Card(MovementPage, "MoveCard", UDim2.fromOffset(24, 70), UDim2.new(1, -48, 0, 220))

local speedHackEnabled = false
RunService.RenderStepped:Connect(function()
    if speedHackEnabled then
        local h = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 33 end
    end
end)

CreateToggle(MovementCard, "SpeedHack", 24, function(state)
    speedHackEnabled = state
    if not state then
        local h = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 end
    end
end)

local OtherPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)
local SettingsPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)

--// MENU SWITCH
local MenuItems = {
    { Name = "Home", Sub = "SESSION", Kind = "home", Page = HomePage },
    { Name = "Aim", Sub = "TARGETING", Kind = "aim", Page = AimPage },
    { Name = "Visuals", Sub = "DISPLAY", Kind = "wh", Page = WhPage },
    { Name = "Movement", Sub = "MOTION", Kind = "move", Page = MovementPage },
    { Name = "Other", Sub = "EXTRA", Kind = "other", Page = OtherPage },
    { Name = "Settings", Sub = "SYSTEM", Kind = "settings", Page = SettingsPage }
}

local MenuButtons = {}

local function SelectTab(index)
    local selected = MenuItems[index]
    CurrentTitle.Text = selected.Name
    CurrentSubtitle.Text = selected.Sub

    for _, item in ipairs(MenuItems) do
        item.Page.Visible = (item == selected)
    end

    for i, data in ipairs(MenuButtons) do
        local on = (i == index)
        Tween(data.Button, { BackgroundColor3 = on and COLORS.Accent or COLORS.Card, BackgroundTransparency = on and 0 or 1 })
        Tween(data.Label, { TextColor3 = on and COLORS.Text or COLORS.Dim })
        RecolorIcon(data.Icon, on and COLORS.Text or COLORS.Dim)
    end
end

for index, data in ipairs(MenuItems) do
    local button = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = COLORS.Card, BackgroundTransparency = 1,
        BorderSizePixel = 0, Text = "", AutoButtonColor = false, LayoutOrder = index, ZIndex = 8
    }, MenuContainer)
    Corner(button, 12)

    local icon = PaintIcon(button, data.Kind, COLORS.Dim)
    icon.Position = UDim2.fromOffset(12, 10)

    local label = Create("TextLabel", {
        Position = UDim2.fromOffset(42, 0), Size = UDim2.new(1, -50, 1, 0),
        BackgroundTransparency = 1, Text = data.Name, TextColor3 = COLORS.Dim, TextSize = 13, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9
    }, button)

    button.Activated:Connect(function() SelectTab(index) end)
    table.insert(MenuButtons, { Button = button, Icon = icon, Label = label })
end

SelectTab(1)

--// DRAG & CLOSE
local dragging, dragStart, startPos = false, nil, nil
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

CloseButton.Activated:Connect(function()
    MainFrame.Visible = false
end)
