--// CSS JAVA - Visual redesign
--// Window size locked: 800 x 500
--// Home + session balance + cleaned Aim tab
--// WH / ESP + Speed Hack added from previous version

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
    WindowSize = Vector2.new(800, 500),
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

    --// Compatibility colors for the old WH / speed-hack function
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

--//==================================================
--// TRANSLATIONS
--//==================================================

local ROLE_TRANSLATIONS = {
    ["police"] = "Полиция",
    ["cop"] = "Полицейский",
    ["sheriff"] = "Шериф",
    ["deputy"] = "Помощник шерифа",
    ["border patrol"] = "Погранслужба",
    ["border"] = "Пограничник",
    ["military"] = "Военный",
    ["army"] = "Армия",
    ["swat"] = "Спецназ",
    ["fbi"] = "ФБР",
    ["civilian"] = "Гражданский",
    ["civ"] = "Гражданский",
    ["citizen"] = "Житель",
    ["criminal"] = "Преступник",
    ["illegal"] = "Нелегал",
    ["rebel"] = "Повстанец",
    ["cartel"] = "Картель",
    ["mafia"] = "Мафия",
    ["gang"] = "Бандит",
    ["prisoner"] = "Заключенный",
    ["guard"] = "Охранник",
    ["doctor"] = "Врач",
    ["medic"] = "Медик",
    ["firefighter"] = "Пожарный",
    ["neutral"] = "Нейтрал"
}

local function GetRussianRole(plr)
    local rawRole = ""
    
    if plr.Team then
        rawRole = plr.Team.Name
    end
    
    if rawRole == "" or rawRole == "Choosing" then
        local ls = plr:FindFirstChild("leaderstats")
        if ls then
            local roleVal = ls:FindFirstChild("Role") or ls:FindFirstChild("Team") or ls:FindFirstChild("Job")
            if roleVal then
                rawRole = tostring(roleVal.Value)
            end
        end
    end
    
    if rawRole == "" then
        return "Игрок"
    end
    
    local lower = string.lower(rawRole)
    for key, ru in pairs(ROLE_TRANSLATIONS) do
        if string.find(lower, key) then
            return ru
        end
    end
    
    return rawRole
end

--//==================================================
--// OLD TOGGLE FUNCTION
--//==================================================

local function AddCorner(parent, radius)
    return Create("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, parent)
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

        if callback then
            callback(State)
        end
    end

    Toggle.Activated:Connect(function()
        SetState(not State)
    end)

    return Row
end

--//==================================================
--// GUI RESET
--//==================================================

pcall(function()
    local old = CoreGui:FindFirstChild("CSS_JAVA_GUI")
    if old then
        old:Destroy()
    end
end)

local ScreenGui = Create("ScreenGui", {
    Name = "CSS_JAVA_GUI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999
}, CoreGui)

--//==================================================
--// FULL SCREEN BACKGROUND
--//==================================================

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

local GlowA = Create("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.18, 0.22),
    Size = UDim2.fromOffset(280, 280),
    BackgroundColor3 = COLORS.Accent,
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    ZIndex = 1
}, BackgroundLayer)
Corner(GlowA, 140)

local GlowB = Create("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.84, 0.78),
    Size = UDim2.fromOffset(240, 240),
    BackgroundColor3 = COLORS.Accent2,
    BackgroundTransparency = 0.9,
    BorderSizePixel = 0,
    ZIndex = 1
}, BackgroundLayer)
Corner(GlowB, 120)

task.spawn(function()
    while GlowA.Parent do
        Tween(GlowA, {
            Position = UDim2.fromScale(0.22, 0.28),
            BackgroundTransparency = 0.84
        }, 2.4)

        Tween(GlowB, {
            Position = UDim2.fromScale(0.78, 0.72),
            BackgroundTransparency = 0.86
        }, 2.4)

        task.wait(2.5)

        Tween(GlowA, {
            Position = UDim2.fromScale(0.16, 0.20),
            BackgroundTransparency = 0.9
        }, 2.4)

        Tween(GlowB, {
            Position = UDim2.fromScale(0.86, 0.80),
            BackgroundTransparency = 0.92
        }, 2.4)

        task.wait(2.5)
    end
end)

