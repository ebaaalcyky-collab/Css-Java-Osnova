--// CSS JAVA - Main.lua (FULL & FIXED VERSION)
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

--//==================================================
--// SERVICES
--//==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

-- Безопасный родительский контейнер для GUI (фикс для любых инжекторов)
local ParentContainer = (gethui and gethui()) or CoreGui or Player:WaitForChild("PlayerGui")

--//==================================================
--// CONFIG
--//==================================================

local CONFIG = {
    WindowSize = Vector2.new(1000, 620),

    MinScale = 0.42,
    MaxScale = 1,

    CornerRadius = 16,

    BackgroundTransparency = 0,
    BackgroundOverlayTransparency = 0.45,
    WindowTransparency = 0.04,

    SidebarWidth = 225,

    AnimationTime = 0.18,
    
    MaxEspDistance = 250
}

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
--// COLORS
--//==================================================

local COLORS = {
    Background = Color3.fromRGB(9, 10, 14),
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
    White = Color3.fromRGB(255, 255, 255),
    Health = Color3.fromRGB(46, 204, 113),
    Armor = Color3.fromRGB(52, 152, 219)
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
    return Create("UICorner", { CornerRadius = UDim.new(0, radius) }, parent)
end

local function AddStroke(parent, color, transparency, thickness)
    return Create("UIStroke", {
        Color = color,
        Transparency = transparency or 0,
        Thickness = thickness or 1
    }, parent)
end

local function Tween(object, properties, duration)
    if not object then return end
    TweenService:Create(
        object,
        TweenInfo.new(duration or CONFIG.AnimationTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        properties
    ):Play()
end

--//==================================================
--// GUI ROOT
--//==================================================

if ParentContainer:FindFirstChild("CSS_JAVA_GUI") then
    ParentContainer:FindFirstChild("CSS_JAVA_GUI"):Destroy()
end

local ScreenGui = Create("ScreenGui", {
    Name = "CSS_JAVA_GUI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999
}, ParentContainer)

--//==================================================
--// FULL SCREEN BACKGROUND
--//==================================================

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
    BorderSizePixel = 0,
    Image = ASSETS.background,
    ImageColor3 = Color3.fromRGB(255, 255, 255),
    ImageTransparency = CONFIG.BackgroundTransparency,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 0
}, BackgroundLayer)

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
--// SCALE SYSTEM
--//==================================================

local UIScale = Create("UIScale", { Scale = 1 })

--//==================================================
--// MAIN WINDOW
--//==================================================

local MainFrame = Create("Frame", {
    Name = "MainWindow",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(CONFIG.WindowSize.X, CONFIG.WindowSize.Y),
    BackgroundColor3 = COLORS.Panel,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 3
}, ScreenGui)

UIScale.Parent = MainFrame

AddCorner(MainFrame, CONFIG.CornerRadius)
AddStroke(MainFrame, COLORS.Border, 0.2, 1)

local WindowBackdrop = Create("Frame", {
    Name = "WindowBackdrop",
    Position = UDim2.fromScale(0, 0),
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = COLORS.Panel,
    BackgroundTransparency = CONFIG.WindowTransparency,
    BorderSizePixel = 0,
    ZIndex = 3
}, MainFrame)

AddCorner(WindowBackdrop, CONFIG.CornerRadius)

--//==================================================
--// SIDEBAR
--//==================================================

local Sidebar = Create("Frame", {
    Name = "Sidebar",
    Position = UDim2.fromOffset(0, 0),
    Size = UDim2.new(0, CONFIG.SidebarWidth, 1, 0),
    BackgroundColor3 = COLORS.Sidebar,
    BackgroundTransparency = 0.06,
    BorderSizePixel = 0,
    ZIndex = 5
}, MainFrame)

AddStroke(Sidebar, COLORS.Border, 0.35, 1)

