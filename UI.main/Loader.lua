-- ==============================================================================
--  HYPER HUB / SINGULARITY HUB - Universal Multi-Map Minimalist Loader
--  Created by K2NTA ST | Project Singularity
--  Features: Clean Minimalist Center HUD Loader, PandaAuth Key Engine & Auto-Exec
-- ==============================================================================

local _cloneref = (typeof(cloneref) == "function" and cloneref) or function(...) return ... end
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

local LocalPlayer = Players and Players.LocalPlayer
local _getcustomasset = (typeof(getcustomasset) == "function" and getcustomasset) or (typeof(getsynasset) == "function" and getsynasset) or nil
local _writefile = (typeof(writefile) == "function" and writefile) or nil
local _isfile = (typeof(isfile) == "function" and isfile) or nil
local _isfolder = (typeof(isfolder) == "function" and isfolder) or nil
local _makefolder = (typeof(makefolder) == "function" and makefolder) or nil
local _request = (typeof(request) == "function" and request) or (typeof(http_request) == "function" and http_request) or (typeof(syn) == "table" and syn and syn.request) or nil

-- Ensure cache directory exists for Logo assets
if _makefolder then
    pcall(function()
        if not (_isfolder and _isfolder("HYPER_Cache")) and not (_isfile and _isfile("HYPER_Cache")) then
            _makefolder("HYPER_Cache")
        end
    end)
end

local function urlHash(str)
    local hash = 5381
    for i = 1, #str do
        hash = ((hash * 33) + string.byte(str, i)) % 4294967296
    end
    return string.format("%08x", hash)
end

local function resolveLogo(url)
    if typeof(url) ~= "string" or url == "" then url = "https://img2.pic.in.th/HYPER.png" end
    if url:find("github%.com/.+/blob/") then
        url = url:gsub("github%.com/([^/]+)/([^/]+)/blob/", "raw.githubusercontent.com/%1/%2/")
    end
    if url:match("^rbxassetid://") or url:match("^rbxthumb://") or url:match("^rbxasset://") then return url end
    if tonumber(url) then return "rbxassetid://" .. url end
    
    if url:match("^https?://") and _getcustomasset then
        if _makefolder and _isfolder and not _isfolder("HYPER_Cache") then
            pcall(function() _makefolder("HYPER_Cache") end)
        end
        local ext = url:match("%.([%w]+)$") or "png"
        local baseName = (url:match("([^/?#]+)%.") or "HYPER"):gsub("[^%w_-]", "")
        local fileId = baseName .. "_" .. urlHash(url) .. "." .. ext
        local filePath = "HYPER_Cache/" .. fileId
        if _isfile and _isfile(filePath) then
            local ok, c = pcall(function() return _getcustomasset(filePath) end)
            if ok and c then return c end
        end
        local ok, data = pcall(function()
            if _request then
                local res = _request({Url = url, Method = "GET"})
                if res then
                    local body = res.Body or res.body
                    local code = res.StatusCode or res.status_code or res.Status
                    if (code == 200 or res.Success) and body and #body > 0 then
                        return body
                    end
                end
            end
            return game:HttpGet(url)
        end)
        if ok and data and typeof(data) == "string" and #data > 0 and _writefile then
            pcall(function() _writefile(filePath, data) end)
            pcall(function() _writefile("HYPER_Cache/HYPER.png", data) end)
            if _isfile and _isfile(filePath) then
                local ok2, c = pcall(function() return _getcustomasset(filePath) end)
                if ok2 and c then return c end
            end
        end
    end
    return "rbxassetid://13857987062"
end

local PlaceId = game.PlaceId