--//==================================================
--// MINI HUD
--//==================================================

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

--//==================================================
--// MAIN WINDOW
--//==================================================

local UIScale = Create("UIScale", {
    Scale = 1
})

local MainFrame = Create("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(800, 500),
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

--//==================================================
--// SIDEBAR
--//==================================================

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
    Image = "",
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 7
}, Brand)

Corner(LogoMark, 13)

Create("TextLabel", {
    Name = "LogoFallback",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = "",
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

--//==================================================
--// HEADER BUTTONS
--//==================================================

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

--//==================================================
--// PAGES
--//==================================================

local PagesFolder = Create("Folder", {
    Name = "Pages"
}, Content)

--//==================================================
--// HOME
--//==================================================

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

local HomePage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = true,
    ZIndex = 4
}, PagesFolder)

local ProfileCard = Card(
    HomePage,
    "ProfileCard",
    UDim2.fromOffset(28, 92),
    UDim2.new(1, -56, 0, 148)
)

local Avatar = Create("ImageLabel", {
    Position = UDim2.fromOffset(18, 18),
    Size = UDim2.fromOffset(112, 112),
    BackgroundColor3 = COLORS.CardInner,
    BorderSizePixel = 0,
    Image = "",
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 10
}, ProfileCard)

Corner(Avatar, 22)
Stroke(Avatar, COLORS.Accent, 0.25, 2)

Create("TextLabel", {
    Position = UDim2.fromOffset(148, 28),
    Size = UDim2.new(1, -168, 0, 18),
    BackgroundTransparency = 1,
    Text = "HOME",
    TextColor3 = COLORS.Accent2,
    TextSize = 12,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 10
}, ProfileCard)

local HomeName = Create("TextLabel", {
    Position = UDim2.fromOffset(148, 50),
    Size = UDim2.new(1, -168, 0, 32),
    BackgroundTransparency = 1,
    Text = Player and Player.Name or "Player",
    TextColor3 = COLORS.Text,
    TextSize = 22,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
    ZIndex = 10
}, ProfileCard)

local HomeId = Create("TextLabel", {
    Position = UDim2.fromOffset(148, 86),
    Size = UDim2.new(1, -168, 0, 20),
    BackgroundTransparency = 1,
    Text = "ID " .. tostring(Player and Player.UserId or 0),
    TextColor3 = COLORS.Dim,
    TextSize = 13,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 10
}, ProfileCard)

local StatsCard = Card(
    HomePage,
    "StatsCard",
    UDim2.fromOffset(28, 256),
    UDim2.new(1, -56, 0, 228)
)

Badge(StatsCard, "LIVE")
Heading(StatsCard, "Session")

local GameValue = StatLine(StatsCard, 72, "Game")
local FpsValue = StatLine(StatsCard, 122, "FPS")
local PingValue = StatLine(StatsCard, 172, "Ping")

--//==================================================
--// AIM
--//==================================================

local AimPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)

local AimCard = Card(
    AimPage,
    "AimCard",
    UDim2.fromOffset(28, 92),
    UDim2.new(1, -56, 0, 392)
)

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

--//==================================================
--// WH / VISUALS
--//==================================================

local WhPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)

local WhCard = Card(
    WhPage,
    "WhCard",
    UDim2.fromOffset(28, 92),
    UDim2.new(1, -56, 0, 130)
)

Badge(WhCard, "VISUALS")
Heading(WhCard, "Display")

--// ESP SETTINGS STATE

local ESP_SETTINGS = {
    Enabled = false,
    Roles = true,
    Health = true,
    Armor = true,
    Distance = true
}

--// MAIN ESP TOGGLE

CreateToggle(WhCard, "Wh", 60, function(state)
    ESP_SETTINGS.Enabled = state
end)

--// DROPDOWN ARROW BUTTON

local DropdownButton = Create("TextButton", {
    Name = "DropdownButton",
    Position = UDim2.fromOffset(20, 108),
    Size = UDim2.new(1, -40, 0, 18),
    BackgroundTransparency = 1,
    Text = "▼",
    TextColor3 = COLORS.SecondaryText,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    ZIndex = 11
}, WhCard)

local isDropdownOpen = false

