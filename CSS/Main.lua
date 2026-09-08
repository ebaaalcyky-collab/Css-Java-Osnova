--// CSS JAVA - Visual redesign
--// Window size locked: 1000 x 620
--// Custom geometric icons + bold type
--// UI only. No gameplay hooks.

local RAW_BASE = "https://raw.githubusercontent.com/ebaaalcyky-collab/Css-Java-Osnova/main/assets/"

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer

local CONFIG = {
    WindowSize = Vector2.new(1000, 620),
    MinScale = 0.42,
    MaxScale = 1,
    SidebarWidth = 236,
    AnimationTime = 0.18
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
    Off = Color3.fromRGB(40, 44, 58)
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
        Size = UDim2.fromOffset(22, 22),
        ZIndex = 12
    }, parent)

    if kind == "aim" then
        local ring = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(16, 16),
            BackgroundTransparency = 1,
            ZIndex = 12
        }, box)
        Stroke(ring, color, 0, 2)
        Corner(ring, 8)
        Pixel(box, UDim2.fromOffset(10, 2), UDim2.fromOffset(2, 5), color, 13)
        Pixel(box, UDim2.fromOffset(10, 15), UDim2.fromOffset(2, 5), color, 13)
        Pixel(box, UDim2.fromOffset(2, 10), UDim2.fromOffset(5, 2), color, 13)
        Pixel(box, UDim2.fromOffset(15, 10), UDim2.fromOffset(5, 2), color, 13)
        local dot = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(4, 4),
            BackgroundColor3 = color,
            BorderSizePixel = 0,
            ZIndex = 13
        }, box)
        Corner(dot, 2)
    elseif kind == "wh" then
        local eye = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(18, 10),
            BackgroundTransparency = 1,
            ZIndex = 12
        }, box)
        Stroke(eye, color, 0, 2)
        Corner(eye, 8)
        local pupil = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(6, 6),
            BackgroundColor3 = color,
            BorderSizePixel = 0,
            ZIndex = 13
        }, box)
        Corner(pupil, 3)
    elseif kind == "move" then
        Pixel(box, UDim2.fromOffset(4, 16), UDim2.fromOffset(4, 4), color, 13)
        Pixel(box, UDim2.fromOffset(9, 11), UDim2.fromOffset(4, 9), color, 13)
        Pixel(box, UDim2.fromOffset(14, 5), UDim2.fromOffset(4, 15), color, 13)
    elseif kind == "other" then
        for i = 0, 2 do
            for j = 0, 2 do
                if not (i == 1 and j == 1) then
                    Pixel(box, UDim2.fromOffset(3 + i * 7, 3 + j * 7), UDim2.fromOffset(4, 4), color, 13)
                end
            end
        end
    elseif kind == "settings" then
        local gear = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(14, 14),
            BackgroundTransparency = 1,
            ZIndex = 12
        }, box)
        Stroke(gear, color, 0, 2)
        Corner(gear, 7)
        local hole = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(6, 6),
            BackgroundColor3 = COLORS.Side,
            BorderSizePixel = 0,
            ZIndex = 13
        }, box)
        Corner(hole, 3)
    elseif kind == "close" then
        local a = Pixel(box, UDim2.fromOffset(5, 10), UDim2.fromOffset(12, 2), color, 13)
        a.Rotation = 45
        local b = Pixel(box, UDim2.fromOffset(5, 10), UDim2.fromOffset(12, 2), color, 13)
        b.Rotation = -45
    elseif kind == "drag" then
        for y = 5, 15, 5 do
            for x = 5, 15, 5 do
                Pixel(box, UDim2.fromOffset(x, y), UDim2.fromOffset(3, 3), color, 13)
            end
        end
    end

    return box
end

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

local BackgroundLayer = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    ZIndex = 0
}, ScreenGui)

