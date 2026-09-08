--// CSS JAVA - UI Redesign
--// Size locked: 1000 x 620
--// Visual only. Feature callbacks are placeholders.

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

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer

local CONFIG = {
    WindowSize = Vector2.new(1000, 620),
    MinScale = 0.42,
    MaxScale = 1,
    CornerRadius = 22,
    SidebarWidth = 225,
    AnimationTime = 0.2
}

local COLORS = {
    Void = Color3.fromRGB(7, 8, 12),
    Panel = Color3.fromRGB(12, 14, 20),
    Sidebar = Color3.fromRGB(9, 11, 16),
    Card = Color3.fromRGB(18, 21, 29),
    CardHover = Color3.fromRGB(24, 28, 38),
    Glass = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(138, 92, 255),
    AccentSoft = Color3.fromRGB(168, 132, 255),
    AccentDim = Color3.fromRGB(88, 58, 168),
    Text = Color3.fromRGB(246, 247, 250),
    Secondary = Color3.fromRGB(168, 173, 186),
    Muted = Color3.fromRGB(108, 114, 128),
    Border = Color3.fromRGB(48, 52, 66),
    Line = Color3.fromRGB(255, 255, 255),
    ToggleOff = Color3.fromRGB(36, 40, 52),
    Danger = Color3.fromRGB(255, 92, 108)
}

local function Create(className, properties, parent)
    local object = Instance.new(className)
    for property, value in pairs(properties or {}) do
        object[property] = value
    end
    object.Parent = parent
    return object
end

local function AddCorner(parent, radius)
    return Create("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
end

local function AddStroke(parent, color, transparency, thickness)
    return Create("UIStroke", {
        Color = color,
        Transparency = transparency or 0,
        Thickness = thickness or 1
    }, parent)
end

local function AddGradient(parent, c1, c2, rotation)
    return Create("UIGradient", {
        Color = ColorSequence.new(c1, c2),
        Rotation = rotation or 90
    }, parent)
end

local function Tween(object, properties, duration, style)
    if not object then
        return
    end
    TweenService:Create(
        object,
        TweenInfo.new(duration or CONFIG.AnimationTime, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        properties
    ):Play()
end

pcall(function()
    local existing = CoreGui:FindFirstChild("CSS_JAVA_GUI")
    if existing then
        existing:Destroy()
    end
end)

local ScreenGui = Create("ScreenGui", {
    Name = "CSS_JAVA_GUI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999
}, CoreGui)

local BackgroundLayer = Create("Frame", {
    Name = "BackgroundLayer",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 0
}, ScreenGui)

Create("ImageLabel", {
    Name = "Background",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Image = ASSETS.background,
    ImageTransparency = 0.12,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 0
}, BackgroundLayer)

Create("Frame", {
    Name = "Dim",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = COLORS.Void,
    BackgroundTransparency = 0.62,
    BorderSizePixel = 0,
    ZIndex = 1
}, BackgroundLayer)

local UIScale = Create("UIScale", { Scale = 1 })

local MainFrame = Create("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(CONFIG.WindowSize.X, CONFIG.WindowSize.Y),
    BackgroundColor3 = COLORS.Panel,
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 3
}, ScreenGui)

UIScale.Parent = MainFrame
AddCorner(MainFrame, CONFIG.CornerRadius)
AddStroke(MainFrame, COLORS.Accent, 0.82, 1)

local Sheen = Create("Frame", {
    Name = "Sheen",
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = COLORS.Glass,
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    ZIndex = 20
}, MainFrame)

local WindowFill = Create("Frame", {
    Name = "WindowFill",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = COLORS.Panel,
    BackgroundTransparency = 0.12,
    BorderSizePixel = 0,
    ZIndex = 3
}, MainFrame)
AddCorner(WindowFill, CONFIG.CornerRadius)
AddGradient(WindowFill, Color3.fromRGB(16, 18, 26), Color3.fromRGB(10, 11, 16), 160)

local Sidebar = Create("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, CONFIG.SidebarWidth, 1, 0),
    BackgroundColor3 = COLORS.Sidebar,
    BackgroundTransparency = 0.12,
    BorderSizePixel = 0,
    ZIndex = 5
}, MainFrame)
AddStroke(Sidebar, COLORS.Line, 0.93, 1)

local Brand = Create("Frame", {
    Name = "Brand",
    Position = UDim2.fromOffset(18, 20),
    Size = UDim2.new(1, -36, 0, 56),
    BackgroundTransparency = 1,
    ZIndex = 6
}, Sidebar)

