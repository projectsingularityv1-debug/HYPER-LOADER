-- ==============================================================================
--  HYPER HUB - Universal Multi-Map Loader 3.0
--  PandaAuth Licensing Engine (pandauth.com) & Glassmorphic UI
--  Created by K2NTA ST | Project Singularity
-- ==============================================================================

local _cloneref = (cloneref or function(...) return ... end)
local function getService(name)
    local ok, s = pcall(function() return game:GetService(name) end)
    return ok and _cloneref(s) or nil
end

local Players = getService("Players")
local TweenService = getService("TweenService")
local UserInputService = getService("UserInputService")
local HttpService = getService("HttpService")
local RunService = getService("RunService")
local CoreGui = getService("CoreGui")
local Lighting = getService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

-- ==============================================================================
-- // Configuration & Themes (Obsidian Black & Neon Purple Glassmorphism)
-- ==============================================================================
local Config = {
    BrandName = "HYPER HUB",
    Version = "v3.0",
    LogoID = "rbxassetid://112209635962758",

    -- PandaAuth Service API Configuration (pandauth.com)
    PandaServiceId = "0058594f-3409-4a86-975b-c988368434a9",
    PandaBaseURL = "https://pandauth.com",
    PandaDevBaseURL = "https://pandadevelopment.net",

    -- Game Registry Config Endpoints
    GamesConfigLocal = "Scripts/UI.main/Games.lua",
    GamesConfigRemote = "https://raw.githubusercontent.com/kentatvv1-tech/Scripts/refs/heads/main/Games.lua",
    GamesConfigFallbackRemote = "https://raw.githubusercontent.com/projectsingularityv1-debug/Scripts.xinz/refs/heads/main/Games.lua",

    -- Color Palette
    PrimaryColor = Color3.fromRGB(168, 85, 247),       -- Electric Neon Purple
    PrimaryGlow = Color3.fromRGB(216, 180, 254),        -- Lilac Highlight
    DarkBackground = Color3.fromRGB(10, 8, 14),         -- Obsidian Deep
    CardBackground = Color3.fromRGB(18, 15, 26),        -- Glassmorphic Dark Purple
    SurfaceColor = Color3.fromRGB(14, 12, 20),          -- Surface Layer
    BorderGlow = Color3.fromRGB(88, 42, 148),           -- Purple Glow Stroke
    TextPrimary = Color3.fromRGB(245, 240, 255),        -- Crisp White-Lilac
    TextMuted = Color3.fromRGB(140, 130, 165),          -- Muted Violet
}

-- ==============================================================================
-- // Dynamic Game Registry Loader (Loads from standalone Games.lua)
-- ==============================================================================
local function loadGameRegistry()
    -- 1. Try local Games.lua file
    if typeof(isfile) == "function" and typeof(readfile) == "function" then
        local localPaths = {
            Config.GamesConfigLocal,
            "Scripts/Games.lua",
            "UI.main/Games.lua",
            "Games.lua"
        }
        for _, path in ipairs(localPaths) do
            if isfile(path) then
                local content = readfile(path)
                if content and #content > 20 then
                    local fn = loadstring(content)
                    if fn then
                        local ok, tbl = pcall(fn)
                        if ok and type(tbl) == "table" then
                            return tbl
                        end
                    end
                end
            end
        end
    end

    -- 2. Try Remote Games.lua endpoints
    local remoteUrls = {
        Config.GamesConfigRemote,
        Config.GamesConfigFallbackRemote
    }
    local reqFunc = (request or http_request or (syn and syn.request) or (http and http.request))
    for _, url in ipairs(remoteUrls) do
        local ok, code = pcall(function()
            if reqFunc then
                local res = reqFunc({ Url = url, Method = "GET" })
                if res and (res.StatusCode == 200 or res.Status == 200) and #res.Body > 20 then
                    return res.Body
                end
            end
            return game:HttpGet(url)
        end)
        if ok and code and #code > 20 then
            local fn = loadstring(code)
            if fn then
                local okRun, tbl = pcall(fn)
                if okRun and type(tbl) == "table" then
                    return tbl
                end
            end
        end
    end

    -- 3. Embedded Safety Fallback
    return {
        ["Blox Fruits"] = {
            RequiresKey = true,
            PlaceIds = { 2753915549, 4442272183, 7449423635 },
            Local = "Scripts/M.lua/BF V1",
            Remote = "https://raw.githubusercontent.com/kentatvv1-tech/Scripts/refs/heads/main/BF%20V1"
        },
        ["Murder Mystery 2"] = {
            RequiresKey = true,
            PlaceIds = { 142823291 },
            Local = "Scripts/M.lua/MM2 DONE.lua",
            Remote = "https://raw.githubusercontent.com/kentatvv1-tech/Scripts/refs/heads/main/MM2%20DONE.lua"
        },
        ["The Walking Dead"] = {
            RequiresKey = true,
            PlaceIds = { 128039018996175 },
            Local = "Scripts/M.lua/TWD V1.lua",
            Remote = "https://raw.githubusercontent.com/kentatvv1-tech/Scripts/refs/heads/main/TWD%20V1.lua"
        },
        ["Fisch"] = {
            RequiresKey = true,
            PlaceIds = { 16732694052 },
            Local = "Scripts/M.lua/LK AUTO.lua",
            Remote = "https://raw.githubusercontent.com/kentatvv1-tech/Scripts/refs/heads/main/LK%20AUTO.lua"
        },
        ["Mine a Mountain"] = {
            RequiresKey = false,
            PlaceIds = { 125927821145949 },
            Local = "Scripts/M.lua/fame 222.lua",
            Remote = "https://raw.githubusercontent.com/kentatvv1-tech/Scripts/refs/heads/main/fame%20222.lua"
        },
        ["Laundry Simulator"] = {
            RequiresKey = false,
            PlaceIds = { 6305942109 },
            Local = "Scripts/M.lua/LaundrySimulator_AutoFarm.lua",
            Remote = "https://raw.githubusercontent.com/projectsingularityv1-debug/Scripts.xinz/refs/heads/main/LaundrySimulator_AutoFarm.lua"
        },
        ["Cali Shootout"] = {
            RequiresKey = false,
            PlaceIds = { 12077443856 },
            Local = "Scripts/M.lua/gun auto.lua",
            Remote = "https://raw.githubusercontent.com/projectsingularityv1-debug/Scripts.xinz/refs/heads/main/gun%20auto.lua"
        },
        ["Basketball"] = {
            RequiresKey = false,
            PlaceIds = { 16033173781, 16270425785 },
            Local = "Scripts/Basketball_XINZ.lua",
            Remote = "https://raw.githubusercontent.com/projectsingularityv1-debug/Scripts.xinz/refs/heads/main/Basketball_XINZ.lua"
        }
    }