-- BRAND
local Brand = Create("Frame", { Name = "Brand", Position = UDim2.fromOffset(20, 22), Size = UDim2.new(1, -40, 0, 58), BackgroundTransparency = 1, ZIndex = 6 }, Sidebar)
local Logo = Create("ImageLabel", { Name = "Logo", Position = UDim2.fromOffset(0, 3), Size = UDim2.fromOffset(48, 48), BackgroundTransparency = 1, Image = ASSETS.logo, ScaleType = Enum.ScaleType.Fit, ZIndex = 7 }, Brand)
AddCorner(Logo, 12)

Create("TextLabel", { Name = "Title", Position = UDim2.fromOffset(60, 3), Size = UDim2.new(1, -60, 0, 25), BackgroundTransparency = 1, Text = "CSS JAVA", TextColor3 = COLORS.Text, TextSize = 19, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 7 }, Brand)
Create("TextLabel", { Name = "Subtitle", Position = UDim2.fromOffset(60, 28), Size = UDim2.new(1, -60, 0, 20), BackgroundTransparency = 1, Text = "CONTROL PANEL", TextColor3 = COLORS.SecondaryText, TextSize = 9, Font = Enum.Font.GothamMedium, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 7 }, Brand)

-- SIDEBAR MENU CONTAINER
local MenuContainer = Create("Frame", { Name = "Menu", Position = UDim2.fromOffset(12, 105), Size = UDim2.new(1, -24, 0, 280), BackgroundTransparency = 1, ZIndex = 7 }, Sidebar)
Create("UIListLayout", { FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 7) }, MenuContainer)

--//==================================================
--// CONTENT
--//==================================================

local Content = Create("Frame", { Name = "Content", Position = UDim2.fromOffset(CONFIG.SidebarWidth, 0), Size = UDim2.new(1, -CONFIG.SidebarWidth, 1, 0), BackgroundTransparency = 1, ZIndex = 4 }, MainFrame)
local TopBar = Create("Frame", { Name = "TopBar", Position = UDim2.fromOffset(30, 25), Size = UDim2.new(1, -60, 0, 50), BackgroundTransparency = 1, ZIndex = 8 }, Content)

local CurrentTitle = Create("TextLabel", { Name = "CurrentTitle", Position = UDim2.fromOffset(0, 0), Size = UDim2.new(1, -130, 0, 29), BackgroundTransparency = 1, Text = "AIM", TextColor3 = COLORS.Text, TextSize = 24, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9 }, TopBar)
local CurrentSubtitle = Create("TextLabel", { Name = "CurrentSubtitle", Position = UDim2.fromOffset(0, 29), Size = UDim2.new(1, -130, 0, 20), BackgroundTransparency = 1, Text = "Basic configuration panel", TextColor3 = COLORS.SecondaryText, TextSize = 12, Font = Enum.Font.GothamMedium, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9 }, TopBar)

-- BUTTONS: CLOSE & DRAG
local CloseButton = Create("TextButton", { Name = "Close", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.fromOffset(38, 38), BackgroundColor3 = COLORS.Card, BackgroundTransparency = 0.1, BorderSizePixel = 0, Text = "×", TextColor3 = COLORS.SecondaryText, TextSize = 22, Font = Enum.Font.GothamMedium, AutoButtonColor = false, ZIndex = 10 }, TopBar)
AddCorner(CloseButton, 10)
AddStroke(CloseButton, COLORS.Border, 0.25, 1)

CloseButton.MouseEnter:Connect(function() Tween(CloseButton, { BackgroundColor3 = Color3.fromRGB(75, 35, 45), TextColor3 = COLORS.White }) end)
CloseButton.MouseLeave:Connect(function() Tween(CloseButton, { BackgroundColor3 = COLORS.Card, TextColor3 = COLORS.SecondaryText }) end)