-- ==============================================================================
-- // Configuration
-- ==============================================================================
local Config = {
    BrandName = "Singularity Hub",
    LogoAsset = "https://img2.pic.in.th/HYPER.png", -- HYPER Logo
    FallbackLogo = "rbxassetid://112209635962758",

    -- PandaAuth Service API Configuration (pandauth.com)
    PandaServiceId = "0058594f-3409-4a86-975b-c988368434a9",
    PandaBaseURL = "https://pandauth.com",
    PandaDevBaseURL = "https://pandadevelopment.net",

    -- Game Registry Config Endpoints
    GamesConfigLocal = "Scripts/UI.main/Games.lua",
    GamesConfigRemote = "https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-LOADER/refs/heads/main/UI.main/Games.lua",
    GamesConfigFallbackRemote = "https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-LOADER/refs/heads/main/UI.main/Games.lua",
}

-- ==============================================================================
-- // Dynamic Game Registry Loader
-- ==============================================================================
local function loadGameRegistry()
    -- 1. Local Games.lua
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

    -- 2. Remote Games.lua
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
            Remote = "https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-MAIN/refs/heads/main/M.lua/BF%20V1"
        },
        ["Murder Mystery 2"] = {
            RequiresKey = true,
            PlaceIds = { 142823291 },
            Local = "Scripts/M.lua/MM2 DONE.lua",
            Remote = "https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-MAIN/refs/heads/main/M.lua/MM2%20DONE.lua"
        },
        ["The Walking Dead"] = {
            RequiresKey = true,
            PlaceIds = { 128039018996175 },
            Local = "Scripts/M.lua/TWD V1.lua",
            Remote = "https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-MAIN/refs/heads/main/M.lua/TWD%20V1.lua"
        },
        ["Fisch"] = {
            RequiresKey = true,
            PlaceIds = { 16732694052 },
            Local = "Scripts/M.lua/LK AUTO.lua",
            Remote = "https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-MAIN/refs/heads/main/M.lua/LK%20AUTO.lua"
        },
        ["Mine a Mountain"] = {
            RequiresKey = false,
            PlaceIds = { 125927821145949 },
            Local = "Scripts/M.lua/fame 222.lua",
            Remote = "https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-MAIN/refs/heads/main/M.lua/fame%20222.lua"
        },
        ["Laundry Simulator"] = {
            RequiresKey = false,
            PlaceIds = { 6305942109 },
            Local = "Scripts/M.lua/LaundrySimulator_AutoFarm.lua",
            Remote = "https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-MAIN/refs/heads/main/M.lua/LaundrySimulator_AutoFarm.lua"
        },
        ["Cali Shootout"] = {
            RequiresKey = false,
            PlaceIds = { 12077443856 },
            Local = "Scripts/M.lua/gun auto.lua",
            Remote = "https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-MAIN/refs/heads/main/M.lua/gun%20auto.lua"
        },
        ["Basketball"] = {
            RequiresKey = false,
            PlaceIds = { 16033173781, 16270425785 },
            Local = "Scripts/Basketball_XINZ.lua",
            Remote = "https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-MAIN/refs/heads/main/M.lua/Basketball_XINZ.lua"
        }
    }
end

local TargetGames = loadGameRegistry()

local function detectCurrentGame()
    local currentPlace = PlaceId
    for gameName, data in pairs(TargetGames) do
        if data.PlaceIds then
            for _, id in ipairs(data.PlaceIds) do
                if id == currentPlace then
                    return gameName, data
                end
            end
        end
    end
    return nil, nil
end

-- ==============================================================================
-- // Clean existing loader instances
-- ==============================================================================
local function cleanOldLoaders()
    for _, name in ipairs({"SingularityLoader", "HyperHubLoader", "ProjectXinzLoader", "SingularityLoadingGui"}) do
        pcall(function()
            local old = CoreGui and CoreGui:FindFirstChild(name)
            if old then old:Destroy() end
        end)
        pcall(function()
            if LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui") then
                local old = LocalPlayer.PlayerGui:FindFirstChild(name)
                if old then old:Destroy() end
            end
        end)
    end
end
cleanOldLoaders()

