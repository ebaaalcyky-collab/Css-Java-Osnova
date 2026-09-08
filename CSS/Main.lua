--// CSS JAVA - Main.lua
--// GUI ONLY / NO GAMEPLAY FUNCTIONS

local RAW_BASE = "https://raw.githubusercontent.com/ebaaalcyky-collab/Css-Java-Osnova/main/assets/"

local ASSETS = {
    background = RAW_BASE .. "background.png",
    logo = RAW_BASE .. "logo.png",
    aim = RAW_BASE .. "aim.png",
    wh = RAW_BASE .. "wh.png",
    movement = RAW_BASE .. "movement.png",
    settings = RAW_BASE .. "settings.png",
    player = RAW_BASE .. "player.png"
}

--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

--//==================================================
--// CONFIG
--//==================================================

local CONFIG = {
    WindowSize = Vector2.new(1000, 620),

    MinScale = 0.42,
    MaxScale = 1,

    CornerRadius = 16,

    -- FIX:
    -- Было 0.28, из-за чего background.png был прозрачным.
    BackgroundTransparency = 0,

    -- FIX:
    -- Чем меньше значение, тем сильнее затемнение фона.
    -- 0.70 = лёгкое затемнение.
    BackgroundOverlayTransparency = 0.70,

    SidebarWidth = 225,

    AnimationTime = 0.18
}

--//==================================================
--// COLORS
--//==================================================

local COLORS = {
    Background = Color3.fromRGB(9, 10, 14),

    -- FIX:
    -- Панели слегка прозрачные, чтобы фон был виден.
    Panel = Color3.fromRGB(14, 16, 22),

    Sidebar = Color3.fromRGB(11, 13, 18),

    Card = Color3.fromRGB(20, 23, 31),
    CardHover = Color3.fromRGB(27, 30, 40),

    Accent = Color3.fromRGB(130, 85, 255),
    AccentDark = Color3.fromRGB(91, 58, 190),

    Text = Color3.fromRGB(245, 245, 248),
    SecondaryText = Color3.fromRGB(145, 149, 160),
    MutedText = Color3.fromRGB(95, 99, 110),

    Border = Color3.fromRGB(42, 45, 56),

    ToggleOff = Color3.fromRGB(42, 45, 54),
    ToggleOn = Color3.fromRGB(130, 85, 255),

    White = Color3.fromRGB(255, 255, 255)
}

--//==================================================
--// HELPERS
--//==================================================

local function Create(className, properties, parent)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    object.Parent = parent

    return object
end

local function AddCorner(parent, radius)
    return Create("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, parent)
end

local function AddStroke(parent, color, transparency, thickness)
    return Create("UIStroke", {
        Color = color,
        Transparency = transparency or 0,
        Thickness = thickness or 1
    }, parent)
end

local function AddPadding(parent, left, right, top, bottom)
    return Create("UIPadding", {
        PaddingLeft = UDim.new(0, left or 0),
        PaddingRight = UDim.new(0, right or 0),
        PaddingTop = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or 0)
    }, parent)
end