DropdownButton.Activated:Connect(function()
    isDropdownOpen = not isDropdownOpen

    if isDropdownOpen then
        DropdownButton.Text = "▲"

        Tween(WhCard, {
            Size = UDim2.new(1, -56, 0, 350)
        })

    else
        DropdownButton.Text = "▼"

        Tween(WhCard, {
            Size = UDim2.new(1, -56, 0, 130)
        })
    end
end)

--// DROPDOWN SUB-SETTINGS

local SubContainer = Create("Frame", {
    Name = "SubContainer",
    Position = UDim2.fromOffset(20, 130),
    Size = UDim2.new(1, -40, 0, 210),
    BackgroundTransparency = 1,
    ZIndex = 10
}, WhCard)

CreateToggle(SubContainer, "Roles", 0, function(state)
    ESP_SETTINGS.Roles = state
end)

CreateToggle(SubContainer, "Health Bar", 50, function(state)
    ESP_SETTINGS.Health = state
end)

CreateToggle(SubContainer, "Armor Bar", 100, function(state)
    ESP_SETTINGS.Armor = state
end)

CreateToggle(SubContainer, "Distance", 150, function(state)
    ESP_SETTINGS.Distance = state
end)

--//==================================================
--// ESP ENGINE LOGIC
--//==================================================

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

        -- Highlight
        local hl = Instance.new("Highlight")
        hl.Name = "CSS_ESP_HL"
        hl.Adornee = character
        hl.FillColor = COLORS.Accent
        hl.FillTransparency = 0.6
        hl.OutlineColor = COLORS.White
        hl.OutlineTransparency = 0.1
        hl.Enabled = false
        hl.Parent = character

        -- BillboardGui
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

        -- Name
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(1, 0, 0, 16)
        nameLabel.Position = UDim2.fromOffset(0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = plr.Name
        nameLabel.TextColor3 = COLORS.White
        nameLabel.TextSize = 13
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextStrokeTransparency = 0.3
        nameLabel.Parent = container

        -- Role
        local roleLabel = Instance.new("TextLabel")
        roleLabel.Name = "RoleLabel"
        roleLabel.Size = UDim2.new(1, 0, 0, 14)
        roleLabel.Position = UDim2.fromOffset(0, 16)
        roleLabel.BackgroundTransparency = 1
        roleLabel.Text = "[" .. GetRussianRole(plr) .. "]"
        roleLabel.TextColor3 = COLORS.Accent
        roleLabel.TextSize = 11
        roleLabel.Font = Enum.Font.GothamMedium
        roleLabel.TextStrokeTransparency = 0.4
        roleLabel.Parent = container

        -- Health & Armor text/bar
        local statsLabel = Instance.new("TextLabel")
        statsLabel.Name = "StatsLabel"
        statsLabel.Size = UDim2.new(1, 0, 0, 14)
        statsLabel.Position = UDim2.fromOffset(0, 30)
        statsLabel.BackgroundTransparency = 1
        statsLabel.Text = "HP: 100 | AP: 0"
        statsLabel.TextColor3 = COLORS.Health
        statsLabel.TextSize = 10
        statsLabel.Font = Enum.Font.GothamBold
        statsLabel.TextStrokeTransparency = 0.5
        statsLabel.Parent = container

        -- Distance
        local distLabel = Instance.new("TextLabel")
        distLabel.Name = "DistLabel"
        distLabel.Size = UDim2.new(1, 0, 0, 14)
        distLabel.Position = UDim2.fromOffset(0, 44)
        distLabel.BackgroundTransparency = 1
        distLabel.Text = "0 m"
        distLabel.TextColor3 = COLORS.SecondaryText
        distLabel.TextSize = 10
        distLabel.Font = Enum.Font.Gotham
        distLabel.TextStrokeTransparency = 0.5
        distLabel.Parent = container

        bb.Parent = character
    end

    if plr.Character then
        ApplyEsp(plr.Character)
    end

    plr.CharacterAdded:Connect(ApplyEsp)
end

RunService.RenderStepped:Connect(function()
    if not ESP_SETTINGS.Enabled then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                local gui = plr.Character:FindFirstChild("CSS_ESP_GUI")
                local hl = plr.Character:FindFirstChild("CSS_ESP_HL")

                if gui then
                    gui.Enabled = false
                end

                if hl then
                    hl.Enabled = false
                end
            end
        end

        return
    end

    local myChar = Player.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")

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

                        -- Roles visibility
                        if roleLbl then
                            roleLbl.Visible = ESP_SETTINGS.Roles
                            roleLbl.Text = "[" .. GetRussianRole(plr) .. "]"
                        end

                        -- Health / Armor logic
                        if statsLbl then
                            local humanoid = char:FindFirstChildOfClass("Humanoid")
                            local hp = humanoid and math.floor(humanoid.Health) or 0

                            -- Armor check (leaderstats or Armor object)
                            local armor = 0
                            local ls = plr:FindFirstChild("leaderstats")

                            if ls and ls:FindFirstChild("Armor") then
                                armor = math.floor(ls.Armor.Value)
                            elseif char:FindFirstChild("Armor") then
                                armor = math.floor(char.Armor.Value)
                            end

                            local textParts = {}

                            if ESP_SETTINGS.Health then
                                table.insert(textParts, "HP: " .. hp)
                            end

                            if ESP_SETTINGS.Armor then
                                table.insert(textParts, "AP: " .. armor)
                            end

                            statsLbl.Text = table.concat(textParts, " | ")
                            statsLbl.Visible = (ESP_SETTINGS.Health or ESP_SETTINGS.Armor)
                        end

                        -- Distance visibility
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

--//==================================================
--// MOVEMENT
--//==================================================

local MovementPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)

local MovementCard = Card(
    MovementPage,
    "MoveCard",
    UDim2.fromOffset(28, 92),
    UDim2.new(1, -56, 0, 228)
)

Badge(MovementCard, "MOVEMENT")
Heading(MovementCard, "Motion")

--//==================================================
--// PLAYER SPEED HACK
--//==================================================

local speedHackEnabled = false

RunService.RenderStepped:Connect(function()
    if speedHackEnabled then
        local character = Player.Character

        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")

            if humanoid then
                humanoid.WalkSpeed = 33
            end
        end
    end
end)

CreateToggle(MovementCard, "speed-hack", 72, function(state)
    speedHackEnabled = state

    if not state then
        local character = Player.Character

        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")

            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
end)

--//==================================================
--// SPEEDHACK CAR
--// VehicleSeat MaxSpeed is scaled from its original value.
--// The original value is cached so +/- never compounds the change.
--//==================================================

local carSpeedEnabled = false
local carSpeedMultiplier = 2.00
local CAR_SPEED_MIN = 0.25
local CAR_SPEED_MAX = 5.00
local CAR_SPEED_STEP = 0.25
local originalCarSpeeds = setmetatable({}, {__mode = "k"})

local function rememberCarSpeed(seat)
    if not seat or not seat:IsA("VehicleSeat") then
        return
    end

    if originalCarSpeeds[seat] == nil then
        local ok, value = pcall(function()
            return seat.MaxSpeed
        end)

        if ok and typeof(value) == "number" then
            originalCarSpeeds[seat] = value
        end
    end
end

local function applyCarSpeed(seat)
    if not seat or not seat:IsA("VehicleSeat") then
        return
    end

    rememberCarSpeed(seat)

    local baseSpeed = originalCarSpeeds[seat]
    if not baseSpeed then
        return
    end

    pcall(function()
        seat.MaxSpeed = carSpeedEnabled
            and (baseSpeed * carSpeedMultiplier)
            or baseSpeed
    end)
end

local function applyCarSpeedToAll()
    for _, object in ipairs(workspace:GetDescendants()) do
        if object:IsA("VehicleSeat") then
            applyCarSpeed(object)
        end
    end
end

for _, object in ipairs(workspace:GetDescendants()) do
    if object:IsA("VehicleSeat") then
        rememberCarSpeed(object)
    end
end

workspace.DescendantAdded:Connect(function(object)
    if object:IsA("VehicleSeat") then
        task.defer(function()
            rememberCarSpeed(object)
            if carSpeedEnabled then
                applyCarSpeed(object)
            end
        end)
    end
end)

Player.CharacterAdded:Connect(function(character)
    character.DescendantAdded:Connect(function(object)
        if object:IsA("VehicleSeat") then
            task.defer(function()
                rememberCarSpeed(object)
                if carSpeedEnabled then
                    applyCarSpeed(object)
                end
            end)
        end
    end)
end)

local CarSpeedRow = Create("Frame", {
    Name = "SpeedHackCarRow",
    Position = UDim2.fromOffset(20, 126),
    Size = UDim2.new(1, -40, 0, 82),
    BackgroundColor3 = COLORS.CardInner,
    BackgroundTransparency = 0.2,
    BorderSizePixel = 0,
    ZIndex = 10
}, MovementCard)

Corner(CarSpeedRow, 14)
Stroke(CarSpeedRow, COLORS.Line, 0.9, 1)

Create("TextLabel", {
    Position = UDim2.fromOffset(14, 9),
    Size = UDim2.new(1, -28, 0, 18),
    BackgroundTransparency = 1,
    Text = "speedhack car",
    TextColor3 = COLORS.Text,
    TextSize = 13,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 11
}, CarSpeedRow)

local CarSpeedValue = Create("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 34),
    Size = UDim2.fromOffset(90, 28),
    BackgroundTransparency = 1,
    Text = "x2.00",
    TextColor3 = COLORS.Accent2,
    TextSize = 17,
    Font = FONT,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 12
}, CarSpeedRow)

