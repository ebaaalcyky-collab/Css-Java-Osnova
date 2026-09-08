--// CSS JAVA - Main.lua
--// GUI ONLY / DEBUG CONSOLE
--// Delta X diagnostic build

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local RAW_BASE =
    "https://raw.githubusercontent.com/ebaaalcyky-collab/Css-Java-Osnova/main/assets/"

local ASSETS = {
    background = RAW_BASE .. "background.png",
    logo       = RAW_BASE .. "logo.png",
    aim        = RAW_BASE .. "aim.png",
    wh         = RAW_BASE .. "wh.png",
    movement   = RAW_BASE .. "movement.png",
    settings   = RAW_BASE .. "settings.png",
    player     = RAW_BASE .. "player.png"
}

--==================================================
-- REMOVE OLD GUI
--==================================================

pcall(function()
    local old = CoreGui:FindFirstChild("CSS_JAVA_GUI")
    if old then
        old:Destroy()
    end
end)

--==================================================
-- HELPERS
--==================================================

local function New(class, props)
    local obj = Instance.new(class)

    for key, value in pairs(props or {}) do
        pcall(function()
            obj[key] = value
        end)
    end

    return obj
end

local function Corner(parent, radius)
    return New("UICorner", {
        Parent = parent,
        CornerRadius = UDim.new(0, radius)
    })
end

local function Stroke(parent, color, thickness, transparency)
    return New("UIStroke", {
        Parent = parent,
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0
    })
end

--==================================================
-- GUI
--==================================================

local GUI = New("ScreenGui", {
    Name = "CSS_JAVA_GUI",
    Parent = CoreGui,
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

local Scale = New("UIScale", {
    Parent = GUI,
    Scale = 0.82
})

local Main = New("Frame", {
    Name = "Main",
    Parent = GUI,
    Size = UDim2.new(0, 1000, 0, 620),
    Position = UDim2.new(0.5, -500, 0.5, -310),
    BackgroundColor3 = Color3.fromRGB(12, 12, 17),
    BorderSizePixel = 0
})

Corner(Main, 14)
Stroke(Main, Color3.fromRGB(45, 45, 55), 1)

--==================================================
-- TOP BAR
--==================================================

local TopBar = New("Frame", {
    Parent = Main,
    Size = UDim2.new(1, 0, 0, 55),
    BackgroundColor3 = Color3.fromRGB(17, 17, 23),
    BorderSizePixel = 0
})

Corner(TopBar, 14)

local Title = New("TextLabel", {
    Parent = TopBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 22, 0, 5),
    Size = UDim2.new(0, 400, 0, 45),
    Font = Enum.Font.GothamBold,
    Text = "CSS JAVA",
    TextSize = 22,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left
})

local Subtitle = New("TextLabel", {
    Parent = TopBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 140, 0, 7),
    Size = UDim2.new(0, 250, 0, 40),
    Font = Enum.Font.Gotham,
    Text = "DELTA DEBUG BUILD",
    TextSize = 12,
    TextColor3 = Color3.fromRGB(130, 130, 145),
    TextXAlignment = Enum.TextXAlignment.Left
})

--==================================================
-- CLOSE BUTTON
--==================================================

local Close = New("TextButton", {
    Parent = TopBar,
    Size = UDim2.new(0, 38, 0, 38),
    Position = UDim2.new(1, -47, 0, 8),
    BackgroundColor3 = Color3.fromRGB(30, 30, 38),
    BorderSizePixel = 0,
    Text = "×",
    Font = Enum.Font.GothamBold,
    TextSize = 24,
    TextColor3 = Color3.fromRGB(230, 230, 230),
    AutoButtonColor = false
})

Corner(Close, 9)

Close.MouseButton1Click:Connect(function()
    GUI.Enabled = false
end)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = New("Frame", {
    Parent = Main,
    Position = UDim2.new(0, 0, 0, 55),
    Size = UDim2.new(0, 190, 1, -55),
    BackgroundColor3 = Color3.fromRGB(15, 15, 21),
    BorderSizePixel = 0
})

local Logo = New("ImageLabel", {
    Parent = Sidebar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, -45, 0, 25),
    Size = UDim2.new(0, 90, 0, 90),
    Image = "",
    ScaleType = Enum.ScaleType.Fit
})

--==================================================
-- TABS
--==================================================

local Tabs = {
    {
        name = "AIM",
        image = ASSETS.aim
    },
    {
        name = "WALLHACK",
        image = ASSETS.wh
    },
    {
        name = "MOVEMENT",
        image = ASSETS.movement
    },
    {
        name = "SETTINGS",
        image = ASSETS.settings
    },
    {
        name = "PLAYER",
        image = ASSETS.player
    }
}