local function Tween(object, properties, duration)
    TweenService:Create(
        object,
        TweenInfo.new(
            duration or CONFIG.AnimationTime,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    ):Play()
end

--//==================================================
--// GUI ROOT
--//==================================================

local ExistingGui = nil

pcall(function()
    ExistingGui = CoreGui:FindFirstChild("CSS_JAVA_GUI")
end)

if ExistingGui then
    ExistingGui:Destroy()
end

local ScreenGui = Create("ScreenGui", {
    Name = "CSS_JAVA_GUI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999
}, CoreGui)

--//==================================================
--// SCALE SYSTEM
--//==================================================

local UIScale = Create("UIScale", {
    Scale = 1
})

--//==================================================
--// BACKGROUND LAYER
--//==================================================

-- FIX:
-- Фон теперь НЕ находится внутри MainFrame.
-- Поэтому MainFrame больше не может скрыть background.png.

local BackgroundLayer = Create("Frame", {
    Name = "BackgroundLayer",

    Position = UDim2.fromScale(0, 0),
    Size = UDim2.fromScale(1, 1),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ZIndex = 0
}, ScreenGui)

local Background = Create("ImageLabel", {
    Name = "Background",

    Position = UDim2.fromScale(0, 0),
    Size = UDim2.fromScale(1, 1),

    BackgroundTransparency = 1,

    Image = ASSETS.background,

    -- FIX:
    -- Раньше было 90,90,100.
    -- Это серило изображение.
    ImageColor3 = Color3.fromRGB(255, 255, 255),

    ImageTransparency = CONFIG.BackgroundTransparency,

    ScaleType = Enum.ScaleType.Crop,

    BorderSizePixel = 0,

    ZIndex = 0
}, BackgroundLayer)

-- FIX:
-- Лёгкое затемнение поверх background.png.
local BackgroundOverlay = Create("Frame", {
    Name = "BackgroundOverlay",

    Position = UDim2.fromScale(0, 0),
    Size = UDim2.fromScale(1, 1),

    BackgroundColor3 = Color3.fromRGB(5, 6, 9),

    BackgroundTransparency = CONFIG.BackgroundOverlayTransparency,

    BorderSizePixel = 0,

    ZIndex = 1
}, BackgroundLayer)

--//==================================================
--// MAIN WINDOW
--//==================================================

local MainFrame = Create("Frame", {
    Name = "MainWindow",

    AnchorPoint = Vector2.new(0.5, 0.5),

    Position = UDim2.fromScale(0.5, 0.5),

    Size = UDim2.fromOffset(
        CONFIG.WindowSize.X,
        CONFIG.WindowSize.Y
    ),

    -- FIX:
    -- Было 0.04.
    -- Теперь основная область окна прозрачная,
    -- а отдельные панели сами имеют свои цвета.
    BackgroundColor3 = COLORS.Panel,
    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 3
}, ScreenGui)

UIScale.Parent = MainFrame

AddCorner(MainFrame, CONFIG.CornerRadius)
AddStroke(MainFrame, COLORS.Border, 0.2, 1)

--//==================================================
--// WINDOW BACKDROP
--//==================================================

-- FIX:
-- Если хочется чуть затемнить именно область окна,
-- используется отдельный слой.
local WindowBackdrop = Create("Frame", {
    Name = "WindowBackdrop",

    Position = UDim2.fromScale(0, 0),
    Size = UDim2.fromScale(1, 1),

    BackgroundColor3 = COLORS.Panel,

    BackgroundTransparency = 0.72,

    BorderSizePixel = 0,

    ZIndex = 2
}, MainFrame)

AddCorner(WindowBackdrop, CONFIG.CornerRadius)

--//==================================================
--// SIDEBAR
--//==================================================

local Sidebar = Create("Frame", {
    Name = "Sidebar",

    Position = UDim2.fromOffset(0, 0),

    Size = UDim2.new(
        0,
        CONFIG.SidebarWidth,
        1,
        0
    ),

    BackgroundColor3 = COLORS.Sidebar,

    BackgroundTransparency = 0.06,

    BorderSizePixel = 0,

    ZIndex = 5
}, MainFrame)

AddStroke(Sidebar, COLORS.Border, 0.35, 1)

--//==================================================
--// BRAND
--//==================================================

local Brand = Create("Frame", {
    Name = "Brand",

    Position = UDim2.fromOffset(20, 22),

    Size = UDim2.new(1, -40, 0, 58),

    BackgroundTransparency = 1,

    ZIndex = 6
}, Sidebar)

local Logo = Create("ImageLabel", {
    Name = "Logo",

    Position = UDim2.fromOffset(0, 3),

    Size = UDim2.fromOffset(48, 48),

    BackgroundTransparency = 1,

    Image = ASSETS.logo,

    ScaleType = Enum.ScaleType.Fit,

    ZIndex = 7
}, Brand)

AddCorner(Logo, 12)

local BrandTitle = Create("TextLabel", {
    Name = "Title",

    Position = UDim2.fromOffset(60, 3),

    Size = UDim2.new(1, -60, 0, 25),

    BackgroundTransparency = 1,

    Text = "CSS JAVA",

    TextColor3 = COLORS.Text,

    TextSize = 19,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 7
}, Brand)

local BrandSubtitle = Create("TextLabel", {
    Name = "Subtitle",

    Position = UDim2.fromOffset(60, 28),

    Size = UDim2.new(1, -60, 0, 20),

    BackgroundTransparency = 1,

    Text = "CONTROL PANEL",

    TextColor3 = COLORS.SecondaryText,

    TextSize = 9,

    Font = Enum.Font.GothamMedium,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 7
}, Brand)

--//==================================================
--// SIDEBAR MENU
--//==================================================

local MenuContainer = Create("Frame", {
    Name = "Menu",

    Position = UDim2.fromOffset(12, 105),

    Size = UDim2.new(1, -24, 0, 280),

    BackgroundTransparency = 1,

    ZIndex = 7
}, Sidebar)

local MenuLayout = Create("UIListLayout", {
    FillDirection = Enum.FillDirection.Vertical,

    HorizontalAlignment = Enum.HorizontalAlignment.Center,

    SortOrder = Enum.SortOrder.LayoutOrder,

    Padding = UDim.new(0, 7)
}, MenuContainer)

--//==================================================
--// CONTENT
--//==================================================

local Content = Create("Frame", {
    Name = "Content",

    Position = UDim2.fromOffset(CONFIG.SidebarWidth, 0),

    Size = UDim2.new(
        1,
        -CONFIG.SidebarWidth,
        1,
        0
    ),

    BackgroundTransparency = 1,

    ZIndex = 4
}, MainFrame)

--//==================================================
--// TOP BAR
--//==================================================

local TopBar = Create("Frame", {
    Name = "TopBar",

    Position = UDim2.fromOffset(30, 25),

    Size = UDim2.new(1, -60, 0, 50),

    BackgroundTransparency = 1,

    ZIndex = 8
}, Content)

local CurrentTitle = Create("TextLabel", {
    Name = "CurrentTitle",

    Position = UDim2.fromOffset(0, 0),

    Size = UDim2.new(1, -130, 0, 29),

    BackgroundTransparency = 1,

    Text = "AIM",

    TextColor3 = COLORS.Text,

    TextSize = 24,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 9
}, TopBar)

local CurrentSubtitle = Create("TextLabel", {
    Name = "CurrentSubtitle",

    Position = UDim2.fromOffset(0, 29),

    Size = UDim2.new(1, -130, 0, 20),

    BackgroundTransparency = 1,

    Text = "Basic configuration panel",

    TextColor3 = COLORS.SecondaryText,

    TextSize = 12,

    Font = Enum.Font.GothamMedium,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 9
}, TopBar)

--//==================================================
--// CLOSE BUTTON
--//==================================================

local CloseButton = Create("TextButton", {
    Name = "Close",

    AnchorPoint = Vector2.new(1, 0),

    Position = UDim2.new(1, 0, 0, 0),

    Size = UDim2.fromOffset(38, 38),

    BackgroundColor3 = COLORS.Card,

    BackgroundTransparency = 0.1,

    BorderSizePixel = 0,

    Text = "×",

    TextColor3 = COLORS.SecondaryText,

    TextSize = 22,

    Font = Enum.Font.GothamMedium,

    AutoButtonColor = false,

    ZIndex = 10
}, TopBar)

AddCorner(CloseButton, 10)
AddStroke(CloseButton, COLORS.Border, 0.25, 1)

CloseButton.MouseEnter:Connect(function()
    Tween(CloseButton, {
        BackgroundColor3 = Color3.fromRGB(75, 35, 45),
        TextColor3 = COLORS.White
    })
end)

CloseButton.MouseLeave:Connect(function()
    Tween(CloseButton, {
        BackgroundColor3 = COLORS.Card,
        TextColor3 = COLORS.SecondaryText
    })
end)

--//==================================================
--// DRAG BUTTON
--//==================================================

local DragButton = Create("TextButton", {
    Name = "DragButton",

    AnchorPoint = Vector2.new(1, 0),

    Position = UDim2.new(1, -47, 0, 0),

    Size = UDim2.fromOffset(38, 38),

    BackgroundColor3 = COLORS.Card,

    BackgroundTransparency = 0.1,

    BorderSizePixel = 0,

    Text = "⠿",

    TextColor3 = COLORS.SecondaryText,

    TextSize = 20,

    Font = Enum.Font.GothamBold,

    AutoButtonColor = false,

    ZIndex = 10
}, TopBar)

AddCorner(DragButton, 10)
AddStroke(DragButton, COLORS.Border, 0.25, 1)

--//==================================================
--// CONTENT CARD
--//==================================================

local SettingsCard = Create("Frame", {
    Name = "DemoSettings",

    Position = UDim2.fromOffset(30, 105),

    Size = UDim2.new(1, -60, 0, 250),

    BackgroundColor3 = COLORS.Card,

    -- FIX:
    -- Было 0.08. Оставляем лёгкую прозрачность,
    -- чтобы background немного просвечивал.
    BackgroundTransparency = 0.08,

    BorderSizePixel = 0,

    ZIndex = 8
}, Content)

AddCorner(SettingsCard, 14)
AddStroke(SettingsCard, COLORS.Border, 0.25, 1)

local CardTitle = Create("TextLabel", {
    Name = "CardTitle",

    Position = UDim2.fromOffset(22, 18),

    Size = UDim2.new(1, -44, 0, 25),

    BackgroundTransparency = 1,

    Text = "DEMONSTRATION",

    TextColor3 = COLORS.Text,

    TextSize = 13,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 9
}, SettingsCard)

local CardDescription = Create("TextLabel", {
    Name = "CardDescription",

    Position = UDim2.fromOffset(22, 43),

    Size = UDim2.new(1, -44, 0, 20),

    BackgroundTransparency = 1,

    Text = "Visual controls only — no gameplay functionality",

    TextColor3 = COLORS.SecondaryText,

    TextSize = 11,

    Font = Enum.Font.GothamMedium,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 9
}, SettingsCard)

--//==================================================
--// TOGGLE CREATOR
--//==================================================

local function CreateToggle(parent, text, order)
    local Row = Create("Frame", {
        Name = text .. "Row",

        Position = UDim2.fromOffset(
            20,
            72 + ((order - 1) * 52)
        ),

        Size = UDim2.new(1, -40, 0, 44),

        BackgroundTransparency = 1,

        ZIndex = 10
    }, parent)

    local Label = Create("TextLabel", {
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
            Tween(Toggle, {
                BackgroundColor3 = COLORS.ToggleOn
            })

            Tween(Circle, {
                Position = UDim2.new(1, -26, 0.5, 0),
                BackgroundColor3 = COLORS.White
            })
        else
            Tween(Toggle, {
                BackgroundColor3 = COLORS.ToggleOff
            })

            Tween(Circle, {
                Position = UDim2.new(0, 4, 0.5, 0),
                BackgroundColor3 = COLORS.SecondaryText
            })
        end
    end

    Toggle.Activated:Connect(function()
        SetState(not State)
    end)

    return Row
end

CreateToggle(SettingsCard, "Enabled", 1)
CreateToggle(SettingsCard, "Preview", 2)
CreateToggle(SettingsCard, "Advanced", 3)

--//==================================================
--// FOOTER INFO
--//==================================================

local InfoCard = Create("Frame", {
    Name = "Info",

    Position = UDim2.fromOffset(30, 375),

    Size = UDim2.new(1, -60, 0, 105),

    BackgroundColor3 = COLORS.Card,

    BackgroundTransparency = 0.15,

    BorderSizePixel = 0,

    ZIndex = 8
}, Content)

AddCorner(InfoCard, 14)
AddStroke(InfoCard, COLORS.Border, 0.3, 1)

local InfoTitle = Create("TextLabel", {
    Position = UDim2.fromOffset(20, 17),

    Size = UDim2.new(1, -40, 0, 23),

    BackgroundTransparency = 1,

    Text = "INTERFACE READY",

    TextColor3 = COLORS.Accent,

    TextSize = 12,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 9
}, InfoCard)

local InfoText = Create("TextLabel", {
    Position = UDim2.fromOffset(20, 42),

    Size = UDim2.new(1, -40, 0, 42),

    BackgroundTransparency = 1,

    Text = "This panel is a clean GUI foundation.\nAll controls are visual placeholders.",

    TextColor3 = COLORS.SecondaryText,

    TextSize = 11,

    Font = Enum.Font.GothamMedium,

    TextXAlignment = Enum.TextXAlignment.Left,

    TextYAlignment = Enum.TextYAlignment.Top,

    ZIndex = 9
}, InfoCard)

--//==================================================
--// PLAYER PANEL
--//==================================================

local PlayerPanel = Create("Frame", {
    Name = "PlayerPanel",

    AnchorPoint = Vector2.new(0, 1),

    Position = UDim2.new(0, 12, 1, -15),

    Size = UDim2.new(1, -24, 0, 55),

    BackgroundColor3 = COLORS.Card,

    BackgroundTransparency = 0.12,

    BorderSizePixel = 0,

    ZIndex = 8
}, Sidebar)

AddCorner(PlayerPanel, 12)
AddStroke(PlayerPanel, COLORS.Border, 0.3, 1)

local PlayerIcon = Create("ImageLabel", {
    Position = UDim2.fromOffset(8, 7),

    Size = UDim2.fromOffset(40, 40),

    BackgroundTransparency = 1,

    Image = ASSETS.player,

    ScaleType = Enum.ScaleType.Fit,

    ZIndex = 9
}, PlayerPanel)

AddCorner(PlayerIcon, 20)

local PlayerName = Create("TextLabel", {
    Position = UDim2.fromOffset(57, 7),

    Size = UDim2.new(1, -65, 0, 22),

    BackgroundTransparency = 1,

    Text = Player and Player.Name or "Player",

    TextColor3 = COLORS.Text,

    TextSize = 12,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    TextTruncate = Enum.TextTruncate.AtEnd,

    ZIndex = 9
}, PlayerPanel)

local PlayerRole = Create("TextLabel", {
    Position = UDim2.fromOffset(57, 28),

    Size = UDim2.new(1, -65, 0, 17),

    BackgroundTransparency = 1,

    Text = "CSS JAVA",

    TextColor3 = COLORS.SecondaryText,

    TextSize = 9,

    Font = Enum.Font.GothamMedium,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 9
}, PlayerPanel)

--//==================================================
--// MENU DATA
--//==================================================

local MenuItems = {
    {
        Name = "AIM",
        Icon = ASSETS.aim,
        Subtitle = "Basic configuration panel"
    },

    {
        Name = "WH",
        Icon = ASSETS.wh,
        Subtitle = "Visual configuration panel"
    },

    {
        Name = "MOVEMENT",
        Icon = ASSETS.movement,
        Subtitle = "Movement configuration panel"
    },

    {
        Name = "OTHER",
        Icon = ASSETS.settings,
        Subtitle = "Other configuration panel"
    },

    {
        Name = "SETTINGS",
        Icon = ASSETS.settings,
        Subtitle = "Interface settings"
    }
}

local MenuButtons = {}

--//==================================================
--// TAB SYSTEM
--//==================================================

local function SelectTab(index)
    local selected = MenuItems[index]

    if not selected then
        return
    end

    CurrentTitle.Text = selected.Name
    CurrentSubtitle.Text = selected.Subtitle

    for i, buttonData in ipairs(MenuButtons) do
        local Button = buttonData.Button
        local Icon = buttonData.Icon
        local Indicator = buttonData.Indicator

        if i == index then
            Tween(Button, {
                BackgroundColor3 = COLORS.Accent,
                BackgroundTransparency = 0.08
            })

            Tween(Icon, {
                ImageColor3 = COLORS.White,
                ImageTransparency = 0
            })

            Tween(Indicator, {
                BackgroundTransparency = 0
            })
        else
            Tween(Button, {
                BackgroundColor3 = COLORS.Card,
                BackgroundTransparency = 1
            })

            Tween(Icon, {
                ImageColor3 = COLORS.SecondaryText,
                ImageTransparency = 0
            })

            Tween(Indicator, {
                BackgroundTransparency = 1
            })
        end
    end
end

--//==================================================
--// CREATE MENU BUTTONS
--//==================================================

for index, data in ipairs(MenuItems) do

    local Button = Create("TextButton", {
        Name = data.Name,

        Size = UDim2.new(1, 0, 0, 48),

        BackgroundColor3 = COLORS.Card,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,

        LayoutOrder = index,

        ZIndex = 8
    }, MenuContainer)

    AddCorner(Button, 11)

    local Indicator = Create("Frame", {
        Name = "Indicator",

        Position = UDim2.fromOffset(0, 10),

        Size = UDim2.fromOffset(3, 28),

        BackgroundColor3 = COLORS.White,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        ZIndex = 10
    }, Button)

    AddCorner(Indicator, 2)

    local Icon = Create("ImageLabel", {
        Name = "Icon",

        Position = UDim2.fromOffset(14, 10),

        Size = UDim2.fromOffset(28, 28),

        BackgroundTransparency = 1,

        Image = data.Icon,

        ImageColor3 = COLORS.SecondaryText,

        ScaleType = Enum.ScaleType.Fit,

        ZIndex = 9
    }, Button)

    local Text = Create("TextLabel", {
        Position = UDim2.fromOffset(54, 0),

        Size = UDim2.new(1, -62, 1, 0),

        BackgroundTransparency = 1,

        Text = data.Name,

        TextColor3 = COLORS.Text,

        TextSize = 11,

        Font = Enum.Font.GothamBold,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 9
    }, Button)

    Button.MouseEnter:Connect(function()
        if index ~= 1 then
            Tween(Button, {
                BackgroundTransparency = 0.7
            })
        end
    end)

    Button.MouseLeave:Connect(function()
        if index ~= 1 then
            Tween(Button, {
                BackgroundTransparency = 1
            })
        end
    end)

    Button.Activated:Connect(function()
        SelectTab(index)
    end)

    table.insert(MenuButtons, {
        Button = Button,
        Icon = Icon,
        Indicator = Indicator
    })
end

SelectTab(1)

--//==================================================
--// RESPONSIVE SCALING
--//==================================================

local Camera = workspace.CurrentCamera

local function UpdateScale()
    Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    local viewport = Camera.ViewportSize

    local horizontalScale =
        (viewport.X - 20) / CONFIG.WindowSize.X

    local verticalScale =
        (viewport.Y - 20) / CONFIG.WindowSize.Y

    local calculatedScale =
        math.min(horizontalScale, verticalScale)

    calculatedScale = math.clamp(
        calculatedScale,
        CONFIG.MinScale,
        CONFIG.MaxScale
    )

    UIScale.Scale = calculatedScale
end

UpdateScale()

if Camera then
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
end

--//==================================================
--// DRAG SYSTEM
--//==================================================

local Dragging = false
local DragStart = nil
local StartPosition = nil

local function BeginDrag(input)
    Dragging = true

    DragStart = input.Position

    StartPosition = MainFrame.Position

    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            Dragging = false
        end
    end)
end

local function UpdateDrag(input)
    if not Dragging then
        return
    end

    local Delta = input.Position - DragStart

    MainFrame.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end

local function ConnectDrag(object)
    object.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            BeginDrag(input)
        end
    end)

    object.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            UserInputService.InputChanged:Connect(function(changedInput)
                if changedInput == input then
                    UpdateDrag(changedInput)
                end
            end)
        end
    end)