Create("ImageLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Image = RAW_BASE .. "background.png",
    ImageTransparency = 0.2,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 0
}, BackgroundLayer)

Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = Color3.fromRGB(4, 5, 8),
    BackgroundTransparency = 0.42,
    BorderSizePixel = 0,
    ZIndex = 1
}, BackgroundLayer)

local UIScale = Create("UIScale", { Scale = 1 })

local MainFrame = Create("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(1000, 620),
    BackgroundColor3 = COLORS.BgB,
    BackgroundTransparency = 0.04,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 3
}, ScreenGui)
UIScale.Parent = MainFrame
Corner(MainFrame, 24)
Stroke(MainFrame, COLORS.Accent, 0.72, 1)

Create("Frame", {
    Size = UDim2.new(0, 3, 1, 0),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0,
    ZIndex = 30
}, MainFrame)

Create("Frame", {
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = COLORS.Line,
    BackgroundTransparency = 0.86,
    BorderSizePixel = 0,
    ZIndex = 30
}, MainFrame)

local Sidebar = Create("Frame", {
    Size = UDim2.new(0, CONFIG.SidebarWidth, 1, 0),
    BackgroundColor3 = COLORS.Side,
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ZIndex = 5
}, MainFrame)

local Brand = Create("Frame", {
    Position = UDim2.fromOffset(20, 24),
    Size = UDim2.new(1, -40, 0, 54),
    BackgroundTransparency = 1,
    ZIndex = 6
}, Sidebar)

local LogoMark = Create("Frame", {
    Size = UDim2.fromOffset(42, 42),
    Position = UDim2.fromOffset(0, 6),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0,
    ZIndex = 7
}, Brand)
Corner(LogoMark, 13)
Create("TextLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = "CJ",
    TextColor3 = COLORS.Text,
    TextSize = 16,
    Font = FONT,
    ZIndex = 8
}, LogoMark)

Create("TextLabel", {
    Position = UDim2.fromOffset(54, 8),
    Size = UDim2.new(1, -54, 0, 22),
    BackgroundTransparency = 1,
    Text = "CSS JAVA",
    TextColor3 = COLORS.Text,
    TextSize = 17,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 7
}, Brand)

Create("TextLabel", {
    Position = UDim2.fromOffset(54, 30),
    Size = UDim2.new(1, -54, 0, 16),
    BackgroundTransparency = 1,
    Text = "CONTROL",
    TextColor3 = COLORS.Accent2,
    TextSize = 11,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 7
}, Brand)