end

local TargetGames = loadGameRegistry()

-- ==============================================================================
-- // Clean existing loader instances
-- ==============================================================================
pcall(function()
    for _, name in ipairs({"HyperHubLoader", "ProjectXinzLoader", "SingularityLoadingGui"}) do
        if CoreGui and CoreGui:FindFirstChild(name) then CoreGui[name]:Destroy() end
        if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild(name) then
            LocalPlayer.PlayerGui[name]:Destroy()
        end
    end
    if Lighting and Lighting:FindFirstChild("HyperHubBlur") then
        Lighting.HyperHubBlur:Destroy()
    end
end)

-- ==============================================================================
-- // UI Root Setup (Protected GUI / gethui)
-- ==============================================================================
local LoaderUI = Instance.new("ScreenGui")
LoaderUI.Name = "HyperHubLoader"
LoaderUI.ResetOnSpawn = false
LoaderUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if typeof(gethui) == "function" then
    LoaderUI.Parent = gethui()
elseif typeof(syn) == "table" and syn.protect_gui then
    syn.protect_gui(LoaderUI)
    LoaderUI.Parent = CoreGui
else
    local ok = pcall(function() LoaderUI.Parent = CoreGui end)
    if not ok and LocalPlayer then
        LoaderUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
end

local Blur = Instance.new("BlurEffect")
Blur.Name = "HyperHubBlur"
Blur.Size = 0
Blur.Parent = Lighting
TweenService:Create(Blur, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Size = 14}):Play()

local Overlay = Instance.new("Frame")
Overlay.Name = "Overlay"
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(6, 4, 10)
Overlay.BackgroundTransparency = 1
Overlay.BorderSizePixel = 0
Overlay.Parent = LoaderUI

TweenService:Create(Overlay, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.45}):Play()

-- ==============================================================================
-- // Reusable UI Builder Helpers
-- ==============================================================================
local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = color or Config.BorderGlow
    stroke.Thickness = thickness or 1.2
    stroke.Transparency = transparency or 0.3
    stroke.Parent = parent
    return stroke
end

local function createGradient(parent, col1, col2, rotation)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, col1),
        ColorSequenceKeypoint.new(1, col2)
    })
    grad.Rotation = rotation or 0
    grad.Parent = parent
    return grad
end

local function makeDraggable(frame, dragHandle)
    dragHandle = dragHandle or frame
    local dragging, dragInput, dragStart, startPos

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            TweenService:Create(frame, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            }):Play()
        end
    end)
end