end

ConnectDrag(TopBar)
ConnectDrag(DragButton)

--//==================================================
--// CLOSE / REOPEN
--//==================================================

local Closed = false

CloseButton.Activated:Connect(function()
    if Closed then
        return
    end

    Closed = true

    Tween(MainFrame, {
        Size = UDim2.fromOffset(
            CONFIG.WindowSize.X * 0.92,
            CONFIG.WindowSize.Y * 0.92
        )
    }, 0.15)

    task.wait(0.12)

    MainFrame.Visible = false
    DragButton.Visible = false
    ReopenButton.Visible = true
end)

--//==================================================
--// REOPEN BUTTON
--//==================================================

local ReopenButton = Create("TextButton", {
    Name = "ReopenButton",

    AnchorPoint = Vector2.new(1, 1),

    Position = UDim2.new(1, -25, 1, -25),

    Size = UDim2.fromOffset(58, 58),

    BackgroundColor3 = COLORS.Accent,

    BorderSizePixel = 0,

    Text = "C",

    TextColor3 = COLORS.White,

    TextSize = 20,

    Font = Enum.Font.GothamBold,

    AutoButtonColor = false,

    Visible = false,

    ZIndex = 100
}, ScreenGui)

AddCorner(ReopenButton, 29)
AddStroke(ReopenButton, COLORS.White, 0.75, 1)