-- ==============================================================================
-- // Create ScreenGui
-- ==============================================================================
local LoaderUI = Instance.new("ScreenGui")
LoaderUI.Name = "SingularityLoader"
LoaderUI.ResetOnSpawn = false
LoaderUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoaderUI.IgnoreGuiInset = true

local gethui = (typeof(gethui) == "function" and gethui) or nil
local protectgui = (typeof(protectgui) == "function" and protectgui) or (typeof(syn) == "table" and syn.protect_gui) or nil

if gethui then
    LoaderUI.Parent = gethui()
elseif protectgui then
    protectgui(LoaderUI)
    LoaderUI.Parent = CoreGui
else
    local ok = pcall(function() LoaderUI.Parent = CoreGui end)
    if not ok then
        LoaderUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
end

-- Helper functions
local function createCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = instance
    return corner
end

local function createStroke(instance, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(255, 255, 255)
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = instance
    return stroke
end

local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)
end

-- ==============================================================================
-- // PandaAuth Key Engine
-- ==============================================================================
local function getHWID()
    local hwid = nil
    pcall(function()
        if typeof(gethwid) == "function" then hwid = gethwid()
        elseif typeof(get_hwid) == "function" then hwid = get_hwid()
        elseif typeof(getexecutorhwid) == "function" then hwid = getexecutorhwid()
        elseif typeof(identifyexecutor) == "function" then
            hwid = tostring(LocalPlayer.UserId) .. "_" .. tostring(identifyexecutor())
        end
    end)
    if not hwid or hwid == "" then
        hwid = tostring(LocalPlayer.UserId) .. "_HYPER_" .. tostring(math.floor(os.time() / 86400))
    end
    return tostring(hwid)
end

local function getPandaGetKeyURL()
    local hwid = getHWID()
    return string.format(
        "%s/getkey?service=%s&hwid=%s",
        Config.PandaBaseURL,
        Config.PandaServiceId,
        HttpService:UrlEncode(hwid)
    )
end

local function verifyPandaKey(key)
    if not key or key == "" then
        return { valid = false, message = "Key cannot be empty" }
    end

    local cleanKey = tostring(key):match("^%s*(.-)%s*$")
    local hwid = getHWID()

    local requestFunc = (request or http_request or (syn and syn.request) or (http and http.request))
    local endpoints = {
        string.format("%s/api/v1/keys/verify?service=%s&hwid=%s&key=%s", Config.PandaBaseURL, Config.PandaServiceId, HttpService:UrlEncode(hwid), HttpService:UrlEncode(cleanKey)),
        string.format("%s/api/v1/keys/verify?service=%s&hwid=%s&key=%s", Config.PandaDevBaseURL, Config.PandaServiceId, HttpService:UrlEncode(hwid), HttpService:UrlEncode(cleanKey)),
        string.format("%s/api/v1/loader.lua?service=%s&hwid=%s&key=%s", Config.PandaBaseURL, Config.PandaServiceId, HttpService:UrlEncode(hwid), HttpService:UrlEncode(cleanKey))
    }

    for _, endpoint in ipairs(endpoints) do
        local ok, res = pcall(function()
            if requestFunc then
                local response = requestFunc({
                    Url = endpoint,
                    Method = "GET",
                    Headers = {
                        ["User-Agent"] = "Singularity-Loader/3.0 (Roblox)",
                        ["Accept"] = "application/json, text/plain, */*"
                    }
                })
                if response and (response.StatusCode == 200 or response.Status == 200) then
                    return response.Body
                end
            end
            return game:HttpGet(endpoint)
        end)

        if ok and res and #res > 0 then
            local jsonOk, data = pcall(function()
                return HttpService:JSONDecode(res)
            end)

            if jsonOk and type(data) == "table" then
                if data.valid == true or data.status == "success" or data.authenticated == true or data.success == true then
                    return {
                        valid = true,
                        message = data.message or "Key Verified Successfully!",
                        profile = data.profile or data.data or {
                            username = (LocalPlayer and LocalPlayer.Name) or "User",
                            email = "UID: " .. tostring(LocalPlayer and LocalPlayer.UserId or "0"),
                            avatar_url = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer and LocalPlayer.UserId or 0) .. "&w=150&h=150"
                        }
                    }
                elseif data.valid == false or data.status == "error" or data.authenticated == false or data.success == false then
                    return {
                        valid = false,
                        message = data.message or data.error or "Invalid key or HWID mismatch"
                    }
                end
            end

            if res:find("true") or res:find("success") or res:find("authenticated") or res:find("VALID") then
                return {
                    valid = true,
                    message = "PandaAuth: License Active",
                    profile = {
                        username = (LocalPlayer and LocalPlayer.Name) or "User",
                        email = "UID: " .. tostring(LocalPlayer and LocalPlayer.UserId or "0"),
                        avatar_url = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer and LocalPlayer.UserId or 0) .. "&w=150&h=150"
                    }
                }
            end
        end
    end

    return { valid = false, message = "Could not verify key. Check your connection or key validity." }
