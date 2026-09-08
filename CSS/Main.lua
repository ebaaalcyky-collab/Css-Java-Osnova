--// CSS JAVA - Visual redesign
--// Window size locked: 1000 x 620
--// Home + session balance + cleaned Aim tab

local RAW_BASE = "https://raw.githubusercontent.com/ebaaalcyky-collab/Css-Java-Osnova/main/assets/"

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local MarketplaceService = game:GetService("MarketplaceService")
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
    Off = Color3.fromRGB(40, 44, 58),
    Plus = Color3.fromRGB(80, 220, 140),
    Minus = Color3.fromRGB(255, 92, 108)
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

    if kind == "home" then
        Pixel(box, UDim2.fromOffset(3, 11), UDim2.fromOffset(16, 9), color, 13)
        local roof = Create("Frame", {
            Position = UDim2.fromOffset(2, 6),
            Size = UDim2.fromOffset(18, 8),
            Rotation = 45,
            BackgroundColor3 = color,
            BorderSizePixel = 0,
            ZIndex = 12
        }, box)
        Corner(roof, 2)
        Pixel(box, UDim2.fromOffset(9, 13), UDim2.fromOffset(4, 7), COLORS.Side, 14)
    elseif kind == "aim" then
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
    Position = UDim2.fromOffset(16, 96),
    Size = UDim2.new(1, -32, 0, 360),
    BackgroundTransparency = 1,
    ZIndex = 7
}, Sidebar)
Create("UIListLayout", {
    Padding = UDim.new(0, 7),
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
    Text = "Home",
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
    Text = "SESSION",
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

local function StatLine(parent, y, labelText)
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
        Size = UDim2.new(0.4, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = labelText,
        TextColor3 = COLORS.Dim,
        TextSize = 13,
        Font = FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 11
    }, row)

    local value = Create("TextLabel", {
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(1, -14, 1, 0),
        BackgroundTransparency = 1,
        Text = "—",
        TextColor3 = COLORS.Text,
        TextSize = 14,
        Font = FONT,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 11
    }, row)

    return value
end

-- HOME
local HomePage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = true,
    ZIndex = 4
}, PagesFolder)

local ProfileCard = Card(HomePage, "ProfileCard", UDim2.fromOffset(28, 92), UDim2.new(0.42, -36, 0, 392))
Badge(ProfileCard, "PLAYER")
Heading(ProfileCard, "Profile")

local Avatar = Create("ImageLabel", {
    Position = UDim2.fromOffset(24, 78),
    Size = UDim2.fromOffset(96, 96),
    BackgroundColor3 = COLORS.CardInner,
    BorderSizePixel = 0,
    Image = "",
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 10
}, ProfileCard)
Corner(Avatar, 18)
Stroke(Avatar, COLORS.Accent, 0.45, 1)

local HomeName = Create("TextLabel", {
    Position = UDim2.fromOffset(24, 186),
    Size = UDim2.new(1, -48, 0, 28),
    BackgroundTransparency = 1,
    Text = Player and Player.Name or "Player",
    TextColor3 = COLORS.Text,
    TextSize = 18,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
    ZIndex = 10
}, ProfileCard)

local HomeId = Create("TextLabel", {
    Position = UDim2.fromOffset(24, 214),
    Size = UDim2.new(1, -48, 0, 20),
    BackgroundTransparency = 1,
    Text = "ID " .. tostring(Player and Player.UserId or 0),
    TextColor3 = COLORS.Mute,
    TextSize = 12,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 10
}, ProfileCard)

local StatsCard = Card(HomePage, "StatsCard", UDim2.new(0.42, 8, 0, 92), UDim2.new(0.58, -36, 0, 392))
Badge(StatsCard, "SESSION")
Heading(StatsCard, "Live info")

local GameValue = StatLine(StatsCard, 78, "Game")
local FpsValue = StatLine(StatsCard, 132, "FPS")
local PingValue = StatLine(StatsCard, 186, "Ping")
local PlaceValue = StatLine(StatsCard, 240, "Place")

-- AIM cleaned
local AimPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)
local AimCard = Card(AimPage, "AimCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 392))
Badge(AimCard, "AIM")
Heading(AimCard, "Targeting")
Create("TextLabel", {
    Position = UDim2.fromOffset(24, 78),
    Size = UDim2.new(1, -48, 0, 80),
    BackgroundTransparency = 1,
    Text = "This tab is empty for now.",
    TextColor3 = COLORS.Dim,
    TextSize = 16,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    ZIndex = 10
}, AimCard)

-- WH placeholder page kept
local WhPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)
local WhCard = Card(WhPage, "WhCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 140))
Badge(WhCard, "VISUALS")
Heading(WhCard, "Display")

-- MOVEMENT placeholder
local MovementPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)
local MovementCard = Card(MovementPage, "MoveCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 140))
Badge(MovementCard, "MOVEMENT")
Heading(MovementCard, "Motion")

-- OTHER + balance
local OtherPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)

local BalanceCard = Card(OtherPage, "BalanceCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 392))
Badge(BalanceCard, "MONEY")
Heading(BalanceCard, "Balance info")

local StartValue = StatLine(BalanceCard, 78, "Started")
local NowValue = StatLine(BalanceCard, 132, "Now")
local DiffValue = StatLine(BalanceCard, 186, "Session")
local SourceValue = StatLine(BalanceCard, 240, "Source")

local SettingsPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false
}, PagesFolder)

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