local function UpdateCarSpeedLabel()
    CarSpeedValue.Text = "x" .. string.format("%.2f", carSpeedMultiplier)
end

local MinusButton = Create("TextButton", {
    Name = "Minus",
    Position = UDim2.fromOffset(14, 34),
    Size = UDim2.fromOffset(58, 30),
    BackgroundColor3 = COLORS.Minus,
    BorderSizePixel = 0,
    Text = "−",
    TextColor3 = COLORS.White,
    TextSize = 18,
    Font = FONT,
    AutoButtonColor = false,
    ZIndex = 12
}, CarSpeedRow)

Corner(MinusButton, 9)

local PlusButton = Create("TextButton", {
    Name = "Plus",
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -14, 0, 34),
    Size = UDim2.fromOffset(58, 30),
    BackgroundColor3 = COLORS.Plus,
    BorderSizePixel = 0,
    Text = "+",
    TextColor3 = COLORS.White,
    TextSize = 18,
    Font = FONT,
    AutoButtonColor = false,
    ZIndex = 12
}, CarSpeedRow)

Corner(PlusButton, 9)

local function SetCarSpeedMultiplier(value)
    carSpeedMultiplier = math.clamp(
        math.round(value / CAR_SPEED_STEP) * CAR_SPEED_STEP,
        CAR_SPEED_MIN,
        CAR_SPEED_MAX
    )

    UpdateCarSpeedLabel()

    if carSpeedEnabled then
        applyCarSpeedToAll()
    end