local MenuContainer = Create("Frame", {
    Position = UDim2.fromOffset(16, 100),
    Size = UDim2.new(1, -32, 0, 320),
    BackgroundTransparency = 1,
    ZIndex = 7
}, Sidebar)
Create("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, MenuContainer)

local Content = Create("Frame", {
    Position = UDim2.fromOffset(CONFIG.SidebarWidth, 0),
    Size = UDim2.new(1, -CONFIG.SidebarWidth, 1, 0),
    BackgroundTransparency = 1,
    ZIndex = 4
}, MainFrame)

local TopBar = Create("Frame", {
    Position = UDim2.fromOffset(28, 20),
    Size = UDim2.new(1, -56, 0, 58),
    BackgroundTransparency = 1,
    ZIndex = 8
}, Content)

local CurrentTitle = Create("TextLabel", {
    Size = UDim2.new(1, -100, 0, 32),
    BackgroundTransparency = 1,
    Text = "Aim",
    TextColor3 = COLORS.Text,
    TextSize = 28,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, TopBar)

local CurrentSubtitle = Create("TextLabel", {
    Position = UDim2.fromOffset(0, 34),
    Size = UDim2.new(1, -100, 0, 18),
    BackgroundTransparency = 1,
    Text = "TARGETING",
    TextColor3 = COLORS.Dim,
    TextSize = 12,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, TopBar)

local function HeaderBtn(name, kind, x)
    local b = Create("TextButton", {
        Name = name,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, x, 0, 8),
        Size = UDim2.fromOffset(38, 38),
        BackgroundColor3 = COLORS.Card,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 10
    }, TopBar)
    Corner(b, 12)
    Stroke(b, COLORS.Line, 0.9, 1)
    local icon = PaintIcon(b, kind, COLORS.Dim)
    icon.Position = UDim2.fromOffset(8, 8)
    b.MouseEnter:Connect(function()
        Tween(b, { BackgroundColor3 = COLORS.CardInner })
        RecolorIcon(icon, COLORS.Text)
    end)
    b.MouseLeave:Connect(function()
        Tween(b, { BackgroundColor3 = COLORS.Card })
        RecolorIcon(icon, COLORS.Dim)
    end)
    return b
end

local CloseButton = HeaderBtn("Close", "close", 0)
local DragButton = HeaderBtn("Drag", "drag", -46)

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
    Corner(c, 18)
    Stroke(c, COLORS.Line, 0.9, 1)
    Create("Frame", {
        Size = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = COLORS.Accent,
        BorderSizePixel = 0,
        ZIndex = 9
    }, c)
    return c
end

local function Badge(parent, text)
    return Create("TextLabel", {
        Position = UDim2.fromOffset(24, 16),
        Size = UDim2.new(1, -48, 0, 16),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.Accent2,
        TextSize = 11,
        Font = FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 10
    }, parent)
end

local function Heading(parent, text)
    return Create("TextLabel", {
        Position = UDim2.fromOffset(24, 34),
        Size = UDim2.new(1, -48, 0, 24),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.Text,
        TextSize = 18,
        Font = FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 10
    }, parent)
end

local function CreateToggle(parent, text, y)
    local row = Create("Frame", {
        Position = UDim2.fromOffset(24, y),
        Size = UDim2.new(1, -48, 0, 46),
        BackgroundColor3 = COLORS.CardInner,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        ZIndex = 10
    }, parent)
    Corner(row, 12)

    Create("TextLabel", {
        Position = UDim2.fromOffset(14, 0),
        Size = UDim2.new(1, -80, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.Text,
        TextSize = 14,
        Font = FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 11
    }, row)

    local toggle = Create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(50, 26),
        BackgroundColor3 = COLORS.Off,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 11
    }, row)
    Corner(toggle, 13)

    local circle = Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 3, 0.5, 0),
        Size = UDim2.fromOffset(20, 20),
        BackgroundColor3 = COLORS.Dim,
        BorderSizePixel = 0,
        ZIndex = 12
    }, toggle)
    Corner(circle, 10)

    local state = false
    toggle.Activated:Connect(function()
        state = not state
        if state then
            Tween(toggle, { BackgroundColor3 = COLORS.Accent })
            Tween(circle, { Position = UDim2.new(1, -23, 0.5, 0), BackgroundColor3 = COLORS.Text })
        else
            Tween(toggle, { BackgroundColor3 = COLORS.Off })
            Tween(circle, { Position = UDim2.new(0, 3, 0.5, 0), BackgroundColor3 = COLORS.Dim })
        end
    end)
end

local AimPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = true,
    ZIndex = 4
}, PagesFolder)

local AimCard = Card(AimPage, "AimCard", UDim2.fromOffset(28, 92), UDim2.new(0.58, -36, 0, 292))
Badge(AimCard, "AIM")
Heading(AimCard, "Targeting")
CreateToggle(AimCard, "Enabled", 78)
CreateToggle(AimCard, "Preview", 132)
CreateToggle(AimCard, "Advanced", 186)

local SideCard = Card(AimPage, "SideCard", UDim2.new(0.58, 8, 0, 92), UDim2.new(0.42, -36, 0, 292))
Badge(SideCard, "LAYOUT")
Heading(SideCard, "Panel")
Create("TextLabel", {
    Position = UDim2.fromOffset(24, 78),
    Size = UDim2.new(1, -48, 0, 180),
    BackgroundTransparency = 1,
    Text = "1000 x 620\nBold Gotham\nCustom marks\nGlass panels",
    TextColor3 = COLORS.Dim,
    TextSize = 16,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    ZIndex = 10
}, SideCard)