local DragButton = Create("TextButton", { Name = "DragButton", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -47, 0, 0), Size = UDim2.fromOffset(38, 38), BackgroundColor3 = COLORS.Card, BackgroundTransparency = 0.1, BorderSizePixel = 0, Text = "⠿", TextColor3 = COLORS.SecondaryText, TextSize = 20, Font = Enum.Font.GothamBold, AutoButtonColor = false, ZIndex = 10 }, TopBar)
AddCorner(DragButton, 10)
AddStroke(DragButton, COLORS.Border, 0.25, 1)

-- PAGES FOLDER
local PagesFolder = Create("Folder", { Name = "PagesFolder" }, Content)

--//==================================================
--// HELPER TO CREATE TOGGLE
--//==================================================

local function CreateToggle(parent, text, yOffset, callback)
    local Row = Create("Frame", { Name = text .. "Row", Position = UDim2.fromOffset(20, yOffset), Size = UDim2.new(1, -40, 0, 44), BackgroundTransparency = 1, ZIndex = 10 }, parent)

    Create("TextLabel", { Name = "Label", Position = UDim2.fromOffset(0, 0), Size = UDim2.new(1, -90, 1, 0), BackgroundTransparency = 1, Text = text, TextColor3 = COLORS.Text, TextSize = 13, Font = Enum.Font.GothamMedium, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center, ZIndex = 11 }, Row)

    local Toggle = Create("TextButton", { Name = "Toggle", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(56, 30), BackgroundColor3 = COLORS.ToggleOff, BorderSizePixel = 0, Text = "", AutoButtonColor = false, ZIndex = 11 }, Row)
    AddCorner(Toggle, 15)

    local Circle = Create("Frame", { Name = "Circle", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.fromOffset(22, 22), BackgroundColor3 = COLORS.SecondaryText, BorderSizePixel = 0, ZIndex = 12 }, Toggle)
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

    Toggle.Activated:Connect(function() SetState(not State) end)
    return Row
end

--//==================================================
--// PAGES CONTENT
--//==================================================

-- 1. AIM PAGE
local AimPage = Create("Frame", { Name = "AimPage", Position = UDim2.fromOffset(0, 0), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = true, ZIndex = 4 }, PagesFolder)
local AimCard = Create("Frame", { Name = "DemoSettings", Position = UDim2.fromOffset(30, 105), Size = UDim2.new(1, -60, 0, 250), BackgroundColor3 = COLORS.Card, BackgroundTransparency = 0.08, BorderSizePixel = 0, ZIndex = 8 }, AimPage)
AddCorner(AimCard, 14)
AddStroke(AimCard, COLORS.Border, 0.25, 1)

Create("TextLabel", { Name = "CardTitle", Position = UDim2.fromOffset(22, 18), Size = UDim2.new(1, -44, 0, 25), BackgroundTransparency = 1, Text = "DEMONSTRATION", TextColor3 = COLORS.Text, TextSize = 13, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9 }, AimCard)
CreateToggle(AimCard, "Enabled", 72)
CreateToggle(AimCard, "Preview", 124)
CreateToggle(AimCard, "Advanced", 176)

-- 2. WH PAGE
local WhPage = Create("Frame", { Name = "WhPage", Position = UDim2.fromOffset(0, 0), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 4 }, PagesFolder)
local WhCard = Create("Frame", { Name = "WhSettings", Position = UDim2.fromOffset(30, 105), Size = UDim2.new(1, -60, 0, 130), BackgroundColor3 = COLORS.Card, BackgroundTransparency = 0.08, BorderSizePixel = 0, ClipsDescendants = true, ZIndex = 8 }, WhPage)
AddCorner(WhCard, 14)
AddStroke(WhCard, COLORS.Border, 0.25, 1)

Create("TextLabel", { Name = "CardTitle", Position = UDim2.fromOffset(22, 18), Size = UDim2.new(1, -44, 0, 25), BackgroundTransparency = 1, Text = "VISUALS", TextColor3 = COLORS.Text, TextSize = 13, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9 }, WhCard)

local ESP_SETTINGS = { Enabled = false, Roles = true, Health = true, Armor = true, Distance = true }

