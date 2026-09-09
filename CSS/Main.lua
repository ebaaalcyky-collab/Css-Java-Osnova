--// CSS JAVA - Visual redesign
--// Window size locked: 1000 x 620
--// Home + session balance + WH/ESP + SpeedHack + Speed Car (with speed control)

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

--// ROLES & TRANSLATIONS
local ROLE_TRANSLATIONS = {
    ["police"] = "Полиция", ["cop"] = "Полицейский", ["sheriff"] = "Шериф", ["deputy"] = "Помощник шерифа",
    ["border patrol"] = "Погранслужба", ["border"] = "Пограничник", ["military"] = "Военный", ["army"] = "Армия",
    ["swat"] = "Спецназ", ["fbi"] = "ФБР", ["civilian"] = "Гражданский", ["civ"] = "Гражданский", ["citizen"] = "Житель",
    ["criminal"] = "Преступник", ["illegal"] = "Нелегал", ["rebel"] = "Повстанец", ["cartel"] = "Картель",
    ["mafia"] = "Мафия", ["gang"] = "Бандит", ["prisoner"] = "Заключенный", ["guard"] = "Охранник",
    ["doctor"] = "Врач", ["medic"] = "Медик", ["firefighter"] = "Пожарный", ["neutral"] = "Нейтрал"
}

local function GetRussianRole(plr)
    local rawRole = plr.Team and plr.Team.Name or ""
    if rawRole == "" or rawRole == "Choosing" then
        local ls = plr:FindFirstChild("leaderstats")
        if ls then
            local roleVal = ls:FindFirstChild("Role") or ls:FindFirstChild("Team") or ls:FindFirstChild("Job")
            if roleVal then rawRole = tostring(roleVal.Value) end
        end
    end
    if rawRole == "" then return "Игрок" end
    local lower = string.lower(rawRole)
    for key, ru in pairs(ROLE_TRANSLATIONS) do
        if string.find(lower, key) then return ru end
    end
    return rawRole
end

local function AddCorner(parent, radius)
    return Create("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
end

local function CreateToggle(parent, text, yOffset, callback)
    local Row = Create("Frame", {
        Name = text .. "Row",
        Position = UDim2.fromOffset(20, yOffset),
        Size = UDim2.new(1, -40, 0, 44),
        BackgroundTransparency = 1,
        ZIndex = 10
    }, parent)

    Create("TextLabel", {
        Name = "Label",
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(1, -90, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.Text,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        ZIndex = 11
    }, Row)

    local Toggle = Create("TextButton", {
        Name = "Toggle",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.fromOffset(56, 30),
        BackgroundColor3 = COLORS.ToggleOff,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 11
    }, Row)

    AddCorner(Toggle, 15)

    local Circle = Create("Frame", {
        Name = "Circle",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 4, 0.5, 0),
        Size = UDim2.fromOffset(22, 22),
        BackgroundColor3 = COLORS.SecondaryText,
        BorderSizePixel = 0,
        ZIndex = 12
    }, Toggle)

    AddCorner(Circle, 11)

    local State = false

    local function SetState(value)
        State = value
        if State then
            Tween(Toggle, { BackgroundColor3 = COLORS.ToggleOn })
            Tween(Circle, { Position = UDim2.new(1, -26, 0.5, 0), BackgroundColor3 = COLORS.White })
        else
            Tween(Toggle, { BackgroundColor3 = COLORS.ToggleOff })
            Tween(Circle, { Position = UDim2.new(0, 4, 0.5, 0), BackgroundColor3 = COLORS.SecondaryText })
        end
        if callback then callback(State) end
    end

    Toggle.Activated:Connect(function()
        SetState(not State)
    end)

    return Row
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

--// BACKGROUND & GLOWS
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
    BackgroundTransparency = 0.38,
    BorderSizePixel = 0,
    ZIndex = 1
}, BackgroundLayer)

--// MINI HUD
local MiniHud = Create("Frame", {
    Name = "MiniHud",
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -70, 1, -24),
    Size = UDim2.fromOffset(92, 40),
    BackgroundColor3 = COLORS.Card,
    BackgroundTransparency = 0.12,
    BorderSizePixel = 0,
    Visible = false,
    ZIndex = 99
}, ScreenGui)