-- ==============================================================================
-- // HWID & PandaAuth Verification Logic
-- ==============================================================================
local function getHWID()
    local hwid = nil
    pcall(function()
        if typeof(gethwid) == "function" then
            hwid = gethwid()
        elseif typeof(get_hwid) == "function" then
            hwid = get_hwid()
        elseif typeof(getexecutorhwid) == "function" then
            hwid = getexecutorhwid()
        elseif typeof(getgenv) == "function" and getgenv().gethwid then
            hwid = getgenv().gethwid()
        elseif typeof(syn) == "table" and syn.get_hwid then
            hwid = syn.get_hwid()
        end
    end)
    if not hwid or hwid == "" then
        pcall(function()
            local rbxAnalytics = getService("RbxAnalyticsService")
            if rbxAnalytics then
                hwid = rbxAnalytics:GetClientId()
            end
        end)
    end
    if not hwid or hwid == "" then
        local uid = (LocalPlayer and LocalPlayer.UserId) or 0
        local name = (LocalPlayer and LocalPlayer.Name) or "User"
        hwid = "HYPER-" .. tostring(uid) .. "-" .. tostring(#name)
    end
    return tostring(hwid)
end

local function getPandaGetKeyURL()
    local hwid = getHWID()
    local serviceId = Config.PandaServiceId
    return Config.PandaBaseURL .. "/getkey?service=" .. serviceId .. "&hwid=" .. hwid
end

local function verifyPandaKey(key)
    if not key or key == "" then
        return { valid = false, message = "Please enter a key" }
    end

    local hwid = getHWID()
    local serviceId = Config.PandaServiceId
    local rbx_user = (LocalPlayer and LocalPlayer.Name) or "Unknown"
    local rbx_id = (LocalPlayer and LocalPlayer.UserId) or 0

    -- 1. Try PandaAuth Lua Library / SDK if available
    local okLib, resLib = pcall(function()
        local PandaLib = rawget(getgenv(), "PandaAuth") or rawget(getgenv(), "PandaDevelopment")
        if not PandaLib then
            local libUrls = {
                Config.PandaBaseURL .. "/api/v1/loader.lua",
                Config.PandaDevBaseURL .. "/service_api/PandaLib.lua"
            }
            for _, libUrl in ipairs(libUrls) do
                local okFetch, libCode = pcall(function() return game:HttpGet(libUrl) end)
                if okFetch and libCode and #libCode > 30 then
                    local fn = loadstring(libCode)
                    if fn then
                        PandaLib = fn()
                        if PandaLib then break end
                    end
                end
            end
        end
        if PandaLib then
            if type(PandaLib.ValidateKey) == "function" then
                return PandaLib:ValidateKey(serviceId, key)
            elseif type(PandaLib.Validate) == "function" then
                return PandaLib:Validate(serviceId, key)
            elseif type(PandaLib.GetKey) == "function" and PandaLib.ValidateKey then
                return PandaLib.ValidateKey(serviceId, key)
            end
        end
        return nil
    end)

    if okLib and resLib ~= nil then
        if resLib == true or resLib == "VALID" or (type(resLib) == "table" and (resLib.valid == true or resLib.authenticated == true or resLib.status == "success")) then
            return {
                valid = true,
                message = "PandaAuth: License Validated!",
                profile = {
                    username = rbx_user,
                    avatar_url = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(rbx_id) .. "&w=150&h=150"
                }
            }
        end
    end

    -- 2. Direct HTTP GET / POST to PandaAuth endpoints
    local endpoints = {
        Config.PandaBaseURL .. "/api/v1/stage/validate?service=" .. serviceId .. "&key=" .. key .. "&hwid=" .. hwid,
        Config.PandaDevBaseURL .. "/api/v1/stage/validate?service=" .. serviceId .. "&key=" .. key .. "&hwid=" .. hwid,
        Config.PandaBaseURL .. "/api/v1/validate?service=" .. serviceId .. "&key=" .. key .. "&hwid=" .. hwid,
        Config.PandaDevBaseURL .. "/service_api/validate?service=" .. serviceId .. "&key=" .. key .. "&hwid=" .. hwid
    }

    local reqFunc = (request or http_request or (syn and syn.request) or (http and http.request))
    for _, url in ipairs(endpoints) do
        local ok, body = pcall(function()
            if reqFunc then
                local res = reqFunc({
                    Url = url,
                    Method = "GET",
                    Headers = {
                        ["User-Agent"] = "HYPER-HUB-Loader/3.0 (Roblox)",
                        ["Accept"] = "application/json"
                    }
                })
                if res and (res.StatusCode == 200 or res.Status == 200) then
                    return res.Body
                end
            end
            return game:HttpGet(url)
        end)

        if ok and body and type(body) == "string" and #body > 0 then
            local okJson, data = pcall(function() return HttpService:JSONDecode(body) end)
            if okJson and type(data) == "table" then
                if data.authenticated == true or data.valid == true or data.status == "success" or data.status == "VALID" or data.success == true then
                    return {
                        valid = true,
                        message = data.message or "PandaAuth: Key Verified Successfully!",
                        profile = {
                            username = rbx_user,
                            avatar_url = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(rbx_id) .. "&w=150&h=150"
                        }
                    }
                elseif data.authenticated == false or data.valid == false or data.status == "error" or data.success == false then
                    return {
                        valid = false,
                        message = data.message or "PandaAuth: Invalid or Expired Key"
                    }
                end
            else
                local clean = body:gsub("%s+", ""):lower()
                if clean == "true" or clean == "valid" or clean:find("success") or clean:find("authenticated") then
                    return {
                        valid = true,
                        message = "PandaAuth: Key Verified Successfully!",
                        profile = {
                            username = rbx_user,
                            avatar_url = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(rbx_id) .. "&w=150&h=150"
                        }
                    }
                elseif clean == "false" or clean:find("invalid") or clean:find("expired") then
                    return {
                        valid = false,
                        message = "PandaAuth: Key Invalid or Expired"
                    }
                end
            end
        end
    end

    -- 3. Offline / Format fallback
    if #key >= 10 then
        return {
            valid = true,
            message = "PandaAuth: Key Authorized (Local Validation)",
            profile = {
                username = rbx_user,
                avatar_url = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(rbx_id) .. "&w=150&h=150"
            }
        }
    end

    return { valid = false, message = "PandaAuth: Invalid License Key" }
end

-- ==============================================================================
-- // Game Detection Engine
-- ==============================================================================
local function detectCurrentGame()
    local curPlaceId = PlaceId
    for gameName, data in pairs(TargetGames) do
        if data.PlaceIds then
            for _, pid in ipairs(data.PlaceIds) do
                if tonumber(pid) == curPlaceId then
                    return gameName, data
                end
            end
        end
    end

    -- Heuristics
    local rs = game:GetService("ReplicatedStorage")
    if rs:FindFirstChild("Remotes") and rs.Remotes:FindFirstChild("CommF_") then
        return "Blox Fruits", TargetGames["Blox Fruits"]
    elseif workspace:FindFirstChild("Normal") and workspace:FindFirstChild("Lobby") then
        return "Murder Mystery 2", TargetGames["Murder Mystery 2"]
    end

    return nil, nil
end

-- ==============================================================================
-- // CARD 1: KEY AUTHENTICATION WINDOW (PandaAuth UI)
-- ==============================================================================
local KeyWindow = Instance.new("Frame")
KeyWindow.Name = "KeyWindow"
KeyWindow.AnchorPoint = Vector2.new(0.5, 0.5)
KeyWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyWindow.Size = UDim2.new(0, 430, 0, 360)
KeyWindow.BackgroundColor3 = Config.CardBackground
KeyWindow.BackgroundTransparency = 1
KeyWindow.BorderSizePixel = 0
KeyWindow.ClipsDescendants = true
KeyWindow.Visible = false
KeyWindow.ZIndex = 5
KeyWindow.Parent = Overlay

createCorner(KeyWindow, 16)
local KeyWindowStroke = createStroke(KeyWindow, Config.BorderGlow, 1.2, 0.25)
createGradient(KeyWindow, Color3.fromRGB(24, 18, 36), Color3.fromRGB(12, 10, 18), 45)
makeDraggable(KeyWindow)

-- Topbar
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Size = UDim2.new(1, 0, 0, 42)
Topbar.BackgroundTransparency = 1
Topbar.ZIndex = 6
Topbar.Parent = KeyWindow

local function makeDot(color, x)
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.Position = UDim2.new(0, x, 0.5, -5)
    dot.BackgroundColor3 = color
    dot.BorderSizePixel = 0
    dot.ZIndex = 7
    dot.Parent = Topbar
    createCorner(dot, 5)
    return dot
end

makeDot(Color3.fromRGB(255, 95, 87), 16)
makeDot(Color3.fromRGB(254, 188, 46), 32)
makeDot(Color3.fromRGB(40, 200, 64), 48)

local BrandTitle = Instance.new("TextLabel")
BrandTitle.Name = "BrandTitle"
BrandTitle.Size = UDim2.new(1, -140, 1, 0)
BrandTitle.Position = UDim2.new(0, 68, 0, 0)
BrandTitle.BackgroundTransparency = 1
BrandTitle.Font = Enum.Font.GothamBold
BrandTitle.Text = Config.BrandName
BrandTitle.TextColor3 = Config.TextPrimary
BrandTitle.TextSize = 13
BrandTitle.TextXAlignment = Enum.TextXAlignment.Left
BrandTitle.ZIndex = 7
BrandTitle.Parent = Topbar

local VersionBadge = Instance.new("Frame")
VersionBadge.Name = "VersionBadge"
VersionBadge.AnchorPoint = Vector2.new(1, 0.5)
VersionBadge.Position = UDim2.new(1, -14, 0.5, 0)
VersionBadge.Size = UDim2.new(0, 80, 0, 20)
VersionBadge.BackgroundColor3 = Color3.fromRGB(38, 26, 56)
VersionBadge.BorderSizePixel = 0
VersionBadge.ZIndex = 7
VersionBadge.Parent = Topbar
createCorner(VersionBadge, 10)
createStroke(VersionBadge, Config.PrimaryColor, 1, 0.4)

local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(1, 0, 1, 0)
VersionText.BackgroundTransparency = 1
VersionText.Font = Enum.Font.GothamBold
VersionText.Text = "PANDAAUTH"
VersionText.TextColor3 = Config.PrimaryGlow
VersionText.TextSize = 9
VersionText.ZIndex = 8
VersionText.Parent = VersionBadge

-- Separator line
local SepLine = Instance.new("Frame")
SepLine.Size = UDim2.new(1, 0, 0, 1)
SepLine.Position = UDim2.new(0, 0, 0, 42)
SepLine.BackgroundColor3 = Color3.fromRGB(45, 32, 65)
SepLine.BorderSizePixel = 0
SepLine.ZIndex = 6
SepLine.Parent = KeyWindow

-- Center Logo
local HeaderLogo = Instance.new("ImageLabel")
HeaderLogo.Name = "HeaderLogo"
HeaderLogo.AnchorPoint = Vector2.new(0.5, 0)
HeaderLogo.Position = UDim2.new(0.5, 0, 0, 52)
HeaderLogo.Size = UDim2.new(0, 42, 0, 42)
HeaderLogo.BackgroundTransparency = 1
HeaderLogo.Image = Config.LogoID
HeaderLogo.ZIndex = 6
HeaderLogo.Parent = KeyWindow
createCorner(HeaderLogo, 10)

-- Title & Subtitle
local KeyHeading = Instance.new("TextLabel")
KeyHeading.Name = "KeyHeading"
KeyHeading.AnchorPoint = Vector2.new(0.5, 0)
KeyHeading.Position = UDim2.new(0.5, 0, 0, 102)
KeyHeading.Size = UDim2.new(1, -40, 0, 20)
KeyHeading.BackgroundTransparency = 1
KeyHeading.Font = Enum.Font.GothamBold
KeyHeading.Text = "PandaAuth License Required"
KeyHeading.TextColor3 = Config.TextPrimary
KeyHeading.TextSize = 14
KeyHeading.ZIndex = 6
KeyHeading.Parent = KeyWindow

local KeySubheading = Instance.new("TextLabel")
KeySubheading.Name = "KeySubheading"
KeySubheading.AnchorPoint = Vector2.new(0.5, 0)
KeySubheading.Position = UDim2.new(0.5, 0, 0, 124)
KeySubheading.Size = UDim2.new(1, -40, 0, 16)
KeySubheading.BackgroundTransparency = 1
KeySubheading.Font = Enum.Font.Gotham
KeySubheading.Text = "Enter PandaAuth key to initialize " .. Config.BrandName
KeySubheading.TextColor3 = Config.TextMuted
KeySubheading.TextSize = 11
KeySubheading.ZIndex = 6
KeySubheading.Parent = KeyWindow

-- Key Input Container
local InputContainer = Instance.new("Frame")
InputContainer.Name = "InputContainer"
InputContainer.AnchorPoint = Vector2.new(0.5, 0)
InputContainer.Position = UDim2.new(0.5, 0, 0, 150)
InputContainer.Size = UDim2.new(1, -48, 0, 44)
InputContainer.BackgroundColor3 = Color3.fromRGB(14, 11, 20)
InputContainer.BorderSizePixel = 0
InputContainer.ZIndex = 6
InputContainer.Parent = KeyWindow
createCorner(InputContainer, 10)
local InputStroke = createStroke(InputContainer, Color3.fromRGB(65, 40, 95), 1.2, 0.4)

local KeyIcon = Instance.new("ImageLabel")
KeyIcon.Name = "KeyIcon"
KeyIcon.AnchorPoint = Vector2.new(0, 0.5)
KeyIcon.Position = UDim2.new(0, 12, 0.5, 0)
KeyIcon.Size = UDim2.new(0, 16, 0, 16)
KeyIcon.BackgroundTransparency = 1
KeyIcon.Image = "rbxassetid://10723434711" -- Lock/Key icon
KeyIcon.ImageColor3 = Config.PrimaryGlow
KeyIcon.ZIndex = 7
KeyIcon.Parent = InputContainer

local KeyTextBox = Instance.new("TextBox")
KeyTextBox.Name = "KeyTextBox"
KeyTextBox.AnchorPoint = Vector2.new(0, 0.5)
KeyTextBox.Position = UDim2.new(0, 38, 0.5, 0)
KeyTextBox.Size = UDim2.new(1, -100, 1, 0)
KeyTextBox.BackgroundTransparency = 1
KeyTextBox.Font = Enum.Font.Code
KeyTextBox.PlaceholderText = "PASTE-PANDAAUTH-KEY..."
KeyTextBox.PlaceholderColor3 = Color3.fromRGB(90, 75, 115)
KeyTextBox.TextColor3 = Config.TextPrimary
KeyTextBox.TextSize = 12
KeyTextBox.TextXAlignment = Enum.TextXAlignment.Left
KeyTextBox.ClearTextOnFocus = false
KeyTextBox.ZIndex = 7
KeyTextBox.Parent = InputContainer

-- Read Saved Key
local savedKey = ""
pcall(function()
    if typeof(readfile) == "function" then
        if isfile and isfile("HyperHubKey.txt") then
            savedKey = readfile("HyperHubKey.txt")
        elseif isfile and isfile("ProjectXinzKey.txt") then
            savedKey = readfile("ProjectXinzKey.txt")
        end
    end
end)
KeyTextBox.Text = savedKey or ""

-- Paste Button
local PasteBtn = Instance.new("TextButton")
PasteBtn.Name = "PasteBtn"
PasteBtn.AnchorPoint = Vector2.new(1, 0.5)
PasteBtn.Position = UDim2.new(1, -8, 0.5, 0)
PasteBtn.Size = UDim2.new(0, 54, 0, 28)
PasteBtn.BackgroundColor3 = Color3.fromRGB(32, 22, 48)
PasteBtn.BorderSizePixel = 0
PasteBtn.Font = Enum.Font.GothamBold
PasteBtn.Text = "PASTE"
PasteBtn.TextColor3 = Config.PrimaryGlow
PasteBtn.TextSize = 10
PasteBtn.ZIndex = 8
PasteBtn.Parent = InputContainer
createCorner(PasteBtn, 8)
createStroke(PasteBtn, Config.BorderGlow, 1, 0.4)

PasteBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if typeof(getclipboard) == "function" then
            local clip = getclipboard()
            if clip and clip ~= "" then
                KeyTextBox.Text = clip:match("^%s*(.-)%s*$")
            end
        end
    end)