local LogoWrap = Create("Frame", {
    Size = UDim2.fromOffset(44, 44),
    Position = UDim2.fromOffset(0, 6),
    BackgroundColor3 = COLORS.Card,
    BackgroundTransparency = 0.15,
    BorderSizePixel = 0,
    ZIndex = 7
}, Brand)
AddCorner(LogoWrap, 14)
AddStroke(LogoWrap, COLORS.Accent, 0.55, 1)

Create("ImageLabel", {
    Size = UDim2.fromOffset(28, 28),
    Position = UDim2.fromOffset(8, 8),
    BackgroundTransparency = 1,
    Image = ASSETS.logo,
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 8
}, LogoWrap)

Create("TextLabel", {
    Position = UDim2.fromOffset(56, 8),
    Size = UDim2.new(1, -56, 0, 22),
    BackgroundTransparency = 1,
    Text = "CSS JAVA",
    TextColor3 = COLORS.Text,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 7
}, Brand)

Create("TextLabel", {
    Position = UDim2.fromOffset(56, 30),
    Size = UDim2.new(1, -56, 0, 16),
    BackgroundTransparency = 1,
    Text = "Control panel",
    TextColor3 = COLORS.Muted,
    TextSize = 11,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 7
}, Brand)

local MenuContainer = Create("Frame", {
    Name = "Menu",
    Position = UDim2.fromOffset(14, 96),
    Size = UDim2.new(1, -28, 0, 300),
    BackgroundTransparency = 1,
    ZIndex = 7
}, Sidebar)

Create("UIListLayout", {
    FillDirection = Enum.FillDirection.Vertical,
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
}, MenuContainer)

local Content = Create("Frame", {
    Name = "Content",
    Position = UDim2.fromOffset(CONFIG.SidebarWidth, 0),
    Size = UDim2.new(1, -CONFIG.SidebarWidth, 1, 0),
    BackgroundTransparency = 1,
    ZIndex = 4
}, MainFrame)

local TopBar = Create("Frame", {
    Name = "TopBar",
    Position = UDim2.fromOffset(28, 22),
    Size = UDim2.new(1, -56, 0, 52),
    BackgroundTransparency = 1,
    ZIndex = 8
}, Content)

local CurrentTitle = Create("TextLabel", {
    Size = UDim2.new(1, -110, 0, 28),
    BackgroundTransparency = 1,
    Text = "Aim",
    TextColor3 = COLORS.Text,
    TextSize = 24,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, TopBar)

local CurrentSubtitle = Create("TextLabel", {
    Position = UDim2.fromOffset(0, 28),
    Size = UDim2.new(1, -110, 0, 18),
    BackgroundTransparency = 1,
    Text = "Targeting options",
    TextColor3 = COLORS.Secondary,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, TopBar)

local function MakeIconButton(name, text, xOffset)
    local button = Create("TextButton", {
        Name = name,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, xOffset, 0, 6),
        Size = UDim2.fromOffset(36, 36),
        BackgroundColor3 = COLORS.Card,
        BackgroundTransparency = 0.12,
        BorderSizePixel = 0,
        Text = text,
        TextColor3 = COLORS.Secondary,
        TextSize = 16,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = false,
        ZIndex = 10
    }, TopBar)
    AddCorner(button, 11)
    AddStroke(button, COLORS.Line, 0.9, 1)

    button.MouseEnter:Connect(function()
        Tween(button, { BackgroundTransparency = 0, TextColor3 = COLORS.Text })
    end)
    button.MouseLeave:Connect(function()
        Tween(button, { BackgroundTransparency = 0.12, TextColor3 = COLORS.Secondary })
    end)
    return button
end

local CloseButton = MakeIconButton("Close", "×", 0)
local DragButton = MakeIconButton("Drag", "⠿", -44)

CloseButton.MouseEnter:Connect(function()
    Tween(CloseButton, { BackgroundColor3 = Color3.fromRGB(70, 24, 34), TextColor3 = COLORS.Danger })
end)
CloseButton.MouseLeave:Connect(function()
    Tween(CloseButton, { BackgroundColor3 = COLORS.Card, TextColor3 = COLORS.Secondary })
end)

local PagesFolder = Create("Folder", { Name = "PagesFolder" }, Content)

local function CreateCard(parent, name, position, size)
    local card = Create("Frame", {
        Name = name,
        Position = position,
        Size = size,
        BackgroundColor3 = COLORS.Card,
        BackgroundTransparency = 0.12,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 8
    }, parent)
    AddCorner(card, 16)
    AddStroke(card, COLORS.Line, 0.9, 1)
    Create("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = COLORS.Glass,
        BackgroundTransparency = 0.9,
        BorderSizePixel = 0,
        ZIndex = 9
    }, card)
    return card