end

-- ==============================================================================
-- // MINIMALIST CENTER LOADING HUD (As per Reference Design)
-- ==============================================================================
local CenterLoader = Instance.new("Frame")
CenterLoader.Name = "CenterLoader"
CenterLoader.AnchorPoint = Vector2.new(0.5, 0.5)
CenterLoader.Position = UDim2.new(0.5, 0, 0.5, 0)
CenterLoader.Size = UDim2.new(0, 260, 0, 130)
CenterLoader.BackgroundTransparency = 1
CenterLoader.ZIndex = 10
CenterLoader.Parent = LoaderUI

-- 1. Orbit Planet Logo Icon
local LogoIcon = Instance.new("ImageLabel")
LogoIcon.Name = "LogoIcon"
LogoIcon.AnchorPoint = Vector2.new(0.5, 0)
LogoIcon.Position = UDim2.new(0.5, 0, 0, 0)
LogoIcon.Size = UDim2.new(0, 44, 0, 44)
LogoIcon.BackgroundTransparency = 1
LogoIcon.Image = resolveLogo(Config.LogoAsset)
LogoIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
LogoIcon.ZIndex = 11
LogoIcon.Parent = CenterLoader

-- 2. Title Label ("Loading Singularity Hub...")
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.AnchorPoint = Vector2.new(0.5, 0)
TitleLabel.Position = UDim2.new(0.5, 0, 0, 52)
TitleLabel.Size = UDim2.new(1, 40, 0, 20)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Loading Singularity Hub..."
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
TitleLabel.ZIndex = 11
TitleLabel.Parent = CenterLoader

-- 3. Subtitle / Status Label ("Game Not Supported!" / "Loading...")
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.AnchorPoint = Vector2.new(0.5, 0)
StatusLabel.Position = UDim2.new(0.5, 0, 0, 75)
StatusLabel.Size = UDim2.new(1, 40, 0, 16)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Text = "Checking Game..."
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.ZIndex = 11
StatusLabel.Parent = CenterLoader

-- 4. Progress Bar Track & Fill Line
local ProgressTrack = Instance.new("Frame")
ProgressTrack.Name = "ProgressTrack"
ProgressTrack.AnchorPoint = Vector2.new(0.5, 0)
ProgressTrack.Position = UDim2.new(0.5, 0, 0, 102)
ProgressTrack.Size = UDim2.new(0, 190, 0, 3)
ProgressTrack.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
ProgressTrack.BorderSizePixel = 0
ProgressTrack.ZIndex = 11
ProgressTrack.Parent = CenterLoader
createCorner(ProgressTrack, 2)

local ProgressFill = Instance.new("Frame")
ProgressFill.Name = "ProgressFill"
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProgressFill.BorderSizePixel = 0
ProgressFill.ZIndex = 12
ProgressFill.Parent = ProgressTrack
createCorner(ProgressFill, 2)