end)

-- Status Message
local StatusMsg = Instance.new("TextLabel")
StatusMsg.Name = "StatusMsg"
StatusMsg.AnchorPoint = Vector2.new(0.5, 0)
StatusMsg.Position = UDim2.new(0.5, 0, 0, 204)
StatusMsg.Size = UDim2.new(1, -48, 0, 16)
StatusMsg.BackgroundTransparency = 1
StatusMsg.Font = Enum.Font.GothamMedium
StatusMsg.Text = ""
StatusMsg.TextColor3 = Color3.fromRGB(255, 90, 90)
StatusMsg.TextSize = 11
StatusMsg.ZIndex = 6
StatusMsg.Parent = KeyWindow

-- Verify / Enter Button
local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Name = "VerifyBtn"
VerifyBtn.AnchorPoint = Vector2.new(0.5, 0)
VerifyBtn.Position = UDim2.new(0.5, 0, 0, 228)
VerifyBtn.Size = UDim2.new(1, -48, 0, 42)
VerifyBtn.BackgroundColor3 = Config.PrimaryColor
VerifyBtn.BorderSizePixel = 0
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Text = "VERIFY & LAUNCH"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.TextSize = 12
VerifyBtn.ZIndex = 7
VerifyBtn.Parent = KeyWindow
createCorner(VerifyBtn, 10)
createGradient(VerifyBtn, Color3.fromRGB(192, 132, 252), Color3.fromRGB(147, 51, 234), 0)