end

local function CreateToggle(parent, text, yOffset, callback)
    local row = Create("Frame", {
        Position = UDim2.fromOffset(20, yOffset),
        Size = UDim2.new(1, -40, 0, 44),
        BackgroundTransparency = 1,
        ZIndex = 10
    }, parent)

    Create("TextLabel", {
        Size = UDim2.new(1, -78, 1, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.Text,
        TextSize = 14,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 11
    }, row)

    local toggle = Create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.fromOffset(48, 26),
        BackgroundColor3 = COLORS.ToggleOff,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 11
    }, row)
    AddCorner(toggle, 13)

    local circle = Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 3, 0.5, 0),
        Size = UDim2.fromOffset(20, 20),
        BackgroundColor3 = COLORS.Secondary,
        BorderSizePixel = 0,
        ZIndex = 12
    }, toggle)
    AddCorner(circle, 10)

    local state = false
    local function setState(value)
        state = value
        if state then
            Tween(toggle, { BackgroundColor3 = COLORS.Accent })
            Tween(circle, { Position = UDim2.new(1, -23, 0.5, 0), BackgroundColor3 = COLORS.Text })
        else
            Tween(toggle, { BackgroundColor3 = COLORS.ToggleOff })
            Tween(circle, { Position = UDim2.new(0, 3, 0.5, 0), BackgroundColor3 = COLORS.Secondary })
        end
        if callback then
            callback(state)
        end
    end

    toggle.Activated:Connect(function()
        setState(not state)
    end)

    return setState
end

-- AIM
local AimPage = Create("Frame", {
    Name = "AimPage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = true,
    ZIndex = 4
}, PagesFolder)