CreateToggle(WhCard, "Wh", 60, function(state) ESP_SETTINGS.Enabled = state end)

local DropdownButton = Create("TextButton", { Name = "DropdownButton", Position = UDim2.fromOffset(20, 108), Size = UDim2.new(1, -40, 0, 18), BackgroundTransparency = 1, Text = "▼", TextColor3 = COLORS.SecondaryText, TextSize = 12, Font = Enum.Font.GothamBold, ZIndex = 11 }, WhCard)
local isDropdownOpen = false

DropdownButton.Activated:Connect(function()
    isDropdownOpen = not isDropdownOpen
    DropdownButton.Text = isDropdownOpen and "▲" or "▼"
    Tween(WhCard, { Size = UDim2.new(1, -60, 0, isDropdownOpen and 350 or 130) })
end)

local SubContainer = Create("Frame", { Name = "SubContainer", Position = UDim2.fromOffset(20, 130), Size = UDim2.new(1, -40, 0, 210), BackgroundTransparency = 1, ZIndex = 10 }, WhCard)
CreateToggle(SubContainer, "Roles", 0, function(state) ESP_SETTINGS.Roles = state end)
CreateToggle(SubContainer, "Health Bar", 50, function(state) ESP_SETTINGS.Health = state end)
CreateToggle(SubContainer, "Armor Bar", 100, function(state) ESP_SETTINGS.Armor = state end)
CreateToggle(SubContainer, "Distance", 150, function(state) ESP_SETTINGS.Distance = state end)

--// ================= ESP LOGIC =================
local EspStorage = Instance.new("Folder")
EspStorage.Name = "CSS_ESP_STORAGE"
EspStorage.Parent = ParentContainer

local function RemoveEsp(targetPlr)
    local old = EspStorage:FindFirstChild(targetPlr.Name)
    if old then old:Destroy() end
    if targetPlr.Character then
        local hl = targetPlr.Character:FindFirstChild("CSS_ESP_HL")
        if hl then hl:Destroy() end
    end
end