ReopenButton.Activated:Connect(function()
    Closed = false

    MainFrame.Visible = true
    DragButton.Visible = true

    MainFrame.Size = UDim2.fromOffset(
        CONFIG.WindowSize.X * 0.92,
        CONFIG.WindowSize.Y * 0.92
    )

    Tween(MainFrame, {
        Size = UDim2.fromOffset(
            CONFIG.WindowSize.X,
            CONFIG.WindowSize.Y
        )
    }, 0.18)

    ReopenButton.Visible = false

    task.defer(UpdateScale)
end)

--//==================================================
--// KEEP WINDOW WITHIN SCREEN
--//==================================================

local function ClampWindow()
    Camera = workspace.CurrentCamera

    if not Camera then
        return
    end

    local viewport = Camera.ViewportSize

    local scale = UIScale.Scale

    local width = CONFIG.WindowSize.X * scale
    local height = CONFIG.WindowSize.Y * scale

    local halfWidth = width / 2
    local halfHeight = height / 2

    local x = MainFrame.AbsolutePosition.X + width / 2
    local y = MainFrame.AbsolutePosition.Y + height / 2

    local minX = halfWidth + 5
    local maxX = viewport.X - halfWidth - 5

    local minY = halfHeight + 5
    local maxY = viewport.Y - halfHeight - 5

    local targetX = math.clamp(
        x,
        minX,
        math.max(minX, maxX)
    )

    local targetY = math.clamp(
        y,
        minY,
        math.max(minY, maxY)
    )

    MainFrame.Position = UDim2.fromOffset(
        targetX,
        targetY
    )

    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
end

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        if Dragging then
            task.defer(ClampWindow)
        end
    end
end)

if Camera then
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        task.defer(ClampWindow)
    end)
end

--//==================================================
--// MOBILE TOUCH FEEDBACK
--//==================================================

local function TouchFeedback(button)
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            Tween(button, {
                BackgroundTransparency = 0.2
            }, 0.08)
        end
    end)

    button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            Tween(button, {
                BackgroundTransparency = 0.05
            }, 0.08)
        end
    end)
end

TouchFeedback(CloseButton)
TouchFeedback(DragButton)
TouchFeedback(ReopenButton)

for _, data in ipairs(MenuButtons) do
    TouchFeedback(data.Button)
end

--//==================================================
--// INITIAL POSITION
--//==================================================

task.defer(function()
    UpdateScale()
    ClampWindow()
end)

print("[CSS JAVA] GUI loaded successfully.")