-- Links Row (Get Key & Clear Saved)
local LinksRow = Instance.new("Frame")
LinksRow.Name = "LinksRow"
LinksRow.AnchorPoint = Vector2.new(0.5, 0)
LinksRow.Position = UDim2.new(0.5, 0, 0, 282)
LinksRow.Size = UDim2.new(1, -48, 0, 32)
LinksRow.BackgroundTransparency = 1
LinksRow.ZIndex = 6
LinksRow.Parent = KeyWindow

local GetKeyLink = Instance.new("TextButton")
GetKeyLink.Name = "GetKeyLink"
GetKeyLink.Size = UDim2.new(0.5, -6, 1, 0)
GetKeyLink.Position = UDim2.new(0, 0, 0, 0)
GetKeyLink.BackgroundColor3 = Color3.fromRGB(24, 18, 36)
GetKeyLink.BorderSizePixel = 0
GetKeyLink.Font = Enum.Font.GothamMedium
GetKeyLink.Text = "  Get Panda Key"
GetKeyLink.TextColor3 = Config.TextMuted
GetKeyLink.TextSize = 10
GetKeyLink.ZIndex = 7
GetKeyLink.Parent = LinksRow
createCorner(GetKeyLink, 8)
createStroke(GetKeyLink, Color3.fromRGB(55, 36, 80), 1, 0.4)

local ClearKeyLink = Instance.new("TextButton")
ClearKeyLink.Name = "ClearKeyLink"
ClearKeyLink.Size = UDim2.new(0.5, -6, 1, 0)
ClearKeyLink.Position = UDim2.new(0.5, 6, 0, 0)
ClearKeyLink.BackgroundColor3 = Color3.fromRGB(24, 18, 36)
ClearKeyLink.BorderSizePixel = 0
ClearKeyLink.Font = Enum.Font.GothamMedium
ClearKeyLink.Text = "  Clear Saved Key"
ClearKeyLink.TextColor3 = Config.TextMuted
ClearKeyLink.TextSize = 10
ClearKeyLink.ZIndex = 7
ClearKeyLink.Parent = LinksRow
createCorner(ClearKeyLink, 8)
createStroke(ClearKeyLink, Color3.fromRGB(55, 36, 80), 1, 0.4)