RunService.RenderStepped:Connect(function()
    if not ESP_SETTINGS.Enabled then
        EspStorage:ClearAllChildren()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                local hl = plr.Character:FindFirstChild("CSS_ESP_HL")
                if hl then hl:Destroy() end
            end
        end
        return
    end

    local myChar = Player.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            local char = plr.Character
            local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")

            if hrp and myHrp then
                local dist = (myHrp.Position - hrp.Position).Magnitude

                if dist <= CONFIG.MaxEspDistance then
                    local hl = char:FindFirstChild("CSS_ESP_HL")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "CSS_ESP_HL"
                        hl.Adornee = char
                        hl.FillColor = COLORS.Accent
                        hl.FillTransparency = 0.6
                        hl.OutlineColor = COLORS.White
                        hl.Parent = char
                    end

                    local gui = EspStorage:FindFirstChild(plr.Name)
                    if not gui then
                        gui = Instance.new("BillboardGui")
                        gui.Name = plr.Name
                        gui.Size = UDim2.fromOffset(160, 70)
                        gui.StudsOffset = Vector3.new(0, 3.5, 0)
                        gui.AlwaysOnTop = true

                        local c = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 }, gui)
                        Create("TextLabel", { Name = "NameL", Size = UDim2.new(1,0,0,14), Position = UDim2.fromOffset(0,0), BackgroundTransparency = 1, Text = plr.Name, TextColor3 = COLORS.White, TextSize = 12, Font = Enum.Font.GothamBold }, c)
                        Create("TextLabel", { Name = "RoleL", Size = UDim2.new(1,0,0,14), Position = UDim2.fromOffset(0,14), BackgroundTransparency = 1, TextColor3 = COLORS.Accent, TextSize = 10, Font = Enum.Font.GothamMedium }, c)
                        Create("TextLabel", { Name = "StatsL", Size = UDim2.new(1,0,0,14), Position = UDim2.fromOffset(0,28), BackgroundTransparency = 1, TextColor3 = COLORS.Health, TextSize = 10, Font = Enum.Font.GothamBold }, c)
                        Create("TextLabel", { Name = "DistL", Size = UDim2.new(1,0,0,14), Position = UDim2.fromOffset(0,42), BackgroundTransparency = 1, TextColor3 = COLORS.SecondaryText, TextSize = 10, Font = Enum.Font.Gotham }, c)

                        gui.Parent = EspStorage
                    end

                    gui.Adornee = hrp

                    local container = gui:FindFirstChild("Frame")
                    if container then
                        local roleL = container:FindFirstChild("RoleL")
                        local statsL = container:FindFirstChild("StatsL")
                        local distL = container:FindFirstChild("DistL")

                        if roleL then
                            roleL.Visible = ESP_SETTINGS.Roles
                            roleL.Text = "[" .. GetRussianRole(plr) .. "]"
                        end

                        if statsL then
                            local hum = char:FindFirstChildOfClass("Humanoid")
                            local hp = hum and math.floor(hum.Health) or 0
                            local ap = 0
                            local ls = plr:FindFirstChild("leaderstats")
                            if ls and ls:FindFirstChild("Armor") then ap = math.floor(ls.Armor.Value) end

                            local parts = {}
                            if ESP_SETTINGS.Health then table.insert(parts, "HP: " .. hp) end
                            if ESP_SETTINGS.Armor then table.insert(parts, "AP: " .. ap) end
                            statsL.Text = table.concat(parts, " | ")
                            statsL.Visible = (#parts > 0)
                        end

                        if distL then
                            distL.Visible = ESP_SETTINGS.Distance
                            distL.Text = math.floor(dist) .. " m"
                        end
                    end
                else
                    RemoveEsp(plr)
                end
            end
        end
    end
end)

Players.PlayerRemoving:Connect(RemoveEsp)

-- 3. MOVEMENT PAGE
local MovementPage = Create("Frame", { Name = "MovementPage", Position = UDim2.fromOffset(0, 0), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 4 }, PagesFolder)
local MovementCard = Create("Frame", { Name = "MovementSettings", Position = UDim2.fromOffset(30, 105), Size = UDim2.new(1, -60, 0, 150), BackgroundColor3 = COLORS.Card, BackgroundTransparency = 0.08, BorderSizePixel = 0, ZIndex = 8 }, MovementPage)
AddCorner(MovementCard, 14)
AddStroke(MovementCard, COLORS.Border, 0.25, 1)

Create("TextLabel", { Name = "CardTitle", Position = UDim2.fromOffset(22, 18), Size = UDim2.new(1, -44, 0, 25), BackgroundTransparency = 1, Text = "MOVEMENT CONFIG", TextColor3 = COLORS.Text, TextSize = 13, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9 }, MovementCard)

local speedHackEnabled = false
RunService.RenderStepped:Connect(function()
    if speedHackEnabled and Player.Character then
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = 33 end
    end
end)

CreateToggle(MovementCard, "speed-hack", 72, function(state)
    speedHackEnabled = state
    if not state and Player.Character then
        local humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = 16 end
    end
end)

-- 4. OTHER PAGE
local OtherPage = Create("Frame", { Name = "OtherPage", Position = UDim2.fromOffset(0, 0), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 4 }, PagesFolder)
local OtherCard = Create("Frame", { Name = "OtherSettings", Position = UDim2.fromOffset(30, 105), Size = UDim2.new(1, -60, 0, 150), BackgroundColor3 = COLORS.Card, BackgroundTransparency = 0.08, BorderSizePixel = 0, ZIndex = 8 }, OtherPage)
AddCorner(OtherCard, 14)
AddStroke(OtherCard, COLORS.Border, 0.25, 1)
Create("TextLabel", { Name = "CardTitle", Position = UDim2.fromOffset(22, 18), Size = UDim2.new(1, -44, 0, 25), BackgroundTransparency = 1, Text = "OTHER SETTINGS", TextColor3 = COLORS.Text, TextSize = 13, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9 }, OtherCard)