end

MinusButton.Activated:Connect(function()
    SetCarSpeedMultiplier(carSpeedMultiplier - CAR_SPEED_STEP)
end)

PlusButton.Activated:Connect(function()
    SetCarSpeedMultiplier(carSpeedMultiplier + CAR_SPEED_STEP)
end)

CreateToggle(MovementCard, "speedhack car", 126, function(state)
    carSpeedEnabled = state

    if state then
        applyCarSpeedToAll()
    else
        for seat, baseSpeed in pairs(originalCarSpeeds) do
            if seat and seat.Parent then
                pcall(function()
                    seat.MaxSpeed = baseSpeed
                end)
            end
        end
    end
end)

UpdateCarSpeedLabel()

--//==================================================
--// OTHER + BALANCE
--//==================================================

local OtherPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)

local function BigStatCard(parent, pos, size, badge, title)
    local card = Card(parent, badge .. "Card", pos, size)

    Badge(card, badge)
    Heading(card, title)

    local session = Create("TextLabel", {
        Position = UDim2.fromOffset(24, 72),
        Size = UDim2.new(1, -48, 0, 64),
        BackgroundTransparency = 1,
        Text = "0",
        TextColor3 = COLORS.Text,
        TextSize = 36,
        Font = FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 10
    }, card)

    local hint = Create("TextLabel", {
        Position = UDim2.fromOffset(24, 130),
        Size = UDim2.new(1, -48, 0, 18),
        BackgroundTransparency = 1,
        Text = "SESSION",
        TextColor3 = COLORS.Mute,
        TextSize = 11,
        Font = FONT,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 10
    }, card)

    local startL = StatLine(card, 168, "Start")
    local nowL = StatLine(card, 222, "Now")

    return startL, nowL, session, hint