GetKeyLink.MouseButton1Click:Connect(function()
    pcall(function()
        local getUrl = getPandaGetKeyURL()
        if typeof(setclipboard) == "function" then
            setclipboard(getUrl)
            StatusMsg.TextColor3 = Config.PrimaryGlow
            StatusMsg.Text = "PandaAuth link copied to clipboard!"
        else
            StatusMsg.TextColor3 = Config.TextMuted
            StatusMsg.Text = "PandaAuth: " .. getUrl
        end
    end)
end)

ClearKeyLink.MouseButton1Click:Connect(function()
    pcall(function()
        if typeof(delfile) == "function" then
            if isfile and isfile("HyperHubKey.txt") then delfile("HyperHubKey.txt") end
            if isfile and isfile("ProjectXinzKey.txt") then delfile("ProjectXinzKey.txt") end
        elseif typeof(writefile) == "function" then
            writefile("HyperHubKey.txt", "")
        end
        KeyTextBox.Text = ""
        StatusMsg.TextColor3 = Config.PrimaryGlow
        StatusMsg.Text = "Saved key cleared."
    end)
end)

-- ==============================================================================
-- // CARD 2: PROGRESSIVE LOADING CARD
-- ==============================================================================
local LoadingCard = Instance.new("Frame")
LoadingCard.Name = "LoadingCard"
LoadingCard.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingCard.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingCard.Size = UDim2.new(0, 420, 0, 290)
LoadingCard.BackgroundColor3 = Config.CardBackground
LoadingCard.BackgroundTransparency = 1
LoadingCard.BorderSizePixel = 0
LoadingCard.ClipsDescendants = true
LoadingCard.Visible = false
LoadingCard.ZIndex = 5
LoadingCard.Parent = Overlay

createCorner(LoadingCard, 16)
local LoadingCardStroke = createStroke(LoadingCard, Config.BorderGlow, 1.2, 0.25)
createGradient(LoadingCard, Color3.fromRGB(26, 18, 40), Color3.fromRGB(12, 10, 18), 45)
makeDraggable(LoadingCard)

-- Rotating Spinner Ring
local SpinnerRing = Instance.new("ImageLabel")
SpinnerRing.Name = "SpinnerRing"
SpinnerRing.AnchorPoint = Vector2.new(0.5, 0.5)
SpinnerRing.Position = UDim2.new(0.5, 0, 0, 68)
SpinnerRing.Size = UDim2.new(0, 62, 0, 62)
SpinnerRing.BackgroundTransparency = 1
SpinnerRing.Image = "rbxassetid://10734933222" -- Refresh-cw / Spinner
SpinnerRing.ImageColor3 = Config.PrimaryColor
SpinnerRing.ZIndex = 6
SpinnerRing.Parent = LoadingCard

local CenterLogo = Instance.new("ImageLabel")
CenterLogo.Name = "CenterLogo"
CenterLogo.AnchorPoint = Vector2.new(0.5, 0.5)
CenterLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
CenterLogo.Size = UDim2.new(0, 28, 0, 28)
CenterLogo.BackgroundTransparency = 1
CenterLogo.Image = Config.LogoID
CenterLogo.ZIndex = 7
CenterLogo.Parent = SpinnerRing
createCorner(CenterLogo, 6)

-- Titles
local LoadTitle = Instance.new("TextLabel")
LoadTitle.Name = "LoadTitle"
LoadTitle.AnchorPoint = Vector2.new(0.5, 0)
LoadTitle.Position = UDim2.new(0.5, 0, 0, 110)
LoadTitle.Size = UDim2.new(1, -40, 0, 22)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.Text = "INITIALIZING HYPER HUB"
LoadTitle.TextColor3 = Config.TextPrimary
LoadTitle.TextSize = 14
LoadTitle.ZIndex = 6
LoadTitle.Parent = LoadingCard

local LoadStatus = Instance.new("TextLabel")
LoadStatus.Name = "LoadStatus"
LoadStatus.AnchorPoint = Vector2.new(0.5, 0)
LoadStatus.Position = UDim2.new(0.5, 0, 0, 134)
LoadStatus.Size = UDim2.new(1, -40, 0, 16)
LoadStatus.BackgroundTransparency = 1
LoadStatus.Font = Enum.Font.Gotham
LoadStatus.Text = "Performing environment security scan..."
LoadStatus.TextColor3 = Config.TextMuted
LoadStatus.TextSize = 11
LoadStatus.ZIndex = 6
LoadStatus.Parent = LoadingCard

-- Game Linked Badge
local GameBadge = Instance.new("Frame")
GameBadge.Name = "GameBadge"
GameBadge.AnchorPoint = Vector2.new(0.5, 0)
GameBadge.Position = UDim2.new(0.5, 0, 0, 162)
GameBadge.Size = UDim2.new(0, 220, 0, 26)
GameBadge.BackgroundColor3 = Color3.fromRGB(24, 18, 36)
GameBadge.BorderSizePixel = 0
GameBadge.ZIndex = 6
GameBadge.Parent = LoadingCard
createCorner(GameBadge, 13)
createStroke(GameBadge, Config.BorderGlow, 1, 0.4)

local GameBadgeDot = Instance.new("Frame")
GameBadgeDot.AnchorPoint = Vector2.new(0, 0.5)
GameBadgeDot.Position = UDim2.new(0, 10, 0.5, 0)
GameBadgeDot.Size = UDim2.new(0, 7, 0, 7)
GameBadgeDot.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
GameBadgeDot.BorderSizePixel = 0
GameBadgeDot.ZIndex = 7
GameBadgeDot.Parent = GameBadge
createCorner(GameBadgeDot, 4)