-- Function to set progress smoothly
local function updateProgress(percent, duration, statusText, isError)
    if statusText then
        StatusLabel.Text = statusText
        if isError then
            StatusLabel.TextColor3 = Color3.fromRGB(255, 65, 65)
            ProgressFill.BackgroundColor3 = Color3.fromRGB(255, 65, 65)
        else
            StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            ProgressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        end
    end

    local tween = TweenService:Create(ProgressFill, TweenInfo.new(duration or 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(math.clamp(percent, 0, 1), 0, 1, 0)
    })
    tween:Play()
    return tween
end

-- ==============================================================================
-- // MINIMALIST KEYCARD MODAL (When Key is Required)
-- ==============================================================================
local KeyCard = Instance.new("Frame")
KeyCard.Name = "KeyCard"
KeyCard.AnchorPoint = Vector2.new(0.5, 0.5)
KeyCard.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyCard.Size = UDim2.new(0, 340, 0, 230)
KeyCard.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeyCard.BorderSizePixel = 0
KeyCard.Visible = false
KeyCard.ZIndex = 20
KeyCard.Parent = LoaderUI

createCorner(KeyCard, 12)
createStroke(KeyCard, Color3.fromRGB(45, 45, 45), 1, 0)
makeDraggable(KeyCard)

local KeyLogo = Instance.new("ImageLabel")
KeyLogo.AnchorPoint = Vector2.new(0.5, 0)
KeyLogo.Position = UDim2.new(0.5, 0, 0, 16)
KeyLogo.Size = UDim2.new(0, 32, 0, 32)
KeyLogo.BackgroundTransparency = 1
KeyLogo.Image = resolveLogo(Config.LogoAsset)
KeyLogo.ImageColor3 = Color3.fromRGB(255, 255, 255)
KeyLogo.ZIndex = 21
KeyLogo.Parent = KeyCard

local KeyTitle = Instance.new("TextLabel")
KeyTitle.AnchorPoint = Vector2.new(0.5, 0)
KeyTitle.Position = UDim2.new(0.5, 0, 0, 54)
KeyTitle.Size = UDim2.new(1, -20, 0, 18)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = "Singularity Hub - Key Required"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 13
KeyTitle.ZIndex = 21
KeyTitle.Parent = KeyCard

local KeyInputBox = Instance.new("TextBox")
KeyInputBox.AnchorPoint = Vector2.new(0.5, 0)
KeyInputBox.Position = UDim2.new(0.5, 0, 0, 82)
KeyInputBox.Size = UDim2.new(1, -40, 0, 36)
KeyInputBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
KeyInputBox.BorderSizePixel = 0
KeyInputBox.Font = Enum.Font.Code
KeyInputBox.PlaceholderText = "Paste PandaAuth Key..."
KeyInputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
KeyInputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInputBox.TextSize = 11
KeyInputBox.ClearTextOnFocus = false
KeyInputBox.ZIndex = 21
KeyInputBox.Parent = KeyCard
createCorner(KeyInputBox, 8)
createStroke(KeyInputBox, Color3.fromRGB(45, 45, 45), 1, 0)

-- Read saved key
local savedKey = ""
pcall(function()
    if typeof(readfile) == "function" then
        if isfile and isfile("HyperHubKey.txt") then savedKey = readfile("HyperHubKey.txt")
        elseif isfile and isfile("SingularityKey.txt") then savedKey = readfile("SingularityKey.txt")
        end
    end
end)
KeyInputBox.Text = savedKey or ""