end

local StartValue, NowValue, DiffValue = BigStatCard(
    OtherPage,
    UDim2.fromOffset(28, 92),
    UDim2.new(0.5, -36, 0, 392),
    "MONEY",
    "Cash"
)

local XpStartValue, XpNowValue, XpDiffValue = BigStatCard(
    OtherPage,
    UDim2.new(0.5, 8, 0, 92),
    UDim2.new(0.5, -36, 0, 392),
    "XP",
    "Experience"
)

--//==================================================
--// SETTINGS
--//==================================================

local SettingsPage = Create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false
}, PagesFolder)

--//==================================================
--// PLAYER PANEL
--//==================================================

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

--//==================================================
--// MENU DATA
--//==================================================

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

        Tween(data.Label, {
            TextColor3 = on and COLORS.Text or COLORS.Dim
        })

        RecolorIcon(
            data.Icon,
            on and COLORS.Text or COLORS.Dim
        )
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

    local icon = PaintIcon(
        button,
        data.Kind,
        COLORS.Dim
    )

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
            Tween(button, {
                BackgroundTransparency = 0.65
            })
        end
    end)

    button.MouseLeave:Connect(function()
        if not data.Page.Visible then
            Tween(button, {
                BackgroundTransparency = 1
            })
        end
    end)

    button.Activated:Connect(function()
        SelectTab(index)
    end)

    table.insert(MenuButtons, {
        Button = button,
        Icon = icon,
        Label = label
    })
end

SelectTab(1)

--//==================================================
--// AVATAR
--//==================================================

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
        LogoMark.Image = url
        _G.CSS_JAVA_AVATAR = url
    end
end)

--//==================================================
--// GAME NAME
--//==================================================

task.spawn(function()
    local _ = tostring(game.PlaceId)

    local ok, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)

    if ok and info and info.Name then
        GameValue.Text = info.Name
    else
        GameValue.Text = game.Name
    end
end)

--//==================================================
--// FPS / PING
--//==================================================

local fpsAcc, fpsFrames = 0, 0

RunService.RenderStepped:Connect(function(dt)
    fpsAcc += dt
    fpsFrames += 1

    if fpsAcc >= 0.25 then
        local fps = math.floor(fpsFrames / fpsAcc + 0.5)

        FpsValue.Text = tostring(fps)
        MiniFps.Text = "FPS " .. tostring(fps)

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
    MiniPing.Text = "PING " .. ping
end)

--//==================================================
--// MONEY SESSION TRACKER
--//==================================================

local MONEY_NAMES = {
    "Cash",
    "Money",
    "Dollars",
    "Dollar",
    "Balance",
    "Bank",
    "Wallet",
    "Coins",
    "Gold",
    "Dough",
    "Currency",
    "MoneyValue"
}

local function isMoneyName(name)
    local lower = string.lower(name)

    for _, key in ipairs(MONEY_NAMES) do
        if lower == string.lower(key)
            or string.find(lower, string.lower(key), 1, true) then

            return true
        end
    end

    return false
end

local function readNumber(obj)
    if not obj then
        return nil
    end

    if obj:IsA("IntValue")
        or obj:IsA("NumberValue")
        or obj:IsA("DoubleConstrainedValue")
        or obj:IsA("IntConstrainedValue") then

        return tonumber(obj.Value)
    end

    if obj:IsA("StringValue") then
        local n = tonumber(
            (tostring(obj.Value):gsub("[^0-9%-%.]", ""))
        )

        return n
    end

    return nil
end

local function parseCompact(text)
    if type(text) ~= "string" then
        return nil
    end

    local raw = text
        :gsub("%s+", "")
        :gsub("%$", "")

    local lower = raw:lower()
    local mult = 1

    if lower:find("b") then
        mult = 1000000000
    elseif lower:find("m") then
        mult = 1000000
    elseif lower:find("k") then
        mult = 1000
    end

    local num = raw:match("(%d+[%.,]?%d*)")

    if not num then
        return nil
    end

    if mult > 1 then
        num = num:gsub(",", ".")
    else
        num = num:gsub(",", "")
    end

    local n = tonumber(num)

    if not n then
        return nil
    end

    return n * mult