local MiniAva = Create("ImageLabel", {
    Position = UDim2.fromOffset(10, 11),
    Size = UDim2.fromOffset(40, 40),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0,
    Image = "",
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 9
}, PlayerPanel)
Corner(MiniAva, 20)

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
    HomePage.Visible = selected.Page == HomePage
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
        Size = UDim2.new(1, 0, 0, 44),
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
    icon.Position = UDim2.fromOffset(14, 11)

    local label = Create("TextLabel", {
        Position = UDim2.fromOffset(46, 0),
        Size = UDim2.new(1, -54, 1, 0),
        BackgroundTransparency = 1,
        Text = data.Name,
        TextColor3 = COLORS.Dim,
        TextSize = 13,
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

-- Avatar
task.spawn(function()
    local ok, url = pcall(function()
        return Players:GetUserThumbnailAsync(
            Player.UserId,
            Enum.ThumbnailType.HeadShot,
            Enum.ThumbnailSize.Size150x150
        )
    end)
    if ok and url then
        Avatar.Image = url
        MiniAva.Image = url
    end
end)

-- Game name
task.spawn(function()
    PlaceValue.Text = tostring(game.PlaceId)
    local ok, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if ok and info and info.Name then
        GameValue.Text = info.Name
    else
        GameValue.Text = game.Name
    end
end)

-- FPS / ping
local fpsAcc, fpsFrames = 0, 0
RunService.RenderStepped:Connect(function(dt)
    fpsAcc += dt
    fpsFrames += 1
    if fpsAcc >= 0.25 then
        FpsValue.Text = tostring(math.floor(fpsFrames / fpsAcc + 0.5))
        fpsAcc = 0
        fpsFrames = 0
    end

    local ping = 0
    local okPing, result = pcall(function()
        return math.floor(Player:GetNetworkPing() * 1000 + 0.5)
    end)
    if okPing and typeof(result) == "number" then
        ping = result
    else
        pcall(function()
            local item = Stats.Network.ServerStatsItem["Data Ping"]
            if item then
                ping = math.floor(item:GetValue() + 0.5)
            end
        end)
    end
    PingValue.Text = ping .. " ms"
end)

-- Money session tracker
local MONEY_NAMES = {
    "Cash", "Money", "Dollars", "Dollar", "Balance", "Bank",
    "Wallet", "Coins", "Gold", "Dough", "Currency", "MoneyValue"
}

local function isMoneyName(name)
    local lower = string.lower(name)
    for _, key in ipairs(MONEY_NAMES) do
        if lower == string.lower(key) or string.find(lower, string.lower(key), 1, true) then
            return true
        end
    end
    return false
end

local function readNumber(obj)
    if not obj then return nil end
    if obj:IsA("IntValue") or obj:IsA("NumberValue") or obj:IsA("DoubleConstrainedValue") or obj:IsA("IntConstrainedValue") then
        return tonumber(obj.Value)
    end
    if obj:IsA("StringValue") then
        local n = tonumber((tostring(obj.Value):gsub("[^0-9%-%.]", "")))
        return n
    end
    return nil
end

local function findMoney()
    local best, source = nil, nil
    local function consider(obj, label)
        local n = readNumber(obj)
        if n ~= nil then
            best = n
            source = label
        end
    end

    local ls = Player:FindFirstChild("leaderstats")
    if ls then
        for _, child in ipairs(ls:GetChildren()) do
            if isMoneyName(child.Name) then
                consider(child, "leaderstats." .. child.Name)
            end
        end
        if not source then
            for _, child in ipairs(ls:GetChildren()) do
                if readNumber(child) ~= nil then
                    consider(child, "leaderstats." .. child.Name)
                end
            end
        end
    end

    if not source then
        for _, child in ipairs(Player:GetChildren()) do
            if isMoneyName(child.Name) then
                consider(child, "player." .. child.Name)
            end
        end
    end

    return best, source
end

local startMoney = nil
local lastSource = "—"

local function formatMoney(n)
    n = math.floor(n + 0.5)
    local sign = n < 0 and "-" or ""
    local s = tostring(math.abs(n))
    local out = s
    while true do
        local nexts, count = string.gsub(out, "^(-?%d+)(%d%d%d)", "%1 %2")
        out = nexts
        if count == 0 then break end
    end
    return sign .. out
end

task.spawn(function()
    while true do
        local now, source = findMoney()
        if now ~= nil then
            if startMoney == nil then
                startMoney = now
            end
            lastSource = source or "—"
            local diff = now - startMoney

            StartValue.Text = formatMoney(startMoney) .. "$"
            NowValue.Text = formatMoney(now) .. "$"
            SourceValue.Text = lastSource

            if diff > 0 then
                DiffValue.Text = "+" .. formatMoney(diff) .. "$"
                DiffValue.TextColor3 = COLORS.Plus
            elseif diff < 0 then
                DiffValue.Text = "-" .. formatMoney(math.abs(diff)) .. "$"
                DiffValue.TextColor3 = COLORS.Minus
            else
                DiffValue.Text = "0$"
                DiffValue.TextColor3 = COLORS.Text
            end
        else
            StartValue.Text = "—"
            NowValue.Text = "—"
            DiffValue.Text = "waiting"
            DiffValue.TextColor3 = COLORS.Mute
            SourceValue.Text = "not found"
        end
        task.wait(0.25)
    end
end)

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

print("[CSS JAVA] Home + session balance loaded")