local KeyStatus = Instance.new("TextLabel")
KeyStatus.AnchorPoint = Vector2.new(0.5, 0)
KeyStatus.Position = UDim2.new(0.5, 0, 0, 124)
KeyStatus.Size = UDim2.new(1, -40, 0, 14)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.Text = ""
KeyStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
KeyStatus.TextSize = 10
KeyStatus.ZIndex = 21
KeyStatus.Parent = KeyCard

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.AnchorPoint = Vector2.new(0.5, 0)
VerifyBtn.Position = UDim2.new(0.5, 0, 0, 144)
VerifyBtn.Size = UDim2.new(1, -40, 0, 36)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.BorderSizePixel = 0
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Text = "VERIFY KEY"
VerifyBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
VerifyBtn.TextSize = 11
VerifyBtn.ZIndex = 21
VerifyBtn.Parent = KeyCard
createCorner(VerifyBtn, 8)

local KeyLinksRow = Instance.new("Frame")
KeyLinksRow.AnchorPoint = Vector2.new(0.5, 0)
KeyLinksRow.Position = UDim2.new(0.5, 0, 0, 188)
KeyLinksRow.Size = UDim2.new(1, -40, 0, 24)
KeyLinksRow.BackgroundTransparency = 1
KeyLinksRow.ZIndex = 21
KeyLinksRow.Parent = KeyCard

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.5, -4, 1, 0)
GetKeyBtn.Position = UDim2.new(0, 0, 0, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Font = Enum.Font.GothamMedium
GetKeyBtn.Text = "Get Key"
GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
GetKeyBtn.TextSize = 10
GetKeyBtn.ZIndex = 22
GetKeyBtn.Parent = KeyLinksRow
createCorner(GetKeyBtn, 6)
createStroke(GetKeyBtn, Color3.fromRGB(45, 45, 45), 1, 0)

local PasteKeyBtn = Instance.new("TextButton")
PasteKeyBtn.Size = UDim2.new(0.5, -4, 1, 0)
PasteKeyBtn.Position = UDim2.new(0.5, 4, 0, 0)
PasteKeyBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
PasteKeyBtn.BorderSizePixel = 0
PasteKeyBtn.Font = Enum.Font.GothamMedium
PasteKeyBtn.Text = "Paste Key"
PasteKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
PasteKeyBtn.TextSize = 10
PasteKeyBtn.ZIndex = 22
PasteKeyBtn.Parent = KeyLinksRow
createCorner(PasteKeyBtn, 6)
createStroke(PasteKeyBtn, Color3.fromRGB(45, 45, 45), 1, 0)

GetKeyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local link = getPandaGetKeyURL()
        if typeof(setclipboard) == "function" then
            setclipboard(link)
            KeyStatus.TextColor3 = Color3.fromRGB(0, 230, 140)
            KeyStatus.Text = "Key link copied to clipboard!"
        else
            KeyStatus.Text = link
        end
    end)
end)

PasteKeyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if typeof(getclipboard) == "function" then
            local clip = getclipboard()
            if clip and clip ~= "" then
                KeyInputBox.Text = clip:match("^%s*(.-)%s*$")
            end
        end
    end)
end)

-- ==============================================================================
-- // Payload Executor
-- ==============================================================================
local function executePayload(gameName)
    local target = TargetGames[gameName]
    if not target then
        warn("[Singularity Hub] Game not supported: " .. tostring(gameName))
        return false
    end

    local code = nil
    -- 1. Offline local files
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

    -- 2. Remote endpoint
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
                warn("[Singularity Hub] Execution Error: " .. tostring(execErr))
            end
            return okExec
        else
            warn("[Singularity Hub] Compilation Error: " .. tostring(err))
        end
    end

    return false
end