end

local function looksLikeXP(text, name)
    local blob = string.lower(
        (text or "") .. " " .. (name or "")
    )

    return blob:find("опыт")
        or blob:find("xp")
        or blob:find("exp")
        or blob:find("/")
end

local function parseXP(text)
    if type(text) ~= "string" then
        return nil
    end

    local a, b = text:match(
        "([%d%s,%.]+)%s*/%s*([%d%s,%.]+)"
    )

    if a then
        a = a:gsub("%s", ""):gsub(",", "")
        return tonumber(a)
    end

    if looksLikeXP(text, "") then
        return parseCompact(text)
    end

    return nil
end

local function findMoneyAndXP()
    local money, moneySrc = nil, nil
    local xp, xpSrc = nil, nil

    local function takeMoney(n, label)
        if type(n) ~= "number" then
            return
        end

        if money == nil or n > money then
            money = n
            moneySrc = label
        end
    end

    local function takeXP(n, label)
        if type(n) ~= "number" then
            return
        end

        if xp == nil or n > xp then
            xp = n
            xpSrc = label
        end
    end

    local pg = Player:FindFirstChild("PlayerGui")

    if pg then
        for _, obj in ipairs(pg:GetDescendants()) do
            if obj:IsA("TextLabel")
                or obj:IsA("TextButton") then

                local t = obj.Text or ""
                local n = obj.Name or ""

                if t:find("%$")
                    and not looksLikeXP(t, n) then

                    local v = parseCompact(t)

                    if v and v > 0 then
                        takeMoney(v, "hud." .. n)
                    end

                elseif looksLikeXP(t, n) then
                    local v = parseXP(t)

                    if v and v > 0 then
                        takeXP(v, "hud." .. n)
                    end
                end
            end
        end
    end

    local function scan(root, prefix)
        if not root then
            return
        end

        for _, obj in ipairs(root:GetDescendants()) do
            if isMoneyName(obj.Name) then
                local v = readNumber(obj)

                if v then
                    takeMoney(v, prefix .. obj.Name)
                end
            end

            local lname = string.lower(obj.Name)

            if lname:find("xp")
                or lname:find("exp")
                or lname:find("опыт") then

                local v = readNumber(obj)

                if v then
                    takeXP(v, prefix .. obj.Name)
                end
            end
        end
    end

    scan(
        Player:FindFirstChild("leaderstats"),
        "leaderstats."
    )

    scan(Player, "player.")

    return money, moneySrc, xp, xpSrc
end

local startMoney = nil
local startXP = nil

local function formatMoney(n)
    n = math.floor(n + 0.5)

    local sign = n < 0 and "-" or ""
    local s = tostring(math.abs(n))
    local out = s

    while true do
        local nexts, count = string.gsub(
            out,
            "^(-?%d+)(%d%d%d)",
            "%1 %2"
        )

        out = nexts

        if count == 0 then
            break
        end
    end

    return sign .. out
end

local function paintDiff(label, diff, suffix)
    if diff > 0 then
        label.Text = "+" .. formatMoney(diff) .. suffix
        label.TextColor3 = COLORS.Plus

    elseif diff < 0 then
        label.Text = "-" .. formatMoney(math.abs(diff)) .. suffix
        label.TextColor3 = COLORS.Minus

    else
        label.Text = "0" .. suffix
        label.TextColor3 = COLORS.Text
    end
end

task.spawn(function()
    while true do
        local now, _, xpNow = findMoneyAndXP()

        if now ~= nil then
            if startMoney == nil then
                startMoney = now
            end

            StartValue.Text = formatMoney(startMoney) .. "$"
            NowValue.Text = formatMoney(now) .. "$"

            paintDiff(
                DiffValue,
                now - startMoney,
                "$"
            )
        else
            StartValue.Text = "—"
            NowValue.Text = "—"
            DiffValue.Text = "waiting"
            DiffValue.TextColor3 = COLORS.Mute
        end

        if xpNow ~= nil then
            if startXP == nil then
                startXP = xpNow
            end

            XpStartValue.Text = formatMoney(startXP)
            XpNowValue.Text = formatMoney(xpNow)

            paintDiff(
                XpDiffValue,
                xpNow - startXP,
                " XP"
            )
        else
            XpStartValue.Text = "—"
            XpNowValue.Text = "—"
            XpDiffValue.Text = "waiting"
            XpDiffValue.TextColor3 = COLORS.Mute
        end

        task.wait(0.25)
    end
end)