local FootCard = Card(AimPage, "FootCard", UDim2.fromOffset(28, 400), UDim2.new(1, -56, 0, 84))
Badge(FootCard, "STATUS")
Create("TextLabel", {
    Position = UDim2.fromOffset(24, 38),
    Size = UDim2.new(1, -48, 0, 28),
    BackgroundTransparency = 1,
    Text = "Interface ready",
    TextColor3 = COLORS.Text,
    TextSize = 18,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 10
}, FootCard)

local WhPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)
local WhCard = Card(WhPage, "WhCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 140))
Badge(WhCard, "VISUALS")
Heading(WhCard, "Display")
CreateToggle(WhCard, "Highlights", 78)

local Drop = Create("TextButton", {
    Position = UDim2.fromOffset(24, 132),
    Size = UDim2.new(1, -48, 0, 20),
    BackgroundTransparency = 1,
    Text = "MORE OPTIONS    v",
    TextColor3 = COLORS.Mute,
    TextSize = 12,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 11
}, WhCard)

local Sub = Create("Frame", {
    Position = UDim2.fromOffset(12, 156),
    Size = UDim2.new(1, -24, 0, 200),
    BackgroundTransparency = 1,
    ZIndex = 10
}, WhCard)
CreateToggle(Sub, "Roles", 0)
CreateToggle(Sub, "Health", 52)
CreateToggle(Sub, "Armor", 104)
CreateToggle(Sub, "Distance", 156)

local opened = false
Drop.Activated:Connect(function()
    opened = not opened
    Drop.Text = opened and "MORE OPTIONS    ^" or "MORE OPTIONS    v"
    Tween(WhCard, { Size = opened and UDim2.new(1, -56, 0, 372) or UDim2.new(1, -56, 0, 140) }, 0.2)
end)

local MovementPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)
local MovementCard = Card(MovementPage, "MoveCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 168))
Badge(MovementCard, "MOVEMENT")
Heading(MovementCard, "Motion")
CreateToggle(MovementCard, "Faster walk", 78)

local OtherPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)
local SettingsPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)

local PlayerPanel = Create("Frame", {
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 16, 1, -16),
    Size = UDim2.new(1, -32, 0, 62),
    BackgroundColor3 = COLORS.Card,
    BorderSizePixel = 0,
    ZIndex = 8
}, Sidebar)
Corner(PlayerPanel, 16)
Stroke(PlayerPanel, COLORS.Line, 0.9, 1)

local Ava = Create("Frame", {
    Position = UDim2.fromOffset(10, 11),
    Size = UDim2.fromOffset(40, 40),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0,
    ZIndex = 9
}, PlayerPanel)
Corner(Ava, 20)
Create("TextLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = string.sub(Player and Player.Name or "P", 1, 1),
    TextColor3 = COLORS.Text,
    TextSize = 18,
    Font = FONT,
    ZIndex = 10
}, Ava)

Create("TextLabel", {
    Position = UDim2.fromOffset(58, 12),
    Size = UDim2.new(1, -68, 0, 20),
    BackgroundTransparency = 1,
    Text = Player and Player.Name or "Player",
    TextColor3 = COLORS.Text,
    TextSize = 13,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
    ZIndex = 9
}, PlayerPanel)