local TabButtons = {}

for i, tab in ipairs(Tabs) do

    local Button = New("TextButton", {
        Parent = Sidebar,
        Position = UDim2.new(0, 15, 0, 135 + ((i - 1) * 55)),
        Size = UDim2.new(1, -30, 0, 45),
        BackgroundColor3 = Color3.fromRGB(22, 22, 29),
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false
    })

    Corner(Button, 9)

    local Icon = New("ImageLabel", {
        Parent = Button,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0.5, -12),
        Size = UDim2.new(0, 24, 0, 24),
        Image = "",
        ScaleType = Enum.ScaleType.Fit
    })

    local Text = New("TextLabel", {
        Parent = Button,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 45, 0, 0),
        Size = UDim2.new(1, -50, 1, 0),
        Font = Enum.Font.GothamMedium,
        Text = tab.name,
        TextSize = 12,
        TextColor3 = Color3.fromRGB(190, 190, 200),
        TextXAlignment = Enum.TextXAlignment.Left
    })

    TabButtons[i] = Button
end

--==================================================
-- CONTENT
--==================================================

local Content = New("Frame", {
    Parent = Main,
    Position = UDim2.new(0, 190, 0, 55),
    Size = UDim2.new(1, -190, 1, -55),
    BackgroundColor3 = Color3.fromRGB(12, 12, 17),
    BorderSizePixel = 0
})

local PageTitle = New("TextLabel", {
    Parent = Content,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 25, 0, 20),
    Size = UDim2.new(1, -50, 0, 35),
    Font = Enum.Font.GothamBold,
    Text = "Dashboard",
    TextSize = 24,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left
})

--==================================================
-- INFO CARD
--==================================================

local InfoCard = New("Frame", {
    Parent = Content,
    Position = UDim2.new(0, 25, 0, 70),
    Size = UDim2.new(1, -50, 0, 135),
    BackgroundColor3 = Color3.fromRGB(18, 18, 25),
    BorderSizePixel = 0
})

Corner(InfoCard, 12)
Stroke(InfoCard, Color3.fromRGB(42, 42, 52), 1)

local InfoTitle = New("TextLabel", {
    Parent = InfoCard,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 18, 0, 15),
    Size = UDim2.new(1, -36, 0, 28),
    Font = Enum.Font.GothamBold,
    Text = "CSS JAVA",
    TextSize = 17,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left
})

local InfoText = New("TextLabel", {
    Parent = InfoCard,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 18, 0, 47),
    Size = UDim2.new(1, -36, 0, 65),
    Font = Enum.Font.Gotham,
    Text = "GUI ONLY\nPNG / GitHub / Delta diagnostics enabled",
    TextSize = 13,
    TextColor3 = Color3.fromRGB(145, 145, 160),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
})

--==================================================
-- DEBUG CONSOLE
--==================================================

local Console = New("Frame", {
    Parent = Content,
    Position = UDim2.new(0, 25, 0, 220),
    Size = UDim2.new(1, -50, 0, 315),
    BackgroundColor3 = Color3.fromRGB(7, 7, 10),
    BorderSizePixel = 0
})

Corner(Console, 12)
Stroke(Console, Color3.fromRGB(45, 45, 55), 1)

local ConsoleHeader = New("Frame", {
    Parent = Console,
    Size = UDim2.new(1, 0, 0, 42),
    BackgroundColor3 = Color3.fromRGB(16, 16, 22),
    BorderSizePixel = 0
})

Corner(ConsoleHeader, 12)

local ConsoleTitle = New("TextLabel", {
    Parent = ConsoleHeader,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 0),
    Size = UDim2.new(1, -30, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "DELTA DEBUG CONSOLE",
    TextSize = 13,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextXAlignment = Enum.TextXAlignment.Left
})

local ConsoleOutput = New("TextLabel", {
    Parent = Console,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 52),
    Size = UDim2.new(1, -30, 1, -62),
    Font = Enum.Font.Code,
    Text = "Starting diagnostics...",
    TextSize = 13,
    TextColor3 = Color3.fromRGB(190, 190, 200),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
})

--==================================================
-- DRAG
--==================================================

local dragging = false
local dragStart
local startPos

TopBar.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if not dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local delta = input.Position - dragStart

    Main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end)

--==================================================
-- DEBUG SYSTEM
--==================================================

local Lines = {}