Corner(MiniHud, 12)
Stroke(MiniHud, COLORS.Accent, 0.55, 1)

local MiniFps = Create("TextLabel", {
    Position = UDim2.fromOffset(8, 2),
    Size = UDim2.new(1, -12, 0, 18),
    BackgroundTransparency = 1,
    Text = "FPS --",
    TextColor3 = COLORS.Text,
    TextSize = 11,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 100
}, MiniHud)

local MiniPing = Create("TextLabel", {
    Position = UDim2.fromOffset(8, 18),
    Size = UDim2.new(1, -12, 0, 18),
    BackgroundTransparency = 1,
    Text = "PING --",
    TextColor3 = COLORS.Dim,
    TextSize = 11,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 100
}, MiniHud)

--// MAIN WINDOW
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

--// SIDEBAR
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

local LogoMark = Create("ImageLabel", {
    Size = UDim2.fromOffset(42, 42),
    Position = UDim2.fromOffset(0, 6),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 7
}, Brand)
Corner(LogoMark, 13)

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
    Corner(c, 18)
    Stroke(c, COLORS.Line, 0.9, 1)
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

--// 1) HOME PAGE
local HomePage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = true }, PagesFolder)
local ProfileCard = Card(HomePage, "ProfileCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 148))
local Avatar = Create("ImageLabel", {
    Position = UDim2.fromOffset(18, 18), Size = UDim2.fromOffset(112, 112),
    BackgroundColor3 = COLORS.CardInner, BorderSizePixel = 0, ScaleType = Enum.ScaleType.Crop, ZIndex = 10
}, ProfileCard)
Corner(Avatar, 22)
Stroke(Avatar, COLORS.Accent, 0.25, 2)

Create("TextLabel", { Position = UDim2.fromOffset(148, 28), Size = UDim2.new(1, -168, 0, 18), BackgroundTransparency = 1, Text = "HOME", TextColor3 = COLORS.Accent2, TextSize = 12, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 }, ProfileCard)
Create("TextLabel", { Position = UDim2.fromOffset(148, 50), Size = UDim2.new(1, -168, 0, 32), BackgroundTransparency = 1, Text = Player and Player.Name or "Player", TextColor3 = COLORS.Text, TextSize = 22, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 }, ProfileCard)
Create("TextLabel", { Position = UDim2.fromOffset(148, 86), Size = UDim2.new(1, -168, 0, 20), BackgroundTransparency = 1, Text = "ID " .. tostring(Player and Player.UserId or 0), TextColor3 = COLORS.Dim, TextSize = 13, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 }, ProfileCard)

local StatsCard = Card(HomePage, "StatsCard", UDim2.fromOffset(28, 256), UDim2.new(1, -56, 0, 228))
Badge(StatsCard, "LIVE")
Heading(StatsCard, "Session")
local GameValue = StatLine(StatsCard, 72, "Game")
local FpsValue = StatLine(StatsCard, 122, "FPS")
local PingValue = StatLine(StatsCard, 172, "Ping")

--// 2) AIM PAGE
local AimPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)
local AimCard = Card(AimPage, "AimCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 392))
Badge(AimCard, "AIM")
Heading(AimCard, "Targeting")

--// 3) VISUALS PAGE (WH)
local WhPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)
local WhCard = Card(WhPage, "WhCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 130))
Badge(WhCard, "VISUALS")
Heading(WhCard, "Display")

local ESP_SETTINGS = { Enabled = false, Roles = true, Health = true, Armor = true, Distance = true }

CreateToggle(WhCard, "Wh", 60, function(state) ESP_SETTINGS.Enabled = state end)

local DropdownButton = Create("TextButton", {
    Position = UDim2.fromOffset(20, 104), Size = UDim2.new(1, -40, 0, 20),
    BackgroundTransparency = 1, Text = "▼", TextColor3 = COLORS.SecondaryText, TextSize = 12, Font = Enum.Font.GothamBold, ZIndex = 11
}, WhCard)

local isDropdownOpen = false
DropdownButton.Activated:Connect(function()
    isDropdownOpen = not isDropdownOpen
    if isDropdownOpen then
        DropdownButton.Text = "▲"
        Tween(WhCard, { Size = UDim2.new(1, -56, 0, 350) })
    else
        DropdownButton.Text = "▼"
        Tween(WhCard, { Size = UDim2.new(1, -56, 0, 130) })
    end
end)

local SubContainer = Create("Frame", { Position = UDim2.fromOffset(0, 125), Size = UDim2.new(1, 0, 0, 210), BackgroundTransparency = 1, ZIndex = 10 }, WhCard)
CreateToggle(SubContainer, "Roles", 0, function(state) ESP_SETTINGS.Roles = state end)
CreateToggle(SubContainer, "Health Bar", 50, function(state) ESP_SETTINGS.Health = state end)
CreateToggle(SubContainer, "Armor Bar", 100, function(state) ESP_SETTINGS.Armor = state end)
CreateToggle(SubContainer, "Distance", 150, function(state) ESP_SETTINGS.Distance = state end)

-- ESP LOGIC
local function ClearEsp(targetPlayer)
    if targetPlayer and targetPlayer.Character then
        local oldGui = targetPlayer.Character:FindFirstChild("CSS_ESP_GUI")
        if oldGui then oldGui:Destroy() end
        local oldHl = targetPlayer.Character:FindFirstChild("CSS_ESP_HL")
        if oldHl then oldHl:Destroy() end
    end
end

local function CreateEspForPlayer(plr)
    if plr == Player then return end
    local function ApplyEsp(character)
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        ClearEsp(plr)

        local hl = Instance.new("Highlight")
        hl.Name = "CSS_ESP_HL"
        hl.Adornee = character
        hl.FillColor = COLORS.Accent
        hl.FillTransparency = 0.6
        hl.OutlineColor = COLORS.White
        hl.OutlineTransparency = 0.1
        hl.Enabled = false
        hl.Parent = character

        local bb = Instance.new("BillboardGui")
        bb.Name = "CSS_ESP_GUI"
        bb.Adornee = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
        bb.Size = UDim2.fromOffset(160, 70)
        bb.StudsOffset = Vector3.new(0, 3.2, 0)
        bb.AlwaysOnTop = true
        bb.Enabled = false

        local container = Instance.new("Frame")
        container.Name = "Container"
        container.Size = UDim2.fromScale(1, 1)
        container.BackgroundTransparency = 1
        container.Parent = bb

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(1, 0, 0, 16)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = plr.Name
        nameLabel.TextColor3 = COLORS.White
        nameLabel.TextSize = 13
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Parent = container

        local roleLabel = Instance.new("TextLabel")
        roleLabel.Name = "RoleLabel"
        roleLabel.Size = UDim2.new(1, 0, 0, 14)
        roleLabel.Position = UDim2.fromOffset(0, 16)
        roleLabel.BackgroundTransparency = 1
        roleLabel.Text = "[" .. GetRussianRole(plr) .. "]"
        roleLabel.TextColor3 = COLORS.Accent
        roleLabel.TextSize = 11
        roleLabel.Font = Enum.Font.GothamMedium
        roleLabel.Parent = container

        local statsLabel = Instance.new("TextLabel")
        statsLabel.Name = "StatsLabel"
        statsLabel.Size = UDim2.new(1, 0, 0, 14)
        statsLabel.Position = UDim2.fromOffset(0, 30)
        statsLabel.BackgroundTransparency = 1
        statsLabel.Text = "HP: 100 | AP: 0"
        statsLabel.TextColor3 = COLORS.Health
        statsLabel.TextSize = 10
        statsLabel.Font = Enum.Font.GothamBold
        statsLabel.Parent = container

        local distLabel = Instance.new("TextLabel")
        distLabel.Name = "DistLabel"
        distLabel.Size = UDim2.new(1, 0, 0, 14)
        distLabel.Position = UDim2.fromOffset(0, 44)
        distLabel.BackgroundTransparency = 1
        distLabel.Text = "0 m"
        distLabel.TextColor3 = COLORS.SecondaryText
        distLabel.TextSize = 10
        distLabel.Font = Enum.Font.Gotham
        distLabel.Parent = container

        bb.Parent = character
    end

    if plr.Character then ApplyEsp(plr.Character) end
    plr.CharacterAdded:Connect(ApplyEsp)
end

RunService.RenderStepped:Connect(function()
    if not ESP_SETTINGS.Enabled then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                local gui = plr.Character:FindFirstChild("CSS_ESP_GUI")
                local hl = plr.Character:FindFirstChild("CSS_ESP_HL")
                if gui then gui.Enabled = false end
                if hl then hl.Enabled = false end
            end
        end
        return
    end

    local myHrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local char = plr.Character
            local hrp = char.HumanoidRootPart
            local gui = char:FindFirstChild("CSS_ESP_GUI")
            local hl = char:FindFirstChild("CSS_ESP_HL")

            if not gui or not hl then
                CreateEspForPlayer(plr)
                gui = char:FindFirstChild("CSS_ESP_GUI")
                hl = char:FindFirstChild("CSS_ESP_HL")
            end

            if myHrp and gui and hl then
                local distance = (myHrp.Position - hrp.Position).Magnitude
                if distance <= CONFIG.MaxEspDistance then
                    gui.Enabled = true
                    hl.Enabled = true
                    local container = gui:FindFirstChild("Container")
                    if container then
                        local roleLbl = container:FindFirstChild("RoleLabel")
                        local statsLbl = container:FindFirstChild("StatsLabel")
                        local distLbl = container:FindFirstChild("DistLabel")

                        if roleLbl then
                            roleLbl.Visible = ESP_SETTINGS.Roles
                            roleLbl.Text = "[" .. GetRussianRole(plr) .. "]"
                        end

                        if statsLbl then
                            local humanoid = char:FindFirstChildOfClass("Humanoid")
                            local hp = humanoid and math.floor(humanoid.Health) or 0
                            local armor = 0
                            local ls = plr:FindFirstChild("leaderstats")
                            if ls and ls:FindFirstChild("Armor") then armor = math.floor(ls.Armor.Value) end

                            local textParts = {}
                            if ESP_SETTINGS.Health then table.insert(textParts, "HP: " .. hp) end
                            if ESP_SETTINGS.Armor then table.insert(textParts, "AP: " .. armor) end

                            statsLbl.Text = table.concat(textParts, " | ")
                            statsLbl.Visible = (ESP_SETTINGS.Health or ESP_SETTINGS.Armor)
                        end

                        if distLbl then
                            distLbl.Visible = ESP_SETTINGS.Distance
                            distLbl.Text = math.floor(distance) .. " m"
                        end
                    end
                else
                    gui.Enabled = false
                    hl.Enabled = false
                end
            end
        end
    end
end)

--// 4) MOVEMENT PAGE
local MovementPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)
local MovementCard = Card(MovementPage, "MoveCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 235))
Badge(MovementCard, "MOVEMENT")
Heading(MovementCard, "Motion")

-- SPEED-HACK (WALKSPEED)
local speedHackEnabled = false
RunService.RenderStepped:Connect(function()
    if speedHackEnabled then
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = 33 end
    end
end)

CreateToggle(MovementCard, "speed-hack", 68, function(state)
    speedHackEnabled = state
    if not state then
        local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = 16 end
    end
end)

-- SPEED CAR + REGULATION
local carSpeedMultiplier = 2
local speedCarEnabled = false
local boostedSeats = {}

local function updateSeatSpeed(seat)
    if not seat:IsA("VehicleSeat") then return end
    if not boostedSeats[seat] then boostedSeats[seat] = seat.MaxSpeed end
    pcall(function()
        seat.MaxSpeed = speedCarEnabled and (boostedSeats[seat] * carSpeedMultiplier) or boostedSeats[seat]
    end)
end

local function applySpeedCarToAll()
    for _, object in ipairs(workspace:GetDescendants()) do
        if object:IsA("VehicleSeat") then updateSeatSpeed(object) end
    end
end

CreateToggle(MovementCard, "speed car", 120, function(state)
    speedCarEnabled = state
    applySpeedCarToAll()
end)

local CarSpeedControlRow = Create("Frame", {
    Name = "CarSpeedControlRow",
    Position = UDim2.fromOffset(20, 172),
    Size = UDim2.new(1, -40, 0, 44),
    BackgroundTransparency = 1,
    ZIndex = 10
}, MovementCard)

Create("TextLabel", {
    Position = UDim2.fromOffset(0, 0), Size = UDim2.new(1, -140, 1, 0),
    BackgroundTransparency = 1, Text = "Car Multiplier", TextColor3 = COLORS.Dim, TextSize = 12, Font = Enum.Font.GothamMedium, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 11
}, CarSpeedControlRow)

local MultiplierDisplay = Create("TextLabel", {
    Position = UDim2.new(1, -135, 0, 7), Size = UDim2.fromOffset(45, 30),
    BackgroundColor3 = COLORS.CardInner, Text = "x" .. tostring(carSpeedMultiplier), TextColor3 = COLORS.Text, TextSize = 13, Font = Enum.Font.GothamBold, ZIndex = 11
}, CarSpeedControlRow)
Corner(MultiplierDisplay, 8)

local BtnMinus = Create("TextButton", {
    Position = UDim2.new(1, -85, 0, 7), Size = UDim2.fromOffset(38, 30),
    BackgroundColor3 = COLORS.CardInner, Text = "-", TextColor3 = COLORS.Minus, TextSize = 16, Font = Enum.Font.GothamBold, ZIndex = 11
}, CarSpeedControlRow)
Corner(BtnMinus, 8)

local BtnPlus = Create("TextButton", {
    Position = UDim2.new(1, -42, 0, 7), Size = UDim2.fromOffset(38, 30),
    BackgroundColor3 = COLORS.CardInner, Text = "+", TextColor3 = COLORS.Plus, TextSize = 16, Font = Enum.Font.GothamBold, ZIndex = 11
}, CarSpeedControlRow)
Corner(BtnPlus, 8)

BtnMinus.Activated:Connect(function()
    if carSpeedMultiplier > 1 then
        carSpeedMultiplier = carSpeedMultiplier - 1
        MultiplierDisplay.Text = "x" .. tostring(carSpeedMultiplier)
        if speedCarEnabled then applySpeedCarToAll() end
    end
end)

BtnPlus.Activated:Connect(function()
    if carSpeedMultiplier < 10 then
        carSpeedMultiplier = carSpeedMultiplier + 1
        MultiplierDisplay.Text = "x" .. tostring(carSpeedMultiplier)
        if speedCarEnabled then applySpeedCarToAll() end
    end
end)

--// 5) OTHER & BALANCE PAGE
local OtherPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)