--//==================================================
--// RESPONSIVE SCALING
--//==================================================

local cam = workspace.CurrentCamera

local function UpdateScale()
    cam = workspace.CurrentCamera

    if not cam then
        return
    end

    local v = cam.ViewportSize

    UIScale.Scale = math.clamp(
        math.min(
            (v.X - 20) / 800,
            (v.Y - 20) / 500
        ),
        CONFIG.MinScale,
        CONFIG.MaxScale
    )
end

UpdateScale()

if cam then
    cam:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
end

--//==================================================
--// DRAG
--//==================================================

local dragging, dragStart, startPos = false, nil, nil

local function bindDrag(obj)
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
end

bindDrag(TopBar)
bindDrag(DragButton)

UserInputService.InputChanged:Connect(function(input)
    if dragging
        and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then

        local d = input.Position - dragStart

        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + d.X,
            startPos.Y.Scale,
            startPos.Y.Offset + d.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = false
    end
end)

--//==================================================
--// REOPEN BUTTON
--//==================================================

local closed = false

local reopen = Create("ImageButton", {
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -18, 1, -18),
    Size = UDim2.fromOffset(40, 40),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0,
    Image = "",
    ScaleType = Enum.ScaleType.Crop,
    AutoButtonColor = false,
    Visible = false,
    ZIndex = 100
}, ScreenGui)

Corner(reopen, 18)
Stroke(reopen, COLORS.Accent, 0.2, 2)

task.spawn(function()
    for _ = 1, 40 do
        if _G.CSS_JAVA_AVATAR
            and _G.CSS_JAVA_AVATAR ~= "" then

            reopen.Image = _G.CSS_JAVA_AVATAR
            break
        end

        task.wait(0.1)
    end
end)

local rDrag, rStart, rPos, rMoved = false, nil, nil, false

reopen.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        rDrag = true
        rStart = input.Position
        rPos = reopen.Position
        rMoved = false
        reopen.AnchorPoint = Vector2.new(0, 0)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if rDrag
        and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then

        local d = input.Position - rStart

        if d.Magnitude > 5 then
            rMoved = true
        end

        reopen.Position = UDim2.new(
            rPos.X.Scale,
            rPos.X.Offset + d.X,
            rPos.Y.Scale,
            rPos.Y.Offset + d.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        rDrag = false
    end
end)

--//==================================================
--// CLOSE
--//==================================================

CloseButton.Activated:Connect(function()
    if closed then
        return
    end

    closed = true

    Tween(MainFrame, {
        Size = UDim2.fromOffset(920, 570),
        BackgroundTransparency = 0.4
    }, 0.16)

    Tween(BackgroundLayer, {
        BackgroundTransparency = 1
    }, 0.16)

    task.wait(0.14)

    BackgroundLayer.Visible = false
    MainFrame.Visible = false
    reopen.Visible = true
    MiniHud.Visible = true

    reopen.Size = UDim2.fromOffset(32, 32)

    Tween(reopen, {
        Size = UDim2.fromOffset(40, 40)
    }, 0.18)
end)

reopen.Activated:Connect(function()
    if rMoved then
        rMoved = false
        return
    end

    closed = false

    MiniHud.Visible = false
    reopen.Visible = false
    BackgroundLayer.Visible = true
    MainFrame.Visible = true
    MainFrame.BackgroundTransparency = 0.2
    MainFrame.Size = UDim2.fromOffset(920, 570)

    Tween(MainFrame, {
        Size = UDim2.fromOffset(800, 500),
        BackgroundTransparency = 0.04
    }, 0.2)

    task.defer(UpdateScale)
end)

print("[CSS JAVA] Home + session balance + WH + SpeedHack loaded")