local function Log(text)
    table.insert(Lines, text)

    if #Lines > 17 then
        table.remove(Lines, 1)
    end

    ConsoleOutput.Text = table.concat(Lines, "\n")
    print("[CSS JAVA] " .. text)
end

local function GetGlobal(name)
    local ok, value = pcall(function()
        return getgenv()[name]
    end)

    if ok then
        return value
    end

    local ok2, value2 = pcall(function()
        return _G[name]
    end)

    if ok2 then
        return value2
    end

    return nil
end

local function CheckFunction(name)
    local value = GetGlobal(name)

    if typeof(value) == "function" then
        Log("[PASS] " .. name .. " = function")
        return value
    end

    Log("[FAIL] " .. name .. " = " .. typeof(value))
    return nil
end

--==================================================
-- START DIAGNOSTICS
--==================================================

task.spawn(function()

    task.wait(0.3)

    Lines = {}

    Log("================================")
    Log("CSS JAVA / DELTA DIAGNOSTICS")
    Log("================================")

    -- Roblox environment
    Log("[INFO] Executor check started")

    local requestFunc = CheckFunction("request")
    local httpRequestFunc = CheckFunction("http_request")
    local writeFileFunc = CheckFunction("writefile")
    local readFileFunc = CheckFunction("readfile")
    local isFileFunc = CheckFunction("isfile")
    local makeFolderFunc = CheckFunction("makefolder")
    local getCustomAssetFunc = CheckFunction("getcustomasset")
    local getSynAssetFunc = CheckFunction("getsynasset")

    --==================================================
    -- REQUEST TEST
    --==================================================

    local req = requestFunc or httpRequestFunc

    if req then

        Log("[TEST] GitHub HTTP request...")

        local success, result = pcall(function()

            return req({
                Url = RAW_BASE .. "logo.png",
                Method = "GET"
            })

        end)

        if success and result then

            local status = result.StatusCode or result.Status or 0

            if tonumber(status) == 200 then
                Log("[PASS] GitHub request = 200")
            else
                Log("[FAIL] HTTP status = " .. tostring(status))
            end

            if result.Body then
                Log("[PASS] PNG data received")
                Log("[INFO] Bytes = " .. tostring(#result.Body))
            else
                Log("[FAIL] Response has no Body")
            end

        else
            Log("[FAIL] HTTP request error")
            Log(tostring(result))
        end

    else
        Log("[SKIP] No request function")
    end

    --==================================================
    -- FILE TEST
    --==================================================

    if writeFileFunc and readFileFunc and isFileFunc then

        Log("[TEST] File system...")

        local testFile = "CSS_JAVA_DELTA_TEST.txt"

        local writeOK, writeErr = pcall(function()
            writeFileFunc(testFile, "CSS JAVA TEST")
        end)

        if writeOK then

            local existsOK, exists = pcall(function()
                return isFileFunc(testFile)
            end)

            if existsOK and exists then
                Log("[PASS] writefile / isfile")

                local readOK, data = pcall(function()
                    return readFileFunc(testFile)
                end)

                if readOK and data == "CSS JAVA TEST" then
                    Log("[PASS] readfile")
                else
                    Log("[FAIL] readfile")
                end
            else
                Log("[FAIL] isfile")
            end

        else
            Log("[FAIL] writefile")
            Log(tostring(writeErr))
        end

    else
        Log("[SKIP] File system unavailable")
    end

    --==================================================
    -- CUSTOM ASSET TEST
    --==================================================

    local customAsset = getCustomAssetFunc or getSynAssetFunc

    if customAsset then
        Log("[PASS] Custom asset API available")
    else
        Log("[FAIL] No custom asset API")
    end

    --==================================================
    -- FINAL
    --==================================================

    Log("================================")
    Log("DIAGNOSTICS FINISHED")
    Log("================================")

end)

--==================================================
-- REOPEN BUTTON
--==================================================

local Reopen = New("TextButton", {
    Parent = GUI,
    Visible = false,
    Size = UDim2.new(0, 120, 0, 40),
    Position = UDim2.new(0, 20, 0, 20),
    BackgroundColor3 = Color3.fromRGB(20, 20, 27),
    BorderSizePixel = 0,
    Text = "CSS JAVA",
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    AutoButtonColor = false
})

Corner(Reopen, 9)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
    Reopen.Visible = true
end)

Reopen.MouseButton1Click:Connect(function()
    Main.Visible = true
    Reopen.Visible = false
end)

--==================================================
-- FINISH
--==================================================

print("[CSS JAVA] GUI loaded successfully.")
print("[CSS JAVA] Delta diagnostics running...")