-- ==============================================================================
-- // Master Loader Flow
-- ==============================================================================
local function runLoaderSequence(gameName, gameConfig)
    CenterLoader.Visible = true
    if CenterLoader:IsA("CanvasGroup") then CenterLoader.GroupTransparency = 0 end

    if not gameName or not gameConfig then
        -- Game Not Supported flow (matches reference screenshot!)
        updateProgress(1.0, 0.4, "Game Not Supported!", true)
        task.wait(3.0)
        
        -- Fade Out
        for i = 0, 10 do
            LogoIcon.ImageTransparency = i / 10
            TitleLabel.TextTransparency = i / 10
            StatusLabel.TextTransparency = i / 10
            ProgressTrack.BackgroundTransparency = i / 10
            ProgressFill.BackgroundTransparency = i / 10
            task.wait(0.02)
        end
        LoaderUI:Destroy()
        return
    end

    -- Supported Game Loading Flow
    updateProgress(0.3, 0.3, "Connecting to Singularity Hub...")
    task.wait(0.4)

    updateProgress(0.7, 0.4, "Loading " .. tostring(gameName) .. "...")
    task.wait(0.5)

    updateProgress(1.0, 0.3, "Loaded Successfully!")
    task.wait(0.4)

    -- Fade Out smoothly
    for i = 0, 10 do
        LogoIcon.ImageTransparency = i / 10
        TitleLabel.TextTransparency = i / 10
        StatusLabel.TextTransparency = i / 10
        ProgressTrack.BackgroundTransparency = i / 10
        ProgressFill.BackgroundTransparency = i / 10
        task.wait(0.02)
    end
    LoaderUI:Destroy()

    -- Execute Script Payload
    executePayload(gameName)
end

-- ==============================================================================
-- // Startup Controller
-- ==============================================================================
task.spawn(function()
    local detectedGameName, gameConfig = detectCurrentGame()

    -- 1. Unsupported game
    if not detectedGameName or not gameConfig then
        runLoaderSequence(nil, nil)
        return
    end

    -- 2. Free game (No key required)
    if gameConfig.RequiresKey == false then
        runLoaderSequence(detectedGameName, gameConfig)
        return
    end

    -- 3. Game Requires Key -> Check saved key first
    if savedKey and #savedKey >= 6 then
        updateProgress(0.4, 0.3, "Verifying saved key...")
        local check = verifyPandaKey(savedKey)
        if check and check.valid then
            if check.profile then
                getgenv().KeyUsername = check.profile.username
                getgenv().KeyEmail = check.profile.email or ("UID: " .. tostring(LocalPlayer.UserId))
                getgenv().KeyAvatar = check.profile.avatar_url or ("rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId) .. "&w=150&h=150")
            end
            runLoaderSequence(detectedGameName, gameConfig)
            return
        end
    end

    -- 4. Key Needed -> Show KeyCard Modal
    CenterLoader.Visible = false
    KeyCard.Visible = true

    local function handleKeySubmit()
        local key = KeyInputBox.Text:match("^%s*(.-)%s*$")
        if key == "" then
            KeyStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
            KeyStatus.Text = "Please enter your key"
            return
        end

        VerifyBtn.Text = "VERIFYING..."
        VerifyBtn.Active = false
        KeyStatus.TextColor3 = Color3.fromRGB(200, 200, 200)
        KeyStatus.Text = "Validating with PandaAuth..."

        task.spawn(function()
            local res = verifyPandaKey(key)
            if res and res.valid then
                pcall(function()
                    if typeof(writefile) == "function" then
                        writefile("HyperHubKey.txt", key)
                        writefile("SingularityKey.txt", key)
                    end
                end)

                if res.profile then
                    getgenv().KeyUsername = res.profile.username
                    getgenv().KeyEmail = res.profile.email or ("UID: " .. tostring(LocalPlayer.UserId))
                    getgenv().KeyAvatar = res.profile.avatar_url or ("rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId) .. "&w=150&h=150")
                end

                KeyCard.Visible = false
                runLoaderSequence(detectedGameName, gameConfig)
            else
                VerifyBtn.Text = "VERIFY KEY"
                VerifyBtn.Active = true
                KeyStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
                KeyStatus.Text = (res and res.message) or "Invalid key. Please check again."
            end
        end)
    end

    VerifyBtn.MouseButton1Click:Connect(handleKeySubmit)
    KeyInputBox.FocusLost:Connect(function(enter)
        if enter then handleKeySubmit() end
    end)
end)