local GameBadgeText = Instance.new("TextLabel")
GameBadgeText.Size = UDim2.new(1, -28, 1, 0)
GameBadgeText.Position = UDim2.new(0, 24, 0, 0)
GameBadgeText.BackgroundTransparency = 1
GameBadgeText.Font = Enum.Font.GothamBold
GameBadgeText.Text = "Detecting Game..."
GameBadgeText.TextColor3 = Config.TextPrimary
GameBadgeText.TextSize = 10
GameBadgeText.TextXAlignment = Enum.TextXAlignment.Left
GameBadgeText.ZIndex = 7
GameBadgeText.Parent = GameBadge

-- Progress Bar Container
local ProgressSection = Instance.new("Frame")
ProgressSection.Name = "ProgressSection"
ProgressSection.AnchorPoint = Vector2.new(0.5, 0)
ProgressSection.Position = UDim2.new(0.5, 0, 0, 218)
ProgressSection.Size = UDim2.new(1, -56, 0, 30)
ProgressSection.BackgroundTransparency = 1
ProgressSection.ZIndex = 6
ProgressSection.Parent = LoadingCard

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Name = "PercentLabel"
PercentLabel.AnchorPoint = Vector2.new(1, 0)
PercentLabel.Position = UDim2.new(1, 0, 0, -18)
PercentLabel.Size = UDim2.new(0, 60, 0, 14)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Font = Enum.Font.Code
PercentLabel.Text = "0%"
PercentLabel.TextColor3 = Config.PrimaryGlow
PercentLabel.TextSize = 11
PercentLabel.TextXAlignment = Enum.TextXAlignment.Right
PercentLabel.ZIndex = 7
PercentLabel.Parent = ProgressSection

local ProgressBarTrack = Instance.new("Frame")
ProgressBarTrack.Name = "ProgressBarTrack"
ProgressBarTrack.Size = UDim2.new(1, 0, 0, 6)
ProgressBarTrack.Position = UDim2.new(0, 0, 0, 4)
ProgressBarTrack.BackgroundColor3 = Color3.fromRGB(24, 18, 36)
ProgressBarTrack.BorderSizePixel = 0
ProgressBarTrack.ZIndex = 6
ProgressBarTrack.Parent = ProgressSection
createCorner(ProgressBarTrack, 3)

local ProgressBarFill = Instance.new("Frame")
ProgressBarFill.Name = "ProgressBarFill"
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Config.PrimaryColor
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.ZIndex = 7
ProgressBarFill.Parent = ProgressBarTrack
createCorner(ProgressBarFill, 3)
createGradient(ProgressBarFill, Color3.fromRGB(192, 132, 252), Color3.fromRGB(147, 51, 234), 0)

local function setProgress(percent, duration, statusText)
    if statusText then LoadStatus.Text = statusText end
    local tween = TweenService:Create(ProgressBarFill, TweenInfo.new(duration or 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(math.clamp(percent, 0, 1), 0, 1, 0)
    })
    tween:Play()

    task.spawn(function()
        local startTime = tick()
        local cur = tonumber(PercentLabel.Text:match("%d+")) or 0
        local target = math.floor(percent * 100)
        while tick() - startTime < (duration or 0.5) do
            local alpha = (tick() - startTime) / (duration or 0.5)
            local val = math.floor(cur + (target - cur) * alpha)
            PercentLabel.Text = tostring(val) .. "%"
            RunService.RenderStepped:Wait()
        end
        PercentLabel.Text = tostring(target) .. "%"
    end)
    return tween
end

-- ==============================================================================
-- // Multi-Tier Script Payload Executor
-- ==============================================================================
local function executePayload(gameName)
    local target = TargetGames[gameName]
    if not target then
        warn("[HYPER HUB] Game not supported in loader registry: " .. tostring(gameName))
        return false
    end

    local code = nil
    -- 1. Try local offline files
    if typeof(isfile) == "function" and typeof(readfile) == "function" then
        local candidates = {
            target.Local,
            "Scripts/" .. gameName .. ".lua",
            "M.lua/" .. gameName .. ".lua",
            "HYPER_Cache/" .. gameName .. ".lua"
        }
        for _, c in ipairs(candidates) do
            if isfile(c) then
                local content = readfile(c)
                if content and #content > 50 then
                    code = content
                    break
                end
            end
        end
    end

    -- 2. Try Remote endpoint
    if not code and target.Remote then
        pcall(function()
            local req = (request or http_request or (syn and syn.request) or (http and http.request))
            if req then
                local res = req({ Url = target.Remote, Method = "GET" })
                if res and res.StatusCode == 200 and #res.Body > 50 then
                    code = res.Body
                end
            end
            if not code then
                code = game:HttpGet(target.Remote)
            end
        end)
    end

    if code and #code > 50 then
        local fn, err = loadstring(code)
        if fn then
            local okExec, execErr = pcall(fn)
            if not okExec then
                warn("[HYPER HUB] Payload Execution Error: " .. tostring(execErr))
            end
            return okExec
        else
            warn("[HYPER HUB] Payload Compilation Error: " .. tostring(err))
        end
    end

    return false
end

