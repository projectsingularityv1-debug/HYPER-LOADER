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

-- Ensure cache directory exists for Logo assets & clean stale cache
if _makefolder then
    pcall(function()
        if not (_isfolder and _isfolder("HYPER_Cache")) and not (_isfile and _isfile("HYPER_Cache")) then
            _makefolder("HYPER_Cache")
        end
    end)
end

-- Stale cache cleaner
pcall(function()
    if _isfile and _delfile then
        if _isfile("HYPER_Cache/rawgithubusercontent_4aa2a282.png") then
            _delfile("HYPER_Cache/rawgithubusercontent_4aa2a282.png")
        end
    end
end)

local DEFAULT_HYPER_LOGO_URL = "https://img2.pic.in.th/HYPER.png"
local HYPER_DEFAULT_LOGO_B64 = "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"

local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local b64lut = {}
for i = 1, #b64chars do
    b64lut[string.byte(b64chars, i)] = i - 1
end

local function decodeBase64(str)
    if typeof(crypt) == "table" and crypt.base64_decode then
        local s, res = pcall(crypt.base64_decode, str)
        if s and res and #res > 0 then return res end
    end
    if typeof(base64_decode) == "function" then
        local s, res = pcall(base64_decode, str)
        if s and res and #res > 0 then return res end
    end
    if typeof(syn) == "table" and syn.crypt and syn.crypt.base64 and syn.crypt.base64.decode then
        local s, res = pcall(syn.crypt.base64.decode, str)
        if s and res and #res > 0 then return res end
    end

    local out = {}
    local len = #str
    local char = string.char
    local floor = math.floor
    local byte = string.byte
    local k = 1
    local i = 1
    while i <= len do
        local c1 = b64lut[byte(str, i)]
        local c2 = b64lut[byte(str, i+1)]
        local b3 = byte(str, i+2)
        local b4 = byte(str, i+3)
        local c3 = b3 and b64lut[b3] or nil
        local c4 = b4 and b64lut[b4] or nil
        if not c1 or not c2 then break end

        local n = c1 * 262144 + c2 * 4096 + (c3 or 0) * 64 + (c4 or 0)
        out[k] = char(floor(n / 65536) % 256)
        k = k + 1
        if c3 then
            out[k] = char(floor(n / 256) % 256)
            k = k + 1
        end
        if c4 then
            out[k] = char(n % 256)
            k = k + 1
        end
        i = i + 4
    end
    return table.concat(out)
end

local _cachedEmbeddedLogoData = nil
local function getEmbeddedLogoData()
    if not _cachedEmbeddedLogoData then
        _cachedEmbeddedLogoData = decodeBase64(HYPER_DEFAULT_LOGO_B64)
    end
    return _cachedEmbeddedLogoData
end

-- Pre-seed / ensure fresh HYPER logo exists in cache with exact 19183 bytes
pcall(function()
    if _writefile and _isfile then
        local needWrite = false
        if not _isfile("HYPER_Cache/HYPER.png") then
            needWrite = true
        elseif _readfile then
            local content = _readfile("HYPER_Cache/HYPER.png")
            if not content or #content ~= 19183 then
                needWrite = true
            end
        end
        if needWrite then
            local data = getEmbeddedLogoData()
            if data and #data > 0 then
                _writefile("HYPER_Cache/HYPER.png", data)
                _writefile("HYPER_Cache/HYPER_a79d4b62.png", data)
            end
        end
    end
end)

local function urlHash(str)
    local hash = 5381
    for i = 1, #str do
        hash = ((hash * 33) + string.byte(str, i)) % 4294967296
    end
    return string.format("%08x", hash)
end

local function resolveLogo(url)
    if not url or url == "" or url == "rbxassetid://136264753381080" or url == "136264753381080" or url == "rbxassetid://92567372646337" or url == "92567372646337" or url == "HYPER" or url == "HYPER.png" then
        url = DEFAULT_HYPER_LOGO_URL
    end
    if typeof(url) == "string" and url:find("github%.com/.+/blob/") then
        url = url:gsub("github%.com/([^/]+)/([^/]+)/blob/", "raw.githubusercontent.com/%1/%2/")
    end
    if typeof(url) == "string" and (url:match("^rbxassetid://") or url:match("^rbxthumb://") or url:match("^rbxasset://")) then
        return url
    end
    if tonumber(url) then return "rbxassetid://" .. tostring(url) end
    
    if typeof(url) == "string" and url:match("^https?://") and _getcustomasset then
        if _makefolder and _isfolder and not _isfolder("HYPER_Cache") then
            pcall(function() _makefolder("HYPER_Cache") end)
        end
        local ext = url:match("%.([%w]+)$") or "png"
        local baseName = (url:match("([^/?#]+)%.") or "HYPER"):gsub("[^%w_-]", "")
        local fileId = baseName .. "_" .. urlHash(url) .. "." .. ext
        local filePath = "HYPER_Cache/" .. fileId
        local isHyperLogo = (url == DEFAULT_HYPER_LOGO_URL or url:find("img2%.pic%.in%.th/HYPER%.png") or baseName == "HYPER")

        if _isfile and _isfile(filePath) then
            if isHyperLogo and _readfile then
                local c = _readfile(filePath)
                if c and #c == 19183 then
                    local ok, c_asset = pcall(function() return _getcustomasset(filePath) end)
                    if ok and c_asset then return c_asset end
                end
            else
                local ok, c_asset = pcall(function() return _getcustomasset(filePath) end)
                if ok and c_asset then return c_asset end
            end
        end

        if isHyperLogo and _isfile and _isfile("HYPER_Cache/HYPER.png") then
            if _readfile then
                local c = _readfile("HYPER_Cache/HYPER.png")
                if c and #c == 19183 then
                    local ok, c_asset = pcall(function() return _getcustomasset("HYPER_Cache/HYPER.png") end)
                    if ok and c_asset then return c_asset end
                end
            end
        end

        local ok, data = pcall(function()
            if _request then
                local res = _request({
                    Url = url,
                    Method = "GET",
                    Headers = {
                        ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
                        ["Accept"] = "image/*,*/*;q=0.8"
                    }
                })
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

        if (not ok or not data or typeof(data) ~= "string" or #data == 0) and isHyperLogo then
            data = getEmbeddedLogoData()
            ok = (data and #data > 0)
        end

        if ok and data and typeof(data) == "string" and #data > 0 and _writefile then
            pcall(function() _writefile(filePath, data) end)
            if isHyperLogo then
                pcall(function() _writefile("HYPER_Cache/HYPER.png", data) end)
            end
            if _isfile and _isfile(filePath) then
                local ok2, c_asset = pcall(function() return _getcustomasset(filePath) end)
                if ok2 and c_asset then return c_asset end
            end
        end

        if _getcustomasset and _writefile and (url == DEFAULT_HYPER_LOGO_URL or url:find("HYPER")) then
            local fallbackData = getEmbeddedLogoData()
            pcall(function() _writefile("HYPER_Cache/HYPER.png", fallbackData) end)
            local ok2, c_asset = pcall(function() return _getcustomasset("HYPER_Cache/HYPER.png") end)
            if ok2 and c_asset then return c_asset end
        end
    end
    return DEFAULT_HYPER_LOGO_URL
end

local PlaceId = game.PlaceId

-- ==============================================================================
-- // Configuration
-- ==============================================================================
local Config = {
    BrandName = "Singularity Hub",
    LogoAsset = "https://img2.pic.in.th/HYPER.png", -- HYPER Logo
    FallbackLogo = "https://img2.pic.in.th/HYPER.png",

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