Create("TextLabel", {
    Position = UDim2.fromOffset(58, 32),
    Size = UDim2.new(1, -68, 0, 16),
    BackgroundTransparency = 1,
    Text = "ONLINE",
    TextColor3 = COLORS.Accent2,
    TextSize = 11,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, PlayerPanel)

local MenuItems = {
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
    AimPage.Visible = selected.Page == AimPage
    WhPage.Visible = selected.Page == WhPage
    MovementPage.Visible = selected.Page == MovementPage
    OtherPage.Visible = selected.Page == OtherPage
    SettingsPage.Visible = selected.Page == SettingsPage

    for i, data in ipairs(MenuButtons) do
        local on = i == index
        Tween(data.Button, {
            BackgroundColor3 = on and COLORS.Accent or COLORS.Card,
            BackgroundTransparency = on and 0 or 1
        })
        Tween(data.Label, { TextColor3 = on and COLORS.Text or COLORS.Dim })
        RecolorIcon(data.Icon, on and COLORS.Text or COLORS.Dim)
    end
end

for index, data in ipairs(MenuItems) do
    local button = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundColor3 = COLORS.Card,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = index,
        ZIndex = 8
    }, MenuContainer)
    Corner(button, 14)

    local icon = PaintIcon(button, data.Kind, COLORS.Dim)
    icon.Position = UDim2.fromOffset(14, 13)

    local label = Create("TextLabel", {
        Position = UDim2.fromOffset(46, 0),
        Size = UDim2.new(1, -54, 1, 0),
        BackgroundTransparency = 1,
        Text = data.Name,
        TextColor3 = COLORS.Dim,
        TextSize = 14,
        Font = FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 9
    }, button)

    button.MouseEnter:Connect(function()
        if not data.Page.Visible then
            Tween(button, { BackgroundTransparency = 0.65 })
        end
    end)
    button.MouseLeave:Connect(function()
        if not data.Page.Visible then
            Tween(button, { BackgroundTransparency = 1 })
        end
    end)
    button.Activated:Connect(function()
        SelectTab(index)
    end)

    table.insert(MenuButtons, { Button = button, Icon = icon, Label = label })
end

SelectTab(1)

local cam = workspace.CurrentCamera
local function UpdateScale()
    cam = workspace.CurrentCamera
    if not cam then return end
    local v = cam.ViewportSize
    UIScale.Scale = math.clamp(math.min((v.X - 20) / 1000, (v.Y - 20) / 620), CONFIG.MinScale, CONFIG.MaxScale)
end
UpdateScale()
if cam then cam:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale) end

local dragging, dragStart, startPos = false, nil, nil
local function bindDrag(obj)
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
end
bindDrag(TopBar)
bindDrag(DragButton)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local closed = false
local reopen = Create("TextButton", {
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -22, 1, -22),
    Size = UDim2.fromOffset(54, 54),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0,
    Text = "CJ",
    TextColor3 = COLORS.Text,
    TextSize = 16,
    Font = FONT,
    AutoButtonColor = false,
    Visible = false,
    ZIndex = 100
}, ScreenGui)
Corner(reopen, 18)
Stroke(reopen, COLORS.Line, 0.7, 1)

local rDrag, rStart, rPos, rMoved = false, nil, nil, false
reopen.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        rDrag = true
        rStart = input.Position
        rPos = reopen.Position
        rMoved = false
        reopen.AnchorPoint = Vector2.new(0, 0)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if rDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - rStart
        if d.Magnitude > 5 then rMoved = true end
        reopen.Position = UDim2.new(rPos.X.Scale, rPos.X.Offset + d.X, rPos.Y.Scale, rPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        rDrag = false
    end
end)

CloseButton.Activated:Connect(function()
    if closed then return end
    closed = true
    BackgroundLayer.Visible = false
    Tween(MainFrame, { Size = UDim2.fromOffset(940, 583) }, 0.12)
    task.wait(0.1)
    MainFrame.Visible = false
    reopen.Visible = true
end)

reopen.Activated:Connect(function()
    if rMoved then rMoved = false return end
    closed = false
    BackgroundLayer.Visible = true
    MainFrame.Visible = true
    MainFrame.Size = UDim2.fromOffset(940, 583)
    Tween(MainFrame, { Size = UDim2.fromOffset(1000, 620) }, 0.16)
    reopen.Visible = false
    task.defer(UpdateScale)
end)

print("[CSS JAVA] Redesign loaded | 1000x620 | bold + custom icons")