-- 5. SETTINGS PAGE
local SettingsPage = Create("Frame", { Name = "SettingsPage", Position = UDim2.fromOffset(0, 0), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 4 }, PagesFolder)
local SettingsCard = Create("Frame", { Name = "SettingsContent", Position = UDim2.fromOffset(30, 105), Size = UDim2.new(1, -60, 0, 150), BackgroundColor3 = COLORS.Card, BackgroundTransparency = 0.08, BorderSizePixel = 0, ZIndex = 8 }, SettingsPage)
AddCorner(SettingsCard, 14)
AddStroke(SettingsCard, COLORS.Border, 0.25, 1)
Create("TextLabel", { Name = "CardTitle", Position = UDim2.fromOffset(22, 18), Size = UDim2.new(1, -44, 0, 25), BackgroundTransparency = 1, Text = "UI SETTINGS", TextColor3 = COLORS.Text, TextSize = 13, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9 }, SettingsCard)

--//==================================================
--// PLAYER PANEL (BOTTOM LEFT)
--//==================================================

local PlayerPanel = Create("Frame", { Name = "PlayerPanel", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 12, 1, -15), Size = UDim2.new(1, -24, 0, 55), BackgroundColor3 = COLORS.Card, BackgroundTransparency = 0.12, BorderSizePixel = 0, ZIndex = 8 }, Sidebar)
AddCorner(PlayerPanel, 12)
AddStroke(PlayerPanel, COLORS.Border, 0.3, 1)

local PlayerIcon = Create("ImageLabel", { Name = "PlayerIcon", Position = UDim2.fromOffset(8, 7), Size = UDim2.fromOffset(40, 40), BackgroundTransparency = 1, Image = ASSETS.player, ScaleType = Enum.ScaleType.Fit, ZIndex = 9 }, PlayerPanel)
AddCorner(PlayerIcon, 20)

Create("TextLabel", { Name = "PlayerName", Position = UDim2.fromOffset(57, 7), Size = UDim2.new(1, -65, 0, 22), BackgroundTransparency = 1, Text = Player and Player.Name or "Player", TextColor3 = COLORS.Text, TextSize = 12, Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 9 }, PlayerPanel)
Create("TextLabel", { Name = "PlayerRole", Position = UDim2.fromOffset(57, 28), Size = UDim2.new(1, -65, 0, 17), BackgroundTransparency = 1, Text = "CSS JAVA", TextColor3 = COLORS.SecondaryText, TextSize = 9, Font = Enum.Font.GothamMedium, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9 }, PlayerPanel)

--//==================================================
--// NAVIGATION SYSTEM
--//==================================================

local MenuItems = {
    { Name = "AIM", Icon = ASSETS.aim, Subtitle = "Basic configuration panel", Page = AimPage },
    { Name = "WH", Icon = ASSETS.wh, Subtitle = "Visual configuration panel", Page = WhPage },
    { Name = "MOVEMENT", Icon = ASSETS.movement, Subtitle = "Movement configuration panel", Page = MovementPage },
    { Name = "OTHER", Icon = ASSETS.settings, Subtitle = "Other configuration panel", Page = OtherPage },
    { Name = "SETTINGS", Icon = ASSETS.settings, Subtitle = "Interface settings", Page = SettingsPage }
}

local MenuButtons = {}