local AimCard = CreateCard(AimPage, "AimCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 268))
Create("TextLabel", {
    Position = UDim2.fromOffset(22, 16),
    Size = UDim2.new(1, -44, 0, 18),
    BackgroundTransparency = 1,
    Text = "AIM",
    TextColor3 = COLORS.AccentSoft,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, AimCard)
Create("TextLabel", {
    Position = UDim2.fromOffset(22, 36),
    Size = UDim2.new(1, -44, 0, 20),
    BackgroundTransparency = 1,
    Text = "Targeting",
    TextColor3 = COLORS.Text,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, AimCard)

CreateToggle(AimCard, "Enabled", 78)
CreateToggle(AimCard, "Preview", 130)
CreateToggle(AimCard, "Advanced", 182)

local InfoCard = CreateCard(AimPage, "InfoCard", UDim2.fromOffset(28, 376), UDim2.new(1, -56, 0, 86))
Create("TextLabel", {
    Position = UDim2.fromOffset(22, 16),
    Size = UDim2.new(1, -44, 0, 18),
    BackgroundTransparency = 1,
    Text = "INTERFACE",
    TextColor3 = COLORS.AccentSoft,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, InfoCard)
Create("TextLabel", {
    Position = UDim2.fromOffset(22, 38),
    Size = UDim2.new(1, -44, 0, 32),
    BackgroundTransparency = 1,
    Text = "Visual shell only. Window size is unchanged.",
    TextColor3 = COLORS.Secondary,
    TextSize = 13,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = true,
    ZIndex = 9
}, InfoCard)

-- WH
local WhPage = Create("Frame", {
    Name = "WhPage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)

local WhCard = CreateCard(WhPage, "WhCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 132))
Create("TextLabel", {
    Position = UDim2.fromOffset(22, 16),
    Size = UDim2.new(1, -44, 0, 18),
    BackgroundTransparency = 1,
    Text = "VISUALS",
    TextColor3 = COLORS.AccentSoft,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, WhCard)
CreateToggle(WhCard, "Highlights", 60)

local DropdownButton = Create("TextButton", {
    Position = UDim2.fromOffset(20, 104),
    Size = UDim2.new(1, -40, 0, 20),
    BackgroundTransparency = 1,
    Text = "Advanced settings   ▾",
    TextColor3 = COLORS.Muted,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 11
}, WhCard)

local SubContainer = Create("Frame", {
    Position = UDim2.fromOffset(8, 128),
    Size = UDim2.new(1, -16, 0, 210),
    BackgroundTransparency = 1,
    ZIndex = 10
}, WhCard)

CreateToggle(SubContainer, "Roles", 0)
CreateToggle(SubContainer, "Health", 50)
CreateToggle(SubContainer, "Armor", 100)
CreateToggle(SubContainer, "Distance", 150)

local dropdownOpen = false
DropdownButton.Activated:Connect(function()
    dropdownOpen = not dropdownOpen
    DropdownButton.Text = dropdownOpen and "Advanced settings   ▴" or "Advanced settings   ▾"
    Tween(WhCard, {
        Size = dropdownOpen and UDim2.new(1, -56, 0, 348) or UDim2.new(1, -56, 0, 132)
    }, 0.22)
end)

-- MOVEMENT
local MovementPage = Create("Frame", {
    Name = "MovementPage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false,
    ZIndex = 4
}, PagesFolder)

local MovementCard = CreateCard(MovementPage, "MovementCard", UDim2.fromOffset(28, 92), UDim2.new(1, -56, 0, 150))
Create("TextLabel", {
    Position = UDim2.fromOffset(22, 16),
    Size = UDim2.new(1, -44, 0, 18),
    BackgroundTransparency = 1,
    Text = "MOVEMENT",
    TextColor3 = COLORS.AccentSoft,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, MovementCard)
CreateToggle(MovementCard, "Faster walk", 72)

local OtherPage = Create("Frame", {
    Name = "OtherPage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false
}, PagesFolder)

local SettingsPage = Create("Frame", {
    Name = "SettingsPage",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Visible = false
}, PagesFolder)

local PlayerPanel = Create("Frame", {
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 14, 1, -16),
    Size = UDim2.new(1, -28, 0, 58),
    BackgroundColor3 = COLORS.Card,
    BackgroundTransparency = 0.18,
    BorderSizePixel = 0,
    ZIndex = 8
}, Sidebar)
AddCorner(PlayerPanel, 14)
AddStroke(PlayerPanel, COLORS.Line, 0.9, 1)

local PlayerIcon = Create("ImageLabel", {
    Position = UDim2.fromOffset(9, 9),
    Size = UDim2.fromOffset(40, 40),
    BackgroundTransparency = 1,
    Image = ASSETS.player,
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 9
}, PlayerPanel)
AddCorner(PlayerIcon, 20)

Create("TextLabel", {
    Position = UDim2.fromOffset(56, 10),
    Size = UDim2.new(1, -66, 0, 20),
    BackgroundTransparency = 1,
    Text = Player and Player.Name or "Player",
    TextColor3 = COLORS.Text,
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
    ZIndex = 9
}, PlayerPanel)

Create("TextLabel", {
    Position = UDim2.fromOffset(56, 30),
    Size = UDim2.new(1, -66, 0, 16),
    BackgroundTransparency = 1,
    Text = "Online",
    TextColor3 = COLORS.AccentSoft,
    TextSize = 11,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 9
}, PlayerPanel)

local MenuItems = {
    { Name = "Aim", Key = "AIM", Icon = ASSETS.aim, Subtitle = "Targeting options", Page = AimPage },
    { Name = "Visuals", Key = "WH", Icon = ASSETS.wh, Subtitle = "Display options", Page = WhPage },
    { Name = "Movement", Key = "MOVEMENT", Icon = ASSETS.movement, Subtitle = "Motion options", Page = MovementPage },
    { Name = "Other", Key = "OTHER", Icon = ASSETS.settings, Subtitle = "Extra options", Page = OtherPage },
    { Name = "Settings", Key = "SETTINGS", Icon = ASSETS.settings, Subtitle = "Interface", Page = SettingsPage }
}

local MenuButtons = {}

local function SelectTab(index)
    local selected = MenuItems[index]
    if not selected then
        return
    end

    CurrentTitle.Text = selected.Name
    CurrentSubtitle.Text = selected.Subtitle

    AimPage.Visible = selected.Page == AimPage
    WhPage.Visible = selected.Page == WhPage
    MovementPage.Visible = selected.Page == MovementPage
    OtherPage.Visible = selected.Page == OtherPage
    SettingsPage.Visible = selected.Page == SettingsPage

    for i, data in ipairs(MenuButtons) do
        local active = i == index
        Tween(data.Button, {
            BackgroundColor3 = active and COLORS.Accent or COLORS.Card,
            BackgroundTransparency = active and 0.08 or 1
        })
        Tween(data.Icon, { ImageColor3 = active and COLORS.Text or COLORS.Secondary })
        Tween(data.Label, { TextColor3 = active and COLORS.Text or COLORS.Secondary })
        Tween(data.Indicator, { BackgroundTransparency = active and 0 or 1 })
    end
end

for index, data in ipairs(MenuItems) do
    local button = Create("TextButton", {
        Size = UDim2.new(1, 0, 0, 46),
        BackgroundColor3 = COLORS.Card,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = index,
        ZIndex = 8
    }, MenuContainer)
    AddCorner(button, 12)

    local indicator = Create("Frame", {
        Position = UDim2.fromOffset(0, 12),
        Size = UDim2.fromOffset(3, 22),
        BackgroundColor3 = COLORS.Text,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 10
    }, button)
    AddCorner(indicator, 2)

    local icon = Create("ImageLabel", {
        Position = UDim2.fromOffset(16, 11),
        Size = UDim2.fromOffset(24, 24),
        BackgroundTransparency = 1,
        Image = data.Icon,
        ImageColor3 = COLORS.Secondary,
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 9
    }, button)

    local label = Create("TextLabel", {
        Position = UDim2.fromOffset(48, 0),
        Size = UDim2.new(1, -56, 1, 0),
        BackgroundTransparency = 1,
        Text = data.Name,
        TextColor3 = COLORS.Secondary,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 9
    }, button)

    button.MouseEnter:Connect(function()
        if MenuItems[index].Page.Visible then
            return
        end
        Tween(button, { BackgroundTransparency = 0.72 })
    end)
    button.MouseLeave:Connect(function()
        if MenuItems[index].Page.Visible then
            return
        end
        Tween(button, { BackgroundTransparency = 1 })
    end)
    button.Activated:Connect(function()
        SelectTab(index)
    end)

    table.insert(MenuButtons, {
        Button = button,
        Icon = icon,
        Label = label,
        Indicator = indicator
    })
end

SelectTab(1)

local camera = workspace.CurrentCamera
local function UpdateScale()
    camera = workspace.CurrentCamera
    if not camera then
        return
    end
    local viewport = camera.ViewportSize
    local scale = math.clamp(
        math.min((viewport.X - 20) / CONFIG.WindowSize.X, (viewport.Y - 20) / CONFIG.WindowSize.Y),
        CONFIG.MinScale,
        CONFIG.MaxScale
    )
    UIScale.Scale = scale
end
UpdateScale()
if camera then
    camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
end

local dragging, dragStart, startPosition = false, nil, nil
local function beginDrag(input)
    dragging = true
    dragStart = input.Position
    startPosition = MainFrame.Position
end
local function connectDrag(object)
    object.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            beginDrag(input)
        end
    end)
end
connectDrag(TopBar)
connectDrag(DragButton)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local closed = false
local reopen = Create("TextButton", {
    Name = "ReopenButton",
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, -24, 1, -24),
    Size = UDim2.fromOffset(52, 52),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0,
    Text = "",
    AutoButtonColor = false,
    Visible = false,
    ZIndex = 100
}, ScreenGui)
AddCorner(reopen, 18)
AddStroke(reopen, COLORS.Glass, 0.7, 1)
Create("ImageLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(26, 26),
    BackgroundTransparency = 1,
    Image = ASSETS.logo,
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 101
}, reopen)

local reopenDragging, reopenStart, reopenPos, reopenMoved = false, nil, nil, false
reopen.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        reopenDragging = true
        reopenStart = input.Position
        reopenPos = reopen.Position
        reopenMoved = false
        reopen.AnchorPoint = Vector2.new(0, 0)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if reopenDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - reopenStart
        if delta.Magnitude > 5 then
            reopenMoved = true
        end
        reopen.Position = UDim2.new(
            reopenPos.X.Scale, reopenPos.X.Offset + delta.X,
            reopenPos.Y.Scale, reopenPos.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        reopenDragging = false
    end
end)

CloseButton.Activated:Connect(function()
    if closed then
        return
    end
    closed = true
    BackgroundLayer.Visible = false
    Tween(MainFrame, {
        Size = UDim2.fromOffset(CONFIG.WindowSize.X * 0.94, CONFIG.WindowSize.Y * 0.94)
    }, 0.14)
    task.wait(0.12)
    MainFrame.Visible = false
    reopen.Visible = true
end)

reopen.Activated:Connect(function()
    if reopenMoved then
        reopenMoved = false
        return
    end
    closed = false
    BackgroundLayer.Visible = true
    MainFrame.Visible = true
    MainFrame.Size = UDim2.fromOffset(CONFIG.WindowSize.X * 0.94, CONFIG.WindowSize.Y * 0.94)
    Tween(MainFrame, {
        Size = UDim2.fromOffset(CONFIG.WindowSize.X, CONFIG.WindowSize.Y)
    }, 0.18)
    reopen.Visible = false
    task.defer(UpdateScale)
end)

print("[CSS JAVA] UI redesign loaded. Size 1000x620.")