local function BigStatCard(parent, pos, size, badge, title)
    local card = Card(parent, badge .. "Card", pos, size)
    Badge(card, badge)
    Heading(card, title)

    local session = Create("TextLabel", {
        Position = UDim2.fromOffset(24, 72), Size = UDim2.new(1, -48, 0, 64),
        BackgroundTransparency = 1, Text = "0", TextColor3 = COLORS.Text, TextSize = 36, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10
    }, card)

    local startL = StatLine(card, 168, "Start")
    local nowL = StatLine(card, 222, "Now")
    return startL, nowL, session
end

local StartValue, NowValue, DiffValue = BigStatCard(OtherPage, UDim2.fromOffset(28, 92), UDim2.new(0.5, -36, 0, 392), "MONEY", "Cash")
local XpStartValue, XpNowValue, XpDiffValue = BigStatCard(OtherPage, UDim2.new(0.5, 8, 0, 92), UDim2.new(0.5, -36, 0, 392), "XP", "Experience")

--// 6) SETTINGS PAGE
local SettingsPage = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false }, PagesFolder)

--// MENU TAB SWITCHING
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
        Size = UDim2.new(1, 0, 0, 44), BackgroundColor3 = COLORS.Card, BackgroundTransparency = 1,
        BorderSizePixel = 0, Text = "", AutoButtonColor = false, LayoutOrder = index, ZIndex = 8
    }, MenuContainer)
    Corner(button, 14)

    local icon = PaintIcon(button, data.Kind, COLORS.Dim)
    icon.Position = UDim2.fromOffset(14, 11)

    local label = Create("TextLabel", {
        Position = UDim2.fromOffset(46, 0), Size = UDim2.new(1, -54, 1, 0),
        BackgroundTransparency = 1, Text = data.Name, TextColor3 = COLORS.Dim, TextSize = 13, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9
    }, button)

    button.Activated:Connect(function() SelectTab(index) end)
    table.insert(MenuButtons, { Button = button, Icon = icon, Label = label })
end

SelectTab(1)

--// DRAG & CLOSE
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
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

CloseButton.Activated:Connect(function()
    MainFrame.Visible = false
    BackgroundLayer.Visible = false
    MiniHud.Visible = true
end)

print("[CSS JAVA] All features successfully active and visible!")