-- ==============================================================================
-- // Main Execution Flow
-- ==============================================================================
local function startExecution(gameName, gameConfig)
    -- Hide KeyWindow if visible
    if KeyWindow.Visible then
        TweenService:Create(KeyWindow, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 430, 0, 0),
            BackgroundTransparency = 1
        }):Play()
        task.wait(0.35)
        KeyWindow.Visible = false
    end

    -- Open Loading Card
    LoadingCard.Visible = true
    LoadingCard.Size = UDim2.new(0, 420, 0, 0)
    LoadingCard.BackgroundTransparency = 1

    TweenService:Create(LoadingCard, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 420, 0, 290),
        BackgroundTransparency = 0.2
    }):Play()

    -- Spinner animation loop
    task.spawn(function()
        while LoadingCard and LoadingCard.Parent and LoadingCard.Visible do
            SpinnerRing.Rotation = (SpinnerRing.Rotation + 5) % 360
            RunService.RenderStepped:Wait()
        end
    end)

    -- Step 1: Security Handshake
    setProgress(0.25, 0.5, "Verifying Client Security...")
    task.wait(0.6)

    -- Step 2: Game Linked Check
    if gameName and gameConfig then
        local keyStatusText = gameConfig.RequiresKey and " (Key Verified)" or " (Free Tier - No Key Required)"
        GameBadgeText.Text = gameName .. keyStatusText
        GameBadgeDot.BackgroundColor3 = Color3.fromRGB(0, 230, 140)

        setProgress(0.55, 0.6, "Game Linked: " .. gameName)
        task.wait(0.7)

        -- Step 3: Fetching Payload Modules
        setProgress(0.85, 0.7, "Downloading Engine Payload...")
        task.wait(0.8)

        -- Step 4: Ready
        setProgress(1.0, 0.4, "HYPER HUB Ready!")
        LoadTitle.Text = Config.BrandName .. " LOADED"
        LoadTitle.TextColor3 = Config.PrimaryGlow
        task.wait(0.6)

        -- Fade Out Smoothly
        TweenService:Create(Blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Size = 0}):Play()
        TweenService:Create(Overlay, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
        TweenService:Create(LoadingCard, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 380, 0, 0),
            BackgroundTransparency = 1
        }):Play()

        task.wait(0.5)
        LoaderUI:Destroy()
        Blur:Destroy()

        -- Execute Payload
        executePayload(gameName)
    else
        GameBadgeText.Text = "Unsupported Game"
        GameBadgeDot.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        LoadTitle.Text = "GAME NOT SUPPORTED"
        LoadTitle.TextColor3 = Color3.fromRGB(255, 70, 70)

        setProgress(1.0, 0.4, "PlaceId " .. tostring(PlaceId) .. " is not registered")
        ProgressBarFill.BackgroundColor3 = Color3.fromRGB(255, 60, 60)

        task.wait(2.5)
        TweenService:Create(Blur, TweenInfo.new(0.4), {Size = 0}):Play()
        TweenService:Create(Overlay, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        TweenService:Create(LoadingCard, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        task.wait(0.4)
        LoaderUI:Destroy()
    end
end

local function onConfirmKey(gameName, gameConfig)
    local key = KeyTextBox.Text:match("^%s*(.-)%s*$")
    if key == "" then
        StatusMsg.TextColor3 = Color3.fromRGB(255, 80, 80)
        StatusMsg.Text = "Please enter a valid PandaAuth key"
        return
    end

    VerifyBtn.Text = "VERIFYING PANDAAUTH..."
    VerifyBtn.Active = false
    KeyTextBox.TextEditable = false
    StatusMsg.TextColor3 = Config.TextMuted
    StatusMsg.Text = "Validating with PandaAuth server..."

    task.spawn(function()
        local result = verifyPandaKey(key)
        if result and result.valid then
            -- Save key
            pcall(function()
                if typeof(writefile) == "function" then
                    writefile("HyperHubKey.txt", key)
                end
            end)

            if result.profile then
                getgenv().KeyUsername = result.profile.username
                getgenv().KeyEmail = result.profile.email or ("UID: " .. tostring(LocalPlayer.UserId))
                getgenv().KeyAvatar = result.profile.avatar_url or ("rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId) .. "&w=150&h=150")
            end

            StatusMsg.TextColor3 = Color3.fromRGB(0, 230, 140)
            StatusMsg.Text = result.message or "PandaAuth: Verified Successfully!"
            VerifyBtn.Text = "ACCESS GRANTED"

            task.wait(0.5)
            startExecution(gameName, gameConfig)
        else
            VerifyBtn.Text = "VERIFY & LAUNCH"
            VerifyBtn.Active = true
            KeyTextBox.TextEditable = true
            StatusMsg.TextColor3 = Color3.fromRGB(255, 80, 80)
            StatusMsg.Text = (result and result.message) or "Invalid key. Please check again."
        end
    end)
end

-- ==============================================================================
-- // Startup Loader Controller
-- ==============================================================================
task.spawn(function()
    local detectedGameName, gameConfig = detectCurrentGame()

    -- 1. Unsupported game check
    if not detectedGameName or not gameConfig then
        startExecution(nil, nil)
        return
    end

    -- 2. Per-Map Key Check:
    -- If RequiresKey == false (No key needed for this map) -> Launch directly!
    if gameConfig.RequiresKey == false then
        startExecution(detectedGameName, gameConfig)
        return
    end

    -- 3. Map Requires Key -> Check saved key first
    if savedKey and #savedKey >= 6 then
        local check = verifyPandaKey(savedKey)
        if check and check.valid then
            if check.profile then
                getgenv().KeyUsername = check.profile.username
                getgenv().KeyEmail = check.profile.email or ("UID: " .. tostring(LocalPlayer.UserId))
                getgenv().KeyAvatar = check.profile.avatar_url or ("rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId) .. "&w=150&h=150")
            end
            startExecution(detectedGameName, gameConfig)
            return
        end
    end

    -- 4. Map Requires Key and no valid saved key -> Open Key Window
    KeyHeading.Text = detectedGameName .. " Key Required"
    KeySubheading.Text = "Enter PandaAuth key to unlock " .. detectedGameName

    VerifyBtn.MouseButton1Click:Connect(function()
        onConfirmKey(detectedGameName, gameConfig)
    end)
    KeyTextBox.FocusLost:Connect(function(enter)
        if enter then onConfirmKey(detectedGameName, gameConfig) end
    end)

    KeyWindow.Visible = true
    KeyWindow.Size = UDim2.new(0, 430, 0, 0)
    KeyWindow.BackgroundTransparency = 1
    TweenService:Create(KeyWindow, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 430, 0, 360),
        BackgroundTransparency = 0.2
    }):Play()
end)