local function SelectTab(index)
    local selected = MenuItems[index]
    if not selected then return end

    CurrentTitle.Text = selected.Name
    CurrentSubtitle.Text = selected.Subtitle

    AimPage.Visible = (selected.Page == AimPage)
    WhPage.Visible = (selected.Page == WhPage)
    MovementPage.Visible = (selected.Page == MovementPage)
    OtherPage.Visible = (selected.Page == OtherPage)
    SettingsPage.Visible = (selected.Page == SettingsPage)

    for i, buttonData in ipairs(MenuButtons) do
        local Button = buttonData.Button
        local Icon = buttonData.Icon
        local Indicator = buttonData.Indicator

        if i == index then
            Tween(Button, { BackgroundColor3 = COLORS.Accent, BackgroundTransparency = 0.08 })
            Tween(Icon, { ImageColor3 = COLORS.White, ImageTransparency = 0 })
            Tween(Indicator, { BackgroundTransparency = 0 })
        else
            Tween(Button, { BackgroundColor3 = COLORS.Card, BackgroundTransparency = 1 })
            Tween(Icon, { ImageColor3 = COLORS.SecondaryText, ImageTransparency = 0 })
            Tween(Indicator, { BackgroundTransparency = 1 })
        end
    end
end

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

    Create("TextLabel", {
        Name = "Text",
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

    Button.Activated:Connect(function() SelectTab(index) end)

    table.insert(MenuButtons, { Button = Button, Icon = Icon, Indicator = Indicator })
end

SelectTab(1)

--//==================================================
--// RESPONSIVE SCALING & DRAGGING
--//==================================================

local function UpdateScale()
    local Camera = workspace.CurrentCamera
    if not Camera then return end
    local viewport = Camera.ViewportSize
    local horizontalScale = (viewport.X - 20) / CONFIG.WindowSize.X
    local verticalScale = (viewport.Y - 20) / CONFIG.WindowSize.Y
    UIScale.Scale = math.clamp(math.min(horizontalScale, verticalScale), CONFIG.MinScale, CONFIG.MaxScale)
end

UpdateScale()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)

local Dragging, DragStart, StartPosition = false, nil, nil

local function ConnectDrag(object)
    object.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = MainFrame.Position
        end
    end)
end

ConnectDrag(TopBar)
ConnectDrag(DragButton)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(
            StartPosition.X.Scale, StartPosition.X.Offset + delta.X,
            StartPosition.Y.Scale, StartPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        Dragging = false
    end
end)

--//==================================================
--// REOPEN BUTTON SYSTEM
--//==================================================

local Closed = false

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

local ReopenDragging, ReopenDragStart, ReopenStartPosition, ReopenHasMoved = false, nil, nil, false

ReopenButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        ReopenDragging = true
        ReopenDragStart = input.Position
        ReopenStartPosition = ReopenButton.Position
        ReopenHasMoved = false
        ReopenButton.AnchorPoint = Vector2.new(0, 0)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if ReopenDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - ReopenDragStart
        if delta.Magnitude > 5 then ReopenHasMoved = true end
        ReopenButton.Position = UDim2.new(
            ReopenStartPosition.X.Scale, ReopenStartPosition.X.Offset + delta.X,
            ReopenStartPosition.Y.Scale, ReopenStartPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        ReopenDragging = false
    end
end)

CloseButton.Activated:Connect(function()
    if Closed then return end
    Closed = true
    BackgroundLayer.Visible = false
    Tween(MainFrame, { Size = UDim2.fromOffset(CONFIG.WindowSize.X * 0.92, CONFIG.WindowSize.Y * 0.92) }, 0.15)
    task.wait(0.12)
    MainFrame.Visible = false
    DragButton.Visible = false
    ReopenButton.Visible = true
end)

ReopenButton.Activated:Connect(function()
    if ReopenHasMoved then ReopenHasMoved = false; return end
    Closed = false
    BackgroundLayer.Visible = true
    MainFrame.Visible = true
    DragButton.Visible = true
    Tween(MainFrame, { Size = UDim2.fromOffset(CONFIG.WindowSize.X, CONFIG.WindowSize.Y) }, 0.18)
    ReopenButton.Visible = false
    task.defer(UpdateScale)
end)

print("[CSS JAVA] Full script successfully loaded!")
