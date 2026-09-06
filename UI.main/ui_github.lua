-- โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•
--  Anti-Detection Bypass Layer (Dex-style)
--  Randomized names, cloneref services, gethui/protectgui hiding
-- โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•โ•


local _cloneref = (typeof(cloneref) == "function" and cloneref) or function(...) return ... end
local _gethui = (typeof(gethui) == "function" and gethui) or (typeof(get_hidden_gui) == "function" and get_hidden_gui) or nil
local _protectgui = (typeof(protect_gui) == "function" and protect_gui) or (typeof(syn) == "table" and syn and syn.protect_gui) or nil

-- Clone all service references to prevent anti-cheat from tracing them
local _Services = setmetatable({}, {
	__index = function(self, name)
		local ok, svc = pcall(function() return _cloneref(game:GetService(name)) end)
		if ok and svc then
			self[name] = svc
			return svc
		end
		return game:GetService(name)
	end
})

-- Generate a randomized, innocent-looking ScreenGui name to evade FindFirstChild scans
local _randomGuiName = (function()
	local chars = "abcdefghijklmnopqrstuvwxyz"
	local prefixes = {"ScreenGui", "GuiRoot", "UIContainer", "Display", "Overlay", "Panel"}
	local prefix = prefixes[math.random(1, #prefixes)]
	local suffix = ""
	for i = 1, 8 do
		local idx = math.random(1, #chars)
		suffix = suffix .. chars:sub(idx, idx)
	end
	return prefix .. "_" .. suffix .. "_" .. tostring(math.random(100000, 999999))
end)()

-- Safe environment functions for Image Caching (Dex Style)
local _writefile = (typeof(writefile) == "function" and writefile) or nil
local _readfile = (typeof(readfile) == "function" and readfile) or nil
local _isfile = (typeof(isfile) == "function" and isfile) or nil
local _isfolder = (typeof(isfolder) == "function" and isfolder) or nil
local _makefolder = (typeof(makefolder) == "function" and makefolder) or nil
local _listfiles = (typeof(listfiles) == "function" and listfiles) or (typeof(list_files) == "function" and list_files) or nil
local _getcustomasset = (typeof(getcustomasset) == "function" and getcustomasset) or (typeof(getsynasset) == "function" and getsynasset) or nil
local _request = (typeof(request) == "function" and request) or (typeof(http_request) == "function" and http_request) or (typeof(syn) == "table" and syn and syn.request) or nil

-- Ensure cache directory exists for Logo assets & clean stale cache
if _makefolder then
	pcall(function()
		if not (_isfolder and _isfolder("HYPER_Cache")) and not (_isfile and _isfile("HYPER_Cache")) then
			_makefolder("HYPER_Cache")
		end
	end)
end

-- Stale cache cleaner (removes old cached XZ logo if present)
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

-- Ultra-Fast CacheImage: Resolves Native IDs, Web Assets and Local Assets into HYPER_Cache
local function CacheImage(url)
	if not url or url == "" or url == "rbxassetid://136264753381080" or url == "136264753381080" or url == "rbxassetid://92567372646337" or url == "92567372646337" or url == "HYPER" or url == "HYPER.png" then
		url = DEFAULT_HYPER_LOGO_URL
	end

	-- Normalize github blob url to raw url
	if typeof(url) == "string" and url:find("github%.com/.+/blob/") then
		url = url:gsub("github%.com/([^/]+)/([^/]+)/blob/", "raw.githubusercontent.com/%1/%2/")
	end

	-- Native Roblox assets (no disk cache, return directly)
	if typeof(url) == "string" and (url:match("^rbxassetid://") or url:match("^rbxthumb://") or url:match("^rbxasset://") or url:match("^http://www.roblox.com/asset/%?id=")) then
		return url
	end

	-- Pure numbers (no disk cache, return directly)
	if tonumber(url) then
		return "rbxassetid://" .. tostring(url)
	end

	-- Check if local file exists directly in HYPER_Cache or root workspace
	if _getcustomasset and _isfile and typeof(url) == "string" then
		if _isfile("HYPER_Cache/" .. url) then
			local ok, custom = pcall(function() return _getcustomasset("HYPER_Cache/" .. url) end)
			if ok and custom then return custom end
		elseif _isfile(url) then
			local ok, custom = pcall(function() return _getcustomasset(url) end)
			if ok and custom then return custom end
		end
	end

	-- Web URLs (http/https) - Caches logo/web images into HYPER_Cache folder
	if typeof(url) == "string" and url:match("^https?://") then
		if _getcustomasset then
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
						local ok, custom = pcall(function() return _getcustomasset(filePath) end)
						if ok and custom then return custom end
					end
				else
					local ok, custom = pcall(function() return _getcustomasset(filePath) end)
					if ok and custom then return custom end
				end
			end

			-- Also check HYPER_Cache/HYPER.png if it is the HYPER logo
			if isHyperLogo and _isfile and _isfile("HYPER_Cache/HYPER.png") then
				if _readfile then
					local c = _readfile("HYPER_Cache/HYPER.png")
					if c and #c == 19183 then
						local ok, custom = pcall(function() return _getcustomasset("HYPER_Cache/HYPER.png") end)
						if ok and custom then return custom end
					end
				end
			end

			-- Fetch asset with browser headers to bypass 403 Forbidden
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

			-- If download failed or returned 403, and this is HYPER logo, use embedded binary data
			if (not ok or not data or typeof(data) ~= "string" or #data == 0) and isHyperLogo then
				data = getEmbeddedLogoData()
				ok = (data and #data > 0)
			end

			if ok and data and typeof(data) == "string" and #data > 0 then
				if _writefile then
					pcall(function() _writefile(filePath, data) end)
					if isHyperLogo then
						pcall(function() _writefile("HYPER_Cache/HYPER.png", data) end)
					end
					if _isfile and _isfile(filePath) then
						local ok2, custom = pcall(function() return _getcustomasset(filePath) end)
						if ok2 and custom then return custom end
					end
				end
			end
		end

		-- If custom asset failed but it is HYPER logo, write and return custom asset of HYPER.png if possible
		if _getcustomasset and _writefile and (url == DEFAULT_HYPER_LOGO_URL or url:find("HYPER")) then
			local data = getEmbeddedLogoData()
			pcall(function() _writefile("HYPER_Cache/HYPER.png", data) end)
			local ok, custom = pcall(function() return _getcustomasset("HYPER_Cache/HYPER.png") end)
			if ok and custom then return custom end
		end

		return DEFAULT_HYPER_LOGO_URL
	end

	return url
end

Library = {}
SaveTheme = {}

local themes = {
	index = {'Dark', 'Light', 'Liquid Glass', 'Amethyst', 'Rose', 'Ocean', 'Neon', 'Gold'},
	Rose = {
		['Shadow'] = Color3.fromRGB(30, 15, 20),
		['Background'] = Color3.fromRGB(35, 18, 25),
		['Page'] = Color3.fromRGB(28, 14, 20),
		['Main'] = Color3.fromRGB(220, 80, 120),
		['Text & Icon'] = Color3.fromRGB(255, 220, 230),
		['Function'] = {
			['Toggle'] = {
				['Background'] = Color3.fromRGB(40, 20, 28),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(100, 30, 55),
					['Toggle Value'] = Color3.fromRGB(220, 80, 120),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(50, 25, 35),
					['Toggle Value'] = Color3.fromRGB(80, 40, 55),
				}
			},
			['Label'] = { ['Background'] = Color3.fromRGB(40, 20, 28) },
			['Dropdown'] = {
				['Background'] = Color3.fromRGB(40, 20, 28),
				['Value Background'] = Color3.fromRGB(28, 14, 20),
				['Value Stroke'] = Color3.fromRGB(220, 80, 120),
				['Dropdown Select'] = {
					['Background'] = Color3.fromRGB(28, 14, 20),
					['Search'] = Color3.fromRGB(45, 22, 32),
					['Item Background'] = Color3.fromRGB(55, 28, 40),
				}
			},
			['Slider'] = {
				['Background'] = Color3.fromRGB(40, 20, 28),
				['Value Background'] = Color3.fromRGB(28, 14, 20),
				['Value Stroke'] = Color3.fromRGB(220, 80, 120),
				['Slider Bar'] = Color3.fromRGB(100, 30, 55),
				['Slider Bar Value'] = Color3.fromRGB(220, 80, 120),
				['Circle Value'] = Color3.fromRGB(255, 220, 230),
			},
			['Code'] = {
				['Background'] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 20, 28)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 20, 28))},
				['Background Code'] = Color3.fromRGB(60, 30, 42),
				['Background Code Value'] = Color3.fromRGB(45, 22, 32),
				['ScrollingFrame Code'] = Color3.fromRGB(220, 80, 120),
			},
			['Button'] = {
				['Background'] = Color3.fromRGB(40, 20, 28),
				['Click'] = Color3.fromRGB(255, 220, 230),
			},
			['Textbox'] = {
				['Background'] = Color3.fromRGB(40, 20, 28),
				['Value Background'] = Color3.fromRGB(28, 14, 20),
				['Value Stroke'] = Color3.fromRGB(220, 80, 120),
			},
			['Keybind'] = {
				['Background'] = Color3.fromRGB(40, 20, 28),
				['Value Background'] = Color3.fromRGB(28, 14, 20),
				['Value Stroke'] = Color3.fromRGB(220, 80, 120),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(100, 30, 55),
					['Toggle Value'] = Color3.fromRGB(220, 80, 120),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(50, 25, 35),
					['Toggle Value'] = Color3.fromRGB(80, 40, 55),
				}
			},
			['Color Picker'] = {
				['Background'] = Color3.fromRGB(40, 20, 28),
				['Color Select'] = {
					['Background'] = Color3.fromRGB(28, 14, 20),
					['UIStroke'] = Color3.fromRGB(220, 80, 120),
				}
			}
		}
	},
	Ocean = {
		['Shadow'] = Color3.fromRGB(5, 15, 30),
		['Background'] = Color3.fromRGB(8, 20, 40),
		['Page'] = Color3.fromRGB(6, 16, 32),
		['Main'] = Color3.fromRGB(0, 150, 220),
		['Text & Icon'] = Color3.fromRGB(200, 235, 255),
		['Function'] = {
			['Toggle'] = {
				['Background'] = Color3.fromRGB(10, 25, 50),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(0, 70, 120),
					['Toggle Value'] = Color3.fromRGB(0, 150, 220),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(15, 35, 65),
					['Toggle Value'] = Color3.fromRGB(20, 55, 90),
				}
			},
			['Label'] = { ['Background'] = Color3.fromRGB(10, 25, 50) },
			['Dropdown'] = {
				['Background'] = Color3.fromRGB(10, 25, 50),
				['Value Background'] = Color3.fromRGB(6, 16, 32),
				['Value Stroke'] = Color3.fromRGB(0, 150, 220),
				['Dropdown Select'] = {
					['Background'] = Color3.fromRGB(6, 16, 32),
					['Search'] = Color3.fromRGB(12, 30, 58),
					['Item Background'] = Color3.fromRGB(15, 38, 70),
				}
			},
			['Slider'] = {
				['Background'] = Color3.fromRGB(10, 25, 50),
				['Value Background'] = Color3.fromRGB(6, 16, 32),
				['Value Stroke'] = Color3.fromRGB(0, 150, 220),
				['Slider Bar'] = Color3.fromRGB(0, 70, 120),
				['Slider Bar Value'] = Color3.fromRGB(0, 150, 220),
				['Circle Value'] = Color3.fromRGB(200, 235, 255),
			},
			['Code'] = {
				['Background'] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 25, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 25, 50))},
				['Background Code'] = Color3.fromRGB(15, 38, 70),
				['Background Code Value'] = Color3.fromRGB(10, 28, 55),
				['ScrollingFrame Code'] = Color3.fromRGB(0, 150, 220),
			},
			['Button'] = {
				['Background'] = Color3.fromRGB(10, 25, 50),
				['Click'] = Color3.fromRGB(200, 235, 255),
			},
			['Textbox'] = {
				['Background'] = Color3.fromRGB(10, 25, 50),
				['Value Background'] = Color3.fromRGB(6, 16, 32),
				['Value Stroke'] = Color3.fromRGB(0, 150, 220),
			},
			['Keybind'] = {
				['Background'] = Color3.fromRGB(10, 25, 50),
				['Value Background'] = Color3.fromRGB(6, 16, 32),
				['Value Stroke'] = Color3.fromRGB(0, 150, 220),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(0, 70, 120),
					['Toggle Value'] = Color3.fromRGB(0, 150, 220),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(15, 35, 65),
					['Toggle Value'] = Color3.fromRGB(20, 55, 90),
				}
			},
			['Color Picker'] = {
				['Background'] = Color3.fromRGB(10, 25, 50),
				['Color Select'] = {
					['Background'] = Color3.fromRGB(6, 16, 32),
					['UIStroke'] = Color3.fromRGB(0, 150, 220),
				}
			}
		}
	},
	Neon = {
		['Shadow'] = Color3.fromRGB(5, 15, 5),
		['Background'] = Color3.fromRGB(8, 20, 8),
		['Page'] = Color3.fromRGB(6, 16, 6),
		['Main'] = Color3.fromRGB(0, 255, 100),
		['Text & Icon'] = Color3.fromRGB(200, 255, 215),
		['Function'] = {
			['Toggle'] = {
				['Background'] = Color3.fromRGB(10, 28, 12),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(0, 100, 40),
					['Toggle Value'] = Color3.fromRGB(0, 255, 100),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(15, 40, 18),
					['Toggle Value'] = Color3.fromRGB(20, 65, 30),
				}
			},
			['Label'] = { ['Background'] = Color3.fromRGB(10, 28, 12) },
			['Dropdown'] = {
				['Background'] = Color3.fromRGB(10, 28, 12),
				['Value Background'] = Color3.fromRGB(6, 16, 6),
				['Value Stroke'] = Color3.fromRGB(0, 255, 100),
				['Dropdown Select'] = {
					['Background'] = Color3.fromRGB(6, 16, 6),
					['Search'] = Color3.fromRGB(12, 32, 14),
					['Item Background'] = Color3.fromRGB(15, 42, 18),
				}
			},
			['Slider'] = {
				['Background'] = Color3.fromRGB(10, 28, 12),
				['Value Background'] = Color3.fromRGB(6, 16, 6),
				['Value Stroke'] = Color3.fromRGB(0, 255, 100),
				['Slider Bar'] = Color3.fromRGB(0, 100, 40),
				['Slider Bar Value'] = Color3.fromRGB(0, 255, 100),
				['Circle Value'] = Color3.fromRGB(200, 255, 215),
			},
			['Code'] = {
				['Background'] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 28, 12)), ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 28, 12))},
				['Background Code'] = Color3.fromRGB(15, 42, 18),
				['Background Code Value'] = Color3.fromRGB(10, 30, 12),
				['ScrollingFrame Code'] = Color3.fromRGB(0, 255, 100),
			},
			['Button'] = {
				['Background'] = Color3.fromRGB(10, 28, 12),
				['Click'] = Color3.fromRGB(200, 255, 215),
			},
			['Textbox'] = {
				['Background'] = Color3.fromRGB(10, 28, 12),
				['Value Background'] = Color3.fromRGB(6, 16, 6),
				['Value Stroke'] = Color3.fromRGB(0, 255, 100),
			},
			['Keybind'] = {
				['Background'] = Color3.fromRGB(10, 28, 12),
				['Value Background'] = Color3.fromRGB(6, 16, 6),
				['Value Stroke'] = Color3.fromRGB(0, 255, 100),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(0, 100, 40),
					['Toggle Value'] = Color3.fromRGB(0, 255, 100),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(15, 40, 18),
					['Toggle Value'] = Color3.fromRGB(20, 65, 30),
				}
			},
			['Color Picker'] = {
				['Background'] = Color3.fromRGB(10, 28, 12),
				['Color Select'] = {
					['Background'] = Color3.fromRGB(6, 16, 6),
					['UIStroke'] = Color3.fromRGB(0, 255, 100),
				}
			}
		}
	},
	Gold = {
		['Shadow'] = Color3.fromRGB(25, 18, 5),
		['Background'] = Color3.fromRGB(30, 22, 8),
		['Page'] = Color3.fromRGB(24, 17, 5),
		['Main'] = Color3.fromRGB(255, 185, 0),
		['Text & Icon'] = Color3.fromRGB(255, 240, 200),
		['Function'] = {
			['Toggle'] = {
				['Background'] = Color3.fromRGB(38, 27, 8),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(120, 80, 0),
					['Toggle Value'] = Color3.fromRGB(255, 185, 0),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(55, 38, 10),
					['Toggle Value'] = Color3.fromRGB(85, 60, 15),
				}
			},
			['Label'] = { ['Background'] = Color3.fromRGB(38, 27, 8) },
			['Dropdown'] = {
				['Background'] = Color3.fromRGB(38, 27, 8),
				['Value Background'] = Color3.fromRGB(24, 17, 5),
				['Value Stroke'] = Color3.fromRGB(255, 185, 0),
				['Dropdown Select'] = {
					['Background'] = Color3.fromRGB(24, 17, 5),
					['Search'] = Color3.fromRGB(42, 30, 10),
					['Item Background'] = Color3.fromRGB(52, 38, 12),
				}
			},
			['Slider'] = {
				['Background'] = Color3.fromRGB(38, 27, 8),
				['Value Background'] = Color3.fromRGB(24, 17, 5),
				['Value Stroke'] = Color3.fromRGB(255, 185, 0),
				['Slider Bar'] = Color3.fromRGB(120, 80, 0),
				['Slider Bar Value'] = Color3.fromRGB(255, 185, 0),
				['Circle Value'] = Color3.fromRGB(255, 240, 200),
			},
			['Code'] = {
				['Background'] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 27, 8)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 27, 8))},
				['Background Code'] = Color3.fromRGB(52, 38, 12),
				['Background Code Value'] = Color3.fromRGB(38, 28, 8),
				['ScrollingFrame Code'] = Color3.fromRGB(255, 185, 0),
			},
			['Button'] = {
				['Background'] = Color3.fromRGB(38, 27, 8),
				['Click'] = Color3.fromRGB(255, 240, 200),
			},
			['Textbox'] = {
				['Background'] = Color3.fromRGB(38, 27, 8),
				['Value Background'] = Color3.fromRGB(24, 17, 5),
				['Value Stroke'] = Color3.fromRGB(255, 185, 0),
			},
			['Keybind'] = {
				['Background'] = Color3.fromRGB(38, 27, 8),
				['Value Background'] = Color3.fromRGB(24, 17, 5),
				['Value Stroke'] = Color3.fromRGB(255, 185, 0),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(120, 80, 0),
					['Toggle Value'] = Color3.fromRGB(255, 185, 0),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(55, 38, 10),
					['Toggle Value'] = Color3.fromRGB(85, 60, 15),
				}
			},
			['Color Picker'] = {
				['Background'] = Color3.fromRGB(38, 27, 8),
				['Color Select'] = {
					['Background'] = Color3.fromRGB(24, 17, 5),
					['UIStroke'] = Color3.fromRGB(255, 185, 0),
				}
			}
		}
	},
	Amethyst = {
		['Shadow'] = Color3.fromRGB(8, 8, 8),
		['Background'] = Color3.fromRGB(15, 15, 15),
		['Page'] = Color3.fromRGB(22, 22, 22),
		['Main'] = Color3.fromRGB(255, 255, 255),
		['Text'] = Color3.fromRGB(255, 255, 255),
		['Icon'] = Color3.fromRGB(255, 255, 255),
		['Text & Icon'] = Color3.fromRGB(235, 235, 235),
		['Function'] = {
			['Toggle'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(255, 255, 255),
					['Toggle Value'] = Color3.fromRGB(20, 20, 20),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(35, 35, 35),
					['Toggle Value'] = Color3.fromRGB(60, 60, 60),
				}
			},
			['Label'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
			},
			['Dropdown'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Value Background'] = Color3.fromRGB(18, 18, 18),
				['Value Stroke'] = Color3.fromRGB(55, 55, 55),
				['Dropdown Select'] = {
					['Background'] = Color3.fromRGB(18, 18, 18),
					['Search'] = Color3.fromRGB(28, 28, 28),
					['Item Background'] = Color3.fromRGB(28, 28, 28),
				}
			},
			['Slider'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Value Background'] = Color3.fromRGB(18, 18, 18),
				['Value Stroke'] = Color3.fromRGB(55, 55, 55),
				['Slider Bar'] = Color3.fromRGB(45, 45, 45),
				['Slider Bar Value'] = Color3.fromRGB(255, 255, 255),
				['Circle Value'] = Color3.fromRGB(255, 255, 255)
			},
			['Code'] = {
				['Background'] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)), ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))},
				['Background Code'] = Color3.fromRGB(32, 32, 32),
				['Background Code Value'] = Color3.fromRGB(20, 20, 20),
				['ScrollingFrame Code'] = Color3.fromRGB(220, 220, 220)
			},
			['Button'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Click'] = Color3.fromRGB(255, 255, 255)
			},
			['Textbox'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Value Background'] = Color3.fromRGB(18, 18, 18),
				['Value Stroke'] = Color3.fromRGB(55, 55, 55),
			},
			['Keybind'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Value Background'] = Color3.fromRGB(18, 18, 18),
				['Value Stroke'] = Color3.fromRGB(55, 55, 55),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(65, 65, 65),
					['Toggle Value'] = Color3.fromRGB(255, 255, 255),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(35, 35, 35),
					['Toggle Value'] = Color3.fromRGB(55, 55, 55),
				}
			},
			['Color Picker'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Color Select'] = {
					['Background'] = Color3.fromRGB(18, 18, 18),
					['UIStroke'] = Color3.fromRGB(55, 55, 55),
				}
			}
		}
	},
	Dark = {
		['Shadow'] = Color3.fromRGB(8, 8, 8),
		['Background'] = Color3.fromRGB(15, 15, 15),
		['Page'] = Color3.fromRGB(22, 22, 22),
		['Main'] = Color3.fromRGB(255, 255, 255),
		['Text'] = Color3.fromRGB(255, 255, 255),
		['Icon'] = Color3.fromRGB(255, 255, 255),
		['Text & Icon'] = Color3.fromRGB(235, 235, 235),
		['Function'] = {
			['Toggle'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(255, 255, 255),
					['Toggle Value'] = Color3.fromRGB(20, 20, 20),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(35, 35, 35),
					['Toggle Value'] = Color3.fromRGB(60, 60, 60),
				}
			},
			['Label'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
			},
			['Dropdown'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Value Background'] = Color3.fromRGB(18, 18, 18),
				['Value Stroke'] = Color3.fromRGB(55, 55, 55),
				['Dropdown Select'] = {
					['Background'] = Color3.fromRGB(18, 18, 18),
					['Search'] = Color3.fromRGB(28, 28, 28),
					['Item Background'] = Color3.fromRGB(28, 28, 28),
				}
			},
			['Slider'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Value Background'] = Color3.fromRGB(18, 18, 18),
				['Value Stroke'] = Color3.fromRGB(55, 55, 55),
				['Slider Bar'] = Color3.fromRGB(45, 45, 45),
				['Slider Bar Value'] = Color3.fromRGB(255, 255, 255),
				['Circle Value'] = Color3.fromRGB(255, 255, 255)
			},
			['Code'] = {
				['Background'] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)), ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))},
				['Background Code'] = Color3.fromRGB(32, 32, 32),
				['Background Code Value'] = Color3.fromRGB(20, 20, 20),
				['ScrollingFrame Code'] = Color3.fromRGB(220, 220, 220)
			},
			['Button'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Click'] = Color3.fromRGB(255, 255, 255)
			},
			['Textbox'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Value Background'] = Color3.fromRGB(18, 18, 18),
				['Value Stroke'] = Color3.fromRGB(55, 55, 55),
				},
			['Keybind'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Value Background'] = Color3.fromRGB(18, 18, 18),
				['Value Stroke'] = Color3.fromRGB(55, 55, 55),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(65, 65, 65),
					['Toggle Value'] = Color3.fromRGB(255, 255, 255),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(35, 35, 35),
					['Toggle Value'] = Color3.fromRGB(55, 55, 55),
				}
			},
			['Color Picker'] = {
				['Background'] = Color3.fromRGB(25, 25, 25),
				['Color Select'] = {
					['Background'] = Color3.fromRGB(18, 18, 18),
					['UIStroke'] = Color3.fromRGB(55, 55, 55),
				}
			}
		}
	},
	Light = {
		['Shadow'] = Color3.fromRGB(180, 185, 195),
		['Background'] = Color3.fromRGB(242, 244, 248),
		['Page'] = Color3.fromRGB(255, 255, 255),
		['Main'] = Color3.fromRGB(0, 122, 255),
		['Text'] = Color3.fromRGB(28, 32, 42),
		['Icon'] = Color3.fromRGB(0, 122, 255),
		['Text & Icon'] = Color3.fromRGB(45, 52, 65),
		['Function'] = {
			['Toggle'] = {
				['Background'] = Color3.fromRGB(232, 235, 242),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(0, 122, 255),
					['Toggle Value'] = Color3.fromRGB(255, 255, 255),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(210, 215, 225),
					['Toggle Value'] = Color3.fromRGB(160, 168, 180),
				}
			},
			['Label'] = {
				['Background'] = Color3.fromRGB(232, 235, 242),
			},
			['Dropdown'] = {
				['Background'] = Color3.fromRGB(232, 235, 242),
				['Value Background'] = Color3.fromRGB(255, 255, 255),
				['Value Stroke'] = Color3.fromRGB(0, 122, 255),
				['Dropdown Select'] = {
					['Background'] = Color3.fromRGB(255, 255, 255),
					['Search'] = Color3.fromRGB(240, 242, 248),
					['Item Background'] = Color3.fromRGB(245, 247, 252),
				}
			},
			['Slider'] = {
				['Background'] = Color3.fromRGB(232, 235, 242),
				['Value Background'] = Color3.fromRGB(255, 255, 255),
				['Value Stroke'] = Color3.fromRGB(0, 122, 255),
				['Slider Bar'] = Color3.fromRGB(215, 222, 235),
				['Slider Bar Value'] = Color3.fromRGB(0, 122, 255),
				['Circle Value'] = Color3.fromRGB(255, 255, 255)
			},
			['Code'] = {
				['Background'] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 235, 242)), ColorSequenceKeypoint.new(1, Color3.fromRGB(232, 235, 242))},
				['Background Code'] = Color3.fromRGB(245, 247, 252),
				['Background Code Value'] = Color3.fromRGB(230, 235, 245),
				['ScrollingFrame Code'] = Color3.fromRGB(0, 122, 255)
			},
			['Button'] = {
				['Background'] = Color3.fromRGB(232, 235, 242),
				['Click'] = Color3.fromRGB(0, 122, 255)
			},
			['Textbox'] = {
				['Background'] = Color3.fromRGB(232, 235, 242),
				['Value Background'] = Color3.fromRGB(255, 255, 255),
				['Value Stroke'] = Color3.fromRGB(0, 122, 255),
			},
			['Keybind'] = {
				['Background'] = Color3.fromRGB(232, 235, 242),
				['Value Background'] = Color3.fromRGB(255, 255, 255),
				['Value Stroke'] = Color3.fromRGB(0, 122, 255),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(0, 122, 255),
					['Toggle Value'] = Color3.fromRGB(255, 255, 255),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(210, 215, 225),
					['Toggle Value'] = Color3.fromRGB(160, 168, 180),
				}
			},
			['Color Picker'] = {
				['Background'] = Color3.fromRGB(232, 235, 242),
				['Color Select'] = {
					['Background'] = Color3.fromRGB(255, 255, 255),
					['UIStroke'] = Color3.fromRGB(0, 122, 255),
				}
			}
		}
	},
	['Liquid Glass'] = {
		['Shadow'] = Color3.fromRGB(0, 25, 40),
		['Background'] = Color3.fromRGB(10, 22, 34),
		['Page'] = Color3.fromRGB(6, 16, 26),
		['Main'] = Color3.fromRGB(0, 225, 255),
		['Text'] = Color3.fromRGB(240, 252, 255),
		['Icon'] = Color3.fromRGB(0, 225, 255),
		['Text & Icon'] = Color3.fromRGB(200, 240, 255),
		['Function'] = {
			['Toggle'] = {
				['Background'] = Color3.fromRGB(14, 30, 46),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(0, 95, 130),
					['Toggle Value'] = Color3.fromRGB(0, 225, 255),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(18, 38, 56),
					['Toggle Value'] = Color3.fromRGB(30, 65, 90),
				}
			},
			['Label'] = {
				['Background'] = Color3.fromRGB(14, 30, 46),
			},
			['Dropdown'] = {
				['Background'] = Color3.fromRGB(14, 30, 46),
				['Value Background'] = Color3.fromRGB(8, 18, 30),
				['Value Stroke'] = Color3.fromRGB(0, 225, 255),
				['Dropdown Select'] = {
					['Background'] = Color3.fromRGB(8, 18, 30),
					['Search'] = Color3.fromRGB(15, 34, 52),
					['Item Background'] = Color3.fromRGB(20, 44, 66),
				}
			},
			['Slider'] = {
				['Background'] = Color3.fromRGB(14, 30, 46),
				['Value Background'] = Color3.fromRGB(8, 18, 30),
				['Value Stroke'] = Color3.fromRGB(0, 225, 255),
				['Slider Bar'] = Color3.fromRGB(0, 95, 130),
				['Slider Bar Value'] = Color3.fromRGB(0, 225, 255),
				['Circle Value'] = Color3.fromRGB(220, 250, 255)
			},
			['Code'] = {
				['Background'] = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(14, 30, 46)), ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 30, 46))},
				['Background Code'] = Color3.fromRGB(20, 44, 66),
				['Background Code Value'] = Color3.fromRGB(14, 32, 50),
				['ScrollingFrame Code'] = Color3.fromRGB(0, 225, 255)
			},
			['Button'] = {
				['Background'] = Color3.fromRGB(14, 30, 46),
				['Click'] = Color3.fromRGB(200, 245, 255)
			},
			['Textbox'] = {
				['Background'] = Color3.fromRGB(14, 30, 46),
				['Value Background'] = Color3.fromRGB(8, 18, 30),
				['Value Stroke'] = Color3.fromRGB(0, 225, 255),
			},
			['Keybind'] = {
				['Background'] = Color3.fromRGB(14, 30, 46),
				['Value Background'] = Color3.fromRGB(8, 18, 30),
				['Value Stroke'] = Color3.fromRGB(0, 225, 255),
				['True'] = {
					['Toggle Background'] = Color3.fromRGB(0, 95, 130),
					['Toggle Value'] = Color3.fromRGB(0, 225, 255),
				},
				['False'] = {
					['Toggle Background'] = Color3.fromRGB(18, 38, 56),
					['Toggle Value'] = Color3.fromRGB(30, 65, 90),
				}
			},
			['Color Picker'] = {
				['Background'] = Color3.fromRGB(14, 30, 46),
				['Color Select'] = {
					['Background'] = Color3.fromRGB(8, 18, 30),
					['UIStroke'] = Color3.fromRGB(0, 225, 255),
				}
			}
		}
	},
}

themes['White'] = themes['Light']
themes['LiquidGlass'] = themes['Liquid Glass']
themes['Glass'] = themes['Liquid Glass']


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = _randomGuiName

local runService = _Services.RunService
local isStudio = runService:IsStudio()

if not isStudio then
	if _gethui then
		ScreenGui.Parent = _gethui()
	elseif _protectgui then
		_protectgui(ScreenGui)
		local success, coreGui = pcall(function() return _Services.CoreGui end)
		if success and coreGui then
			ScreenGui.Parent = coreGui
		else
			ScreenGui.Parent = _Services.Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
		end
	else
		local success, coreGui = pcall(function() return _Services.CoreGui end)
		if success and coreGui then
			ScreenGui.Parent = coreGui
		else
			ScreenGui.Parent = _Services.Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
		end
	end
else
	ScreenGui.Parent = _Services.Players.LocalPlayer.PlayerGui
end

ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

local U, Tw = _Services.UserInputService, _Services.TweenService

do
	function addToTheme(name, obj)
		if not SaveTheme[name] then
			SaveTheme[name] = {}
		end
		table.insert(SaveTheme[name], obj)
	end
	function getColorFromPath(tbl, path)
		local result = tbl
		for _, part in ipairs(string.split(path, ".")) do
			result = result and result[part]
		end
		return result
	end
	function Library:setTheme(st)
		for name, objs in pairs(SaveTheme) do
			for _, obj in pairs(objs) do
				local overrideName = name
				if name == 'Text & Icon' then
					if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
						overrideName = 'Icon'
					elseif obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
						overrideName = 'Text'
					end
				end
				
				local color = getColorFromPath(st, overrideName) or getColorFromPath(st, name)
				if color then
					if obj:IsA("Frame") or obj:IsA("CanvasGroup") then
						obj.BackgroundColor3 = color
					elseif obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
						obj.TextColor3 = color
					elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
						obj.ImageColor3 = color
					elseif obj:IsA("ScrollingFrame") then
						obj.ScrollBarImageColor3 = color
					elseif obj:IsA("UIStroke") then
						obj.Color = color
					elseif obj:IsA("UIGradient") then
						obj.Color = color
					end
				end
			end
		end
	end

		-- High-Performance Lucide & FontAwesome Icon Engine (Compkiller 2.6 / Singularity)
	local IconEngine
	local env = (getgenv and getgenv()) or _G

	if env.HYPER_IconEngine and type(env.HYPER_IconEngine) == "table" and env.HYPER_IconEngine.GetIcon then
		IconEngine = env.HYPER_IconEngine
	else
		local okEngine, resEngine = pcall(function()
			-- 1. Try local files first (instant 0ms, offline support)
			if _isfile and _readfile then
				if _isfile("lucide.lua") then
					return loadstring(_readfile("lucide.lua"))()
				elseif _isfile("icon.lua") then
					return loadstring(_readfile("icon.lua"))()
				elseif _isfile("HYPER_Cache/icon.lua") then
					return loadstring(_readfile("HYPER_Cache/icon.lua"))()
				elseif _isfile("HYPER_Cache/lucide.lua") then
					return loadstring(_readfile("HYPER_Cache/lucide.lua"))()
				end
			end

			-- 2. Try loading directly from your GitHub repositories (with disk caching)
			local urls = {
				"https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-LOADER/refs/heads/main/UI.main/icon.lua",
				"https://raw.githubusercontent.com/projectsingularityv1-debug/HYPER-LOADER/refs/heads/main/UI.main/lucide.lua"
			}

			for _, url in ipairs(urls) do
				local okHttp, resHttp = pcall(function()
					if _request then
						local res = _request({Url = url, Method = "GET"})
						if res and res.StatusCode == 200 then return res.Body end
					end
					return game:HttpGet(url)
				end)

				if okHttp and resHttp and #resHttp > 0 then
					local fn = loadstring(resHttp)
					if fn then
						local mod = fn()
						if type(mod) == "table" and mod.GetIcon then
							-- in-memory only
							return mod
						end
					end
				end
			end

			return nil
		end)

		if okEngine and type(resEngine) == "table" and resEngine.GetIcon then
			IconEngine = resEngine
			env.HYPER_IconEngine = IconEngine
		else
			-- Embedded fallback icon resolver (100% resilient, never crashes)
			local FallbackIcons = {
				["mouse-pointer"] = "rbxassetid://10734898476",
				["star"] = "rbxassetid://10734966248",
				["award"] = "rbxassetid://10709769406",
				["home"] = "rbxassetid://10723407389",
				["settings"] = "rbxassetid://10734950309",
				["user"] = "rbxassetid://10747373176",
				["check"] = "rbxassetid://10709790644",
				["close"] = "rbxassetid://10747384394",
				["x"] = "rbxassetid://10747384394",
				["lock"] = "rbxassetid://10723434711",
				["unlock"] = "rbxassetid://10747366027",
				["sliders"] = "rbxassetid://10734963400",
				["bell"] = "rbxassetid://10709775704",
				["search"] = "rbxassetid://10734943674",
				["folder"] = "rbxassetid://10723387563",
				["file"] = "rbxassetid://10723374641",
				["code"] = "rbxassetid://10709810463",
				["terminal"] = "rbxassetid://10734982144",
				["download"] = "rbxassetid://10723344270",
				["upload"] = "rbxassetid://10747366434",
				["refresh-cw"] = "rbxassetid://10734933222",
				["eye"] = "rbxassetid://10723346959",
				["eye-off"] = "rbxassetid://10723346871",
				["trash"] = "rbxassetid://10747362393",
				["copy"] = "rbxassetid://10709812159",
				["shield"] = "rbxassetid://10734951847",
				["zap"] = "rbxassetid://89858717966393",
				["layers"] = "rbxassetid://10723424505",
				["layout"] = "rbxassetid://10723425376"
			}
			IconEngine = {
				GetIcon = function(self, name, font_aws)
					if not name or name == "" then return "" end
					local strName = tostring(name)
					if strName:find("^rbxassetid://") or strName:find("^rbxasset://") or strName:find("^rbxthumb://") or strName:find("^https?://") then
						return strName
					end
					if tonumber(strName) then
						return "rbxassetid://" .. strName
					end
					local lower = string.lower(strName):gsub("^lucide%-", "")
					return FallbackIcons[lower] or FallbackIcons[strName] or ("rbxassetid://" .. strName)
				end
			}
			env.HYPER_IconEngine = IconEngine
		end
	end

	function gl(i)
		if not i or i == "" then
			return {
				Image = "",
				ImageRectSize = Vector2.new(0, 0),
				ImageRectPosition = Vector2.new(0, 0),
			}
		end

		if type(i) == "table" and i.Image then
			return {
				Image = i.Image,
				ImageRectSize = i.ImageRectSize or Vector2.new(0, 0),
				ImageRectPosition = i.ImageRectPosition or i.ImageRectOffset or Vector2.new(0, 0),
			}
		end

		local resolved = (IconEngine and IconEngine.GetIcon and IconEngine:GetIcon(i)) or (IconEngine and IconEngine.Icons and IconEngine.Icons[i] and IconEngine.Icons[i].Image) or i
		if type(resolved) == "table" and resolved.Image then
			return {
				Image = resolved.Image,
				ImageRectSize = resolved.ImageRectSize or Vector2.new(0, 0),
				ImageRectPosition = resolved.ImageRectPosition or resolved.ImageRectOffset or Vector2.new(0, 0),
			}
		end

		local str = tostring(resolved or "")
		if str == "rbxassetid://136264753381080" or str == "136264753381080" or str == "rbxassetid://92567372646337" or str == "92567372646337" or str == "" or str == "HYPER" or str == "HYPER.png" then
			str = "https://img2.pic.in.th/HYPER.png"
		end
		if str:match("^https?://") or str:match("%.png$") or str:match("%.jpg$") or str:match("%.jpeg$") or str:find("^HYPER_Cache/") or str:find("HYPER") then
			str = CacheImage(str)
		elseif tonumber(str) then
			str = "rbxassetid://" .. str
		elseif str ~= "" and not str:find("^rbxassetid://") and not str:find("^rbxasset://") and not str:find("^rbxthumb://") and not str:find("^http") then
			str = "rbxassetid://" .. str
		end

		return {
			Image = str,
			ImageRectSize = Vector2.new(0, 0),
			ImageRectPosition = Vector2.new(0, 0),
		}
	end
	function tw(info)
		return Tw:Create(info.v,TweenInfo.new(info.t, info.s, Enum.EasingDirection[info.d]),info.g)
	end
	function changecanvas(ScrollingFrame, UIListLayout, Plus)
		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + Plus or 5)
		end)
	end
	function gs(side, pl, pr)
		if not side then
			return pl
		end

		local sideLower = string.lower(tostring(side))
		if sideLower == "r" or sideLower == "right" or side == 2 then
			return pr
		elseif sideLower == "l" or sideLower == "left" or side == 1 then
			return pl
		else
			return pl
		end
	end
	function jc(c, p)
		local Mouse = game.Players.LocalPlayer:GetMouse()

		local relativeX = Mouse.X - c.AbsolutePosition.X
		local relativeY = Mouse.Y - c.AbsolutePosition.Y

		if relativeX < 0 or relativeY < 0 or relativeX > c.AbsoluteSize.X or relativeY > c.AbsoluteSize.Y then
			return
		end

		local ClickButtonCircle = Instance.new("Frame")
		ClickButtonCircle.Parent = p
		ClickButtonCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ClickButtonCircle.BackgroundTransparency = 0.7
		ClickButtonCircle.BorderSizePixel = 0
		ClickButtonCircle.AnchorPoint = Vector2.new(0.5, 0.5)
		ClickButtonCircle.Position = UDim2.new(0, relativeX, 0, relativeY)
		ClickButtonCircle.Size = UDim2.new(0, 0, 0, 0)
		ClickButtonCircle.ZIndex = 10

		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = ClickButtonCircle

		local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local goal = {
			Size = UDim2.new(0, c.AbsoluteSize.X * 1.5, 0, c.AbsoluteSize.X * 1.5),
			BackgroundTransparency = 1
		}

		local expandTween = _Services.TweenService:Create(ClickButtonCircle, tweenInfo, goal)

		expandTween.Completed:Connect(function()
			ClickButtonCircle:Destroy()
		end)

		expandTween:Play()
	end
	function jcf(p, p2)
		local ClickButtonCircle = Instance.new("Frame")
		ClickButtonCircle.Parent = p
		ClickButtonCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ClickButtonCircle.BackgroundTransparency = 0.7
		ClickButtonCircle.BorderSizePixel = 0
		ClickButtonCircle.AnchorPoint = Vector2.new(0.5, 0.5)
		ClickButtonCircle.Position = UDim2.new(0, p2.AbsolutePosition.X - p.AbsolutePosition.X + p2.AbsoluteSize.X / 2, 
			0, p2.AbsolutePosition.Y - p.AbsolutePosition.Y + p2.AbsoluteSize.Y / 2)
		ClickButtonCircle.Size = UDim2.new(0, 0, 0, 0)
		ClickButtonCircle.ZIndex = 10

		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = ClickButtonCircle

		local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local goal = {
			Size = UDim2.new(0, p2.AbsoluteSize.X * 5, 0, p2.AbsoluteSize.X * 5),
			BackgroundTransparency = 1
		}

		local expandTween = _Services.TweenService:Create(ClickButtonCircle, tweenInfo, goal)

		expandTween.Completed:Connect(function()
			ClickButtonCircle:Destroy()
		end)

		expandTween:Play()
	end
	function lak(t, o)
		o = o or t
		if not t or not o then return end
		local a, b, c, d
		local function u(i)
			if Library.IsLocked or not a or not c or not d or not o then return end
			local dt = i.Position - c
			tw({v = o, t = 0.05, s = Enum.EasingStyle.Linear, d = "InOut", g = {Position = UDim2.new(d.X.Scale, d.X.Offset + dt.X, d.Y.Scale, d.Y.Offset + dt.Y)}}):Play()
		end
		t.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				a = true
				c = i.Position
				d = o.Position
				i.Changed:Connect(function()
					if i.UserInputState == Enum.UserInputState.End then
						a = false
					end
				end)
			end
		end)
		t.InputChanged:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
				b = i
			end
		end)
		U.InputChanged:Connect(function(i)
			if i == b and a and c and d and o then
				u(i)
			end
		end)
	end
	function make_resize(t, o)
		o = o or t
		if not t or not o then return end
		local a, b, c, d
		local function u(i)
			if not a or not c or not d or not o then return end
			local dt = i.Position - c
			local newX = math.max(450, d.X.Offset + dt.X)
			local newY = math.max(300, d.Y.Offset + dt.Y)
			tw({v = o, t = 0.05, s = Enum.EasingStyle.Linear, d = "InOut", g = {Size = UDim2.new(d.X.Scale, newX, d.Y.Scale, newY)}}):Play()
		end
		t.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				a = true
				c = i.Position
				d = o.Size
				i.Changed:Connect(function()
					if i.UserInputState == Enum.UserInputState.End then
						a = false
					end
				end)
			end
		end)
		t.InputChanged:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
				b = i
			end
		end)
		U.InputChanged:Connect(function(i)
			if i == b and a and c and d and o then
				u(i)
			end
		end)
	end
	function click(p)
		local Click = Instance.new("TextButton")

		Click.Name = "Click"
		Click.Parent = p
		Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Click.BackgroundTransparency = 1.000
		Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Click.BorderSizePixel = 0
		Click.Size = UDim2.new(1, 0, 1, 0)
		Click.Font = Enum.Font.SourceSans
		Click.Text = ""
		Click.TextColor3 = Color3.fromRGB(0, 0, 0)
		Click.TextSize = 14.000

		return Click
	end
	function background(pl, t, d, i, ty)
		local RealBackground = Instance.new("Frame")
		local Background = Instance.new("Frame")
		local UICorner_1 = Instance.new("UICorner")
		local T_1 = Instance.new("Frame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local UIPadding_3 = Instance.new("UIPadding")
		local TextLabel_1 = Instance.new("TextLabel")
		local TextLabel_2 = Instance.new("TextLabel")

		RealBackground.Name = "Real Background"
		RealBackground.Parent = pl
		RealBackground.BackgroundTransparency = 1
		RealBackground.BorderColor3 = Color3.fromRGB(0,0,0)
		RealBackground.BorderSizePixel = 0
		RealBackground.Size = UDim2.new(1, 0,0, 35)
		RealBackground.ClipsDescendants = true

		Background.Name = "Background"
		Background.Parent = RealBackground
		Background.BackgroundColor3 = Color3.fromRGB(25,25,25)
		Background.BorderColor3 = Color3.fromRGB(0,0,0)
		Background.BorderSizePixel = 0
		Background.Size = UDim2.new(1, 0,1, 0)
		Background.ClipsDescendants = true

		addToTheme('Function.'..ty..'.Background', Background)

		UICorner_1.Parent = Background

		T_1.Name = "T"
		T_1.Parent = Background
		T_1.AnchorPoint = Vector2.new(0, 0.5)
		T_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		T_1.BackgroundTransparency = 1
		T_1.BorderColor3 = Color3.fromRGB(0,0,0)
		T_1.BorderSizePixel = 0
		T_1.Position = UDim2.new(0, 0,0.5, 0)
		T_1.Size = UDim2.new(1, 0,1, 0)

		UIListLayout_2.Parent = T_1
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

		UIPadding_3.Parent = T_1
		UIPadding_3.PaddingLeft = UDim.new(0,13)
		UIPadding_3.PaddingRight = UDim.new(0,70)

		TextLabel_1.Parent = T_1
		TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		TextLabel_1.BackgroundTransparency = 1
		TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
		TextLabel_1.BorderSizePixel = 0
		TextLabel_1.LayoutOrder = 1
		TextLabel_1.Size = UDim2.new(1, 0,0, 14)
		TextLabel_1.Font = Enum.Font.GothamBold
		TextLabel_1.RichText = true
		TextLabel_1.Text = tostring(d)
		TextLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
		TextLabel_1.TextSize = 10
		TextLabel_1.TextTransparency = 0.699999988079071
		TextLabel_1.TextWrapped = true
		TextLabel_1.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel_1.Visible = false
		TextLabel_1.AutomaticSize = Enum.AutomaticSize.Y
		TextLabel_1.Name = 'Desc'

		addToTheme('Text & Icon', TextLabel_1)

		TextLabel_2.Parent = T_1
		TextLabel_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
		TextLabel_2.BackgroundTransparency = 1
		TextLabel_2.BorderColor3 = Color3.fromRGB(0,0,0)
		TextLabel_2.BorderSizePixel = 0
		TextLabel_2.Size = UDim2.new(1, 0,0, 14)
		TextLabel_2.Font = Enum.Font.GothamBold
		TextLabel_2.RichText = true
		TextLabel_2.Text = tostring(t)
		TextLabel_2.TextColor3 = Color3.fromRGB(255,255,255)
		TextLabel_2.TextSize = 12
		TextLabel_2.TextWrapped = true
		TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel_2.AutomaticSize = Enum.AutomaticSize.Y
		TextLabel_2.Name = 'Title'

		addToTheme('Text & Icon', TextLabel_2)

		if d and d ~= "" then
			TextLabel_1.Visible = true
		end

		if i and i ~= "" then
			UIPadding_3.PaddingLeft = UDim.new(0, 50)
			local Image = Instance.new("Frame")
			local Icon_1 = Instance.new("ImageLabel")
			local Frame_1 = Instance.new("Frame")

			Image.Name = "Image"
			Image.Parent = Background
			Image.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Image.BackgroundTransparency = 1
			Image.BorderColor3 = Color3.fromRGB(0,0,0)
			Image.BorderSizePixel = 0
			Image.Size = UDim2.new(0, 40,1, 0)

			Icon_1.Name = "Icon"
			Icon_1.Parent = Image
			Icon_1.AnchorPoint = Vector2.new(0.5, 0.5)
			Icon_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Icon_1.BackgroundTransparency = 1
			Icon_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Icon_1.BorderSizePixel = 0
			Icon_1.Position = UDim2.new(0.5, 0,0.5, 0)
			Icon_1.Size = UDim2.new(0, 20,0, 20)
			Icon_1.Image = gl(i).Image
			Icon_1.ImageRectSize = gl(i).ImageRectSize
			Icon_1.ImageRectOffset = gl(i).ImageRectPosition
			Icon_1.ImageTransparency = 0.7

			Frame_1.Parent = Image
			Frame_1.AnchorPoint = Vector2.new(1, 0.5)
			Frame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Frame_1.BackgroundTransparency = 0.8999999761581421
			Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_1.BorderSizePixel = 0
			Frame_1.Position = UDim2.new(1, 0,0.5, 0)
			Frame_1.Size = UDim2.new(0, 1,0.699999988, 0)

			addToTheme('Text & Icon', Icon_1)

			addToTheme('Text & Icon', Frame_1)
		end

		local function updateSize()
			task.defer(function()
				local newSize = UIListLayout_2.AbsoluteContentSize.Y + 21
				if RealBackground.Size.Y.Offset ~= newSize then
					RealBackground.Size = UDim2.new(1, 0, 0, newSize)
				end
			end)
		end

		delay(.1, updateSize)

		UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)

		local f = {}

		function f:SetTextTransparencyTitle(vs)
			tw({v = TextLabel_2, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {TextTransparency = vs}}):Play()
			if i and i ~= "" then
				local imgFrame = Background:FindFirstChild("Image")
				if imgFrame then
					local iconImg = imgFrame:FindFirstChild("Icon")
					if iconImg then
						tw({v = iconImg, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {ImageTransparency = vs}}):Play()
					end
				end
			end
		end

		function f:SetSizeT(vs)
			UIPadding_3.PaddingRight = UDim.new(0, vs)
		end

		function f:SetTitle(vs)
			TextLabel_2.Text = tostring(vs)
		end

		function f:SetDesc(vs)
			TextLabel_1.Text = tostring(vs)
			if vs and vs ~= "" then
				TextLabel_1.Visible = true
			else
				TextLabel_1.Visible = false
			end
		end

		function f:SetVisibleDesc(vs)
			TextLabel_2.Visible = vs
		end

		return Background, f
	end
	function addDropdownSelect(p, p2, Multi, Callback, Value, List)
		local F = Instance.new("Frame")
		local UIListLayout_1 = Instance.new("UIListLayout")
		local UIPadding_1 = Instance.new("UIPadding")
		local DropdownValue = Instance.new("Frame")
		local UICorner_1 = Instance.new("UICorner")
		local UIStroke_1 = Instance.new("UIStroke")
		local TextLabelValue_1 = Instance.new("TextLabel")
		local UIPadding_2 = Instance.new("UIPadding")
		local ImageLabel_1 = Instance.new("ImageLabel")

		F.Name = "F"
		F.Parent = p
		F.AnchorPoint = Vector2.new(1, 0.5)
		F.BackgroundColor3 = Color3.fromRGB(255,255,255)
		F.BackgroundTransparency = 1
		F.BorderColor3 = Color3.fromRGB(0,0,0)
		F.BorderSizePixel = 0
		F.Position = UDim2.new(1, 0,0.5, 0)
		F.Size = UDim2.new(0, 120,0.800000012, 0)

		UIListLayout_1.Parent = F
		UIListLayout_1.Padding = UDim.new(0,15)
		UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

		UIPadding_1.Parent = F
		UIPadding_1.PaddingRight = UDim.new(0,13)

		DropdownValue.Parent = F
		DropdownValue.BackgroundColor3 = Color3.fromRGB(18,18,18)
		DropdownValue.BorderColor3 = Color3.fromRGB(0,0,0)
		DropdownValue.BorderSizePixel = 0
		DropdownValue.Size = UDim2.new(0, 100,0, 20)

		addToTheme('Function.Dropdown.Value Background', DropdownValue)

		UICorner_1.Parent = DropdownValue
		UICorner_1.CornerRadius = UDim.new(0,4)

		UIStroke_1.Parent = DropdownValue
		UIStroke_1.Color = Color3.fromRGB(255,255,255)
		UIStroke_1.Thickness = 1
		UIStroke_1.Transparency = 0.95

		addToTheme('Function.Dropdown.Value Stroke', UIStroke_1)

		TextLabelValue_1.Parent = DropdownValue
		TextLabelValue_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		TextLabelValue_1.BackgroundTransparency = 1
		TextLabelValue_1.BorderColor3 = Color3.fromRGB(0,0,0)
		TextLabelValue_1.BorderSizePixel = 0
		TextLabelValue_1.Size = UDim2.new(0.8, 0,1, 0)
		TextLabelValue_1.Font = Enum.Font.GothamBold
		TextLabelValue_1.RichText = true
		TextLabelValue_1.Text = "--"
		TextLabelValue_1.TextColor3 = Color3.fromRGB(255,255,255)
		TextLabelValue_1.TextSize = 10
		TextLabelValue_1.TextTransparency = 0.3
		TextLabelValue_1.TextXAlignment = Enum.TextXAlignment.Left
		TextLabelValue_1.TextTruncate = Enum.TextTruncate.AtEnd

		addToTheme('Text & Icon', TextLabelValue_1)

		UIPadding_2.Parent = DropdownValue
		UIPadding_2.PaddingLeft = UDim.new(0,5)
		UIPadding_2.PaddingRight = UDim.new(0,5)

		ImageLabel_1.Parent = DropdownValue
		ImageLabel_1.AnchorPoint = Vector2.new(1, 0.5)
		ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		ImageLabel_1.BackgroundTransparency = 1
		ImageLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
		ImageLabel_1.BorderSizePixel = 0
		ImageLabel_1.Position = UDim2.new(1, 0,0.5, 0)
		ImageLabel_1.Size = UDim2.new(0, 20,0, 20)
		ImageLabel_1.Image = CacheImage("rbxassetid://14937709869")
		ImageLabel_1.ImageTransparency = 0.3

		addToTheme('Text & Icon', ImageLabel_1)

		local DropdownSelect = Instance.new("Frame")
		DropdownSelect.Name = "XinzDropdown"
		local UICorner_1 = Instance.new("UICorner")
		local UIStrokeDropdown_1 = Instance.new("UIStroke")
		local UIPadding_1 = Instance.new("UIPadding")
		local Search_1 = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local TextBox_1 = Instance.new("TextBox")
		local Frame_1 = Instance.new("Frame")
		local Frame_2 = Instance.new("Frame")
		local Frame_3 = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local ScrollingFrame_1 = Instance.new("ScrollingFrame")
		local UIListLayout_1 = Instance.new("UIListLayout")
		local UIPadding_2 = Instance.new("UIPadding")
		local UIPadding_3 = Instance.new("UIPadding")
		local UIPadding_4 = Instance.new("UIPadding")

		DropdownSelect.Parent = ScreenGui
		DropdownSelect.BackgroundColor3 = Color3.fromRGB(18,18,18)
		DropdownSelect.BorderColor3 = Color3.fromRGB(0,0,0)
		DropdownSelect.BorderSizePixel = 0
		DropdownSelect.Size = UDim2.new(0, 150,0, 0)
		DropdownSelect.ClipsDescendants = true

		addToTheme('Function.Dropdown.Dropdown Select.Background', DropdownSelect)

		DropdownSelect.Position = UDim2.new(0, DropdownValue.AbsolutePosition.X - DropdownSelect.Parent.AbsolutePosition.X + DropdownValue.Size.X.Offset - 119, 0, DropdownValue.AbsolutePosition.Y - DropdownSelect.Parent.AbsolutePosition.Y + DropdownValue.Size.Y.Offset - 25)

		UICorner_1.Parent = DropdownSelect
		UICorner_1.CornerRadius = UDim.new(0,4)

		UIStrokeDropdown_1.Parent = DropdownSelect
		UIStrokeDropdown_1.Color = Color3.fromRGB(255,255,255)
		UIStrokeDropdown_1.Thickness = 1
		UIStrokeDropdown_1.Transparency = 1

		UIPadding_1.Parent = DropdownSelect
		UIPadding_1.PaddingBottom = UDim.new(0,5)
		UIPadding_1.PaddingLeft = UDim.new(0,5)
		UIPadding_1.PaddingRight = UDim.new(0,5)
		UIPadding_1.PaddingTop = UDim.new(0,5)

		Search_1.Name = "Search"
		Search_1.Parent = DropdownSelect
		Search_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Search_1.BackgroundTransparency = 0.949999988079071
		Search_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Search_1.BorderSizePixel = 0
		Search_1.Size = UDim2.new(1, 0,0, 20)

		addToTheme('Function.Dropdown.Dropdown Select.Search', Search_1)

		UICorner_2.Parent = Search_1
		UICorner_2.CornerRadius = UDim.new(0,4)

		TextBox_1.Parent = Search_1
		TextBox_1.Active = true
		TextBox_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		TextBox_1.BackgroundTransparency = 1
		TextBox_1.BorderColor3 = Color3.fromRGB(0,0,0)
		TextBox_1.BorderSizePixel = 0
		TextBox_1.CursorPosition = -1
		TextBox_1.Size = UDim2.new(1, 0,1, 0)
		TextBox_1.Font = Enum.Font.Gotham
		TextBox_1.PlaceholderColor3 = Color3.fromRGB(178,178,178)
		TextBox_1.PlaceholderText = "Search . . ."
		TextBox_1.Text = ""
		TextBox_1.TextColor3 = Color3.fromRGB(255,255,255)
		TextBox_1.TextSize = 11

		addToTheme('Text & Icon', Search_1)

		addToTheme('Text & Icon', TextBox_1)

		Frame_1.Parent = Search_1
		Frame_1.AnchorPoint = Vector2.new(0, 1)
		Frame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Frame_1.BackgroundTransparency = 0.8999999761581421
		Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Frame_1.BorderSizePixel = 0
		Frame_1.Position = UDim2.new(0, 0,1, 0)
		Frame_1.Size = UDim2.new(1, 0,0, 2)

		Frame_2.Parent = DropdownSelect
		Frame_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Frame_2.BackgroundTransparency = 1
		Frame_2.BorderColor3 = Color3.fromRGB(0,0,0)
		Frame_2.BorderSizePixel = 0
		Frame_2.Size = UDim2.new(1, 0,1, 0)

		Frame_3.Parent = Frame_2
		Frame_3.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Frame_3.BackgroundTransparency = 0.949999988079071
		Frame_3.BorderColor3 = Color3.fromRGB(0,0,0)
		Frame_3.BorderSizePixel = 0
		Frame_3.Size = UDim2.new(1, 0,1, 0)

		UICorner_3.Parent = Frame_3
		UICorner_3.CornerRadius = UDim.new(0,4)

		ScrollingFrame_1.Name = "ScrollingFrame"
		ScrollingFrame_1.Parent = Frame_3
		ScrollingFrame_1.Active = true
		ScrollingFrame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		ScrollingFrame_1.BackgroundTransparency = 1
		ScrollingFrame_1.BorderColor3 = Color3.fromRGB(0,0,0)
		ScrollingFrame_1.BorderSizePixel = 0
		ScrollingFrame_1.Size = UDim2.new(1, 0,1, 0)
		ScrollingFrame_1.ClipsDescendants = true
		ScrollingFrame_1.AutomaticCanvasSize = Enum.AutomaticSize.None
		ScrollingFrame_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
		ScrollingFrame_1.CanvasPosition = Vector2.new(0, 0)
		ScrollingFrame_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
		ScrollingFrame_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
		ScrollingFrame_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		ScrollingFrame_1.ScrollBarImageColor3 = Color3.fromRGB(107,84,255)
		ScrollingFrame_1.ScrollBarImageTransparency = 0
		ScrollingFrame_1.ScrollBarThickness = 2
		ScrollingFrame_1.ScrollingDirection = Enum.ScrollingDirection.XY
		ScrollingFrame_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
		ScrollingFrame_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
		ScrollingFrame_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

		UIListLayout_1.Parent = ScrollingFrame_1
		UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_1.Padding = UDim.new(0, 3)

		UIPadding_2.Parent = ScrollingFrame_1
		UIPadding_2.PaddingRight = UDim.new(0,5)

		UIPadding_3.Parent = Frame_3
		UIPadding_3.PaddingBottom = UDim.new(0,5)
		UIPadding_3.PaddingLeft = UDim.new(0,5)
		UIPadding_3.PaddingRight = UDim.new(0,3)
		UIPadding_3.PaddingTop = UDim.new(0,5)

		UIPadding_4.Parent = Frame_2
		UIPadding_4.PaddingTop = UDim.new(0,25)

		local Click = click(p2)

		local isopen = false

		local function updateDropdownSize()
			if not isopen then return end

			local visibleCount = 0
			for i, v in pairs(ScrollingFrame_1:GetChildren()) do
				if v:IsA("Frame") and v.Visible then
					visibleCount = visibleCount + 1
				end
			end

			local contentHeight = (UIListLayout_1.AbsoluteContentSize.Y + 54)
			if contentHeight > 200 then
				contentHeight = 200
			end

			tw({v = DropdownSelect, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Size = UDim2.new(0, 150, 0, contentHeight)}}):Play()
		end

		TextBox_1.Changed:Connect(function()
			local SearchT = string.lower(TextBox_1.Text)
			for i, v in pairs(ScrollingFrame_1:GetChildren()) do
				if v:IsA("Frame") then
					if SearchT ~= "" and v:FindFirstChild("TextLabel") then
						if string.find(string.lower(v.TextLabel.Text), SearchT) then
							v.Visible = true
						else
							v.Visible = false
						end
					else
						v.Visible = true
					end
				end
			end
			updateDropdownSize()
		end)

		local function open()
			if isopen then
				return
			end
			DropdownSelect.Visible = true
			local targetX = DropdownValue.AbsolutePosition.X - DropdownSelect.Parent.AbsolutePosition.X + DropdownValue.Size.X.Offset - 119
			local targetY = DropdownValue.AbsolutePosition.Y - DropdownSelect.Parent.AbsolutePosition.Y + DropdownValue.Size.Y.Offset - 25
			local contentHeight = UIListLayout_1.AbsoluteContentSize.Y + 54
			if contentHeight <= 200 then
				tw({v = DropdownSelect, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {Size = UDim2.new(0, 150, 0, contentHeight), Position = UDim2.new(0, targetX, 0, targetY)}}):Play()
			else
				tw({v = DropdownSelect, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {Size = UDim2.new(0, 150, 0, 200), Position = UDim2.new(0, targetX, 0, targetY)}}):Play()
			end
			tw({v = UIStrokeDropdown_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {Transparency = 0.95}}):Play()
			isopen = true
		end

		local function close()
			if not isopen then
				return
			end
			tw({v = UIStrokeDropdown_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {Transparency = 1}}):Play()
			local gf = tw({v = DropdownSelect, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {Size = UDim2.new(0, 150,0, 0)}})
			gf:Play()
			gf.Completed:Connect(function()
				DropdownSelect.Visible = false
				isopen = false
			end)
		end

		U.InputBegan:Connect(function(A)
			if A.UserInputType == Enum.UserInputType.MouseButton1 or A.UserInputType == Enum.UserInputType.Touch then
				local B, C = DropdownSelect.AbsolutePosition, DropdownSelect.AbsoluteSize
				if _Services.Players.LocalPlayer:GetMouse().X < B.X or _Services.Players.LocalPlayer:GetMouse().X > B.X + C.X or _Services.Players.LocalPlayer:GetMouse().Y < (B.Y - 20 - 1) or _Services.Players.LocalPlayer:GetMouse().Y > B.Y + C.Y then
					close()
				end
			end
		end)

		Click.MouseButton1Click:Connect(function()
			if not isopen then
				open()
			else
				close()
			end
		end)

		local itemslist = {}
		local selectedValues = {}
		local selectedItem

		function itemslist:Clear(a)
			local function shouldClear(v)
				if a == nil then
					return true
				elseif type(a) == "string" then
					return v:FindFirstChild("TextLabel") and v.TextLabel.Text == a
				elseif type(a) == "table" then
					for _, name in ipairs(a) do
						if v:FindFirstChild("TextLabel") and v.TextLabel.Text == name then
							return true
						end
					end
				end
				return false
			end

			if Multi then
				selectedValues = {}
				TextLabelValue_1.Text = "--"
				pcall(Callback ,selectedValues)
			end

			for _, v in ipairs(ScrollingFrame_1:GetChildren()) do
				if v:IsA("Frame") and shouldClear(v) then
					if selectedItem and v:FindFirstChild("TextLabel") and v.TextLabel.Text == selectedItem then
						selectedItem = nil
						TextLabelValue_1.Text = "--"
						pcall(Callback, TextLabelValue_1.Text)
					end
					v:Destroy()
				end
			end

			if selectedItem == a or TextLabelValue_1.Text == a then
				selectedItem = nil
				TextLabelValue_1.Text = "--"
			end

			if a == nil then
				selectedItem = nil
				TextLabelValue_1.Text = "--"
			end

			Value = nil
		end

		function itemslist:Add(text)

			local Item_1 = Instance.new("Frame")
			local TextLabel_1 = Instance.new("TextLabel")

			Item_1.Name = "Item"
			Item_1.Parent = ScrollingFrame_1
			Item_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Item_1.BackgroundTransparency = 0.95
			Item_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Item_1.BorderSizePixel = 0
			Item_1.Size = UDim2.new(1, 0,0, 18)

			TextLabel_1.Parent = Item_1
			TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_1.BackgroundTransparency = 1
			TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_1.BorderSizePixel = 0
			TextLabel_1.Size = UDim2.new(1, 0,1, 0)
			TextLabel_1.Font = Enum.Font.GothamBold
			TextLabel_1.Text = text
			TextLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
			TextLabel_1.TextSize = 12
			TextLabel_1.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel_1.TextTransparency = 0.8

			addToTheme('Function.Dropdown.Dropdown Select.Item Background', Item_1)
			addToTheme('Text & Icon', TextLabel_1)

			Instance.new("UICorner", Item_1).CornerRadius = UDim.new(0, 4)
			Instance.new("UIPadding", Item_1).PaddingLeft = UDim.new(0, 5)

			local ClickItem = click(Item_1)
			local function unselect()
				tw({v = TextLabel_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {TextTransparency = 0.8}}):Play()
			end
			local function hasselect()
				tw({v = TextLabel_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {TextTransparency = 0}}):Play()
			end

			ClickItem.MouseButton1Click:Connect(function()
				if Multi then
					if selectedValues[text] then
						selectedValues[text] = nil
						unselect()
					else
						selectedValues[text] = true
						hasselect()
					end
					local selectedList = {}
					for i, v in pairs(selectedValues) do
						table.insert(selectedList, i)
					end
					if #selectedList > 0 then
						TextLabelValue_1.Text = table.concat(selectedList, ", ")
					else
						TextLabelValue_1.Text = "--"
					end
					pcall(Callback, selectedList)
				else
					for i,v in pairs(ScrollingFrame_1:GetChildren()) do
						if v:IsA("Frame") then
							tw({v = v.TextLabel, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {TextTransparency = 0.8}}):Play()
						end
					end
					hasselect()
					Value = text
					TextLabelValue_1.Text = text
					pcall(Callback, TextLabelValue_1.Text)
				end
			end)

			local function isValueInTable(val, tbl)
				if type(tbl) ~= "table" then
					return false
				end

				for _, v in pairs(tbl) do
					if v == val then
						return true
					end
				end
				return false
			end

			delay(0,function()
				if Multi then
					if isValueInTable(text, Value) then
						hasselect()
						selectedValues[text] = true
						local selectedList = {}
						for i, v in pairs(selectedValues) do
							table.insert(selectedList, i)
						end
						if #selectedList > 0 then
							TextLabelValue_1.Text = table.concat(selectedList, ", ")
						else
							TextLabelValue_1.Text = "--"
						end
						pcall(Callback,selectedList)
					end
				else
					if text == Value then
						hasselect()
						Value = text
						TextLabelValue_1.Text = text
						pcall(Callback,TextLabelValue_1.Text)
					end
				end
			end)
		end

		function itemslist:SetValue(value)
			if Multi then
				selectedValues = {}
				selectedValues[value] = true
				TextLabelValue_1.Text = value
				for _, v in ipairs(ScrollingFrame_1:GetChildren()) do
					if v:IsA("Frame") and v:FindFirstChild("TextLabel") then
						if v.TextLabel.Text == value then
							tw({v = v.TextLabel, t = 0.05, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = 0}}):Play()
						else
							tw({v = v.TextLabel, t = 0.05, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = 0.8}}):Play()
						end
					end
				end
				pcall(Callback, selectedValues)
			else
				Value = value
				TextLabelValue_1.Text = value
				for _, v in ipairs(ScrollingFrame_1:GetChildren()) do
					if v:IsA("Frame") and v:FindFirstChild("TextLabel") then
						if v.TextLabel.Text == value then
							tw({v = v.TextLabel, t = 0.05, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = 0}}):Play()
						else
							tw({v = v.TextLabel, t = 0.05, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = 0.8}}):Play()
						end
					end
				end
				pcall(Callback, value)
			end
		end

		for i, v in ipairs(List) do
			itemslist:Add(v, i)
		end

		changecanvas(ScrollingFrame_1, UIListLayout_1, 5)

		function itemslist:Edit(newdata, newdefault)
			itemslist:Clear()
			if type(newdata) == "table" then
				for _, v in pairs(newdata) do
					itemslist:Add(v)
				end
			end
			if newdefault ~= nil then
				itemslist:SetValue(newdefault)
			end
		end

		return itemslist
	end
end

function Library:Window(p)

	local Title = p.Title or 'HYPER HUB'
	local Desc = p.Desc or ''
	local Version = p.Version or '1.0'
	local Icon = p.Icon or "https://img2.pic.in.th/HYPER.png"
	if Icon == "rbxassetid://136264753381080" or Icon == "rbxassetid://92567372646337" or Icon == "136264753381080" or Icon == "92567372646337" or Icon == "" then
		Icon = "https://img2.pic.in.th/HYPER.png"
	end
	local Theme = (p.Theme == 'Amethyst' or not p.Theme or p.Theme == '') and 'Dark' or p.Theme
	local Keybind = p.Config.Keybind or Enum.KeyCode.LeftControl
	local Size = p.Config.Size or UDim2.new(0, 530,0, 400)
	local TabWidth = p.TabWidth or 150
	local ProfileData = p.Profile
	local lp = _Services.Players.LocalPlayer
	if not ProfileData then
		if lp then
			ProfileData = {
				Username = lp.Name == "monota1412" and "[Dev] " .. lp.Name or lp.Name,
				Email = "UID: " .. tostring(lp.UserId),
				AvatarUrl = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(lp.UserId) .. "&w=150&h=150"
			}
		end
	elseif ProfileData and (not ProfileData.AvatarUrl or ProfileData.AvatarUrl == "") then
		if lp and lp.UserId then
			ProfileData.AvatarUrl = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(lp.UserId) .. "&w=150&h=150"
		end
	end

	local R, HAA = false, false
	local CrumbOrientation = "Bottom"
	local HasChangeTheme = Theme
	local IsTheme = Theme

	local Shadow_1 = Instance.new("ImageLabel")
	local UIPadding_1 = Instance.new("UIPadding")
	local Background_1 = Instance.new("CanvasGroup")
	local UICorner_1 = Instance.new("UICorner")
	local Page_1 = Instance.new("Frame")
	local UIPadding_2 = Instance.new("UIPadding")
	
	local TooltipFrame = Instance.new("Frame")
	local TooltipLabel = Instance.new("TextLabel")
	local TooltipCorner = Instance.new("UICorner")
	local TooltipPadding = Instance.new("UIPadding")

	TooltipFrame.Name = "DockTooltip"
	TooltipFrame.Parent = ScreenGui
	TooltipFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
	TooltipFrame.Size = UDim2.new(0, 0, 0, 24)
	TooltipFrame.AnchorPoint = Vector2.new(0.5, 1)
	TooltipFrame.Visible = false
	TooltipFrame.ZIndex = 100
	TooltipFrame.BackgroundTransparency = 1

	TooltipCorner.CornerRadius = UDim.new(0, 4)
	TooltipCorner.Parent = TooltipFrame

	TooltipPadding.PaddingLeft = UDim.new(0, 8)
	TooltipPadding.PaddingRight = UDim.new(0, 8)
	TooltipPadding.Parent = TooltipFrame

	TooltipLabel.Parent = TooltipFrame
	TooltipLabel.BackgroundTransparency = 1
	TooltipLabel.Size = UDim2.new(1, 0, 1, 0)
	TooltipLabel.Font = Enum.Font.GothamMedium
	TooltipLabel.TextSize = 12
	TooltipLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	TooltipLabel.TextTransparency = 1
	TooltipLabel.Text = ""

	Shadow_1.Name = "Shadow"
	Shadow_1.Parent = ScreenGui
	Shadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
	Shadow_1.BackgroundTransparency = 1
	Shadow_1.Position = UDim2.new(0.5, 0,0.5, 0)
	Shadow_1.Size = Size
	Shadow_1.Image = CacheImage("rbxassetid://1316045217")
	Shadow_1.ImageColor3 = Color3.fromRGB(8, 8, 8)
	Shadow_1.ImageTransparency = 0.8
	Shadow_1.ScaleType = Enum.ScaleType.Slice
	Shadow_1.SliceCenter = Rect.new(10, 10, 118, 118)
	Shadow_1.Visible = false

	addToTheme('Shadow', Shadow_1)

	UIPadding_1.Parent = Shadow_1
	UIPadding_1.PaddingBottom = UDim.new(0,8)
	UIPadding_1.PaddingLeft = UDim.new(0,8)
	UIPadding_1.PaddingRight = UDim.new(0,8)
	UIPadding_1.PaddingTop = UDim.new(0,8)

	Background_1.Name = "Background"
	Background_1.Parent = Shadow_1
	Background_1.AnchorPoint = Vector2.new(0.5, 0.5)
	Background_1.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Background_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Background_1.BorderSizePixel = 0
	Background_1.Position = UDim2.new(0.5, 0,0.5, 0)
	Background_1.Size = UDim2.new(1, 0,1, 0)
	Background_1.ClipsDescendants = true
	Background_1.GroupTransparency = 1

	Shadow_1.Visible = true  
	local org = Background_1.Size
	Background_1.Size = org - UDim2.fromOffset(5, 5)
	tw({
		v = Background_1,
		t = 0.15,
		s = Enum.EasingStyle.Linear,
		d = "InOut",
		g = {
			GroupTransparency = 0,
			Size = org
		}
	}):Play()

	addToTheme('Background', Background_1)
	
	local VersionLbl = Instance.new("TextLabel")
	VersionLbl.Name = "VersionLbl"
	VersionLbl.Parent = ScreenGui
	VersionLbl.BackgroundTransparency = 1
	VersionLbl.AnchorPoint = Vector2.new(1, 1)
	VersionLbl.Position = UDim2.new(1, -5, 1, -5)
	VersionLbl.Size = UDim2.new(0, 100, 0, 15)
	VersionLbl.Font = Enum.Font.Gotham
	VersionLbl.Text = Title .. " v" .. Version
	VersionLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	VersionLbl.TextSize = 12
	VersionLbl.TextXAlignment = Enum.TextXAlignment.Right
	VersionLbl.TextTransparency = 0.6
	VersionLbl.ZIndex = 10
	addToTheme('Text & Icon', VersionLbl)

	UICorner_1.Parent = Background_1
	UICorner_1.CornerRadius = UDim.new(0,17)

	Page_1.Name = "Page"
	Page_1.Parent = Background_1
	Page_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Page_1.BackgroundTransparency = 1
	Page_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Page_1.BorderSizePixel = 0
	Page_1.Size = UDim2.new(1, 0,1, 0)

	UIPadding_2.Parent = Page_1
	UIPadding_2.PaddingBottom = UDim.new(0,5)
	UIPadding_2.PaddingLeft = UDim.new(0, TabWidth + 10)
	UIPadding_2.PaddingRight = UDim.new(0,5)
	UIPadding_2.PaddingTop = UDim.new(0,50)

	local Topbar_1 = Instance.new("Frame")
	local Frame_5 = Instance.new("Frame")
	local Ct_1 = Instance.new("Frame")
	local LockUI_1 = Instance.new("ImageButton")
	local UIPadding_11 = Instance.new("UIPadding")
	local Minisize_1 = Instance.new("ImageButton")
	local UIListLayout_6 = Instance.new("UIListLayout")
	local Close_1 = Instance.new("ImageButton")
	local DropdownValue_1 = Instance.new("Frame")
	local Td_1 = Instance.new("Frame")
	local UIPadding_13 = Instance.new("UIPadding")
	local UIListLayout_7 = Instance.new("UIListLayout")
	local Icon_1 = Instance.new("ImageLabel")
	local Title_1 = Instance.new("Frame")
	local Desc_1 = Instance.new("TextLabel")
	local UIListLayout_8 = Instance.new("UIListLayout")
	local Title_2 = Instance.new("TextLabel")
	local ChSize_1 = Instance.new("ImageButton")

	Topbar_1.Name = "Topbar"
	Topbar_1.Parent = Background_1
	Topbar_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Topbar_1.BackgroundTransparency = 1
	Topbar_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Topbar_1.BorderSizePixel = 0
	Topbar_1.Size = UDim2.new(1, 0,0, 45)

	Frame_5.Parent = Topbar_1
	Frame_5.AnchorPoint = Vector2.new(0, 1)
	Frame_5.BackgroundColor3 = Color3.fromRGB(20,20,20)
	Frame_5.BackgroundTransparency = 1
	Frame_5.BorderColor3 = Color3.fromRGB(0,0,0)
	Frame_5.BorderSizePixel = 0
	Frame_5.Position = UDim2.new(0, 0,1, 0)
	Frame_5.Size = UDim2.new(1, 0,0, 2)

	addToTheme('Page', Frame_5)

	Ct_1.Name = "Ct"
	Ct_1.Parent = Topbar_1
	Ct_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Ct_1.BackgroundTransparency = 1
	Ct_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Ct_1.BorderSizePixel = 0
	Ct_1.Size = UDim2.new(1, 0,1, 0)

	UIPadding_11.Parent = Ct_1
	UIPadding_11.PaddingBottom = UDim.new(0,5)
	UIPadding_11.PaddingLeft = UDim.new(0,5)
	UIPadding_11.PaddingRight = UDim.new(0,5)
	UIPadding_11.PaddingTop = UDim.new(0,5)

	LockUI_1.Name = "LockUI"
	LockUI_1.Parent = Ct_1
	LockUI_1.Active = true
	LockUI_1.BackgroundTransparency = 1
	LockUI_1.LayoutOrder = 0
	LockUI_1.Size = UDim2.new(0, 16, 0, 16)
	LockUI_1.Image = CacheImage("rbxassetid://10709791475")
	LockUI_1.ImageColor3 = Color3.fromRGB(150, 150, 150)
	
	LockUI_1.MouseButton1Click:Connect(function()
		Library.IsLocked = not Library.IsLocked
		LockUI_1.Image = Library.IsLocked and CacheImage("rbxassetid://10709791437") or CacheImage("rbxassetid://10709791475")
		if Tabs.BreadcrumbLock then
			Tabs.BreadcrumbLock.Image = Library.IsLocked and CacheImage("rbxassetid://10709791437") or CacheImage("rbxassetid://10709791475")
		end
	end)

	Minisize_1.Name = "Minisize"
	Minisize_1.Parent = Ct_1
	Minisize_1.Active = true
	Minisize_1.BackgroundColor3 = Color3.fromRGB(255, 189, 46)
	Minisize_1.BackgroundTransparency = 0
	Minisize_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Minisize_1.BorderSizePixel = 0
	Minisize_1.LayoutOrder = 2
	Minisize_1.Size = UDim2.new(0, 12,0, 12)
	Minisize_1.Image = ""
	Minisize_1.ImageTransparency = 1
	local UICorner_Minisize = Instance.new("UICorner", Minisize_1)
	UICorner_Minisize.CornerRadius = UDim.new(1, 0)

	addToTheme('Text & Icon', Minisize_1)

	UIListLayout_6.Parent = Ct_1
	UIListLayout_6.Padding = UDim.new(0,6)
	UIListLayout_6.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_6.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_6.VerticalAlignment = Enum.VerticalAlignment.Center

	Close_1.Name = "Close"
	Close_1.Parent = Ct_1
	Close_1.Active = true
	Close_1.BackgroundColor3 = Color3.fromRGB(255, 95, 86)
	Close_1.BackgroundTransparency = 0
	Close_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Close_1.BorderSizePixel = 0
	Close_1.LayoutOrder = 1
	Close_1.Size = UDim2.new(0, 12,0, 12)
	Close_1.Image = ""
	local UICorner_Close = Instance.new("UICorner", Close_1)
	UICorner_Close.CornerRadius = UDim.new(1, 0)

	ChSize_1.Name = "Size"
	ChSize_1.Parent = Ct_1
	ChSize_1.Active = true
	ChSize_1.BackgroundColor3 = Color3.fromRGB(39, 201, 63)
	ChSize_1.BackgroundTransparency = 0
	ChSize_1.BorderColor3 = Color3.fromRGB(0,0,0)
	ChSize_1.BorderSizePixel = 0
	ChSize_1.LayoutOrder = 3
	ChSize_1.Size = UDim2.new(0, 12,0, 12)
	ChSize_1.Image = ""
	ChSize_1.ImageTransparency = 1
	local UICorner_ChSize = Instance.new("UICorner", ChSize_1)
	UICorner_ChSize.CornerRadius = UDim.new(1, 0)

	DropdownValue_1.Name = "DropdownValue"
	DropdownValue_1.Parent = Ct_1
	DropdownValue_1.AnchorPoint = Vector2.new(1, 0.5)
	DropdownValue_1.BackgroundColor3 = Color3.fromRGB(20,20,20)
	DropdownValue_1.BorderColor3 = Color3.fromRGB(0,0,0)
	DropdownValue_1.BorderSizePixel = 0
	DropdownValue_1.Position = UDim2.new(1, 0,0.5, 0)
	DropdownValue_1.Size = UDim2.new(0, 120,0, 20)
	DropdownValue_1.Transparency = 1

	Td_1.Name = "Td"
	Td_1.Parent = Topbar_1
	Td_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Td_1.BackgroundTransparency = 1
	Td_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Td_1.BorderSizePixel = 0
	Td_1.Size = UDim2.new(1, 0,1, 0)

	UIPadding_13.Parent = Td_1
	UIPadding_13.PaddingBottom = UDim.new(0,5)
	UIPadding_13.PaddingLeft = UDim.new(0,10)
	UIPadding_13.PaddingRight = UDim.new(0,10)
	UIPadding_13.PaddingTop = UDim.new(0,5)

	UIListLayout_7.Parent = Td_1
	UIListLayout_7.Padding = UDim.new(0,8)
	UIListLayout_7.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_7.HorizontalAlignment = Enum.HorizontalAlignment.Left
	UIListLayout_7.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_7.VerticalAlignment = Enum.VerticalAlignment.Center

	Icon_1.Name = "Icon"
	Icon_1.Parent = Td_1
	Icon_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Icon_1.BackgroundTransparency = 1
	Icon_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Icon_1.BorderSizePixel = 0
	Icon_1.Size = UDim2.new(0, 45,0, 45)
	local resolvedIcon = gl(Icon)
	Icon_1.Image = resolvedIcon.Image
	Icon_1.ImageRectSize = resolvedIcon.ImageRectSize
	Icon_1.ImageRectOffset = resolvedIcon.ImageRectPosition
	Icon_1.ImageColor3 = Color3.fromRGB(255, 255, 255)

	if resolvedIcon.ImageRectSize and resolvedIcon.ImageRectSize ~= Vector2.new(0, 0) then
		addToTheme('Text', Icon_1)
	end

	Title_1.Name = "Title"
	Title_1.Parent = Td_1
	Title_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Title_1.BackgroundTransparency = 4
	Title_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Title_1.BorderSizePixel = 0
	Title_1.LayoutOrder = 1
	Title_1.Size = UDim2.new(0, 180,1, 0)

	Desc_1.Name = "Desc"
	Desc_1.Parent = Title_1
	Desc_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Desc_1.BackgroundTransparency = 1
	Desc_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Desc_1.BorderSizePixel = 0
	Desc_1.LayoutOrder = 1
	Desc_1.Size = UDim2.new(1, 0,0, 16)
	Desc_1.Font = Enum.Font.GothamBold
	Desc_1.Text = Desc
	Desc_1.TextColor3 = Color3.fromRGB(255,255,255)
	Desc_1.TextSize = 12
	Desc_1.TextTransparency = 0.5
	Desc_1.TextXAlignment = Enum.TextXAlignment.Left
	Desc_1.Visible = false

	addToTheme('Text & Icon', Desc_1)

	if Desc and Desc ~= '' then
		Desc_1.Visible = true
	end

	UIListLayout_8.Parent = Title_1
	UIListLayout_8.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_8.VerticalAlignment = Enum.VerticalAlignment.Center

	Title_2.Name = "Title"
	Title_2.Parent = Title_1
	Title_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Title_2.BackgroundTransparency = 1
	Title_2.BorderColor3 = Color3.fromRGB(0,0,0)
	Title_2.BorderSizePixel = 0
	Title_2.Size = UDim2.new(1, 0,0, 18)
	Title_2.Font = Enum.Font.GothamBold
	Title_2.Text = Title
	Title_2.TextColor3 = Color3.fromRGB(255,255,255)
	Title_2.TextSize = 18
	Title_2.TextXAlignment = Enum.TextXAlignment.Left

	addToTheme('Text & Icon', Title_2)

	local TabP_1 = Instance.new("Frame")
	local Frame_6 = Instance.new("Frame")
	local ScrollingFrame_2 = Instance.new("ScrollingFrame")
	local TabList_1 = Instance.new("Frame")
	local Select_1 = Instance.new("Frame")
	local UICorner_10 = Instance.new("UICorner")
	local UIStroke_3 = Instance.new("UIStroke")
	local UIPadding_16 = Instance.new("UIPadding")
	local UIPadding_17 = Instance.new("UIPadding")
	local UIListLayout_10 = Instance.new("UIListLayout")

	TabP_1.Name = "TabP"
	TabP_1.Parent = Background_1
	TabP_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TabP_1.BackgroundTransparency = 1
	TabP_1.BorderColor3 = Color3.fromRGB(0,0,0)
	TabP_1.BorderSizePixel = 0
	TabP_1.Size = UDim2.new(1, 0,1, 0)

	Frame_6.Parent = TabP_1
	Frame_6.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Frame_6.BackgroundTransparency = 1
	Frame_6.BorderColor3 = Color3.fromRGB(0,0,0)
	Frame_6.BorderSizePixel = 0
	Frame_6.Size = UDim2.new(0, TabWidth, 1, 0)

	ScrollingFrame_2.Name = "ScrollingFrame"
	ScrollingFrame_2.Parent = Frame_6
	ScrollingFrame_2.Active = true
	ScrollingFrame_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
	ScrollingFrame_2.BackgroundTransparency = 1
	ScrollingFrame_2.BorderColor3 = Color3.fromRGB(0,0,0)
	ScrollingFrame_2.BorderSizePixel = 0
	ScrollingFrame_2.Size = UDim2.new(1, 0,1, 0)
	ScrollingFrame_2.ClipsDescendants = true
	ScrollingFrame_2.AutomaticCanvasSize = Enum.AutomaticSize.None
	ScrollingFrame_2.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
	ScrollingFrame_2.CanvasPosition = Vector2.new(0, 0)
	ScrollingFrame_2.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	ScrollingFrame_2.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	ScrollingFrame_2.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ScrollingFrame_2.ScrollBarImageColor3 = Color3.fromRGB(255,255,255)
	ScrollingFrame_2.ScrollBarImageTransparency = 0
	ScrollingFrame_2.ScrollBarThickness = 2
	ScrollingFrame_2.ScrollingDirection = Enum.ScrollingDirection.XY
	ScrollingFrame_2.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
	ScrollingFrame_2.VerticalScrollBarInset = Enum.ScrollBarInset.None
	ScrollingFrame_2.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

	addToTheme('Main', ScrollingFrame_2)

	TabList_1.Name = "TabList"
	TabList_1.Parent = ScrollingFrame_2
	TabList_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	TabList_1.BackgroundTransparency = 1
	TabList_1.BorderColor3 = Color3.fromRGB(0,0,0)
	TabList_1.BorderSizePixel = 0
	TabList_1.Size = UDim2.new(1, 0,1, 0)

	UIListLayout_10.Parent = TabList_1
	UIListLayout_10.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_10.HorizontalAlignment = Enum.HorizontalAlignment.Center

	Select_1.Name = "Select"
	Select_1.Parent = ScrollingFrame_2
	Select_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Select_1.BorderColor3 = Color3.fromRGB(0,0,0)
	Select_1.BorderSizePixel = 0
	Select_1.Position = UDim2.new(0, 0,0, 5)
	Select_1.Size = UDim2.new(0, 3,0, 18)

	addToTheme('Main', Select_1)

	UICorner_10.Parent = Select_1
	UICorner_10.CornerRadius = UDim.new(1,0)

	UIStroke_3.Parent = Select_1
	UIStroke_3.Color = Color3.fromRGB(45,45,45)
	UIStroke_3.Thickness = 1
	UIStroke_3.Transparency = 0.9

	UIPadding_16.Parent = ScrollingFrame_2
	UIPadding_16.PaddingBottom = UDim.new(0,1)
	UIPadding_16.PaddingLeft = UDim.new(0,1)
	UIPadding_16.PaddingRight = UDim.new(0,1)
	UIPadding_16.PaddingTop = UDim.new(0,1)

	UIPadding_17.Parent = TabP_1
	UIPadding_17.PaddingBottom = UDim.new(0,5)
	UIPadding_17.PaddingLeft = UDim.new(0,3)
	UIPadding_17.PaddingTop = UDim.new(0,55)

	changecanvas(ScrollingFrame_2, UIListLayout_10, 5)

	if ProfileData and type(ProfileData) == "table" then
		ScrollingFrame_2.Size = UDim2.new(1, 0, 1, -55)
		
		local Profile_Container = Instance.new("Frame")
		Profile_Container.Name = "Profile_Container"
		Profile_Container.Parent = Frame_6
		Profile_Container.AnchorPoint = Vector2.new(0, 1)
		Profile_Container.Position = UDim2.new(0, 5, 1, -5)
		Profile_Container.Size = UDim2.new(1, -10, 0, 45)
		Profile_Container.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		Profile_Container.BackgroundTransparency = 0
		
		local Profile_Corner = Instance.new("UICorner", Profile_Container)
		Profile_Corner.CornerRadius = UDim.new(0, 100)
		
		local Profile_Avatar = Instance.new("ImageLabel")
		Profile_Avatar.Name = "Avatar"
		Profile_Avatar.Parent = Profile_Container
		Profile_Avatar.AnchorPoint = Vector2.new(0, 0.5)
		Profile_Avatar.Position = UDim2.new(0, 5, 0.5, 0)
		Profile_Avatar.Size = UDim2.new(0, 35, 0, 35)
		Profile_Avatar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
		Profile_Avatar.BackgroundTransparency = 1
		Profile_Avatar.ScaleType = Enum.ScaleType.Crop
		Profile_Avatar.BorderSizePixel = 0
		
		-- Universal High-Reliability Avatar Engine
		local function applyAvatar(src)
			if not src or src == "" then return end
			local str = tostring(src)

			-- 1. rbxthumb format (Roblox Native Headshot)
			if str:match("^rbxthumb://") then
				Profile_Avatar.Image = str
				return
			end

			-- 2. rbxassetid / rbxasset
			if str:match("^rbxassetid://") or str:match("^rbxasset://") then
				Profile_Avatar.Image = str
				return
			end

			-- 3. Pure number (User ID or Asset ID)
			local num = tonumber(str)
			if num then
				Profile_Avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(num) .. "&w=150&h=150"
				return
			end

			-- 4. Contains userIds= or id= (Roblox API parameter format)
			local uid = str:match("userIds=(%d+)") or str:match("[?&]id=(%d+)") or str:match("users/(%d+)")
			if uid then
				Profile_Avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(uid) .. "&w=150&h=150"
				task.spawn(function()
					local s, imgUrl = pcall(function()
						return _Services.Players:GetUserThumbnailAsync(
							tonumber(uid),
							Enum.ThumbnailType.HeadShot,
							Enum.ThumbnailSize.Size150x150
						)
					end)
					if s and imgUrl and imgUrl ~= "" then
						Profile_Avatar.Image = imgUrl
					end
				end)
				return
			end

			-- 5. External Web URL (http/https Discord/Imgur/CDN)
			if str:match("^https?://") then
				Profile_Avatar.Image = CacheImage(str)
				return
			end

			Profile_Avatar.Image = str
		end

		local avatarTarget = (ProfileData and ProfileData.AvatarUrl)
		if not avatarTarget or avatarTarget == "" then
			avatarTarget = (getgenv and (getgenv().KeyAvatarAsset or getgenv().KeyAvatar))
		end
		if not avatarTarget or avatarTarget == "" then
			local lp = _Services.Players.LocalPlayer
			if lp and lp.UserId then
				avatarTarget = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(lp.UserId) .. "&w=150&h=150"
			end
		end

		applyAvatar(avatarTarget)
		
		local Avatar_Corner = Instance.new("UICorner", Profile_Avatar)
		Avatar_Corner.CornerRadius = UDim.new(1, 0)
		
		local Profile_Name = Instance.new("TextLabel")
		Profile_Name.Name = "Username"
		Profile_Name.Parent = Profile_Container
		Profile_Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Profile_Name.BackgroundTransparency = 1
		Profile_Name.Position = UDim2.new(0, 48, 0, 8)
		Profile_Name.Size = UDim2.new(1, -50, 0, 16)
		Profile_Name.Font = Enum.Font.GothamBold
		Profile_Name.Text = ProfileData.Username or "User"
		Profile_Name.TextColor3 = Color3.fromRGB(255, 255, 255)
		Profile_Name.TextSize = 11
		Profile_Name.TextXAlignment = Enum.TextXAlignment.Left
		
		local Profile_Email = Instance.new("TextLabel")
		Profile_Email.Name = "Email"
		Profile_Email.Parent = Profile_Container
		Profile_Email.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Profile_Email.BackgroundTransparency = 1
		Profile_Email.Position = UDim2.new(0, 48, 0, 24)
		Profile_Email.Size = UDim2.new(1, -50, 0, 12)
		Profile_Email.Font = Enum.Font.Gotham
		Profile_Email.Text = ProfileData.Email or "unknown@email.com"
		Profile_Email.TextColor3 = Color3.fromRGB(200, 200, 200)
		Profile_Email.TextSize = 9
		Profile_Email.TextXAlignment = Enum.TextXAlignment.Left
		
		addToTheme('Text & Icon', Profile_Name)
		addToTheme('Page', Profile_Container)
		
		-- Override container color to look nicer for profile
		Profile_Container.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
		Profile_Container.BackgroundTransparency = 0.5
	end

	local Tabs = {
		Value = false,
		List = {},
		DefaultIndex = 1,
		IsCollapsed = false,
		TabTitles = {}
	}
	
	local CollapseBtn = Instance.new("TextButton")
	CollapseBtn.Name = "CollapseBtn"
	CollapseBtn.Parent = Icon_1
	CollapseBtn.Size = UDim2.new(1, 0, 1, 0)
	CollapseBtn.BackgroundTransparency = 1
	CollapseBtn.Text = ""
	
	local function ToggleSidebar()
		Tabs.IsCollapsed = not Tabs.IsCollapsed
		local targetWidth = Tabs.IsCollapsed and 50 or TabWidth
		local targetPadding = Tabs.IsCollapsed and 60 or (TabWidth + 10)
		
		tw({v = Frame_6, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {Size = UDim2.new(0, targetWidth, 1, 0)}}):Play()
		tw({v = UIPadding_2, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {PaddingLeft = UDim.new(0, targetPadding)}}):Play()
		
		tw({v = Title_2, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = Tabs.IsCollapsed and 1 or 0}}):Play()
		tw({v = Desc_1, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = Tabs.IsCollapsed and 1 or 0.5}}):Play()
		
		for _, lbl in ipairs(Tabs.TabTitles) do
			tw({v = lbl, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = Tabs.IsCollapsed and 1 or 0.7}}):Play()
			local funcFrame = lbl.Parent
			if funcFrame then
				local padding = funcFrame:FindFirstChildOfClass("UIPadding")
				if padding then
					tw({v = padding, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {PaddingLeft = UDim.new(0, Tabs.IsCollapsed and 16 or 8)}}):Play()
				end
			end
		end
		
		if ProfileData and type(ProfileData) == "table" then
			local Profile_Container = Frame_6:FindFirstChild("Profile_Container")
			if Profile_Container then
				local NameLbl = Profile_Container:FindFirstChild("Username")
				local RoleLbl = Profile_Container:FindFirstChild("Email")
				local Avatar = Profile_Container:FindFirstChild("Avatar")
				
				if NameLbl then
					tw({v = NameLbl, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = Tabs.IsCollapsed and 1 or 0}}):Play()
				end
				if RoleLbl then
					tw({v = RoleLbl, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = Tabs.IsCollapsed and 1 or 0.5}}):Play()
				end
				if Avatar then
					local targetSize = Tabs.IsCollapsed and UDim2.new(0, 30, 0, 30) or UDim2.new(0, 35, 0, 35)
					local targetPos = Tabs.IsCollapsed and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0, 5, 0.5, 0)
					local targetAnchor = Tabs.IsCollapsed and Vector2.new(0.5, 0.5) or Vector2.new(0, 0.5)
					tw({v = Avatar, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {Size = targetSize, Position = targetPos, AnchorPoint = targetAnchor}}):Play()
				end
				tw({v = Profile_Container, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {BackgroundTransparency = Tabs.IsCollapsed and 1 or 0.5}}):Play()
			end
		end
	end
	
	CollapseBtn.MouseButton1Click:Connect(ToggleSidebar)

	function Tabs:SelectTab(p)
		Tabs.DefaultIndex = p or 1
	end

	function Tabs:Line()
		local Frame = Instance.new("Frame")
		local Line = Instance.new("Frame")

		Frame.Parent = TabList_1
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BackgroundTransparency = 1.000
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Size = UDim2.new(1, 0, 0, 5)
		Frame.Name = 'Line'

		Line.Name = "Line"
		Line.Parent = Frame
		Line.AnchorPoint = Vector2.new(0.5, 0.5)
		Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Line.BackgroundTransparency = 0.900
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0.5, 0, 0.5, 0)
		Line.Size = UDim2.new(0.85, 0, 0, 1)
	end

	function Tabs:Tab(p)
		local Title = p.Title or 'null'
		local Icon = p.Icon or "file"
		local Tab_1 = Instance.new("Frame")
		local Title_3 = Instance.new("TextLabel")
		local UIListLayout_9 = Instance.new("UIListLayout")
		local ImageLabel_2 = Instance.new("ImageLabel")
		local UIPadding_14 = Instance.new("UIPadding")
		local UIStroke_2 = Instance.new("UIStroke")
		local Func = Instance.new("Frame")

		Tab_1.Name = "Tab"
		Tab_1.Parent = TabList_1
		Tab_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Tab_1.BackgroundTransparency = 1
		Tab_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Tab_1.BorderSizePixel = 0
		Tab_1.Size = UDim2.new(1, 0,0, 30)
		Tab_1.LayoutOrder = p.LayoutOrder or 0

		Func.Name = "Func"
		Func.Parent = Tab_1
		Func.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Func.BackgroundTransparency = 1.000
		Func.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Func.BorderSizePixel = 0
		Func.Size = UDim2.new(1, 0, 1, 0)

		Title_3.Name = "Title"
		Title_3.Parent = Func
		Title_3.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Title_3.BackgroundTransparency = 1
		Title_3.BorderColor3 = Color3.fromRGB(0,0,0)
		Title_3.BorderSizePixel = 0
		Title_3.LayoutOrder = 1
		Title_3.Size = UDim2.new(1, 0,1, 0)
		Title_3.Font = Enum.Font.GothamBold
		Title_3.Text = tostring(Title)
		Title_3.TextColor3 = Color3.fromRGB(255,255,255)
		Title_3.TextSize = 11
		Title_3.TextTransparency = Tabs.IsCollapsed and 1 or 0.7
		Title_3.TextWrapped = true
		Title_3.TextXAlignment = Enum.TextXAlignment.Left
		table.insert(Tabs.TabTitles, Title_3)

		addToTheme('Text & Icon', Title_3)

		UIListLayout_9.Parent = Func
		UIListLayout_9.Padding = UDim.new(0,8)
		UIListLayout_9.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_9.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_9.VerticalAlignment = Enum.VerticalAlignment.Center

		ImageLabel_2.Parent = Func
		ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
		ImageLabel_2.BackgroundTransparency = 1
		ImageLabel_2.BorderColor3 = Color3.fromRGB(0,0,0)
		ImageLabel_2.BorderSizePixel = 0
		ImageLabel_2.Size = UDim2.new(0, 18,0, 18)
		ImageLabel_2.Image = gl(Icon).Image
		ImageLabel_2.ImageTransparency = 0.7
		ImageLabel_2.ImageRectSize = gl(Icon).ImageRectSize
		ImageLabel_2.ImageRectOffset = gl(Icon).ImageRectPosition

		addToTheme('Text & Icon', ImageLabel_2)

		UIPadding_14.Parent = Func
		UIPadding_14.PaddingLeft = UDim.new(0, Tabs.IsCollapsed and 16 or 8)

		UIStroke_2.Parent = Title_3
		UIStroke_2.Color = Color3.fromRGB(45,45,45)
		UIStroke_2.Thickness = 1
		UIStroke_2.Transparency = 0.95

		local InPage_1 = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local ScrollingFrame_1 = Instance.new("ScrollingFrame")
		local UIListLayout_1 = Instance.new("UIListLayout")
		local UIPadding_10 = Instance.new("UIPadding")

		InPage_1.Name = "InPage"
		InPage_1.Parent = Page_1
		InPage_1.AnchorPoint = Vector2.new(0.5 ,0.5)
		InPage_1.BackgroundColor3 = Color3.fromRGB(22,22,22)
		InPage_1.BorderColor3 = Color3.fromRGB(0,0,0)
		InPage_1.BorderSizePixel = 0
		InPage_1.Size = UDim2.new(1, 0,1, 0)
		InPage_1.Position = UDim2.new(0.5, 0, 0.5, 0)
		InPage_1.Visible = false

		addToTheme('Page', InPage_1)

		UICorner_2.Parent = InPage_1
		UICorner_2.CornerRadius = UDim.new(0,17)

		ScrollingFrame_1.Name = "ScrollingFrame"
		ScrollingFrame_1.Parent = InPage_1
		ScrollingFrame_1.Active = true
		ScrollingFrame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		ScrollingFrame_1.BackgroundTransparency = 1
		ScrollingFrame_1.BorderColor3 = Color3.fromRGB(0,0,0)
		ScrollingFrame_1.BorderSizePixel = 0
		ScrollingFrame_1.Size = UDim2.new(1, 0,1, 0)
		ScrollingFrame_1.ClipsDescendants = true
		ScrollingFrame_1.AutomaticCanvasSize = Enum.AutomaticSize.None
		ScrollingFrame_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
		ScrollingFrame_1.CanvasPosition = Vector2.new(0, 0)
		ScrollingFrame_1.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
		ScrollingFrame_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
		ScrollingFrame_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		ScrollingFrame_1.ScrollBarImageTransparency = 0
		ScrollingFrame_1.ScrollBarThickness = 0
		ScrollingFrame_1.ScrollingDirection = Enum.ScrollingDirection.XY
		ScrollingFrame_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
		ScrollingFrame_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
		ScrollingFrame_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

		UIListLayout_1.Parent = ScrollingFrame_1
		UIListLayout_1.Padding = UDim.new(0,5)
		UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

		UIPadding_10.Parent = InPage_1
		UIPadding_10.PaddingBottom = UDim.new(0,10)
		UIPadding_10.PaddingLeft = UDim.new(0,10)
		UIPadding_10.PaddingRight = UDim.new(0,10)
		UIPadding_10.PaddingTop = UDim.new(0,10)

		local Click = click(Tab_1)

		local DockBtn = nil
		if Tabs.ReopenBreadcrumb then
			local Crumb = Tabs.ReopenBreadcrumb:FindFirstChild("BackgroundCloseUI")
			if Crumb then Crumb = Crumb:FindFirstChild("Crumb") end
			if Crumb then
				DockBtn = Instance.new("ImageButton")
				DockBtn.Name = "DockBtn_" .. Title
				DockBtn.Parent = Crumb
				DockBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DockBtn.BackgroundTransparency = 1
				DockBtn.Size = UDim2.new(0, 24, 0, 24)
				DockBtn.LayoutOrder = p.LayoutOrder or (10 + #self.List)
				DockBtn.Image = ImageLabel_2.Image
				DockBtn.ImageRectSize = ImageLabel_2.ImageRectSize
				DockBtn.ImageRectOffset = ImageLabel_2.ImageRectOffset
				DockBtn.ImageColor3 = themes[IsTheme]['Text & Icon']
				DockBtn.ZIndex = 50
				addToTheme('Text & Icon', DockBtn)
				
				DockBtn.MouseEnter:Connect(function()
					TooltipLabel.Text = Title
					local ts = _Services.TextService
					local textBounds = ts:GetTextSize(Title, 12, Enum.Font.GothamMedium, Vector2.new(1000, 24))
					TooltipFrame.Size = UDim2.new(0, textBounds.X + 16, 0, 24)
					
					local absPos = DockBtn.AbsolutePosition
					local absSize = DockBtn.AbsoluteSize
					if CrumbOrientation == "Bottom" then
						TooltipFrame.Position = UDim2.new(0, absPos.X + absSize.X/2, 0, absPos.Y - 5)
						TooltipFrame.AnchorPoint = Vector2.new(0.5, 1)
					elseif CrumbOrientation == "Top" then
						TooltipFrame.Position = UDim2.new(0, absPos.X + absSize.X/2, 0, absPos.Y + absSize.Y + 5)
						TooltipFrame.AnchorPoint = Vector2.new(0.5, 0)
					elseif CrumbOrientation == "Left" then
						TooltipFrame.Position = UDim2.new(0, absPos.X + absSize.X + 5, 0, absPos.Y + absSize.Y/2)
						TooltipFrame.AnchorPoint = Vector2.new(0, 0.5)
					elseif CrumbOrientation == "Right" then
						TooltipFrame.Position = UDim2.new(0, absPos.X - 5, 0, absPos.Y + absSize.Y/2)
						TooltipFrame.AnchorPoint = Vector2.new(1, 0.5)
					end
					
					TooltipFrame.Visible = true
					tw({v = TooltipFrame, t = 0.2, s = Enum.EasingStyle.Exponential, d = "Out", g = {BackgroundTransparency = 0}}):Play()
					tw({v = TooltipLabel, t = 0.2, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = 0}}):Play()
				end)
				
				DockBtn.MouseLeave:Connect(function()
					tw({v = TooltipFrame, t = 0.2, s = Enum.EasingStyle.Exponential, d = "Out", g = {BackgroundTransparency = 1}}):Play()
					tw({v = TooltipLabel, t = 0.2, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = 1}}):Play()
				end)
			end
		end

		table.insert(self.List, {
			Page = InPage_1,
			Button = Tab_1,
			DockBtn = DockBtn
		})
		local MyIndex = #self.List

		local function twSelect()
			local scrollingFrame = Select_1.Parent
			local tabScrollingFrame = Tab_1.Parent

			local tabCenterY = Tab_1.AbsolutePosition.Y + (Tab_1.AbsoluteSize.Y / 2)
			local selectOffset = Select_1.AbsoluteSize.Y / 2
			local relativeY = tabCenterY - tabScrollingFrame.AbsolutePosition.Y
			local offset = scrollingFrame.AbsolutePosition.Y - Select_1.Parent.AbsolutePosition.Y

			local targetY = relativeY + offset - selectOffset

			local pos = UDim2.new(0, Select_1.Position.X.Offset, 0, targetY)

			tw({
				v = Select_1,
				t = 0.5,
				s = Enum.EasingStyle.Exponential,
				d = "Out",
				g = {
					Position = pos
				}
			}):Play()
		end

		local function chg()
			for i, v in pairs(self.List) do
				v.Page.Visible = false
				for i, v in pairs(ScrollingFrame_1:GetChildren()) do
					if v:IsA('Frame') and v:FindFirstChild('Background') then
						v.Background.Position = UDim2.new(0, 0, 0,0)
						v.Background.AnchorPoint = Vector2.new(1 ,0)
					end
				end
				task.spawn(function()
					for i, v in next, ScrollingFrame_1:GetChildren() do
						if v:IsA('Frame') and v:FindFirstChild('Background') then
							tw({
								v = v.Background,
								t = 0.3,
								s = Enum.EasingStyle.Exponential,
								d = "InOut",
								g = {AnchorPoint = Vector2.new(0 ,0)}
							}):Play()
							task.wait(.05)
						end
					end
				end)
				InPage_1.Visible = true
			end
			for i, v in pairs(TabList_1:GetChildren()) do
				if v:IsA('Frame') and v.Name ~= 'Line' then
					tw({
						v = v.Func.Title,
						t = 0.15,
						s = Enum.EasingStyle.Linear,
						d = "InOut",
						g = {TextTransparency = Tabs.IsCollapsed and 1 or 0.7, TextColor3 = themes[IsTheme]['Text & Icon']}
					}):Play()
					tw({
						v = v.Func.ImageLabel,
						t = 0.15,
						s = Enum.EasingStyle.Linear,
						d = "InOut",
						g = {ImageTransparency = 0.7, ImageColor3 = themes[IsTheme]['Text & Icon']}
					}):Play()
				end
			end
			for i, v in pairs(self.List) do
				if v.DockBtn then
					tw({
						v = v.DockBtn,
						t = 0.15,
						s = Enum.EasingStyle.Linear,
						d = "InOut",
						g = {ImageTransparency = 0.7, ImageColor3 = themes[IsTheme]['Text & Icon']}
					}):Play()
				end
			end
			Tabs.ActiveTabTitle = Title_3
			Tabs.ActiveTabIcon = ImageLabel_2
			Tabs.ActiveDockBtn = DockBtn
			tw({
				v = Title_3,
				t = 0.15,
				s = Enum.EasingStyle.Linear,
				d = "InOut",
				g = {TextTransparency = Tabs.IsCollapsed and 1 or 0, TextColor3 = Color3.fromRGB(255, 255, 255)}
			}):Play()
			tw({
				v = ImageLabel_2,
				t = 0.15,
				s = Enum.EasingStyle.Linear,
				d = "InOut",
				g = {ImageTransparency = 0, ImageColor3 = themes[IsTheme].Main}
			}):Play()
			if DockBtn then
				tw({
					v = DockBtn,
					t = 0.15,
					s = Enum.EasingStyle.Linear,
					d = "InOut",
					g = {ImageTransparency = 0, ImageColor3 = themes[IsTheme].Main}
				}):Play()
			end
			Page_1.Visible = true
			twSelect()
		end

		Click.MouseButton1Click:Connect(chg)

		if DockBtn then
			DockBtn.MouseButton1Down:Connect(function()
				-- Flash red to confirm click registered
				local prevColor = DockBtn.ImageColor3
				DockBtn.ImageColor3 = Color3.fromRGB(255, 0, 0)
				delay(0.2, function()
					DockBtn.ImageColor3 = prevColor
				end)

				task.spawn(function()
					if Tabs.closeui then pcall(Tabs.closeui) end
					pcall(chg)
				end)
			end)
		end
		changecanvas(ScrollingFrame_1, UIListLayout_1, 5)

		delay(.1, function()
			if not self.Value then
				local total = #self.List
				local index = self.DefaultIndex

				if type(index) ~= "number" or index < 1 or index > total then
					index = 1
				end

				if MyIndex == index then
					chg()
					self.Value = true
				end
			end
		end)

		local Func = {}

		function Func:Section(p)
			local Title = p.Title or 'null'
			local RealBackground = Instance.new("Frame")
			local Section = Instance.new("Frame")
			local Section_1 = Instance.new("TextLabel")
			local UIPadding_1 = Instance.new("UIPadding")

			RealBackground.Name = "Real Background"
			RealBackground.Parent = ScrollingFrame_1
			RealBackground.BackgroundTransparency = 1
			RealBackground.BorderColor3 = Color3.fromRGB(0,0,0)
			RealBackground.BorderSizePixel = 0
			RealBackground.Size = UDim2.new(1, 0,0, 20)
			RealBackground.ClipsDescendants = true

			Section.Name = "Background"
			Section.Parent = RealBackground
			Section.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Section.BackgroundTransparency = 1
			Section.BorderColor3 = Color3.fromRGB(0,0,0)
			Section.BorderSizePixel = 0
			Section.Size = UDim2.new(1, 0,0, 20)

			Section_1.Name = "Section"
			Section_1.Parent = Section
			Section_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Section_1.BackgroundTransparency = 1
			Section_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Section_1.BorderSizePixel = 0
			Section_1.Size = UDim2.new(1, 0,0, 20)
			Section_1.Font = Enum.Font.GothamBold
			Section_1.Text = Title
			Section_1.TextColor3 = Color3.fromRGB(255,255,255)
			Section_1.TextSize = 12
			Section_1.TextXAlignment = Enum.TextXAlignment.Left

			addToTheme('Text & Icon', Section_1)

			UIPadding_1.Parent = Section
			UIPadding_1.PaddingLeft = UDim.new(0,5)
			UIPadding_1.PaddingRight = UDim.new(0,5)

			local New = {}

			function New:SetTitle(t)
				Section_1.Text = t
			end

			return New
		end

		function Func:Toggle(p)
			local Value = p.Value or false
			local Image = p.Image or ''
			local Callback = p.Callback or function() end
			local Title = p.Title or 'null'
			local Desc = p.Desc or ''

			local Toggle, Config = background(ScrollingFrame_1, Title, Desc, Image, 'Toggle')

			local F_1 = Instance.new("Frame")
			local UIListLayout_1 = Instance.new("UIListLayout")
			local UIPadding_1 = Instance.new("UIPadding")
			local Frame_1 = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local Frame_2 = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local UIPadding_2 = Instance.new("UIPadding")

			F_1.Name = "F"
			F_1.Parent = Toggle
			F_1.AnchorPoint = Vector2.new(1, 0.5)
			F_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			F_1.BackgroundTransparency = 1
			F_1.BorderColor3 = Color3.fromRGB(0,0,0)
			F_1.BorderSizePixel = 0
			F_1.Position = UDim2.new(1, 0,0.5, 0)
			F_1.Size = UDim2.new(0, 100,0.800000012, 0)

			UIListLayout_1.Parent = F_1
			UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Right
			UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

			UIPadding_1.Parent = F_1
			UIPadding_1.PaddingRight = UDim.new(0,13)

			Frame_1.Parent = F_1
			Frame_1.BackgroundColor3 = Color3.fromRGB(36, 35, 48)
			Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_1.BorderSizePixel = 0
			Frame_1.Size = UDim2.new(0, 34,0, 17)

			UICorner_2.Parent = Frame_1
			UICorner_2.CornerRadius = UDim.new(1,0)

			Frame_2.Parent = Frame_1
			Frame_2.AnchorPoint = Vector2.new(0, 0.5)
			Frame_2.BackgroundColor3 = Color3.fromRGB(44, 42, 62)
			Frame_2.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_2.BorderSizePixel = 0
			Frame_2.Position = UDim2.new(0, 0,0.5, 0)
			Frame_2.Size = UDim2.new(0, 13,0, 13)

			if Value then
				Frame_1.BackgroundColor3 = themes[IsTheme].Function.Toggle.True['Toggle Background']
				Frame_2.BackgroundColor3 = themes[IsTheme].Function.Toggle.True['Toggle Value']
			else
				Frame_1.BackgroundColor3 = themes[IsTheme].Function.Toggle.False['Toggle Background']
				Frame_2.BackgroundColor3 = themes[IsTheme].Function.Toggle.False['Toggle Value']
			end

			UICorner_3.Parent = Frame_2
			UICorner_3.CornerRadius = UDim.new(1,0)

			UIPadding_2.Parent = Frame_1
			UIPadding_2.PaddingLeft = UDim.new(0,2)
			UIPadding_2.PaddingRight = UDim.new(0,2)

			local Click = click(Toggle)

			Value = not Value

			local function change()
				Value = not Value
				if Value then
					Config:SetTextTransparencyTitle(0)
					tw({v = Frame_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {BackgroundColor3 = themes[IsTheme].Function.Toggle.True['Toggle Background']}}):Play()
					tw({v = Frame_2, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out",
						g = {
							BackgroundColor3 = themes[IsTheme].Function.Toggle.True['Toggle Value'],
							AnchorPoint = Vector2.new(1, 0.5),
							Position = UDim2.new(1, 0,0.5, 0)
						}}):Play()
				else
					Config:SetTextTransparencyTitle(0.7)
					tw({v = Frame_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {BackgroundColor3 = themes[IsTheme].Function.Toggle.False['Toggle Background']}}):Play()
					tw({v = Frame_2, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out",
						g = {
							BackgroundColor3 = themes[IsTheme].Function.Toggle.False['Toggle Value'],
							AnchorPoint = Vector2.new(0, 0.5),
							Position = UDim2.new(0, 0,0.5, 0)
						}}):Play()
				end
				pcall(Callback, Value)
			end

			Toggle:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
				if Value then
					Frame_1.BackgroundColor3 = themes[IsTheme].Function.Toggle.True['Toggle Background']
					Frame_2.BackgroundColor3 = themes[IsTheme].Function.Toggle.True['Toggle Value']
				else
					Frame_1.BackgroundColor3 = themes[IsTheme].Function.Toggle.False['Toggle Background']
					Frame_2.BackgroundColor3 = themes[IsTheme].Function.Toggle.False['Toggle Value']
				end
			end)

			Click.MouseButton1Click:Connect(change)

			delay(0.1, change)

			local New = {}

			function New:SetTitle(t)
				Config:SetTitle(t)
			end

			function New:SetDesc(t)
				Config:SetDesc(t)
			end

			function New:SetVisible(t)
				Toggle.Visible = t
			end

			function New:SetValue(t)
				Value = not t
				change()
			end

			return New
		end

		function Func:Label(p)
			local Title = p.Title or 'null'
			local Desc = p.Desc or ''
			local Image = p.Image or ''

			local Label, Config = background(ScrollingFrame_1, Title, Desc, Image, 'Label')

			Config:SetTextTransparencyTitle(0)
			Config:SetSizeT(0)

			local New = {}

			function New:SetTitle(t)
				Config:SetTitle(t)
			end

			function New:SetDesc(t)
				Config:SetDesc(t)
			end

			function New:SetVisible(t)
				Label.Visible = t
			end

			return New
		end

		function Func:Paragraph(p)
			local Title = p.Title or 'null'
			local Desc = p.Content or p.Desc or ''
			local Image = p.Image or ''

			local Label, Config = background(ScrollingFrame_1, Title, Desc, Image, 'Label')

			Config:SetTextTransparencyTitle(0)
			Config:SetSizeT(0)

			local New = {}

			function New:SetTitle(t)
				Config:SetTitle(t)
			end

			function New:SetDesc(t)
				Config:SetDesc(t)
			end
			
			function New:SetContent(t)
				Config:SetDesc(t)
			end

			function New:SetVisible(t)
				Label.Visible = t
			end

			return New
		end

		function Func:Button(p)
			local Title = p.Title or 'null'
			local Desc = p.Desc or ''
			local Image = p.Image or ''
			local Callback = p.Callback or function() end

			local Button, Config = background(ScrollingFrame_1, Title, Desc, Image, 'Button')

			Config:SetTextTransparencyTitle(0)
			Config:SetSizeT(50)

			Button.ClipsDescendants = true

			local F = Instance.new("Frame")
			local UIListLayout_1 = Instance.new("UIListLayout")
			local UIPadding_1 = Instance.new("UIPadding")
			local Image_1 = Instance.new("ImageLabel")

			F.Name = "F"
			F.Parent = Button
			F.AnchorPoint = Vector2.new(1, 0.5)
			F.BackgroundColor3 = Color3.fromRGB(255,255,255)
			F.BackgroundTransparency = 1
			F.BorderColor3 = Color3.fromRGB(0,0,0)
			F.BorderSizePixel = 0
			F.Position = UDim2.new(1, 0,0.5, 0)
			F.Size = UDim2.new(0, 50,0.800000012, 0)

			UIListLayout_1.Parent = F
			UIListLayout_1.Padding = UDim.new(0,8)
			UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Right
			UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

			UIPadding_1.Parent = F
			UIPadding_1.PaddingRight = UDim.new(0,13)

			Image_1.Name = "Image"
			Image_1.Parent = F
			Image_1.AnchorPoint = Vector2.new(1, 0.5)
			Image_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Image_1.BackgroundTransparency = 1
			Image_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Image_1.BorderSizePixel = 0
			Image_1.Position = UDim2.new(1, 0,0.5, 0)
			Image_1.Size = UDim2.new(0, 20,0, 20)
			Image_1.Image = CacheImage("rbxassetid://14923748517")
			Image_1.ImageTransparency = 0.3

			local Click = click(Button)
			Click.MouseButton1Click:Connect(function()
				Button.AnchorPoint = Vector2.new(0.5, 0.5)
				Button.Position = UDim2.new(0.5, 0, 0.5,0)
				jc(Click, Button)
				tw({v = Button, t = 0.15, s = Enum.EasingStyle.Back, d = "Out", g = {Size = UDim2.new(.9, 0,.9, 0)}}):Play()
				delay(.06, function()
					tw({v = Button, t = 0.15, s = Enum.EasingStyle.Back, d = "Out", g = {Size = UDim2.new(1, 0,1, 0)}}):Play()
				end)
				pcall(Callback)
			end)

			local New = {}

			function New:SetTitle(t)
				Config:SetTitle(t)
			end

			function New:SetDesc(t)
				Config:SetDesc(t)
			end

			function New:SetVisible(t)
				Button.Visible = t
			end

			function New:SetEnabled(t)
				Click.Active = not not t
			end

			function New:SetCallback(fn)
				Callback = fn or function() end
			end

			return New
		end

		function Func:Slider(p)
			local Title = p.Title or 'null'
			local Desc = p.Desc or ''
			local Image = p.Image or ''
			local Min = p.Min or 0
			local Max = p.Max or 100
			local Value = p.Value or Min + 1
			local Rounding = p.Rounding or 0
			local Callback = p.Callback or function() end

			local Slider, Config = background(ScrollingFrame_1, Title, Desc, Image, 'Slider')

			Config:SetTextTransparencyTitle(0)
			Config:SetSizeT(200)

			local F = Instance.new("Frame")
			local UIListLayout_1 = Instance.new("UIListLayout")
			local UIPadding_1 = Instance.new("UIPadding")
			local FrameValueTextBox = Instance.new('Frame')
			local TextBox_1 = Instance.new("TextBox")
			local UICorner_1 = Instance.new("UICorner")
			local UIStroke_1 = Instance.new("UIStroke")
			local Frame_1 = Instance.new("Frame")
			local Frame_2 = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local Frame_3 = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local Frame_4 = Instance.new("Frame")
			local UICorner_4 = Instance.new("UICorner")
			local UIPadding_2 = Instance.new("UIPadding")

			F.Name = "F"
			F.Parent = Slider
			F.AnchorPoint = Vector2.new(1, 0.5)
			F.BackgroundColor3 = Color3.fromRGB(255,255,255)
			F.BackgroundTransparency = 1
			F.BorderColor3 = Color3.fromRGB(0,0,0)
			F.BorderSizePixel = 0
			F.Position = UDim2.new(1, 0,0.5, 0)
			F.Size = UDim2.new(0, 195,0.8, 0)

			UIListLayout_1.Parent = F
			UIListLayout_1.Padding = UDim.new(0,8)
			UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Right
			UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

			UIPadding_1.Parent = F
			UIPadding_1.PaddingRight = UDim.new(0,13)

			FrameValueTextBox.Parent = F
			FrameValueTextBox.Active = true
			FrameValueTextBox.BackgroundColor3 = Color3.fromRGB(18,18,18)
			FrameValueTextBox.BorderColor3 = Color3.fromRGB(0,0,0)
			FrameValueTextBox.BorderSizePixel = 0
			FrameValueTextBox.Size = UDim2.new(0, 50,0, 20)
			FrameValueTextBox.LayoutOrder = 1

			addToTheme('Function.Slider.Value Background', FrameValueTextBox)

			TextBox_1.Parent = FrameValueTextBox
			TextBox_1.Active = true
			TextBox_1.BackgroundTransparency = 1
			TextBox_1.BorderColor3 = Color3.fromRGB(0,0,0)
			TextBox_1.BorderSizePixel = 0
			TextBox_1.Size = UDim2.new(1, 0,1, 0)
			TextBox_1.Font = Enum.Font.Cartoon
			TextBox_1.PlaceholderColor3 = Color3.fromRGB(178,178,178)
			TextBox_1.PlaceholderText = ""
			TextBox_1.Text = tonumber(Value)
			TextBox_1.TextColor3 = Color3.fromRGB(255,255,255)
			TextBox_1.TextSize = 12

			addToTheme('Text & Icon', TextBox_1)

			UICorner_1.Parent = FrameValueTextBox
			UICorner_1.CornerRadius = UDim.new(0,4)

			UIStroke_1.Parent = FrameValueTextBox
			UIStroke_1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke_1.Color = Color3.fromRGB(255,255,255)
			UIStroke_1.Thickness = 1
			UIStroke_1.Transparency = 0.95

			addToTheme('Function.Slider.Value Stroke', UIStroke_1)

			Frame_1.Parent = F
			Frame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Frame_1.BackgroundTransparency = 1
			Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_1.BorderSizePixel = 0
			Frame_1.Size = UDim2.new(0, 120,0, 20)

			Frame_2.Parent = Frame_1
			Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame_2.BackgroundColor3 = Color3.fromRGB(45,45,45)
			Frame_2.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_2.BorderSizePixel = 0
			Frame_2.Position = UDim2.new(0.5, 0,0.5, 0)
			Frame_2.Size = UDim2.new(1, 0,0, 10)

			addToTheme('Function.Slider.Slider Bar', Frame_2)

			UICorner_2.Parent = Frame_2
			UICorner_2.CornerRadius = UDim.new(1,0)

			Frame_3.Parent = Frame_2
			Frame_3.AnchorPoint = Vector2.new(0, 0.5)
			Frame_3.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Frame_3.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_3.BorderSizePixel = 0
			Frame_3.Position = UDim2.new(0, 0,0.5, 0)
			Frame_3.Size = UDim2.new(0, 0,1, 0)

			addToTheme('Function.Slider.Slider Bar Value', Frame_3)

			UICorner_3.Parent = Frame_3
			UICorner_3.CornerRadius = UDim.new(1,0)

			Frame_4.Parent = Frame_3
			Frame_4.AnchorPoint = Vector2.new(1, 0.5)
			Frame_4.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Frame_4.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_4.BorderSizePixel = 0
			Frame_4.Position = UDim2.new(1, 0,0.5, 0)
			Frame_4.Size = UDim2.new(0, 13,0, 13)

			addToTheme('Function.Slider.Circle Value', Frame_4)

			UICorner_4.Parent = Frame_4
			UICorner_4.CornerRadius = UDim.new(1,0)

			UIPadding_2.Parent = Frame_2
			UIPadding_2.PaddingBottom = UDim.new(0,2)
			UIPadding_2.PaddingLeft = UDim.new(0,2)
			UIPadding_2.PaddingRight = UDim.new(0,2)
			UIPadding_2.PaddingTop = UDim.new(0,2)

			local Click = click(Frame_1)

			local function roundToDecimal(value, decimals)
				local factor = 10 ^ decimals
				return math.floor(value * factor + 0.5) / factor
			end

			local function updateSlider(value)
				value = math.clamp(value, Min, Max)
				value = roundToDecimal(value, Rounding)
				Value = value
				local va = (value - Min) / (Max - Min)
				tw({v = Frame_3, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Size = UDim2.new(math.clamp(va, 0.12, 1), 0, 1, 0)}}):Play()
				TextBox_1.Text = tostring(roundToDecimal(value, Rounding))
				pcall(Callback ,value)
			end

			updateSlider(Value or 0)

			TextBox_1.FocusLost:Connect(function()
				local value = tonumber(TextBox_1.Text) or Min
				updateSlider(value)
			end)

			local function move(input)
				local sliderBar = Frame_2
				local relativeX = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
				local value = relativeX * (Max - Min) + Min
				updateSlider(value)
			end

			local dragging = false

			Click.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					move(input)
				end
			end)

			Click.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)

			U.InputChanged:Connect(function(input)
				if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					move(input)
				end
			end)

			local New = {}

			function New:SetTitle(t)
				Config:SetTitle(t)
			end

			function New:SetDesc(t)
				Config:SetDesc(t)
			end

			function New:SetVisible(t)
				Slider.Visible = t
			end

			function New:SetValue(t)
				updateSlider(t)
			end

			function New:SetMin(t)
				Min = t
				if Value < t then
					updateSlider(t)
				end
			end

			function New:SetMax(t)
				Max = t
				if Value > t then
					updateSlider(t)
				end
			end

			return New
		end

		function Func:Code(p)
			local Title = p.Title or 'null'
			local CodeText = p.Code or '-- print("Hello World")'

			local RealBackground = Instance.new("Frame")
			local Code = Instance.new("Frame")
			local UICorner_1 = Instance.new("UICorner")
			local FF_1 = Instance.new("Frame")
			local UIPadding_1 = Instance.new("UIPadding")
			local F_1 = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local Frame_1 = Instance.new("Frame")
			local UIPadding_2 = Instance.new("UIPadding")
			local Frame_2 = Instance.new("Frame")
			local UIPadding_3 = Instance.new("UIPadding")
			local TextBox_2 = Instance.new("TextLabel")
			local Top_1 = Instance.new("Frame")
			local Left_1 = Instance.new("Frame")
			local Whatisthis_1 = Instance.new("ImageLabel")
			local UIListLayout_1 = Instance.new("UIListLayout")
			local Frame_3 = Instance.new("Frame")
			local Frame_4 = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local UIListLayout_2 = Instance.new("UIListLayout")
			local UIPadding_4 = Instance.new("UIPadding")
			local TextLabel_1 = Instance.new("TextLabel")
			local Right_1 = Instance.new("Frame")
			local UIListLayout_3 = Instance.new("UIListLayout")
			local Frame_5 = Instance.new("Frame")
			local TextButton_1 = Instance.new("TextButton")
			local UIPadding_5 = Instance.new("UIPadding")
			local ImageLabel_1 = Instance.new("ImageLabel")
			local UIGradient_1 = Instance.new("UIGradient")

			RealBackground.Name = "Real Background"
			RealBackground.Parent = ScrollingFrame_1
			RealBackground.BackgroundTransparency = 1
			RealBackground.BorderColor3 = Color3.fromRGB(0,0,0)
			RealBackground.BorderSizePixel = 0
			RealBackground.Size = UDim2.new(1, 0,0, 120)
			RealBackground.ClipsDescendants = true

			Code.Name = "Background"
			Code.Parent = RealBackground
			Code.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Code.BorderColor3 = Color3.fromRGB(0,0,0)
			Code.BorderSizePixel = 0
			Code.Size = UDim2.new(1, 0,1, 0)
			Code.ClipsDescendants = true

			UICorner_1.Parent = Code

			FF_1.Name = "FF"
			FF_1.Parent = Code
			FF_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			FF_1.BackgroundTransparency = 1
			FF_1.BorderColor3 = Color3.fromRGB(0,0,0)
			FF_1.BorderSizePixel = 0
			FF_1.Size = UDim2.new(1, 0,1, 0)

			UIPadding_1.Parent = FF_1
			UIPadding_1.PaddingBottom = UDim.new(0,8)
			UIPadding_1.PaddingLeft = UDim.new(0,8)
			UIPadding_1.PaddingRight = UDim.new(0,8)
			UIPadding_1.PaddingTop = UDim.new(0,8)

			F_1.Name = "F"
			F_1.Parent = FF_1
			F_1.AnchorPoint = Vector2.new(0, 0.5)
			F_1.BackgroundColor3 = Color3.fromRGB(51,62,68)
			F_1.BorderColor3 = Color3.fromRGB(0,0,0)
			F_1.BorderSizePixel = 0
			F_1.Position = UDim2.new(0, 0,0.5, 0)
			F_1.Size = UDim2.new(1, 0,1, 0)
			F_1.ClipsDescendants = true

			addToTheme('Function.Code.Background Code', F_1)

			UICorner_2.Parent = F_1

			Frame_1.Parent = F_1
			Frame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Frame_1.BackgroundTransparency = 1
			Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_1.BorderSizePixel = 0
			Frame_1.Size = UDim2.new(1, 0,1, 0)

			UIPadding_2.Parent = Frame_1
			UIPadding_2.PaddingTop = UDim.new(0,30)

			Frame_2.Parent = Frame_1
			Frame_2.BackgroundColor3 = Color3.fromRGB(38, 50, 56)
			Frame_2.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_2.BorderSizePixel = 0
			Frame_2.Size = UDim2.new(1, 0,1, 0)

			addToTheme('Function.Code.Background Code Value', Frame_2)

			Instance.new('UICorner', Frame_2)

			UIPadding_3.Parent = Frame_2
			UIPadding_3.PaddingBottom = UDim.new(0,5)
			UIPadding_3.PaddingLeft = UDim.new(0,8)
			UIPadding_3.PaddingRight = UDim.new(0,8)
			UIPadding_3.PaddingTop = UDim.new(0,8)

			local ScrollingFrame = Instance.new("ScrollingFrame")

			ScrollingFrame.Parent = Frame_2
			ScrollingFrame.Active = true
			ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ScrollingFrame.BackgroundTransparency = 1.000
			ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ScrollingFrame.BorderSizePixel = 0
			ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
			ScrollingFrame.CanvasSize = UDim2.new(2, 0, 0, 0)
			ScrollingFrame.ScrollBarThickness = 4
			ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(216, 150, 179)

			addToTheme('Function.Code.ScrollingFrame Code', ScrollingFrame)

			local Code_1 = Instance.new("Frame")
			local UIPaddingCode_1 = Instance.new("UIPadding")

			Code_1.Name = "Code"
			Code_1.Parent = ScrollingFrame
			Code_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Code_1.BackgroundTransparency = 1
			Code_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Code_1.BorderSizePixel = 0
			Code_1.Size = UDim2.new(1, 0,1, 0)

			UIPaddingCode_1.Name = "UIPaddingCode"
			UIPaddingCode_1.Parent = Code_1
			UIPaddingCode_1.PaddingLeft = UDim.new(0,20)

			TextBox_2.Name = "TextBox"
			TextBox_2.Parent = Code_1
			TextBox_2.Active = true
			TextBox_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextBox_2.BackgroundTransparency = 1
			TextBox_2.BorderColor3 = Color3.fromRGB(0,0,0)
			TextBox_2.BorderSizePixel = 0
			TextBox_2.Size = UDim2.new(0, 0,0, 0)
			TextBox_2.Font = Enum.Font.Code
			TextBox_2.RichText = true
			TextBox_2.TextColor3 = Color3.fromRGB(255,255,255)
			TextBox_2.TextSize = 12
			TextBox_2.TextXAlignment = Enum.TextXAlignment.Left
			TextBox_2.TextYAlignment = Enum.TextYAlignment.Top
			TextBox_2.Text = CodeText
			TextBox_2.AutomaticSize = Enum.AutomaticSize.XY

			addToTheme('Text & Icon', TextBox_2)

			Top_1.Name = "Top"
			Top_1.Parent = F_1
			Top_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Top_1.BackgroundTransparency = 1
			Top_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Top_1.BorderSizePixel = 0
			Top_1.Size = UDim2.new(1, 0,0, 30)

			Left_1.Name = "Left"
			Left_1.Parent = Top_1
			Left_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Left_1.BackgroundTransparency = 1
			Left_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Left_1.BorderSizePixel = 0
			Left_1.Size = UDim2.new(1, 0,1, 0)

			Whatisthis_1.Name = "Whatisthis"
			Whatisthis_1.Parent = Left_1
			Whatisthis_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Whatisthis_1.BackgroundTransparency = 1
			Whatisthis_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Whatisthis_1.BorderSizePixel = 0
			Whatisthis_1.Size = UDim2.new(0, 50,0, 13)
			Whatisthis_1.Image = CacheImage("rbxassetid://81518443444327")
			Whatisthis_1.ScaleType = Enum.ScaleType.Fit

			UIListLayout_1.Parent = Left_1
			UIListLayout_1.Padding = UDim.new(0,5)
			UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

			Frame_3.Parent = Left_1
			Frame_3.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Frame_3.BackgroundTransparency = 1
			Frame_3.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_3.BorderSizePixel = 0
			Frame_3.Size = UDim2.new(0, 100,0, 30)

			Frame_4.Parent = Frame_3
			Frame_4.BackgroundColor3 = Color3.fromRGB(37, 49, 55)
			Frame_4.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_4.BorderSizePixel = 0
			Frame_4.Position = UDim2.new(0, 0,0.15, 0)
			Frame_4.Size = UDim2.new(1, 0,0, 30)

			addToTheme('Function.Code.Background Code Value', Frame_4)

			addToTheme('Function.Code.Background Value', Frame_4)

			UICorner_3.Parent = Frame_4

			UIListLayout_2.Parent = Frame_4
			UIListLayout_2.Padding = UDim.new(0,5)
			UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

			UIPadding_4.Parent = Frame_4
			UIPadding_4.PaddingLeft = UDim.new(0,8)
			UIPadding_4.PaddingRight = UDim.new(0,8)

			TextLabel_1.Parent = Frame_4
			TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_1.BackgroundTransparency = 1
			TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_1.BorderSizePixel = 0
			TextLabel_1.Size = UDim2.new(1, 0,0, 25)
			TextLabel_1.Font = Enum.Font.GothamBold
			TextLabel_1.Text = tostring(Title)
			TextLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
			TextLabel_1.TextSize = 11

			addToTheme('Text & Icon', TextLabel_1)

			Right_1.Name = "Right"
			Right_1.Parent = Top_1
			Right_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Right_1.BackgroundTransparency = 1
			Right_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Right_1.BorderSizePixel = 0
			Right_1.Size = UDim2.new(1, 0,1, 0)

			UIListLayout_3.Parent = Right_1
			UIListLayout_3.Padding = UDim.new(0,5)
			UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Right
			UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Center

			Frame_5.Parent = Right_1
			Frame_5.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Frame_5.BackgroundTransparency = 1
			Frame_5.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_5.BorderSizePixel = 0
			Frame_5.Size = UDim2.new(0, 60,0, 30)

			TextButton_1.Parent = Frame_5
			TextButton_1.Active = true
			TextButton_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextButton_1.BackgroundTransparency = 1
			TextButton_1.BorderColor3 = Color3.fromRGB(0,0,0)
			TextButton_1.BorderSizePixel = 0
			TextButton_1.Size = UDim2.new(1, 0,1, 0)
			TextButton_1.Font = Enum.Font.GothamBold
			TextButton_1.Text = "Copy"
			TextButton_1.TextColor3 = Color3.fromRGB(255,255,255)
			TextButton_1.TextSize = 11
			TextButton_1.TextTransparency = 0.5
			TextButton_1.TextXAlignment = Enum.TextXAlignment.Right

			UIPadding_5.Parent = Frame_5
			UIPadding_5.PaddingRight = UDim.new(0,10)

			ImageLabel_1.Parent = Frame_5
			ImageLabel_1.AnchorPoint = Vector2.new(0, 0.5)
			ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			ImageLabel_1.BackgroundTransparency = 1
			ImageLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
			ImageLabel_1.BorderSizePixel = 0
			ImageLabel_1.Position = UDim2.new(0, 0,0.5, 0)
			ImageLabel_1.Size = UDim2.new(0, 16,0, 16)
			ImageLabel_1.Image = CacheImage("rbxassetid://13847222481")
			ImageLabel_1.ImageTransparency = 0.5

			UIGradient_1.Parent = Code
			--UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(216, 150, 179)), ColorSequenceKeypoint.new(1, Color3.fromRGB(105, 81, 164))}
			UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)), ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))}
			UIGradient_1.Rotation = 45

			addToTheme('Function.Code.Background', UIGradient_1)

			local Line = Instance.new("Frame")
			local LineText_1 = Instance.new("TextLabel")

			Line.Name = "Line"
			Line.Parent = ScrollingFrame
			Line.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Line.BackgroundTransparency = 1
			Line.BorderColor3 = Color3.fromRGB(0,0,0)
			Line.BorderSizePixel = 0
			Line.Size = UDim2.new(1, 0,1, 0)

			LineText_1.Name = "LineText"
			LineText_1.Parent = Line
			LineText_1.Active = true
			LineText_1.AutomaticSize = Enum.AutomaticSize.XY
			LineText_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			LineText_1.BackgroundTransparency = 1
			LineText_1.BorderColor3 = Color3.fromRGB(0,0,0)
			LineText_1.BorderSizePixel = 0
			LineText_1.Size = UDim2.new(0, 0,0, 0)
			LineText_1.Font = Enum.Font.RobotoMono
			LineText_1.RichText = true
			LineText_1.Text = ''
			LineText_1.TextColor3 = Color3.fromRGB(255,255,255)
			LineText_1.TextSize = 12
			LineText_1.TextXAlignment = Enum.TextXAlignment.Left
			LineText_1.TextYAlignment = Enum.TextYAlignment.Top
			LineText_1.TextWrapped = true

			local highlighter = {}

			do
				local keywords = {
					lua = {
						"and", "break", "or", "else", "elseif", "if", "then", "until", "repeat", "while", "do", "for", "in", "end",
						"local", "return", "function", "export"
					},
					rbx = {
						"game", "workspace", "script", "math", "string", "table", "task", "wait", "select", "next", "Enum",
						"error", "warn", "tick", "assert", "shared", "loadstring", "tonumber", "tostring", "type",
						"typeof", "unpack", "print", "Instance", "CFrame", "Vector3", "Vector2", "Color3", "UDim", "UDim2", "Ray", "BrickColor",
						"OverlapParams", "RaycastParams", "Axes", "Random", "Region3", "Rect", "TweenInfo",
						"collectgarbage", "not", "utf8", "pcall", "xpcall", "_G", "setmetatable", "getmetatable", "os", "pairs", "ipairs"
					},
					operators = {
						"#", "+", "-", "*", "%", "/", "^", "=", "~", "=", "<", ">",
					}
				}

				local colors = {
					numbers = Color3.fromHex("#79c0ff"),
					boolean = Color3.fromHex("#79c0ff"),
					operator = Color3.fromHex("#ff7b72"),
					lua = Color3.fromHex("#ff7b72"),
					rbx = Color3.fromHex("#7fcfef"), -- def
					str = Color3.fromHex("#a5d6ff"),
					comment = Color3.fromHex("#8b949e"),
					null = Color3.fromHex("#79c0ff"),
					call = Color3.fromHex("#d2a8ff"),    
					self_call = Color3.fromHex("#d2a8ff"),
					local_property = Color3.fromHex("#ff7b72"),
				}

				local function createKeywordSet(keywords)
					local keywordSet = {}
					for _, keyword in ipairs(keywords) do
						keywordSet[keyword] = true
					end
					return keywordSet
				end

				local luaSet = createKeywordSet(keywords.lua)
				local rbxSet = createKeywordSet(keywords.rbx)
				local operatorsSet = createKeywordSet(keywords.operators)

				local function getHighlight(tokens, index)
					local token = tokens[index]

					if colors[token .. "_color"] then
						return colors[token .. "_color"]
					end

					if tonumber(token) then
						return colors.numbers
					elseif token == "nil" then
						return colors.null
					elseif token:sub(1, 2) == "--" then
						return colors.comment
					elseif operatorsSet[token] then
						return colors.operator
					elseif luaSet[token] then
						return colors.lua
					elseif rbxSet[token] then
						return colors.rbx
					elseif token:sub(1, 1) == "\"" or token:sub(1, 1) == "\'" then
						return colors.str
					elseif token == "true" or token == "false" then
						return colors.boolean
					else
					end

					if tokens[index + 1] == "(" then
						if tokens[index - 1] == ":" then
							return colors.self_call
						end

						return colors.call
					end

					if tokens[index - 1] == "." then
						if tokens[index - 2] == "Enum" then
							return colors.rbx
						end

						return colors.local_property
					end
				end

				function highlighter.run(source)
					local tokens = {}
					local multiStrings = {}
					local currentToken = ""

					local index = 1
					source = source:gsub("%[%[.-%]%]", function(str)
						local placeholder = "" .. index .. "__"
						multiStrings[placeholder] = str
						index = index + 1
						return placeholder
					end)

					local inString = false
					local inComment = false
					local commentPersist = false

					for i = 1, #source do
						local character = source:sub(i, i)

						if inComment then
							if character == "\n" and not commentPersist then
								table.insert(tokens, currentToken)
								table.insert(tokens, character)
								currentToken = ""
								inComment = false
							elseif source:sub(i - 1, i) == "]]" and commentPersist then
								currentToken = currentToken .. "]"
								table.insert(tokens, currentToken)
								currentToken = ""
								inComment = false
								commentPersist = false
							else
								currentToken = currentToken .. character
							end
						elseif inString then
							if character == inString and source:sub(i - 1, i - 1) ~= "\\" or character == "\n" then
								currentToken = currentToken .. character
								inString = false
							else
								currentToken = currentToken .. character
							end
						else
							local foundPlaceholder = source:sub(i):match("^__MULTISTR_%d+__")
							if foundPlaceholder then
								table.insert(tokens, foundPlaceholder)
								i = i + #foundPlaceholder - 1
							elseif source:sub(i, i + 1) == "--" then
								table.insert(tokens, currentToken)
								currentToken = "-"
								inComment = true
								commentPersist = source:sub(i + 2, i + 3) == "[["
							elseif character == "\"" or character == "\'" then
								table.insert(tokens, currentToken)
								currentToken = character
								inString = character
							elseif operatorsSet[character] then
								table.insert(tokens, currentToken)
								table.insert(tokens, character)
								currentToken = ""
							elseif character:match("[%w_]") then
								currentToken = currentToken .. character
							else
								table.insert(tokens, currentToken)
								table.insert(tokens, character)
								currentToken = ""
							end
						end
					end

					table.insert(tokens, currentToken)

					local highlighted = {}

					for i, token in ipairs(tokens) do
						if multiStrings[token] then
							local syntax = string.format(
								'<font color = "#%s">%s</font>',
								colors.str:ToHex(),
								multiStrings[token]:gsub("<", "&lt;"):gsub(">", "&gt;")
							)
							table.insert(highlighted, syntax)
						else
							local highlight = getHighlight(tokens, i)

							if highlight then
								local syntax = string.format(
									'<font color = "#%s">%s</font>',
									highlight:ToHex(),
									token:gsub("<", "&lt;"):gsub(">", "&gt;")
								)
								table.insert(highlighted, syntax)
							else
								table.insert(highlighted, token)
							end
						end
					end

					return table.concat(highlighted)
				end
			end

			local iscop = false

			TextButton_1.MouseButton1Click:Connect(function()
				if not iscop then
					setclipboard(CodeText)
					TextButton_1.Text = "Copied"
					ImageLabel_1.Image = CacheImage("rbxassetid://14939475472")
					Frame_5.Size = UDim2.new(0, 65,0, 30)
					iscop = true
					delay(1, function()
						TextButton_1.Text = "Copy"
						ImageLabel_1.Image = CacheImage("rbxassetid://13847222481")
						Frame_5.Size = UDim2.new(0, 58,0, 30)
						iscop = false
					end)
				end
			end)

			TextBox_2.Text = highlighter.run(TextBox_2.Text)

			TextBox_2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				ScrollingFrame.CanvasSize = UDim2.new(0, TextBox_2.AbsoluteSize.X + 20, 0, 0)
			end)

			local function updateLineNumbers()
				tw({v = RealBackground, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Size = UDim2.new(1, 0,0, TextBox_2.TextBounds.Y + 65)}}):Play()
				tw({v = Frame_3, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Size = UDim2.new(0, TextLabel_1.TextBounds.X + 30,0, 30)}}):Play()

				local count = #TextBox_2.Text:split("\n")

				local str = ""
				for i = 1, count do
					str = str .. i .. "\n"
				end
				LineText_1.Text = str
			end

			updateLineNumbers()
			TextBox_2:GetPropertyChangedSignal("Text"):Connect(updateLineNumbers)

			local New = {}

			function New:SetTitle(t)
				TextLabel_1.Text = tostring(t)
			end

			function New:SetCode(t)
				TextBox_2.Text = highlighter.run(t)
				CodeText = t
			end

			return New
		end

		function Func:Dropdown(p)
			local Title = p.Title or 'null'
			local Desc = p.Desc or ''
			local Image = p.Image or ''
			local List = p.List or {}
			local Value = p.Value or List[1]
			local Multi = p.Multi or false
			local Callback = p.Callback or function() end

			local Dropdown, Config = background(ScrollingFrame_1, Title, Desc, Image, 'Dropdown')

			Config:SetTextTransparencyTitle(0)
			Config:SetSizeT(125)

			local DropdownSelect = addDropdownSelect(Dropdown, Dropdown, Multi, Callback, Value, List)

			local New = {}

			function New:SetTitle(t)
				Config:SetTitle(t)
			end

			function New:SetDesc(t)
				Config:SetDesc(t)
			end

			function New:SetVisible(t)
				Dropdown.Visible = t
			end

			function New:SetValue(t)
				DropdownSelect:SetValue(t)
			end

			function New:Add(t)
				DropdownSelect:Add(t)
			end

			function New:Clear(t)
				local n = t or nil
				DropdownSelect:Clear(n)
			end

			return New
		end

		function Func:Keybind(p)
			local Title = p.Title or 'null'
			local Desc = p.Desc or ''
			local Image = p.Image or ''
			local Value = p.Value or false
			local Key = p.Key or Enum.KeyCode.E
			local Callback = p.Callback or function() end
			local KeyChangedCallback = p.KeyChangedCallback or function() end

			local Keybind, Config = background(ScrollingFrame_1, Title, Desc, Image, 'Keybind')

			Config:SetSizeT(100)

			local F = Instance.new("TextButton")
			local UIListLayout_1 = Instance.new("UIListLayout")
			local UIPadding_1 = Instance.new("UIPadding")
			local ToggleValue_1 = Instance.new("Frame")
			local UICorner_1 = Instance.new("UICorner")
			local Frame_1 = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local UIPadding_2 = Instance.new("UIPadding")
			local KeybindValue_1 = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local UIStroke_1 = Instance.new("UIStroke")
			local TextLabel_1 = Instance.new("TextLabel")
			local UIPadding_3 = Instance.new("UIPadding")

			F.Name = "F"
			F.Parent = Keybind
			F.AnchorPoint = Vector2.new(1, 0.5)
			F.BackgroundColor3 = Color3.fromRGB(255,255,255)
			F.BackgroundTransparency = 1
			F.BorderColor3 = Color3.fromRGB(0,0,0)
			F.BorderSizePixel = 0
			F.Position = UDim2.new(1, 0,0.5, 0)
			F.Size = UDim2.new(0, 100,0.800000012, 0)
			F.Text = ''

			UIListLayout_1.Parent = F
			UIListLayout_1.Padding = UDim.new(0,8)
			UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Right
			UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

			UIPadding_1.Parent = F
			UIPadding_1.PaddingRight = UDim.new(0,13)

			ToggleValue_1.Name = "ToggleValue"
			ToggleValue_1.Parent = F
			ToggleValue_1.BackgroundColor3 = Color3.fromRGB(65,65,65)
			ToggleValue_1.BorderColor3 = Color3.fromRGB(0,0,0)
			ToggleValue_1.BorderSizePixel = 0
			ToggleValue_1.LayoutOrder = 1
			ToggleValue_1.Size = UDim2.new(0, 0, 0, 0)   -- เธเนเธญเธ: เนเธกเนเนเธเนเธเธทเนเธเธ—เธตเนเนเธ layout
			ToggleValue_1.Visible = false

			UICorner_1.Parent = ToggleValue_1
			UICorner_1.CornerRadius = UDim.new(1,0)

			Frame_1.Parent = ToggleValue_1
			Frame_1.AnchorPoint = Vector2.new(1, 0.5)
			Frame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_1.BorderSizePixel = 0
			Frame_1.Position = UDim2.new(1, 0,0.5, 0)
			Frame_1.Size = UDim2.new(0, 13,0, 13)

			addToTheme('Main', Frame_1)

			UICorner_2.Parent = Frame_1
			UICorner_2.CornerRadius = UDim.new(1,0)

			UIPadding_2.Parent = ToggleValue_1
			UIPadding_2.PaddingLeft = UDim.new(0,2)
			UIPadding_2.PaddingRight = UDim.new(0,2)

			KeybindValue_1.Name = "KeybindValue"
			KeybindValue_1.Parent = F
			KeybindValue_1.BackgroundColor3 = Color3.fromRGB(18,18,18)
			KeybindValue_1.BorderColor3 = Color3.fromRGB(0,0,0)
			KeybindValue_1.BorderSizePixel = 0
			KeybindValue_1.Size = UDim2.new(0, 30,0, 20)

			addToTheme('Function.Keybind.Value Background', KeybindValue_1)

			UICorner_3.Parent = KeybindValue_1
			UICorner_3.CornerRadius = UDim.new(0,4)

			UIStroke_1.Parent = KeybindValue_1
			UIStroke_1.Color = Color3.fromRGB(255,255,255)
			UIStroke_1.Thickness = 1
			UIStroke_1.Transparency = 0.95

			addToTheme('Function.Keybind.Value Stroke', UIStroke_1)

			TextLabel_1.Parent = KeybindValue_1
			TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_1.BackgroundTransparency = 1
			TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_1.BorderSizePixel = 0
			TextLabel_1.Size = UDim2.new(1, 0,1, 0)
			TextLabel_1.Font = Enum.Font.GothamBold
			TextLabel_1.RichText = true
			TextLabel_1.Text = tostring(Key):gsub("Enum.KeyCode.", "")
			TextLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
			TextLabel_1.TextSize = 10
			TextLabel_1.TextTransparency = 0.30000001192092896
			TextLabel_1.TextWrapped = true

			addToTheme('Text & Icon', TextLabel_1)

			UIPadding_3.Parent = KeybindValue_1
			UIPadding_3.PaddingLeft = UDim.new(0,5)
			UIPadding_3.PaddingRight = UDim.new(0,5)

			local Click = click(Keybind)
			KeybindValue_1.ZIndex = 2
			F.ZIndex = 2

			Value = not Value

			local function change()
				Value = not Value
				if Value then
					Config:SetTextTransparencyTitle(0)
					tw({v = ToggleValue_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {BackgroundColor3 = themes[IsTheme].Function.Keybind.True['Toggle Background']}}):Play()
					tw({v = Frame_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out",
						g = {
							BackgroundColor3 = themes[IsTheme].Function.Keybind.True['Toggle Value'],
							AnchorPoint = Vector2.new(1, 0.5),
							Position = UDim2.new(1, 0,0.5, 0)
						}}):Play()
				else
					Config:SetTextTransparencyTitle(0.7)
					tw({v = ToggleValue_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {BackgroundColor3 = themes[IsTheme].Function.Keybind.False['Toggle Background']}}):Play()
					tw({v = Frame_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out",
						g = {
							BackgroundColor3 = themes[IsTheme].Function.Keybind.False['Toggle Value'],
							AnchorPoint = Vector2.new(0, 0.5),
							Position = UDim2.new(0, 0,0.5, 0)
						}}):Play()
				end
			end

			Click.MouseButton1Click:Connect(change)

			delay(0.1, change)

			local changeing = false

			local function adjustBoxBindSize()
				local textSize = _Services.TextService:GetTextSize(TextLabel_1.Text, TextLabel_1.TextSize, TextLabel_1.Font, Vector2.new(1000, 1000))
				tw({v = KeybindValue_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {Size = UDim2.new(0, textSize.X + 20, 0, 20)}}):Play()
			end

			adjustBoxBindSize()

			local function changeKey()
				changeing = true
				TextLabel_1.Text = "..."
				local inputConnection
				inputConnection = U.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						Key = input.KeyCode
						TextLabel_1.Text = tostring(Key):gsub("Enum.KeyCode.", "")
						adjustBoxBindSize()
						-- เน€เธเธฅเธตเนเธขเธเนเธเน key เนเธชเธ”เธ เนเธกเน trigger callback
						KeyChangedCallback(Key)
						inputConnection:Disconnect()
						task.wait(.1)
						changeing = false
					end
				end)
			end

			U.InputBegan:Connect(function(input, gameProcessed)
				if gameProcessed then return end
				if input.KeyCode == Key and not changeing then
					change()
					pcall(Callback, Value, Key)
				end
			end)

			-- เนเธกเนเน€เธฃเธตเธขเธ Callback เธ•เธญเธ init เน€เธเธทเนเธญเธเนเธญเธเธเธฑเธ toggle เน€เธเธดเธ”เธ—เธฑเธเธ—เธต
			-- delay(0, function()
			-- 	pcall(Callback, Key, Value)
			-- end)

			Keybind:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
				if Value then
					ToggleValue_1.BackgroundColor3 = themes[IsTheme].Function.Keybind.True['Toggle Background']
					Frame_1.BackgroundColor3 = themes[IsTheme].Function.Keybind.True['Toggle Value']
				else
					ToggleValue_1.BackgroundColor3 = themes[IsTheme].Function.Keybind.False['Toggle Background']
					Frame_1.BackgroundColor3 = themes[IsTheme].Function.Keybind.False['Toggle Value']
				end
			end)

			F.MouseButton1Click:Connect(changeKey)

			local New = {}

			function New:SetTitle(t)
				Config:SetTitle(t)
			end

			function New:SetDesc(t)
				Config:SetDesc(t)
			end

			function New:SetVisible(t)
				Keybind.Visible = t
			end

			function New:SetValue(t)
				Value = not t
				change()
			end

			function New:SetKey(t)
				Key = t
				TextLabel_1.Text = tostring(Key):gsub("Enum.KeyCode.", "")
				adjustBoxBindSize()
				-- เนเธกเนเน€เธฃเธตเธขเธ callback เธ•เธญเธ SetKey
			end

			return New
		end

		-- ===== K2NTA Console Component =====
		function Func:Console(p)
			local Title = p.Title or 'Console'
			local MaxLines = p.MaxLines or 100

			-- === Container background ===
			local RealBG = Instance.new("Frame")
			local ConsoleBG = Instance.new("Frame")
			local UICornerCon = Instance.new("UICorner")
			local UIStrokeCon = Instance.new("UIStroke")

			RealBG.Name = "Real Background"
			RealBG.Parent = ScrollingFrame_1
			RealBG.BackgroundTransparency = 1
			RealBG.BorderSizePixel = 0
			RealBG.Size = UDim2.new(1, 0, 0, 220)
			RealBG.ClipsDescendants = false

			ConsoleBG.Name = "Background"
			ConsoleBG.Parent = RealBG
			ConsoleBG.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
			ConsoleBG.BorderSizePixel = 0
			ConsoleBG.Size = UDim2.new(1, 0, 1, 0)

			UICornerCon.Parent = ConsoleBG
			UICornerCon.CornerRadius = UDim.new(0, 8)

			UIStrokeCon.Parent = ConsoleBG
			UIStrokeCon.Color = Color3.fromRGB(60, 60, 80)
			UIStrokeCon.Thickness = 1

			-- === Topbar: title + clear button ===
			local TopBar = Instance.new("Frame")
			local TopLabel = Instance.new("TextLabel")
			local ClearBtn = Instance.new("TextButton")
			local UICornerClear = Instance.new("UICorner")

			TopBar.Parent = ConsoleBG
			TopBar.BackgroundTransparency = 1
			TopBar.BorderSizePixel = 0
			TopBar.Size = UDim2.new(1, 0, 0, 24)
			TopBar.Position = UDim2.new(0, 0, 0, 0)

			TopLabel.Parent = TopBar
			TopLabel.BackgroundTransparency = 1
			TopLabel.BorderSizePixel = 0
			TopLabel.Size = UDim2.new(1, -60, 1, 0)
			TopLabel.Position = UDim2.new(0, 8, 0, 0)
			TopLabel.Font = Enum.Font.GothamBold
			TopLabel.Text = "๐“ " .. Title
			TopLabel.TextColor3 = Color3.fromRGB(160, 160, 200)
			TopLabel.TextSize = 10
			TopLabel.TextXAlignment = Enum.TextXAlignment.Left

			ClearBtn.Parent = TopBar
			ClearBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 20)
			ClearBtn.BorderSizePixel = 0
			ClearBtn.AnchorPoint = Vector2.new(1, 0.5)
			ClearBtn.Position = UDim2.new(1, -6, 0.5, 0)
			ClearBtn.Size = UDim2.new(0, 48, 0, 16)
			ClearBtn.Font = Enum.Font.GothamBold
			ClearBtn.Text = "CLEAR"
			ClearBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
			ClearBtn.TextSize = 9

			UICornerClear.Parent = ClearBtn
			UICornerClear.CornerRadius = UDim.new(0, 4)

			-- Divider line
			local Divider = Instance.new("Frame")
			Divider.Parent = ConsoleBG
			Divider.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
			Divider.BorderSizePixel = 0
			Divider.Position = UDim2.new(0, 0, 0, 24)
			Divider.Size = UDim2.new(1, 0, 0, 1)

			-- === Scrolling log area ===
			local LogFrame = Instance.new("ScrollingFrame")
			local LogLayout = Instance.new("UIListLayout")
			local LogPadding = Instance.new("UIPadding")

			LogFrame.Parent = ConsoleBG
			LogFrame.BackgroundTransparency = 1
			LogFrame.BorderSizePixel = 0
			LogFrame.Position = UDim2.new(0, 0, 0, 25)
			LogFrame.Size = UDim2.new(1, 0, 1, -25)
			LogFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
			LogFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
			LogFrame.ScrollBarThickness = 3
			LogFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 160)
			LogFrame.ScrollingDirection = Enum.ScrollingDirection.Y
			LogFrame.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
			LogFrame.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
			LogFrame.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
			LogFrame.ClipsDescendants = true

			LogLayout.Parent = LogFrame
			LogLayout.SortOrder = Enum.SortOrder.LayoutOrder
			LogLayout.Padding = UDim.new(0, 4)

			LogPadding.Parent = LogFrame
			LogPadding.PaddingLeft = UDim.new(0, 8)
			LogPadding.PaddingRight = UDim.new(0, 8)
			LogPadding.PaddingTop = UDim.new(0, 8)
			LogPadding.PaddingBottom = UDim.new(0, 8)

			-- === Log colors by level ===
			local levelColors = {
				info    = Color3.fromRGB(140, 200, 255),
				success = Color3.fromRGB(100, 230, 130),
				warn    = Color3.fromRGB(255, 210, 80),
				error   = Color3.fromRGB(255, 90, 90),
				system  = Color3.fromRGB(180, 140, 255),
			}
			local levelIcons = {
				info    = "โน",
				success = "โ“",
				warn    = "โ ",
				error   = "โ—",
				system  = "โ—",
			}

			local logCount = 0
			local logLines = {}

			-- === Internal: add line ===
			local function addLine(text, level)
				level = level or "info"
				logCount = logCount + 1

				-- remove oldest if over max
				if #logLines >= MaxLines then
					local oldest = table.remove(logLines, 1)
					if oldest and oldest.Parent then oldest:Destroy() end
				end

				local timeStr = os.date and os.date("%H:%M:%S") or ""
				local icon = levelIcons[level] or "ยท"
				local color = levelColors[level] or Color3.fromRGB(200, 200, 200)

				-- Card Container
				local RowFrame = Instance.new("Frame")
				local RowCorner = Instance.new("UICorner")
				local AccentBar = Instance.new("Frame")
				local AccentCorner = Instance.new("UICorner")
				local RowLabel = Instance.new("TextLabel")
				local RowPadding = Instance.new("UIPadding")

				RowFrame.Parent = LogFrame
				RowFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 34)
				RowFrame.BackgroundTransparency = 1 -- เน€เธฃเธดเนเธกเธ•เนเธเธ—เธตเนเนเธชเธชเธณเธซเธฃเธฑเธ animation
				RowFrame.BorderSizePixel = 0
				RowFrame.Size = UDim2.new(1, 0, 0, 0)
				RowFrame.AutomaticSize = Enum.AutomaticSize.Y
				RowFrame.LayoutOrder = logCount

				RowCorner.Parent = RowFrame
				RowCorner.CornerRadius = UDim.new(0, 6)

				AccentBar.Parent = RowFrame
				AccentBar.BackgroundColor3 = color
				AccentBar.BorderSizePixel = 0
				AccentBar.Size = UDim2.new(0, 3, 1, 0)
				AccentBar.Position = UDim2.new(0, 0, 0, 0)
				AccentBar.BackgroundTransparency = 1

				AccentCorner.Parent = AccentBar
				AccentCorner.CornerRadius = UDim.new(0, 3)

				RowLabel.Parent = RowFrame
				RowLabel.BackgroundTransparency = 1
				RowLabel.BorderSizePixel = 0
				RowLabel.Size = UDim2.new(1, -6, 1, 0)
				RowLabel.Position = UDim2.new(0, 8, 0, 0)
				RowLabel.AutomaticSize = Enum.AutomaticSize.Y
				RowLabel.Font = Enum.Font.GothamMedium
				RowLabel.RichText = true
				RowLabel.TextXAlignment = Enum.TextXAlignment.Left
				RowLabel.TextSize = 11
				RowLabel.TextWrapped = true
				RowLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
				RowLabel.TextTransparency = 1
				RowLabel.Text = string.format(
					'<font color="#%02x%02x%02x" size="12"><b>%s</b></font>  <font color="#787896" size="9">%s</font>  %s',
					math.floor(color.R*255), math.floor(color.G*255), math.floor(color.B*255), icon,
					timeStr,
					text
				)

				RowPadding.Parent = RowFrame
				RowPadding.PaddingTop = UDim.new(0, 6)
				RowPadding.PaddingBottom = UDim.new(0, 6)

				table.insert(logLines, RowFrame)

				-- Fade in animation
				local TweenService = _Services.TweenService
				local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
				TweenService:Create(RowFrame, ti, {BackgroundTransparency = 0.4}):Play()
				TweenService:Create(AccentBar, ti, {BackgroundTransparency = 0}):Play()
				TweenService:Create(RowLabel, ti, {TextTransparency = 0}):Play()

				-- auto-scroll to bottom
				task.defer(function()
					LogFrame.CanvasPosition = Vector2.new(0, math.huge)
				end)

				-- print to real console too
				print(string.format("[K2NTA][%s] %s %s", level:upper(), icon, text))
			end

			-- === Clear ===
			ClearBtn.MouseButton1Click:Connect(function()
				for _, v in ipairs(logLines) do
					if v and v.Parent then v:Destroy() end
				end
				logLines = {}
				logCount = 0
			end)

			-- hover effect on clear button
			ClearBtn.MouseEnter:Connect(function()
				ClearBtn.BackgroundColor3 = Color3.fromRGB(80, 25, 25)
			end)
			ClearBtn.MouseLeave:Connect(function()
				ClearBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 20)
			end)

			-- === Public API ===
			local New = {}

			function New:Log(text, level)
				addLine(text, level or "info")
			end

			function New:Info(text)    addLine(text, "info")    end
			function New:Success(text) addLine(text, "success") end
			function New:Warn(text)    addLine(text, "warn")    end
			function New:Error(text)   addLine(text, "error")   end
			function New:System(text)  addLine(text, "system")  end

			function New:Clear()
				for _, v in ipairs(logLines) do
					if v and v.Parent then v:Destroy() end
				end
				logLines = {}
				logCount = 0
			end

			function New:SetVisible(t)
				RealBG.Visible = t
			end

			return New
		end

		function Func:ColorPicker(p)
			local Title = p.Title
			local Desc = p.Desc or ''
			local Image = p.Image or ''
			local Value = p.Value or Color3.fromRGB(255, 255, 255)
			local Callback = p.Callback or function() end

			local ColorPicker, Config = background(ScrollingFrame_1, Title, Desc, Image, 'Color Picker')

			Config:SetTextTransparencyTitle(0)
			Config:SetSizeT(50)

			local ListFunctionColorPicker = Instance.new("Frame")
			local Picker_1 = Instance.new("Frame")
			local UICorner_1 = Instance.new("UICorner")
			local GlowDot_1 = Instance.new("ImageLabel")
			local Picker_2 = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local UIPadding_1 = Instance.new("UIPadding")

			ListFunctionColorPicker.Name = "ListFunctionColorPicker"
			ListFunctionColorPicker.Parent = ColorPicker
			ListFunctionColorPicker.BackgroundColor3 = Color3.fromRGB(255,255,255)
			ListFunctionColorPicker.BackgroundTransparency = 1
			ListFunctionColorPicker.BorderColor3 = Color3.fromRGB(0,0,0)
			ListFunctionColorPicker.BorderSizePixel = 0
			ListFunctionColorPicker.Size = UDim2.new(1, 0,1, 0)

			Picker_1.Name = "Picker"
			Picker_1.Parent = ListFunctionColorPicker
			Picker_1.AnchorPoint = Vector2.new(1, 0.5)
			Picker_1.BackgroundColor3 = Value
			Picker_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Picker_1.BorderSizePixel = 0
			Picker_1.Position = UDim2.new(1, 0,0.5, 0)
			Picker_1.Size = UDim2.new(0, 20,0, 20)

			UICorner_1.Parent = Picker_1
			UICorner_1.CornerRadius = UDim.new(1,0)

			GlowDot_1.Name = "GlowDot"
			GlowDot_1.Parent = Picker_1
			GlowDot_1.AnchorPoint = Vector2.new(0.5, 0.5)
			GlowDot_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			GlowDot_1.BackgroundTransparency = 1
			GlowDot_1.BorderColor3 = Color3.fromRGB(0,0,0)
			GlowDot_1.BorderSizePixel = 0
			GlowDot_1.Position = UDim2.new(0.5, 0,0.5, 0)
			GlowDot_1.Size = UDim2.new(1.5, 0,1.5, 0)
			GlowDot_1.Image = CacheImage("rbxassetid://105506802034513")
			GlowDot_1.ImageColor3 = Value
			GlowDot_1.ImageTransparency = 0.2

			Picker_2.Name = "Picker"
			Picker_2.Parent = GlowDot_1
			Picker_2.AnchorPoint = Vector2.new(0.5, 0.5)
			Picker_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Picker_2.BorderColor3 = Color3.fromRGB(0,0,0)
			Picker_2.BorderSizePixel = 0
			Picker_2.Position = UDim2.new(0.5, 0,0.5, 0)
			Picker_2.Size = UDim2.new(0, 12,0, 12)

			UICorner_2.Parent = Picker_2
			UICorner_2.CornerRadius = UDim.new(1,0)

			UIPadding_1.Parent = ListFunctionColorPicker
			UIPadding_1.PaddingRight = UDim.new(0,10)

			local ColorpickBar = Instance.new("Frame")
			local UICorner_1 = Instance.new("UICorner")
			local UIStroke_1 = Instance.new("UIStroke")
			local UIPadding_1 = Instance.new("UIPadding")
			local Color_1 = Instance.new("ImageLabel")
			local ColorCorner_1 = Instance.new("UICorner")
			local ColorSelection_1 = Instance.new("ImageLabel")
			local Hue_1 = Instance.new("ImageLabel")
			local HueCorner_1 = Instance.new("UICorner")
			local HueGradient_1 = Instance.new("UIGradient")
			local HueSelection_1 = Instance.new("ImageLabel")

			lak(ColorpickBar)

			ColorpickBar.Name = "ColorpickBar"
			ColorpickBar.Parent = ScreenGui
			ColorpickBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
			ColorpickBar.BorderColor3 = Color3.fromRGB(0,0,0)
			ColorpickBar.BorderSizePixel = 0
			ColorpickBar.Size = UDim2.new(0, 120,0, 0)
			ColorpickBar.ClipsDescendants = true
			local targetX = Picker_1.AbsolutePosition.X - ColorpickBar.Parent.AbsolutePosition.X + Picker_1.Size.X.Offset - 100
			local targetY = Picker_1.AbsolutePosition.Y - ColorpickBar.Parent.AbsolutePosition.Y + Picker_1.Size.Y.Offset - 20
			ColorpickBar.Position = UDim2.new(0, targetX, 0, targetY)

			addToTheme('Function.Color Picker.Color Select.Background', ColorpickBar)

			UICorner_1.Parent = ColorpickBar
			UICorner_1.CornerRadius = UDim.new(0, 6)

			UIStroke_1.Parent = ColorpickBar
			UIStroke_1.Thickness = 1
			UIStroke_1.Transparency = 1
			UIStroke_1.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_1.Transparency = 0.95

			addToTheme('Function.Color Picker.Color Select.UIStroke', UIStroke_1)

			UIPadding_1.Parent = ColorpickBar
			UIPadding_1.PaddingBottom = UDim.new(0,5)
			UIPadding_1.PaddingLeft = UDim.new(0,10)
			UIPadding_1.PaddingRight = UDim.new(0,10)
			UIPadding_1.PaddingTop = UDim.new(0,5)

			Color_1.Name = "Color"
			Color_1.Parent = ColorpickBar
			Color_1.AnchorPoint = Vector2.new(0, 0)
			Color_1.BackgroundColor3 = Color3.fromRGB(39,39,39)
			Color_1.Position = UDim2.new(0, 0,0, 25)
			Color_1.Size = UDim2.new(0, 80,0, 80)
			Color_1.ZIndex = 10
			Color_1.Image = CacheImage("rbxassetid://4155801252")

			ColorCorner_1.Name = "ColorCorner"
			ColorCorner_1.Parent = Color_1
			ColorCorner_1.CornerRadius = UDim.new(0,3)

			ColorSelection_1.Name = "ColorSelection"
			ColorSelection_1.Parent = Color_1
			ColorSelection_1.AnchorPoint = Vector2.new(0.5, 0.5)
			ColorSelection_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			ColorSelection_1.BackgroundTransparency = 1
			ColorSelection_1.Size = UDim2.new(0, 12,0, 12)
			ColorSelection_1.Image = CacheImage("http://www.roblox.com/asset/?id=4805639000")
			ColorSelection_1.ScaleType = Enum.ScaleType.Fit

			Hue_1.Name = "Hue"
			Hue_1.Parent = ColorpickBar
			Hue_1.AnchorPoint = Vector2.new(0, 0)
			Hue_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Hue_1.Position = UDim2.new(0.47, 0,0, 25)
			Hue_1.Size = UDim2.new(0, 10,0, 80)

			HueCorner_1.Name = "HueCorner"
			HueCorner_1.Parent = Hue_1
			HueCorner_1.CornerRadius = UDim.new(1,0)

			HueGradient_1.Name = "HueGradient"
			HueGradient_1.Parent = Hue_1
			HueGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.2, Color3.fromRGB(234, 255, 0)), ColorSequenceKeypoint.new(0.4, Color3.fromRGB(21, 255, 0)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.9, Color3.fromRGB(255, 0, 251)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4))}
			HueGradient_1.Rotation = 270

			HueSelection_1.Name = "HueSelection"
			HueSelection_1.Parent = Hue_1
			HueSelection_1.AnchorPoint = Vector2.new(0.5, 0.5)
			HueSelection_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			HueSelection_1.BackgroundTransparency = 1
			HueSelection_1.Position = UDim2.new(0.5, 0,1, 0)
			HueSelection_1.Size = UDim2.new(0, 12,0, 12)
			HueSelection_1.Image = CacheImage("http://www.roblox.com/asset/?id=4805639000")

			local TitleColorPicker = Instance.new("TextLabel")

			TitleColorPicker.Name = "TitleColorPicker"
			TitleColorPicker.Parent = ColorpickBar
			TitleColorPicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TitleColorPicker.BackgroundTransparency = 1.000
			TitleColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TitleColorPicker.BorderSizePixel = 0
			TitleColorPicker.Size = UDim2.new(1, 0, 0, 27)
			TitleColorPicker.Font = Enum.Font.GothamBold
			TitleColorPicker.Text = Title
			TitleColorPicker.TextColor3 = Color3.fromRGB(0, 0, 0)
			TitleColorPicker.TextSize = 12.000
			TitleColorPicker.TextXAlignment = Enum.TextXAlignment.Left
			TitleColorPicker.TextColor3 = Color3.fromRGB(255, 255, 255)

			addToTheme('Text & Icon', TitleColorPicker)

			local BoxColor = Instance.new("Frame")
			local Hax_1 = Instance.new("Frame")
			local BarValueHax_1 = Instance.new("Frame")
			local UICorner_1 = Instance.new("UICorner")
			local UIStroke_11 = Instance.new("UIStroke")
			local TextLabel_1 = Instance.new("TextBox")
			local TextLabel_2 = Instance.new("TextLabel")
			local UIListLayoutBoxColor_1 = Instance.new("UIListLayout")
			local Red_1 = Instance.new("Frame")
			local BarValueRed_1 = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local UIStroke_2 = Instance.new("UIStroke")
			local TextLabel_3 = Instance.new("TextBox")
			local TextLabel_4 = Instance.new("TextLabel")
			local Green_1 = Instance.new("Frame")
			local BarValueGreen_1 = Instance.new("Frame")
			local UICorner_3 = Instance.new("UICorner")
			local UIStroke_3 = Instance.new("UIStroke")
			local TextLabel_5 = Instance.new("TextBox")
			local TextLabel_6 = Instance.new("TextLabel")
			local Blue_1 = Instance.new("Frame")
			local BarValueBlue_1 = Instance.new("Frame")
			local UICorner_4 = Instance.new("UICorner")
			local UIStroke_4 = Instance.new("UIStroke")
			local TextLabel_7 = Instance.new("TextBox")
			local TextLabel_8 = Instance.new("TextLabel")

			BoxColor.Name = "BoxColor"
			BoxColor.Parent = ColorpickBar
			BoxColor.AnchorPoint = Vector2.new(1, 0)
			BoxColor.BackgroundColor3 = Color3.fromRGB(255,255,255)
			BoxColor.BackgroundTransparency = 1
			BoxColor.BorderColor3 = Color3.fromRGB(0,0,0)
			BoxColor.BorderSizePixel = 0
			BoxColor.Position = UDim2.new(1, 0,0, 25)
			BoxColor.Size = UDim2.new(0, 80,0, 80)

			Hax_1.Name = "Hax"
			Hax_1.Parent = BoxColor
			Hax_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Hax_1.BackgroundTransparency = 1
			Hax_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Hax_1.BorderSizePixel = 0
			Hax_1.Size = UDim2.new(1, 0,0, 21)

			BarValueHax_1.Name = "BarValueHax"
			BarValueHax_1.Parent = Hax_1
			BarValueHax_1.AnchorPoint = Vector2.new(0, 0.5)
			BarValueHax_1.BackgroundColor3 = Color3.fromRGB(217,217,217)
			BarValueHax_1.BackgroundTransparency = 1
			BarValueHax_1.BorderColor3 = Color3.fromRGB(0,0,0)
			BarValueHax_1.BorderSizePixel = 0
			BarValueHax_1.Position = UDim2.new(0, 0,0.5, 0)
			BarValueHax_1.Size = UDim2.new(0.6, 0,0, 15)

			UICorner_1.Parent = BarValueHax_1
			UICorner_1.CornerRadius = UDim.new(1,0)

			UIStroke_11.Parent = BarValueHax_1
			UIStroke_11.Thickness = 1
			UIStroke_11.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_11.Transparency = 0.95

			addToTheme('Function.Color Picker.Color Select.UIStroke', UIStroke_11)

			TextLabel_1.Name = "TextLabel"
			TextLabel_1.Parent = BarValueHax_1
			TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_1.BackgroundTransparency = 1
			TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_1.BorderSizePixel = 0
			TextLabel_1.Size = UDim2.new(1, 0,1, 0)
			TextLabel_1.Font = Enum.Font.Gotham
			TextLabel_1.PlaceholderColor3 = Color3.fromRGB(178,178,178)
			TextLabel_1.PlaceholderText = "#FFFFFF"
			TextLabel_1.Text = "#FFFFFF"
			TextLabel_1.TextSize = 9
			TextLabel_1.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel_1.TextColor3 = Color3.fromRGB(255, 255, 255)

			addToTheme('Text & Icon', TextLabel_1)

			TextLabel_2.Parent = Hax_1
			TextLabel_2.AnchorPoint = Vector2.new(1, 0.5)
			TextLabel_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_2.BackgroundTransparency = 1
			TextLabel_2.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_2.BorderSizePixel = 0
			TextLabel_2.Position = UDim2.new(0.980000019, 0,0.5, 0)
			TextLabel_2.Size = UDim2.new(0, 20,0, 20)
			TextLabel_2.Font = Enum.Font.Gotham
			TextLabel_2.Text = "Hax"
			TextLabel_2.TextSize = 9
			TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)

			addToTheme('Text & Icon', TextLabel_2)

			UIListLayoutBoxColor_1.Name = "UIListLayoutBoxColor"
			UIListLayoutBoxColor_1.Parent = BoxColor
			UIListLayoutBoxColor_1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayoutBoxColor_1.VerticalAlignment = Enum.VerticalAlignment.Center

			Red_1.Name = "Red"
			Red_1.Parent = BoxColor
			Red_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Red_1.BackgroundTransparency = 1
			Red_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Red_1.BorderSizePixel = 0
			Red_1.LayoutOrder = 1
			Red_1.Size = UDim2.new(1, 0,0, 21)

			BarValueRed_1.Name = "BarValueRed"
			BarValueRed_1.Parent = Red_1
			BarValueRed_1.AnchorPoint = Vector2.new(0, 0.5)
			BarValueRed_1.BackgroundColor3 = Color3.fromRGB(217,217,217)
			BarValueRed_1.BackgroundTransparency = 1
			BarValueRed_1.BorderColor3 = Color3.fromRGB(0,0,0)
			BarValueRed_1.BorderSizePixel = 0
			BarValueRed_1.Position = UDim2.new(0, 0,0.5, 0)
			BarValueRed_1.Size = UDim2.new(0.600000024, 0,0, 15)

			UICorner_2.Parent = BarValueRed_1
			UICorner_2.CornerRadius = UDim.new(1,0)

			UIStroke_2.Parent = BarValueRed_1
			UIStroke_2.Thickness = 1
			UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_2.Transparency = 0.95

			addToTheme('Function.Color Picker.Color Select.UIStroke', UIStroke_2)

			TextLabel_3.Name = "TextLabel"
			TextLabel_3.Parent = BarValueRed_1
			TextLabel_3.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_3.BackgroundTransparency = 1
			TextLabel_3.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_3.BorderSizePixel = 0
			TextLabel_3.Size = UDim2.new(1, 0,1, 0)
			TextLabel_3.Font = Enum.Font.Gotham
			TextLabel_3.PlaceholderColor3 = Color3.fromRGB(178,178,178)
			TextLabel_3.PlaceholderText = "255"
			TextLabel_3.Text = "255"
			TextLabel_3.TextSize = 9
			TextLabel_3.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)

			addToTheme('Text & Icon', TextLabel_3)

			TextLabel_4.Parent = Red_1
			TextLabel_4.AnchorPoint = Vector2.new(1, 0.5)
			TextLabel_4.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_4.BackgroundTransparency = 1
			TextLabel_4.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_4.BorderSizePixel = 0
			TextLabel_4.Position = UDim2.new(0.980000019, 0,0.5, 0)
			TextLabel_4.Size = UDim2.new(0, 20,0, 20)
			TextLabel_4.Font = Enum.Font.Gotham
			TextLabel_4.Text = "Red"
			TextLabel_4.TextSize = 9
			TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)

			addToTheme('Text & Icon', TextLabel_4)

			Green_1.Name = "Green"
			Green_1.Parent = BoxColor
			Green_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Green_1.BackgroundTransparency = 1
			Green_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Green_1.BorderSizePixel = 0
			Green_1.LayoutOrder = 2
			Green_1.Size = UDim2.new(1, 0,0, 21)

			BarValueGreen_1.Name = "BarValueGreen"
			BarValueGreen_1.Parent = Green_1
			BarValueGreen_1.AnchorPoint = Vector2.new(0, 0.5)
			BarValueGreen_1.BackgroundColor3 = Color3.fromRGB(217,217,217)
			BarValueGreen_1.BackgroundTransparency = 1
			BarValueGreen_1.BorderColor3 = Color3.fromRGB(0,0,0)
			BarValueGreen_1.BorderSizePixel = 0
			BarValueGreen_1.Position = UDim2.new(0, 0,0.5, 0)
			BarValueGreen_1.Size = UDim2.new(0.600000024, 0,0, 15)

			UICorner_3.Parent = BarValueGreen_1
			UICorner_3.CornerRadius = UDim.new(1,0)

			UIStroke_3.Parent = BarValueGreen_1
			UIStroke_3.Thickness = 1
			UIStroke_3.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_3.Transparency = 0.95

			addToTheme('Function.Color Picker.Color Select.UIStroke', UIStroke_3)

			TextLabel_5.Name = "TextLabel"
			TextLabel_5.Parent = BarValueGreen_1
			TextLabel_5.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_5.BackgroundTransparency = 1
			TextLabel_5.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_5.BorderSizePixel = 0
			TextLabel_5.Size = UDim2.new(1, 0,1, 0)
			TextLabel_5.Font = Enum.Font.Gotham
			TextLabel_5.PlaceholderColor3 = Color3.fromRGB(178,178,178)
			TextLabel_5.PlaceholderText = "255"
			TextLabel_5.Text = "255"
			TextLabel_5.TextSize = 9
			TextLabel_5.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel_5.TextColor3 = Color3.fromRGB(255, 255, 255)

			addToTheme('Text & Icon', TextLabel_5)

			TextLabel_6.Parent = Green_1
			TextLabel_6.AnchorPoint = Vector2.new(1, 0.5)
			TextLabel_6.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_6.BackgroundTransparency = 1
			TextLabel_6.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_6.BorderSizePixel = 0
			TextLabel_6.Position = UDim2.new(0.980000019, 0,0.5, 0)
			TextLabel_6.Size = UDim2.new(0, 20,0, 20)
			TextLabel_6.Font = Enum.Font.Gotham
			TextLabel_6.Text = "Green"
			TextLabel_6.TextSize = 9
			TextLabel_6.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel_6.TextColor3 = Color3.fromRGB(255, 255, 255)

			addToTheme('Text & Icon', TextLabel_6)

			Blue_1.Name = "Blue"
			Blue_1.Parent = BoxColor
			Blue_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Blue_1.BackgroundTransparency = 1
			Blue_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Blue_1.BorderSizePixel = 0
			Blue_1.LayoutOrder = 3
			Blue_1.Size = UDim2.new(1, 0,0, 21)

			BarValueBlue_1.Name = "BarValueBlue"
			BarValueBlue_1.Parent = Blue_1
			BarValueBlue_1.AnchorPoint = Vector2.new(0, 0.5)
			BarValueBlue_1.BackgroundColor3 = Color3.fromRGB(217,217,217)
			BarValueBlue_1.BackgroundTransparency = 1
			BarValueBlue_1.BorderColor3 = Color3.fromRGB(0,0,0)
			BarValueBlue_1.BorderSizePixel = 0
			BarValueBlue_1.Position = UDim2.new(0, 0,0.5, 0)
			BarValueBlue_1.Size = UDim2.new(0.600000024, 0,0, 15)

			UICorner_4.Parent = BarValueBlue_1
			UICorner_4.CornerRadius = UDim.new(1,0)

			UIStroke_4.Parent = BarValueBlue_1
			UIStroke_4.Thickness = 1
			UIStroke_4.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_4.Transparency = 0.95

			addToTheme('Function.Color Picker.Color Select.UIStroke', UIStroke_4)

			TextLabel_7.Name = "TextLabel"
			TextLabel_7.Parent = BarValueBlue_1
			TextLabel_7.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_7.BackgroundTransparency = 1
			TextLabel_7.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_7.BorderSizePixel = 0
			TextLabel_7.Size = UDim2.new(1, 0,1, 0)
			TextLabel_7.Font = Enum.Font.Gotham
			TextLabel_7.PlaceholderColor3 = Color3.fromRGB(178,178,178)
			TextLabel_7.PlaceholderText = "255"
			TextLabel_7.Text = "255"
			TextLabel_7.TextSize = 9
			TextLabel_7.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel_7.TextColor3 = Color3.fromRGB(255, 255, 255)

			addToTheme('Text & Icon', TextLabel_7)

			TextLabel_8.Parent = Blue_1
			TextLabel_8.AnchorPoint = Vector2.new(1, 0.5)
			TextLabel_8.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_8.BackgroundTransparency = 1
			TextLabel_8.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_8.BorderSizePixel = 0
			TextLabel_8.Position = UDim2.new(0.980000019, 0,0.5, 0)
			TextLabel_8.Size = UDim2.new(0, 20,0, 20)
			TextLabel_8.Font = Enum.Font.Gotham
			TextLabel_8.Text = "Blue"
			TextLabel_8.TextSize = 9
			TextLabel_8.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel_8.TextColor3 = Color3.fromRGB(255, 255, 255)

			addToTheme('Text & Icon', TextLabel_8)

			local Shower = Instance.new("Frame")
			local UICornerShow = Instance.new("UICorner")
			local GlowDotShow = Instance.new("ImageLabel")

			Shower.Name = "Shower"
			Shower.Parent = ColorpickBar
			Shower.AnchorPoint = Vector2.new(1, 0)
			Shower.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			Shower.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Shower.BorderSizePixel = 0
			Shower.Position = UDim2.new(1, 0, 0.0500000007, 0)
			Shower.Size = UDim2.new(0, 40, 0, 15)

			UICornerShow.CornerRadius = UDim.new(1, 0)
			UICornerShow.Name = "UICornerShow"
			UICornerShow.Parent = Shower

			GlowDotShow.Name = "GlowDotShow"
			GlowDotShow.Parent = Shower
			GlowDotShow.AnchorPoint = Vector2.new(0.5, 0.5)
			GlowDotShow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			GlowDotShow.BackgroundTransparency = 1.000
			GlowDotShow.BorderColor3 = Color3.fromRGB(0, 0, 0)
			GlowDotShow.BorderSizePixel = 0
			GlowDotShow.Position = UDim2.new(0.5, 0, 0.5, 0)
			GlowDotShow.Size = UDim2.new(1.25, 0, 1.5, 0)
			GlowDotShow.Image = CacheImage("rbxassetid://105506802034513")
			GlowDotShow.ImageColor3 = Color3.fromRGB(255, 0, 0)
			GlowDotShow.ImageTransparency = 0.200

			local Click = click(ColorPicker)
			local ClickColor = click(Color_1)
			local ClickHue = click(Hue_1)
			local isopen = false

			local ColorH, ColorS, ColorV = 1, 1, 1
			local lastColorH = -1
			local ColorInput = nil
			local HueInput = nil
			local Mouse = _Services.Players.LocalPlayer:GetMouse()
			local lastColor = nil
			local ColorInput = nil
			local HueInput = nil
			local isTouchDevice = U.TouchEnabled

			local function open()
				local targetX = Picker_1.AbsolutePosition.X - ColorpickBar.Parent.AbsolutePosition.X + Picker_1.Size.X.Offset - 145
				local targetY = Picker_1.AbsolutePosition.Y - ColorpickBar.Parent.AbsolutePosition.Y + Picker_1.Size.Y.Offset - 50
				tw({v = ColorpickBar, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Size = UDim2.new(0, 200,0, 125), Position = UDim2.new(0, targetX, 0, targetY)}}):Play()
				tw({v = UIStroke_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {Transparency = 0.95}}):Play()
			end
			local function close()
				isopen = false
				tw({v = ColorpickBar, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Size = UDim2.new(0, 200,0, 0)}}):Play()
				tw({v = UIStroke_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {Transparency = 1}}):Play()
			end

			U.InputBegan:Connect(function(A)
				if A.UserInputType == Enum.UserInputType.MouseButton1 or A.UserInputType == Enum.UserInputType.Touch then
					local B, C = ColorpickBar.AbsolutePosition, ColorpickBar.AbsoluteSize
					if _Services.Players.LocalPlayer:GetMouse().X < B.X or _Services.Players.LocalPlayer:GetMouse().X > B.X + C.X or _Services.Players.LocalPlayer:GetMouse().Y < (B.Y - 20 - 1) or _Services.Players.LocalPlayer:GetMouse().Y > B.Y + C.Y then
						close()
					end
				end
			end)

			Click.MouseButton1Click:Connect(function()
				isopen = not isopen
				if isopen then
					open()
				else
					close()
				end
			end)

			local function UpdateColorPicker(nope)
				Picker_1.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
				GlowDot_1.ImageColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
				Color_1.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

				Shower.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
				GlowDotShow.ImageColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)

				local r, g, b = Picker_1.BackgroundColor3.R * 255, Picker_1.BackgroundColor3.G * 255, Picker_1.BackgroundColor3.B * 255

				TextLabel_3.Text = tostring(math.floor(r))
				TextLabel_5.Text = tostring(math.floor(g))
				TextLabel_7.Text = tostring(math.floor(b))

				local hex = string.format("#%02X%02X%02X", math.floor(r), math.floor(g), math.floor(b))
				TextLabel_1.Text = hex

				ColorH, ColorS, ColorV = Color3.toHSV(Picker_1.BackgroundColor3)

				if ColorS ~= 0 and ColorV ~= 0 then
					tw({v = ColorSelection_1, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Position = UDim2.new(ColorS, 0, 1 - ColorV, 0)}}):Play()
				end
				if lastColorH ~= ColorH and ColorS ~= 0 and ColorV ~= 0 and ColorS ~= 255 and ColorV ~= 255 then
					lastColorH = ColorH
					tw({v = HueSelection_1, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Position = UDim2.new(0.5, 0, 1 - ColorH, 0)}}):Play()
				end

				if lastColor ~= Picker_1.BackgroundColor3 then
					lastColor = Picker_1.BackgroundColor3
					pcall(Callback, math.floor(r), math.floor(g), math.floor(b))
				end
			end

			local function HexToRGB(hex)
				if hex:sub(1, 1) == "#" then
					hex = hex:sub(2)
				end

				if #hex == 6 then
					local r = tonumber(hex:sub(1, 2), 16) / 255
					local g = tonumber(hex:sub(3, 4), 16) / 255
					local b = tonumber(hex:sub(5, 6), 16) / 255
					return r, g, b
				else
					return 0, 0, 0
				end
			end

			local function UpdateColorFromText()
				local hex = TextLabel_1.Text:match("^#[%x]+$")
				if hex then
					local r, g, b = HexToRGB(hex)
					r = math.clamp(r, 0, 1)
					g = math.clamp(g, 0, 1)
					b = math.clamp(b, 0, 1)

					local h, s, v = Color3.toHSV(Color3.new(r, g, b))
					ColorH, ColorS, ColorV = h, s, v
					UpdateColorPicker(true)
				else
					local r = tonumber(TextLabel_3.Text) or 0
					local g = tonumber(TextLabel_5.Text) or 0
					local b = tonumber(TextLabel_7.Text) or 0

					r = math.clamp(r, 0, 255) / 255
					g = math.clamp(g, 0, 255) / 255
					b = math.clamp(b, 0, 255) / 255

					local h, s, v = Color3.toHSV(Color3.new(r, g, b))
					ColorH, ColorS, ColorV = h, s, v
					UpdateColorPicker(true)
				end
			end

			TextLabel_3.FocusLost:Connect(UpdateColorFromText)
			TextLabel_5.FocusLost:Connect(UpdateColorFromText)
			TextLabel_7.FocusLost:Connect(UpdateColorFromText)
			TextLabel_1.FocusLost:Connect(UpdateColorFromText)


			ColorH = 1 - (math.clamp(HueSelection_1.AbsolutePosition.Y - Hue_1.AbsolutePosition.Y, 0, Hue_1.AbsoluteSize.Y) / Hue_1.AbsoluteSize.Y)
			ColorS = (math.clamp(ColorSelection_1.AbsolutePosition.X - Color_1.AbsolutePosition.X, 0, Color_1.AbsoluteSize.X) / Color_1.AbsoluteSize.X)
			ColorV = 1 - (math.clamp(ColorSelection_1.AbsolutePosition.Y - Color_1.AbsolutePosition.Y, 0, Color_1.AbsoluteSize.Y) / Color_1.AbsoluteSize.Y)

			Picker_1.BackgroundColor3 = Value
			Color_1.BackgroundColor3 = Value

			ClickColor.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if ColorInput then
						ColorInput:Disconnect()
					end

					ColorInput = _Services.RunService.RenderStepped:Connect(function()
						local ColorX = (math.clamp(Mouse.X - Color_1.AbsolutePosition.X, 0, Color_1.AbsoluteSize.X) /Color_1.AbsoluteSize.X)
						local ColorY = (math.clamp(Mouse.Y - Color_1.AbsolutePosition.Y, 0, Color_1.AbsoluteSize.Y) /Color_1.AbsoluteSize.Y)

						tw({v = ColorSelection_1, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Position = UDim2.new(ColorX, 0, ColorY, 0)}}):Play()
						ColorS = ColorX
						ColorV = 1 - ColorY

						UpdateColorPicker(true)
					end)
				end
			end)

			ClickColor.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if ColorInput then
						ColorInput:Disconnect()
					end
				end
			end)

			ClickHue.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if HueInput then
						HueInput:Disconnect()
					end

					HueInput = _Services.RunService.RenderStepped:Connect(function()
						local HueY = (math.clamp(Mouse.Y - Hue_1.AbsolutePosition.Y, 0, Hue_1.AbsoluteSize.Y) /Hue_1.AbsoluteSize.Y)
						tw({v = HueSelection_1, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Position = UDim2.new(0.5, 0, HueY, 0)}}):Play()
						ColorH = 1 - HueY

						UpdateColorPicker(true)
					end)
				end
			end)

			ClickHue.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if HueInput then
						HueInput:Disconnect()
					end
				end
			end)

			if isTouchDevice then
				Color_1.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Touch then
						if ColorInput then
							ColorInput:Disconnect()
						end

						ColorInput = _Services.RunService.RenderStepped:Connect(function()
							local ColorX = (math.clamp(Mouse.X - Color_1.AbsolutePosition.X, 0, Color_1.AbsoluteSize.X) / Color_1.AbsoluteSize.X)
							local ColorY = (math.clamp(Mouse.Y - Color_1.AbsolutePosition.Y, 0, Color_1.AbsoluteSize.Y) / Color_1.AbsoluteSize.Y)

							ColorSelection_1.Position = UDim2.new(ColorX, 0, ColorY, 0)
							ColorS = ColorX
							ColorV = 1 - ColorY

							UpdateColorPicker(true)
						end)
					end
				end)

				Color_1.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Touch then
						if ColorInput then
							ColorInput:Disconnect()
						end
					end
				end)

				Hue_1.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Touch then
						if HueInput then
							HueInput:Disconnect()
						end

						HueInput = _Services.RunService.RenderStepped:Connect(function()
							local HueY = (math.clamp(Mouse.Y - Hue_1.AbsolutePosition.Y, 0, Hue_1.AbsoluteSize.Y) / Hue_1.AbsoluteSize.Y)

							HueSelection_1.Position = UDim2.new(0.48, 0, HueY, 0)
							ColorH = 1 - HueY

							UpdateColorPicker(true)
						end)
					end
				end)

				Hue_1.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Touch then
						if HueInput then
							HueInput:Disconnect()
						end
					end
				end)
			end

			delay(0,function()
				ColorH, ColorS, ColorV = Color3.toHSV(Picker_1.BackgroundColor3)
				UpdateColorPicker(true)
				local r, g, b = Picker_1.BackgroundColor3.R * 255, Picker_1.BackgroundColor3.G * 255, Picker_1.BackgroundColor3.B * 255
				pcall(Callback, math.floor(r), math.floor(g), math.floor(b))
			end)

			local New = {}

			function New:SetTitle(t)
				Config:SetTitle(t)
			end

			function New:SetDesc(t)
				Config:SetDesc(t)
			end

			function New:SetVisible(t)
				ColorPicker.Visible = t
			end

			function New:SetValue(colorTable)
				local r = colorTable.R or Picker_1.BackgroundColor3.R * 255
				local g = colorTable.G or Picker_1.BackgroundColor3.G * 255
				local b = colorTable.B or Picker_1.BackgroundColor3.B * 255

				if r >= 0 and r <= 255 and g >= 0 and g <= 255 and b >= 0 and b <= 255 then
					local newColor = Color3.fromRGB(r, g, b)

					Picker_1.BackgroundColor3 = newColor
					Color_1.BackgroundColor3 = newColor

					local h, s, v = Color3.toHSV(newColor)
					ColorH, ColorS, ColorV = h, s, v

					ColorSelection_1.Position = UDim2.new(s, 0, 1 - v, 0)
					HueSelection_1.Position = UDim2.new(0.48, 0, 1 - h, 0)
					pcall(Callback, r, g, b)
				end
			end

			return New
		end

		function Func:Textbox(p)
			local Title = p.Title
			local Desc = p.Desc or ''
			local Image = p.Image or ''
			local Value = p.Value or ''
			local Placeholder = p.Placeholder or 'Paste Your Text'
			local ClearText = p.ClearText or p.ClearTextOnFocus or false
			local Callback = p.Callback or function() end

			local Textbox, Config = background(ScrollingFrame_1, Title, Desc, Image, 'Textbox')

			Config:SetTextTransparencyTitle(0)
			Config:SetSizeT(145)

			local F = Instance.new("Frame")
			local UIListLayout_1 = Instance.new("UIListLayout")
			local UIPadding_1 = Instance.new("UIPadding")
			local Frame_1 = Instance.new("Frame")
			local UICorner_1 = Instance.new("UICorner")
			local UIStroke_1 = Instance.new("UIStroke")
			local UIPadding_2 = Instance.new("UIPadding")
			local ImageLabel_1 = Instance.new("ImageLabel")
			local TextLabel_1 = Instance.new("TextBox")
			local Frame_2 = Instance.new("Frame")

			F.Name = "F"
			F.Parent = Textbox
			F.AnchorPoint = Vector2.new(1, 0.5)
			F.BackgroundColor3 = Color3.fromRGB(255,255,255)
			F.BackgroundTransparency = 1
			F.BorderColor3 = Color3.fromRGB(0,0,0)
			F.BorderSizePixel = 0
			F.Position = UDim2.new(1, 0,0.5, 0)
			F.Size = UDim2.new(0, 150,0.800000012, 0)

			UIListLayout_1.Parent = F
			UIListLayout_1.Padding = UDim.new(0,15)
			UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Right
			UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

			UIPadding_1.Parent = F
			UIPadding_1.PaddingRight = UDim.new(0,13)

			Frame_1.Parent = F
			Frame_1.BackgroundColor3 = Color3.fromRGB(18,18,18)
			Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_1.BorderSizePixel = 0
			Frame_1.Size = UDim2.new(0, 130,0, 25)

			addToTheme('Function.Textbox.Value Background', Frame_1)

			UICorner_1.Parent = Frame_1
			UICorner_1.CornerRadius = UDim.new(0,4)

			UIStroke_1.Parent = Frame_1
			UIStroke_1.Color = Color3.fromRGB(255,255,255)
			UIStroke_1.Thickness = 1
			UIStroke_1.Transparency = 0.95

			addToTheme('Function.Textbox.Value Stroke', UIStroke_1)

			UIPadding_2.Parent = Frame_1
			UIPadding_2.PaddingLeft = UDim.new(0,5)
			UIPadding_2.PaddingRight = UDim.new(0,5)

			ImageLabel_1.Parent = Frame_1
			ImageLabel_1.AnchorPoint = Vector2.new(1, 0.5)
			ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			ImageLabel_1.BackgroundTransparency = 1
			ImageLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
			ImageLabel_1.BorderSizePixel = 0
			ImageLabel_1.Position = UDim2.new(1, 0,0.5, 0)
			ImageLabel_1.Size = UDim2.new(0, 15,0, 15)
			ImageLabel_1.Image = CacheImage("rbxassetid://13868675087")
			ImageLabel_1.ImageTransparency = 0.30000001192092896

			addToTheme('Text & Value', ImageLabel_1)

			TextLabel_1.Name = "TextLabel"
			TextLabel_1.Parent = Frame_1
			TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
			TextLabel_1.BackgroundTransparency = 1
			TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
			TextLabel_1.BorderSizePixel = 0
			TextLabel_1.Size = UDim2.new(0.800000012, 0,1, 0)
			TextLabel_1.Font = Enum.Font.GothamBold
			TextLabel_1.PlaceholderColor3 = Color3.fromRGB(178,178,178)
			TextLabel_1.PlaceholderText = Placeholder
			TextLabel_1.RichText = true
			TextLabel_1.Text = Value
			TextLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
			TextLabel_1.TextSize = 10
			TextLabel_1.TextTransparency = 0.30000001192092896
			TextLabel_1.TextWrapped = true
			TextLabel_1.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel_1.ClearTextOnFocus = not ClearText

			addToTheme('Text & Value', TextLabel_1)

			Frame_2.Parent = Frame_1
			Frame_2.AnchorPoint = Vector2.new(0.5, 1)
			Frame_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
			Frame_2.BackgroundTransparency = 0.949999988079071
			Frame_2.BorderColor3 = Color3.fromRGB(0,0,0)
			Frame_2.BorderSizePixel = 0
			Frame_2.Position = UDim2.new(0.5, 0,1, 0)
			Frame_2.Size = UDim2.new(1.05, 0,0, 2)

			local function o()
				if #TextLabel_1.Text > 0 then
					pcall(Callback, TextLabel_1.Text)
				end
			end

			TextLabel_1.FocusLost:Connect(o)

			delay(0, o)

			local New = {}

			function New:SetTitle(t)
				Config:SetTitle(t)
			end

			function New:SetDesc(t)
				Config:SetDesc(t)
			end

			function New:SetVisible(t)
				Textbox.Visible = t
			end

			function New:SetValue(t)
				TextLabel_1.Text = t
			end

			function New:SetClearTextOnFocus(t)
				TextLabel_1.ClearTextOnFocus = not t
			end

			function New:SetPlaceholderText(t)
				TextLabel_1.PlaceholderText = t
			end

			return New
		end

		function Func:Image()
			local ImageLogo = Instance.new("ImageLabel")
			local SecondImage = Instance.new("ImageLabel")
			local UICorner_1 = Instance.new("UICorner")
			local UICorner_2 = Instance.new("UICorner")
			
			ImageLogo.Name = "Im"
			ImageLogo.Parent = ScrollingFrame_1
			ImageLogo.AnchorPoint = Vector2.new(0.5,0.5)
			ImageLogo.Position = UDim2.new(0.5,0,0.5,0)
			ImageLogo.BackgroundTransparency = 1
			ImageLogo.Size = UDim2.new(1, 0, 0, 180)
			ImageLogo.Image = CacheImage('rbxassetid://111362591084511')
			ImageLogo.ScaleType = Enum.ScaleType.Crop
			
			UICorner_1.Parent = ImageLogo
			UICorner_1.CornerRadius = UDim.new(0, 8) -- เธเธญเธเธกเธ 8

			-- Overlay for crossfade
			SecondImage.Name = "ImOverlay"
			SecondImage.Parent = ImageLogo
			SecondImage.BackgroundTransparency = 1
			SecondImage.Size = UDim2.new(1, 0, 1, 0)
			SecondImage.Image = ''
			SecondImage.ScaleType = Enum.ScaleType.Crop
			SecondImage.ImageTransparency = 1
			
			UICorner_2.Parent = SecondImage
			UICorner_2.CornerRadius = UDim.new(0, 8)

			local New = {}

			function New:SetImage(img, doFade)
				if doFade then
					SecondImage.Image = img
					SecondImage.ImageTransparency = 1
					local t = tw({
						v = SecondImage, 
						t = 0.5, 
						s = Enum.EasingStyle.Quad, 
						d = "InOut", 
						g = {ImageTransparency = 0}
					})
					t:Play()
					task.wait(0.5)
					ImageLogo.Image = img
					SecondImage.ImageTransparency = 1
				else
					ImageLogo.Image = img
				end
			end

			function New:SetVisible(t)
				ImageLogo.Visible = t
			end

			return New
		end

		return Func
	end

	local Notification = Instance.new("Frame")
	local UIPaddingUIListLayoutNotification_1 = Instance.new("UIPadding")
	local UIListLayoutNotification_1 = Instance.new("UIListLayout")

	Notification.Name = "Notification"
	Notification.Parent = ScreenGui
	Notification.AnchorPoint = Vector2.new(1, 1)
	Notification.BackgroundColor3 = Color3.fromRGB(255,255,255)
	Notification.BackgroundTransparency = 1
Notification.BorderColor3 = Color3.fromRGB(0,0,0)
	Notification.BorderSizePixel = 0
	Notification.Position = UDim2.new(1, 0,1, 0)
	Notification.Size = UDim2.new(0, 100,0, 100)

	UIPaddingUIListLayoutNotification_1.Parent = Notification
	UIPaddingUIListLayoutNotification_1.PaddingBottom = UDim.new(0,20)
	UIPaddingUIListLayoutNotification_1.PaddingRight = UDim.new(0,5)

	UIListLayoutNotification_1.Parent = Notification
	UIListLayoutNotification_1.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayoutNotification_1.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayoutNotification_1.VerticalAlignment = Enum.VerticalAlignment.Bottom

	function Tabs:Notify(p)
		Tabs.Notification = Tabs.Notify
		local Title = p.Title or 'Notification'
		local Desc = p.Desc or ''
		local Time = p.Time or 5

		local Shadow = Instance.new("ImageLabel")
		local UIPadding_1 = Instance.new("UIPadding")
		local Background_1 = Instance.new("CanvasGroup")
		local UICorner_1 = Instance.new("UICorner")
		local Frame_1 = Instance.new("Frame")
		
		local ContentContainer = Instance.new("Frame")
		local UIListLayout_Content = Instance.new("UIListLayout")
		local IconImg = Instance.new("ImageLabel")
		local Text_1 = Instance.new("Frame")
		local Title_1 = Instance.new("TextLabel")
		local UIListLayout_1 = Instance.new("UIListLayout")
		local Description_1 = Instance.new("TextLabel")

		Shadow.Name = "Shadow"
		Shadow.Parent = Notification
		Shadow.BackgroundColor3 = Color3.fromRGB(163,162,165)
		Shadow.BackgroundTransparency = 1
		Shadow.Size = UDim2.new(0, 240,0, 0)
		Shadow.Image = CacheImage("rbxassetid://1316045217")
		Shadow.ImageColor3 = themes[IsTheme].Shadow
		Shadow.ImageTransparency = 0.5
		Shadow.ScaleType = Enum.ScaleType.Slice
		Shadow.SliceCenter = Rect.new(10, 10, 118, 118)

		addToTheme('Shadow', Shadow)

		UIPadding_1.Parent = Shadow
		UIPadding_1.PaddingBottom = UDim.new(0,5)
		UIPadding_1.PaddingLeft = UDim.new(0,5)
		UIPadding_1.PaddingRight = UDim.new(0,5)
		UIPadding_1.PaddingTop = UDim.new(0,5)

		Background_1.Name = "Background"
		Background_1.Parent = Shadow
		Background_1.AnchorPoint = Vector2.new(0.5, 0.5)
		Background_1.BackgroundColor3 = themes[IsTheme].Background
		Background_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Background_1.BorderSizePixel = 0
		Background_1.Position = UDim2.new(0.5, 0,0.5, 0)
		Background_1.Size = UDim2.new(1, 0,1, 0)
		Background_1.ClipsDescendants = true
		Background_1.GroupTransparency = 1

		addToTheme('Background', Background_1)

		UICorner_1.Parent = Background_1
		UICorner_1.CornerRadius = UDim.new(0,8)

		Frame_1.Parent = Background_1
		Frame_1.AnchorPoint = Vector2.new(0, 1)
		Frame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Frame_1.BackgroundTransparency = 0.85
		Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Frame_1.BorderSizePixel = 0
		Frame_1.Position = UDim2.new(0, 0,1, 0)
		Frame_1.Size = UDim2.new(1, 0,0, 4)
		
		ContentContainer.Name = "ContentContainer"
		ContentContainer.Parent = Background_1
		ContentContainer.BackgroundTransparency = 1
		ContentContainer.Size = UDim2.new(1, -24, 1, -24)
		ContentContainer.Position = UDim2.new(0, 12, 0, 12)
		
		UIListLayout_Content.Parent = ContentContainer
		UIListLayout_Content.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_Content.Padding = UDim.new(0, 12)
		UIListLayout_Content.VerticalAlignment = Enum.VerticalAlignment.Center
		
		IconImg.Name = "Icon"
		IconImg.Parent = ContentContainer
		IconImg.BackgroundTransparency = 1
		IconImg.Size = UDim2.new(0, 28, 0, 28)
		if p.Icon then
			IconImg.Image = CacheImage(type(p.Icon) == "number" and "rbxassetid://"..p.Icon or p.Icon)
			addToTheme('Text & Icon', IconImg)
		else
			IconImg.Image = Icon_1.Image
			IconImg.ImageRectSize = Icon_1.ImageRectSize
			IconImg.ImageRectOffset = Icon_1.ImageRectOffset
			IconImg.ImageColor3 = Color3.fromRGB(255,255,255)
		end
		
		Text_1.Name = "Text"
		Text_1.Parent = ContentContainer
		Text_1.BackgroundTransparency = 1
		Text_1.Size = UDim2.new(1, -40, 1, 0)

		Title_1.Name = "Title"
		Title_1.Parent = Text_1
		Title_1.AutomaticSize = Enum.AutomaticSize.Y
		Title_1.BackgroundTransparency = 1
		Title_1.Size = UDim2.new(1, 0,0, 0)
		Title_1.Font = Enum.Font.GothamBold
		Title_1.Text = tostring(Title)
		Title_1.TextColor3 = themes[IsTheme]['Text & Icon']
		Title_1.TextSize = 14
		Title_1.TextWrapped = true
		Title_1.RichText = true
		Title_1.TextXAlignment = Enum.TextXAlignment.Left
		Title_1.TextYAlignment = Enum.TextYAlignment.Top

		addToTheme('Text & Icon', Title_1)

		UIListLayout_1.Parent = Text_1
		UIListLayout_1.Padding = UDim.new(0,4)
		UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

		Description_1.Name = "Description"
		Description_1.Parent = Text_1
		Description_1.AutomaticSize = Enum.AutomaticSize.Y
		Description_1.BackgroundTransparency = 1
		Description_1.LayoutOrder = 2
		Description_1.Size = UDim2.new(1, 0,0, 0)
		Description_1.Font = Enum.Font.Gotham
		Description_1.Text = tostring(Desc)
		Description_1.TextColor3 = themes[IsTheme]['Text & Icon']
		Description_1.TextSize = 12
		Description_1.TextTransparency = 0.4
		Description_1.TextWrapped = true
		Description_1.RichText = true
		Description_1.TextXAlignment = Enum.TextXAlignment.Left
		Description_1.TextYAlignment = Enum.TextYAlignment.Top
		
		if Desc == "" then
			Description_1.Visible = false
		end

		addToTheme('Text & Icon', Description_1)

		Background_1.Size = UDim2.new(1, 0,1, 0) - UDim2.fromOffset(5, 5)

		if Desc and Desc ~= '' then
			Description_1.Visible = true
		end

		local function updateSize()
			task.defer(function()
				local newSize = math.max(28, UIListLayout_1.AbsoluteContentSize.Y) + 32
				if Shadow.Size.Y.Offset ~= newSize then
					Shadow.Size = UDim2.new(0, 240, 0, newSize)
				end
			end)
		end

		delay(.1, updateSize)

		UIListLayout_1:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)

		local g = tw({
			v = Shadow,
			t = 0.15,
			s = Enum.EasingStyle.Exponential,
			d = "InOut",
			g = {
				Size = UDim2.new(0, 180,0, 55)
			}
		})
		g:Play()
		g.Completed:Wait()
		tw({
			v = Background_1,
			t = 0.15,
			s = Enum.EasingStyle.Linear,
			d = "InOut",
			g = {
				Size = UDim2.new(1, 0,1, 0),
				GroupTransparency = 0.3
			}
		}):Play()

		task.spawn(function()
			for i = Time, 1, -1 do
				tw({v = Frame_1, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Size = UDim2.new(i / Time, 0,0, 4)}}):Play()
				task.wait(1)
			end
			local f = tw({
				v = Background_1,
				t = 0.15,
				s = Enum.EasingStyle.Linear,
				d = "InOut",
				g = {
					Size = UDim2.new(1, 0,1, 0) - UDim2.fromOffset(5, 5),
					GroupTransparency = 1
				}
			})
			f:Play()
			f.Completed:Connect(function()
				Shadow.ImageTransparency = 1
				local g = tw({
					v = Shadow,
					t = 0.15,
					s = Enum.EasingStyle.Exponential,
					d = "InOut",
					g = {
						Size = UDim2.new(0, 180,0, 0)
					}
				})
				g:Play()
				g.Completed:Connect(function()
					Shadow:Destroy()
				end)
			end)
		end)
	end

	function Tabs:Dialog(p)
		if Shadow_1:FindFirstChild('Dialog') then
			return
		end
		local Button1 = p.Button1.Callback or function() end
		local Button2 = p.Button2.Callback or function() end
		local Title = p.Title or 'null'
		local TitleButton1 = p.Button1.Title or 'null'
		local TitleButton2 = p.Button2.Title or 'null'
		local Color1 = p.Button1.Color or Color3.fromRGB(0, 188, 0)
		local Color2 = p.Button2.Color or Color3.fromRGB(226, 39, 6)

		local Dialog = Instance.new("CanvasGroup")
		local UICorner_1 = Instance.new("UICorner")
		local Frame_1 = Instance.new("Frame")
		local TextLabel_1 = Instance.new("TextLabel")
		local UIListLayout_1 = Instance.new("UIListLayout")
		local Frame_2 = Instance.new("Frame")
		local Button1_1 = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIGradient_1 = Instance.new("UIGradient")
		local UIStroke_1 = Instance.new("UIStroke")
		local UIGradient_2 = Instance.new("UIGradient")
		local TextLabel_2 = Instance.new("TextLabel")
		local UIStroke_2 = Instance.new("UIStroke")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local Button2_1 = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local UIGradient_3 = Instance.new("UIGradient")
		local UIStroke_3 = Instance.new("UIStroke")
		local UIGradient_4 = Instance.new("UIGradient")
		local TextLabel_3 = Instance.new("TextLabel")
		local UIStroke_4 = Instance.new("UIStroke")

		Dialog.Name = "Dialog"
		Dialog.Parent = Shadow_1
		Dialog.BackgroundColor3 = Color3.fromRGB(0,0,0)
		Dialog.BackgroundTransparency = 0.3
		Dialog.BorderColor3 = Color3.fromRGB(0,0,0)
		Dialog.BorderSizePixel = 0
		Dialog.Size = UDim2.new(1, 0,1, 0)
		Dialog.GroupTransparency = 1

		UICorner_1.Parent = Dialog
		UICorner_1.CornerRadius = UDim.new(0,17)

		Frame_1.Parent = Dialog
		Frame_1.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Frame_1.BackgroundTransparency = 1
		Frame_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Frame_1.BorderSizePixel = 0
		Frame_1.Position = UDim2.new(0.5, 0,0.5, 0)
		Frame_1.Size = UDim2.new(0, 100,0, 100)

		TextLabel_1.Parent = Frame_1
		TextLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		TextLabel_1.BackgroundTransparency = 1
		TextLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
		TextLabel_1.BorderSizePixel = 0
		TextLabel_1.Size = UDim2.new(0, 200,0, 30)
		TextLabel_1.Font = Enum.Font.GothamBold
		TextLabel_1.RichText = true
		TextLabel_1.Text = tostring(Title)
		TextLabel_1.TextColor3 = Color3.fromRGB(255,255,255)
		TextLabel_1.TextSize = 20

		UIListLayout_1.Parent = Frame_1
		UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center

		Frame_2.Parent = Frame_1
		Frame_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Frame_2.BackgroundTransparency = 1
		Frame_2.BorderColor3 = Color3.fromRGB(0,0,0)
		Frame_2.BorderSizePixel = 0
		Frame_2.LayoutOrder = 1
		Frame_2.Size = UDim2.new(0, 100,0, 50)

		Button1_1.Name = "Button1"
		Button1_1.Parent = Frame_2
		Button1_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Button1_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Button1_1.BorderSizePixel = 0
		Button1_1.Size = UDim2.new(0, 130,0, 40)

		UICorner_2.Parent = Button1_1
		UICorner_2.CornerRadius = UDim.new(1,0)

		UIGradient_1.Parent = Button1_1
		UIGradient_1.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(124, 124, 124))}

		UIStroke_1.Parent = Button1_1
		UIStroke_1.Color = Color3.fromRGB(255,255,255)
		UIStroke_1.Thickness = 2

		UIGradient_2.Parent = UIStroke_1
		UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(124, 124, 124))}
		UIGradient_2.Rotation = 180

		TextLabel_2.Parent = Button1_1
		TextLabel_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
		TextLabel_2.BackgroundTransparency = 1
		TextLabel_2.BorderColor3 = Color3.fromRGB(0,0,0)
		TextLabel_2.BorderSizePixel = 0
		TextLabel_2.Size = UDim2.new(1, 0,1, 0)
		TextLabel_2.Font = Enum.Font.GothamBold
		TextLabel_2.Text = TitleButton1
		TextLabel_2.TextColor3 = Color1
		TextLabel_2.TextSize = 16

		UIStroke_2.Parent = TextLabel_2
		UIStroke_2.Thickness = 1
		UIStroke_2.Transparency = 0.95

		UIListLayout_2.Parent = Frame_2
		UIListLayout_2.Padding = UDim.new(0,10)
		UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center

		Button2_1.Name = "Button2"
		Button2_1.Parent = Frame_2
		Button2_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Button2_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Button2_1.BorderSizePixel = 0
		Button2_1.Size = UDim2.new(0, 130,0, 40)

		UICorner_3.Parent = Button2_1
		UICorner_3.CornerRadius = UDim.new(1,0)

		UIGradient_3.Parent = Button2_1
		UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(124, 124, 124))}

		UIStroke_3.Parent = Button2_1
		UIStroke_3.Color = Color3.fromRGB(255,255,255)
		UIStroke_3.Thickness = 2

		UIGradient_4.Parent = UIStroke_3
		UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(124, 124, 124))}
		UIGradient_4.Rotation = 180

		TextLabel_3.Parent = Button2_1
		TextLabel_3.BackgroundColor3 = Color3.fromRGB(255,255,255)
		TextLabel_3.BackgroundTransparency = 1
		TextLabel_3.BorderColor3 = Color3.fromRGB(0,0,0)
		TextLabel_3.BorderSizePixel = 0
		TextLabel_3.Size = UDim2.new(1, 0,1, 0)
		TextLabel_3.Font = Enum.Font.GothamBold
		TextLabel_3.Text = TitleButton2
		TextLabel_3.TextColor3 = Color2
		TextLabel_3.TextSize = 16

		UIStroke_4.Parent = TextLabel_3
		UIStroke_4.Thickness = 1
		UIStroke_4.Transparency = 0.95

		tw({v = Dialog, t = 0.25, s = Enum.EasingStyle.Linear, d = "Out", g = {GroupTransparency = 0}}):Play()
		local Click1 = click(Button1_1)
		local Click2 = click(Button2_1)
		Click1.MouseButton1Click:Connect(function()
			pcall(Button1)
			tw({v = TextLabel_2, t = 0.15, s = Enum.EasingStyle.Back, d = "Out", g = {TextSize = TextLabel_2.TextSize - 2}}):Play()
			delay(.06, function()
				tw({v = TextLabel_2, t = 0.15, s = Enum.EasingStyle.Back, d = "Out", g = {TextSize = 16}}):Play()
			end)
			local f = tw({v = Dialog, t = 0.25, s = Enum.EasingStyle.Linear, d = "Out", g = {GroupTransparency = 1}})
			f:Play()
			f.Completed:Wait()
			Dialog:Destroy()
		end)

		Click2.MouseButton1Click:Connect(function()
			pcall(Button2)
			tw({v = TextLabel_3, t = 0.15, s = Enum.EasingStyle.Back, d = "Out", g = {TextSize = TextLabel_3.TextSize - 2}}):Play()
			delay(.06, function()
				tw({v = TextLabel_3, t = 0.15, s = Enum.EasingStyle.Back, d = "Out", g = {TextSize = 16}}):Play()
			end)
			local f = tw({v = Dialog, t = 0.25, s = Enum.EasingStyle.Linear, d = "Out", g = {GroupTransparency = 1}})
			f:Play()
			f.Completed:Wait()
			Dialog:Destroy()
		end)
	end

	-- ==============================================================================
	-- // macOS NSSavePanel - Save Dialog Component
	-- ==============================================================================
	function Tabs:SavePanel(p)
		p = p or {}
		local DefaultName = p.DefaultName or p.Name or "Untitled"
		local DefaultFolder = p.Where or p.Folder or "HYPER_Configs"
		local Folders = type(p.Where) == "table" and p.Where or {DefaultFolder}
		local Formats = p.Formats or p.AllowedFormats or {"JSON (*.json)", "Lua (*.lua)", "Text (*.txt)", "Config (*.cfg)"}
		if type(Formats) == "string" then Formats = {Formats} end
		local DefaultFormat = p.DefaultFormat or Formats[1] or "JSON (*.json)"
		local DataToSave = p.Data or p.Content or nil
		local AutoWrite = (p.AutoWrite ~= false)
		local OnSave = p.OnSave or p.Callback or function() end
		local OnCancel = p.OnCancel or function() end
		local isExpanded = (p.Expanded == true)

		-- Ensure default folder exists on disk if executor supports makefolder
		if _makefolder and _isfolder and not _isfolder(DefaultFolder) then
			pcall(function() _makefolder(DefaultFolder) end)
		end

		local selectedFolder = DefaultFolder
		local selectedFormat = DefaultFormat

		local function getExtension(fmt)
			local ext = fmt:match("%*%.([%w_]+)") or fmt:match("%.([%w_]+)") or fmt:match("([%w_]+)$") or "json"
			return "." .. ext
		end

		local function getCleanFormatLabel(fmt)
			return fmt:match("^([^(]+)") and fmt:match("^([^(]+)"):gsub("%s+$", "") or fmt
		end

		-- Check if a SavePanel already exists to prevent duplicates
		local existingPanel = ScreenGui:FindFirstChild("HYPER_SavePanelOverlay")
		if existingPanel then
			existingPanel:Destroy()
		end

		local SavePanelOverlay = Instance.new("TextButton")
		local PanelShadow = Instance.new("ImageLabel")
		local PanelShadowPadding = Instance.new("UIPadding")
		local PanelCard = Instance.new("CanvasGroup")
		local PanelCorner = Instance.new("UICorner")
		local PanelStroke = Instance.new("UIStroke")

		SavePanelOverlay.Name = "HYPER_SavePanelOverlay"
		SavePanelOverlay.Parent = ScreenGui
		SavePanelOverlay.AutoButtonColor = false
		SavePanelOverlay.Text = ""
		SavePanelOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		SavePanelOverlay.BackgroundTransparency = 1
		SavePanelOverlay.BorderSizePixel = 0
		SavePanelOverlay.Size = UDim2.new(1, 0, 1, 0)
		SavePanelOverlay.Position = UDim2.new(0, 0, 0, 0)
		SavePanelOverlay.ZIndex = 250

		PanelShadow.Name = "PanelShadow"
		PanelShadow.Parent = SavePanelOverlay
		PanelShadow.AnchorPoint = Vector2.new(0.5, 0.5)
		PanelShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
		local compactH = 158
		local expandedH = 338
		local currentH = isExpanded and expandedH or compactH
		PanelShadow.Size = UDim2.new(0, 420, 0, currentH + 20)
		PanelShadow.BackgroundTransparency = 1
		PanelShadow.Image = CacheImage("rbxassetid://1316045217")
		PanelShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		PanelShadow.ImageTransparency = 0.35
		PanelShadow.ScaleType = Enum.ScaleType.Slice
		PanelShadow.SliceCenter = Rect.new(10, 10, 118, 118)
		PanelShadow.ZIndex = 251

		PanelShadowPadding.Parent = PanelShadow
		PanelShadowPadding.PaddingTop = UDim.new(0, 10)
		PanelShadowPadding.PaddingBottom = UDim.new(0, 10)
		PanelShadowPadding.PaddingLeft = UDim.new(0, 10)
		PanelShadowPadding.PaddingRight = UDim.new(0, 10)

		PanelCard.Name = "PanelCard"
		PanelCard.Parent = PanelShadow
		PanelCard.Size = UDim2.new(1, 0, 1, 0)
		PanelCard.BackgroundColor3 = Color3.fromRGB(30, 31, 36)
		PanelCard.BorderSizePixel = 0
		PanelCard.GroupTransparency = 1
		PanelCard.ClipsDescendants = true
		PanelCard.ZIndex = 252

		PanelCorner.CornerRadius = UDim.new(0, 12)
		PanelCorner.Parent = PanelCard

		PanelStroke.Parent = PanelCard
		PanelStroke.Color = Color3.fromRGB(255, 255, 255)
		PanelStroke.Transparency = 0.88
		PanelStroke.Thickness = 1

		-- Top Section (Doc Icon, Save As, Where)
		local TopSection = Instance.new("Frame")
		TopSection.Name = "TopSection"
		TopSection.Parent = PanelCard
		TopSection.BackgroundTransparency = 1
		TopSection.Position = UDim2.new(0, 0, 0, 0)
		TopSection.Size = UDim2.new(1, 0, 0, 95)
		TopSection.ZIndex = 253

		-- File/Doc Icon
		local DocIconCard = Instance.new("Frame")
		local DocIconCorner = Instance.new("UICorner")
		local DocIconStroke = Instance.new("UIStroke")
		local DocIconImg = Instance.new("ImageLabel")

		DocIconCard.Name = "DocIconCard"
		DocIconCard.Parent = TopSection
		DocIconCard.Position = UDim2.new(0, 18, 0, 18)
		DocIconCard.Size = UDim2.new(0, 42, 0, 52)
		DocIconCard.BackgroundColor3 = Color3.fromRGB(40, 42, 50)
		DocIconCard.BorderSizePixel = 0

		DocIconCorner.CornerRadius = UDim.new(0, 6)
		DocIconCorner.Parent = DocIconCard

		DocIconStroke.Color = Color3.fromRGB(255, 255, 255)
		DocIconStroke.Transparency = 0.86
		DocIconStroke.Thickness = 1
		DocIconStroke.Parent = DocIconCard

		DocIconImg.Name = "DocIconImg"
		DocIconImg.Parent = DocIconCard
		DocIconImg.AnchorPoint = Vector2.new(0.5, 0.5)
		DocIconImg.Position = UDim2.new(0.5, 0, 0.5, 0)
		DocIconImg.Size = UDim2.new(0, 24, 0, 24)
		DocIconImg.BackgroundTransparency = 1
		local docResolved = gl("file-text")
		DocIconImg.Image = docResolved.Image
		DocIconImg.ImageRectSize = docResolved.ImageRectSize
		DocIconImg.ImageRectOffset = docResolved.ImageRectPosition
		DocIconImg.ImageColor3 = Color3.fromRGB(150, 175, 215)

		-- Form Inputs Container
		local FormContainer = Instance.new("Frame")
		FormContainer.Name = "FormContainer"
		FormContainer.Parent = TopSection
		FormContainer.BackgroundTransparency = 1
		FormContainer.Position = UDim2.new(0, 72, 0, 15)
		FormContainer.Size = UDim2.new(1, -90, 0, 70)

		-- Row 1: Save As
		local RowSaveAs = Instance.new("Frame")
		RowSaveAs.Name = "RowSaveAs"
		RowSaveAs.Parent = FormContainer
		RowSaveAs.BackgroundTransparency = 1
		RowSaveAs.Position = UDim2.new(0, 0, 0, 0)
		RowSaveAs.Size = UDim2.new(1, 0, 0, 28)

		local LabelSaveAs = Instance.new("TextLabel")
		LabelSaveAs.Name = "LabelSaveAs"
		LabelSaveAs.Parent = RowSaveAs
		LabelSaveAs.BackgroundTransparency = 1
		LabelSaveAs.Position = UDim2.new(0, 0, 0, 0)
		LabelSaveAs.Size = UDim2.new(0, 60, 1, 0)
		LabelSaveAs.Font = Enum.Font.GothamMedium
		LabelSaveAs.Text = "Save As:"
		LabelSaveAs.TextColor3 = Color3.fromRGB(190, 192, 200)
		LabelSaveAs.TextSize = 12
		LabelSaveAs.TextXAlignment = Enum.TextXAlignment.Right

		local InputContainer = Instance.new("Frame")
		local InputCorner = Instance.new("UICorner")
		local InputStroke = Instance.new("UIStroke")
		local NameTextBox = Instance.new("TextBox")

		InputContainer.Name = "InputContainer"
		InputContainer.Parent = RowSaveAs
		InputContainer.Position = UDim2.new(0, 68, 0, 1)
		InputContainer.Size = UDim2.new(1, -102, 0, 26)
		InputContainer.BackgroundColor3 = Color3.fromRGB(44, 46, 54)
		InputContainer.BorderSizePixel = 0

		InputCorner.CornerRadius = UDim.new(0, 6)
		InputCorner.Parent = InputContainer

		InputStroke.Color = Color3.fromRGB(255, 255, 255)
		InputStroke.Transparency = 0.86
		InputStroke.Thickness = 1
		InputStroke.Parent = InputContainer

		NameTextBox.Name = "NameTextBox"
		NameTextBox.Parent = InputContainer
		NameTextBox.BackgroundTransparency = 1
		NameTextBox.Position = UDim2.new(0, 8, 0, 0)
		NameTextBox.Size = UDim2.new(1, -16, 1, 0)
		NameTextBox.Font = Enum.Font.GothamMedium
		NameTextBox.Text = DefaultName
		NameTextBox.PlaceholderText = "Untitled"
		NameTextBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 140)
		NameTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		NameTextBox.TextSize = 12
		NameTextBox.TextXAlignment = Enum.TextXAlignment.Left
		NameTextBox.ClearTextOnFocus = false

		NameTextBox.Focused:Connect(function()
			tw({v = InputStroke, t = 0.2, s = Enum.EasingStyle.Quad, d = "Out", g = {Color = Color3.fromRGB(0, 122, 255), Transparency = 0.3}}):Play()
		end)
		NameTextBox.FocusLost:Connect(function()
			tw({v = InputStroke, t = 0.2, s = Enum.EasingStyle.Quad, d = "Out", g = {Color = Color3.fromRGB(255, 255, 255), Transparency = 0.86}}):Play()
		end)

		-- Disclosure Button [ v ]
		local DisclosureBtn = Instance.new("ImageButton")
		local DisclosureCorner = Instance.new("UICorner")
		local DisclosureStroke = Instance.new("UIStroke")
		local DisclosureChevron = Instance.new("ImageLabel")

		DisclosureBtn.Name = "DisclosureBtn"
		DisclosureBtn.Parent = RowSaveAs
		DisclosureBtn.AnchorPoint = Vector2.new(1, 0)
		DisclosureBtn.Position = UDim2.new(1, 0, 0, 1)
		DisclosureBtn.Size = UDim2.new(0, 26, 0, 26)
		DisclosureBtn.BackgroundColor3 = Color3.fromRGB(44, 46, 54)
		DisclosureBtn.BorderSizePixel = 0
		DisclosureBtn.AutoButtonColor = false

		DisclosureCorner.CornerRadius = UDim.new(0, 6)
		DisclosureCorner.Parent = DisclosureBtn

		DisclosureStroke.Color = Color3.fromRGB(255, 255, 255)
		DisclosureStroke.Transparency = 0.86
		DisclosureStroke.Thickness = 1
		DisclosureStroke.Parent = DisclosureBtn

		DisclosureChevron.Name = "Chevron"
		DisclosureChevron.Parent = DisclosureBtn
		DisclosureChevron.AnchorPoint = Vector2.new(0.5, 0.5)
		DisclosureChevron.Position = UDim2.new(0.5, 0, 0.5, 0)
		DisclosureChevron.Size = UDim2.new(0, 13, 0, 13)
		DisclosureChevron.BackgroundTransparency = 1
		local chevResolved = gl("chevron-down")
		DisclosureChevron.Image = chevResolved.Image
		DisclosureChevron.ImageRectSize = chevResolved.ImageRectSize
		DisclosureChevron.ImageRectOffset = chevResolved.ImageRectPosition
		DisclosureChevron.ImageColor3 = Color3.fromRGB(180, 182, 190)
		DisclosureChevron.Rotation = isExpanded and 180 or 0

		-- Row 2: Where
		local RowWhere = Instance.new("Frame")
		RowWhere.Name = "RowWhere"
		RowWhere.Parent = FormContainer
		RowWhere.BackgroundTransparency = 1
		RowWhere.Position = UDim2.new(0, 0, 0, 36)
		RowWhere.Size = UDim2.new(1, 0, 0, 28)

		local LabelWhere = Instance.new("TextLabel")
		LabelWhere.Name = "LabelWhere"
		LabelWhere.Parent = RowWhere
		LabelWhere.BackgroundTransparency = 1
		LabelWhere.Position = UDim2.new(0, 0, 0, 0)
		LabelWhere.Size = UDim2.new(0, 60, 1, 0)
		LabelWhere.Font = Enum.Font.GothamMedium
		LabelWhere.Text = "Where:"
		LabelWhere.TextColor3 = Color3.fromRGB(190, 192, 200)
		LabelWhere.TextSize = 12
		LabelWhere.TextXAlignment = Enum.TextXAlignment.Right

		local WhereBtn = Instance.new("TextButton")
		local WhereCorner = Instance.new("UICorner")
		local WhereStroke = Instance.new("UIStroke")
		local WhereFolderIcon = Instance.new("ImageLabel")
		local WhereLabel = Instance.new("TextLabel")
		local WhereCaret = Instance.new("TextLabel")

		WhereBtn.Name = "WhereBtn"
		WhereBtn.Parent = RowWhere
		WhereBtn.Position = UDim2.new(0, 68, 0, 1)
		WhereBtn.Size = UDim2.new(1, -68, 0, 26)
		WhereBtn.BackgroundColor3 = Color3.fromRGB(44, 46, 54)
		WhereBtn.BorderSizePixel = 0
		WhereBtn.AutoButtonColor = false
		WhereBtn.Text = ""

		WhereCorner.CornerRadius = UDim.new(0, 6)
		WhereCorner.Parent = WhereBtn

		WhereStroke.Color = Color3.fromRGB(255, 255, 255)
		WhereStroke.Transparency = 0.86
		WhereStroke.Thickness = 1
		WhereStroke.Parent = WhereBtn

		WhereFolderIcon.Name = "FolderIcon"
		WhereFolderIcon.Parent = WhereBtn
		WhereFolderIcon.Position = UDim2.new(0, 7, 0.5, -7)
		WhereFolderIcon.Size = UDim2.new(0, 14, 0, 14)
		WhereFolderIcon.BackgroundTransparency = 1
		local folderRes = gl("folder")
		WhereFolderIcon.Image = folderRes.Image
		WhereFolderIcon.ImageRectSize = folderRes.ImageRectSize
		WhereFolderIcon.ImageRectOffset = folderRes.ImageRectPosition
		WhereFolderIcon.ImageColor3 = Color3.fromRGB(255, 205, 85)

		WhereLabel.Name = "FolderLabel"
		WhereLabel.Parent = WhereBtn
		WhereLabel.BackgroundTransparency = 1
		WhereLabel.Position = UDim2.new(0, 26, 0, 0)
		WhereLabel.Size = UDim2.new(1, -45, 1, 0)
		WhereLabel.Font = Enum.Font.GothamMedium
		WhereLabel.Text = selectedFolder
		WhereLabel.TextColor3 = Color3.fromRGB(235, 235, 240)
		WhereLabel.TextSize = 12
		WhereLabel.TextXAlignment = Enum.TextXAlignment.Left

		WhereCaret.Name = "Caret"
		WhereCaret.Parent = WhereBtn
		WhereCaret.AnchorPoint = Vector2.new(1, 0.5)
		WhereCaret.Position = UDim2.new(1, -8, 0.5, 0)
		WhereCaret.Size = UDim2.new(0, 10, 1, 0)
		WhereCaret.BackgroundTransparency = 1
		WhereCaret.Font = Enum.Font.Gotham
		WhereCaret.Text = "▾"
		WhereCaret.TextColor3 = Color3.fromRGB(160, 160, 170)
		WhereCaret.TextSize = 11

		-- Middle Section (File Browser)
		local BrowserSection = Instance.new("Frame")
		local BrowserCorner = Instance.new("UICorner")
		local BrowserStroke = Instance.new("UIStroke")
		local BrowserHeader = Instance.new("Frame")
		local SearchBoxContainer = Instance.new("Frame")
		local SearchBoxCorner = Instance.new("UICorner")
		local SearchIcon = Instance.new("ImageLabel")
		local SearchInput = Instance.new("TextBox")
		local FileListScroll = Instance.new("ScrollingFrame")
		local FileListLayout = Instance.new("UIListLayout")
		local FileListPadding = Instance.new("UIPadding")

		BrowserSection.Name = "BrowserSection"
		BrowserSection.Parent = PanelCard
		BrowserSection.Position = UDim2.new(0, 18, 0, 95)
		BrowserSection.Size = UDim2.new(1, -36, 0, 180)
		BrowserSection.BackgroundColor3 = Color3.fromRGB(23, 24, 28)
		BrowserSection.BorderSizePixel = 0
		BrowserSection.Visible = isExpanded
		BrowserSection.ClipsDescendants = true

		BrowserCorner.CornerRadius = UDim.new(0, 8)
		BrowserCorner.Parent = BrowserSection

		BrowserStroke.Color = Color3.fromRGB(255, 255, 255)
		BrowserStroke.Transparency = 0.9
		BrowserStroke.Thickness = 1
		BrowserStroke.Parent = BrowserSection

		BrowserHeader.Name = "BrowserHeader"
		BrowserHeader.Parent = BrowserSection
		BrowserHeader.BackgroundTransparency = 1
		BrowserHeader.Position = UDim2.new(0, 8, 0, 6)
		BrowserHeader.Size = UDim2.new(1, -16, 0, 24)

		SearchBoxContainer.Name = "SearchBox"
		SearchBoxContainer.Parent = BrowserHeader
		SearchBoxContainer.Size = UDim2.new(1, 0, 1, 0)
		SearchBoxContainer.BackgroundColor3 = Color3.fromRGB(34, 35, 42)
		SearchBoxContainer.BorderSizePixel = 0

		SearchBoxCorner.CornerRadius = UDim.new(0, 5)
		SearchBoxCorner.Parent = SearchBoxContainer

		SearchIcon.Name = "SearchIcon"
		SearchIcon.Parent = SearchBoxContainer
		SearchIcon.Position = UDim2.new(0, 6, 0.5, -6)
		SearchIcon.Size = UDim2.new(0, 12, 0, 12)
		SearchIcon.BackgroundTransparency = 1
		local searchRes = gl("search")
		SearchIcon.Image = searchRes.Image
		SearchIcon.ImageRectSize = searchRes.ImageRectSize
		SearchIcon.ImageRectOffset = searchRes.ImageRectPosition
		SearchIcon.ImageColor3 = Color3.fromRGB(140, 142, 150)

		SearchInput.Name = "SearchInput"
		SearchInput.Parent = SearchBoxContainer
		SearchInput.BackgroundTransparency = 1
		SearchInput.Position = UDim2.new(0, 24, 0, 0)
		SearchInput.Size = UDim2.new(1, -28, 1, 0)
		SearchInput.Font = Enum.Font.Gotham
		SearchInput.PlaceholderText = "Search files in folder..."
		SearchInput.PlaceholderColor3 = Color3.fromRGB(110, 112, 120)
		SearchInput.Text = ""
		SearchInput.TextColor3 = Color3.fromRGB(225, 225, 230)
		SearchInput.TextSize = 11
		SearchInput.TextXAlignment = Enum.TextXAlignment.Left

		FileListScroll.Name = "FileListScroll"
		FileListScroll.Parent = BrowserSection
		FileListScroll.Position = UDim2.new(0, 0, 0, 34)
		FileListScroll.Size = UDim2.new(1, 0, 1, -38)
		FileListScroll.BackgroundTransparency = 1
		FileListScroll.BorderSizePixel = 0
		FileListScroll.ScrollBarThickness = 3
		FileListScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 102, 112)
		FileListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

		FileListLayout.Parent = FileListScroll
		FileListLayout.Padding = UDim.new(0, 2)
		FileListLayout.SortOrder = Enum.SortOrder.Name

		FileListPadding.Parent = FileListScroll
		FileListPadding.PaddingLeft = UDim.new(0, 8)
		FileListPadding.PaddingRight = UDim.new(0, 8)
		FileListPadding.PaddingTop = UDim.new(0, 2)
		FileListPadding.PaddingBottom = UDim.new(0, 4)

		FileListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			FileListScroll.CanvasSize = UDim2.new(0, 0, 0, FileListLayout.AbsoluteContentSize.Y + 6)
		end)

		-- Refresh File List in Browser
		local function refreshFileList(filterQuery)
			filterQuery = string.lower(filterQuery or "")
			for _, item in ipairs(FileListScroll:GetChildren()) do
				if item:IsA("Frame") or item:IsA("TextButton") then
					item:Destroy()
				end
			end

			local files = {}
			if p.ExistingFiles and type(p.ExistingFiles) == "table" then
				for _, f in ipairs(p.ExistingFiles) do table.insert(files, f) end
			else
				pcall(function()
					if _listfiles then
						local list = _listfiles(selectedFolder) or {}
						for _, filePath in ipairs(list) do
							local fname = filePath:match("([^/\\]+)$")
							if fname then table.insert(files, fname) end
						end
					end
				end)
			end

			local count = 0
			for _, fname in ipairs(files) do
				if filterQuery == "" or string.lower(fname):find(filterQuery, 1, true) then
					count = count + 1
					local row = Instance.new("TextButton")
					local rowCorner = Instance.new("UICorner")
					local rowIcon = Instance.new("ImageLabel")
					local rowName = Instance.new("TextLabel")

					row.Name = fname
					row.Parent = FileListScroll
					row.Size = UDim2.new(1, 0, 0, 24)
					row.BackgroundColor3 = Color3.fromRGB(34, 35, 42)
					row.BackgroundTransparency = 1
					row.BorderSizePixel = 0
					row.AutoButtonColor = false
					row.Text = ""

					rowCorner.CornerRadius = UDim.new(0, 4)
					rowCorner.Parent = row

					rowIcon.Name = "Icon"
					rowIcon.Parent = row
					rowIcon.Position = UDim2.new(0, 6, 0.5, -6)
					rowIcon.Size = UDim2.new(0, 12, 0, 12)
					rowIcon.BackgroundTransparency = 1
					local fileRes = gl("file")
					rowIcon.Image = fileRes.Image
					rowIcon.ImageRectSize = fileRes.ImageRectSize
					rowIcon.ImageRectOffset = fileRes.ImageRectPosition
					rowIcon.ImageColor3 = Color3.fromRGB(150, 165, 195)

					rowName.Name = "Name"
					rowName.Parent = row
					rowName.BackgroundTransparency = 1
					rowName.Position = UDim2.new(0, 24, 0, 0)
					rowName.Size = UDim2.new(1, -30, 1, 0)
					rowName.Font = Enum.Font.Gotham
					rowName.Text = fname
					rowName.TextColor3 = Color3.fromRGB(220, 220, 225)
					rowName.TextSize = 11
					rowName.TextXAlignment = Enum.TextXAlignment.Left

					row.MouseEnter:Connect(function()
						tw({v = row, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0.4}}):Play()
					end)
					row.MouseLeave:Connect(function()
						tw({v = row, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 1}}):Play()
					end)
					row.MouseButton1Click:Connect(function()
						local cleanBase = fname:gsub("%.%w+$", "")
						NameTextBox.Text = cleanBase
						tw({v = row, t = 0.1, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0.1}}):Play()
						delay(0.15, function()
							tw({v = row, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 1}}):Play()
						end)
					end)
				end
			end

			if count == 0 then
				local emptyLbl = Instance.new("TextLabel")
				emptyLbl.Name = "EmptyLabel"
				emptyLbl.Parent = FileListScroll
				emptyLbl.BackgroundTransparency = 1
				emptyLbl.Size = UDim2.new(1, 0, 0, 30)
				emptyLbl.Font = Enum.Font.Gotham
				emptyLbl.Text = (filterQuery == "" and "No files in " .. selectedFolder or "No matching files")
				emptyLbl.TextColor3 = Color3.fromRGB(130, 130, 140)
				emptyLbl.TextSize = 11
				emptyLbl.TextXAlignment = Enum.TextXAlignment.Center
			end
		end

		SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
			refreshFileList(SearchInput.Text)
		end)

		-- Bottom Section (Format Dropdown & Cancel / Save Buttons)
		local BottomSection = Instance.new("Frame")
		BottomSection.Name = "BottomSection"
		BottomSection.Parent = PanelCard
		BottomSection.AnchorPoint = Vector2.new(0, 1)
		BottomSection.Position = UDim2.new(0, 18, 1, -14)
		BottomSection.Size = UDim2.new(1, -36, 0, 30)
		BottomSection.BackgroundTransparency = 1

		-- Format Label & Button
		local FormatContainer = Instance.new("Frame")
		FormatContainer.Name = "FormatContainer"
		FormatContainer.Parent = BottomSection
		FormatContainer.BackgroundTransparency = 1
		FormatContainer.Position = UDim2.new(0, 0, 0, 0)
		FormatContainer.Size = UDim2.new(0, 170, 1, 0)

		local FormatLabel = Instance.new("TextLabel")
		FormatLabel.Name = "FormatLabel"
		FormatLabel.Parent = FormatContainer
		FormatLabel.BackgroundTransparency = 1
		FormatLabel.Position = UDim2.new(0, 0, 0, 0)
		FormatLabel.Size = UDim2.new(0, 52, 1, 0)
		FormatLabel.Font = Enum.Font.GothamMedium
		FormatLabel.Text = "Format:"
		FormatLabel.TextColor3 = Color3.fromRGB(190, 192, 200)
		FormatLabel.TextSize = 12
		FormatLabel.TextXAlignment = Enum.TextXAlignment.Left

		local FormatBtn = Instance.new("TextButton")
		local FormatCorner = Instance.new("UICorner")
		local FormatStroke = Instance.new("UIStroke")
		local FormatBtnLabel = Instance.new("TextLabel")
		local FormatBtnCaret = Instance.new("TextLabel")

		FormatBtn.Name = "FormatBtn"
		FormatBtn.Parent = FormatContainer
		FormatBtn.Position = UDim2.new(0, 56, 0, 1)
		FormatBtn.Size = UDim2.new(1, -56, 0, 26)
		FormatBtn.BackgroundColor3 = Color3.fromRGB(44, 46, 54)
		FormatBtn.BorderSizePixel = 0
		FormatBtn.AutoButtonColor = false
		FormatBtn.Text = ""

		FormatCorner.CornerRadius = UDim.new(0, 6)
		FormatCorner.Parent = FormatBtn

		FormatStroke.Color = Color3.fromRGB(255, 255, 255)
		FormatStroke.Transparency = 0.86
		FormatStroke.Thickness = 1
		FormatStroke.Parent = FormatBtn

		FormatBtnLabel.Name = "FormatBtnLabel"
		FormatBtnLabel.Parent = FormatBtn
		FormatBtnLabel.BackgroundTransparency = 1
		FormatBtnLabel.Position = UDim2.new(0, 8, 0, 0)
		FormatBtnLabel.Size = UDim2.new(1, -26, 1, 0)
		FormatBtnLabel.Font = Enum.Font.GothamMedium
		FormatBtnLabel.Text = getCleanFormatLabel(selectedFormat)
		FormatBtnLabel.TextColor3 = Color3.fromRGB(235, 235, 240)
		FormatBtnLabel.TextSize = 12
		FormatBtnLabel.TextXAlignment = Enum.TextXAlignment.Left

		FormatBtnCaret.Name = "Caret"
		FormatBtnCaret.Parent = FormatBtn
		FormatBtnCaret.AnchorPoint = Vector2.new(1, 0.5)
		FormatBtnCaret.Position = UDim2.new(1, -6, 0.5, 0)
		FormatBtnCaret.Size = UDim2.new(0, 10, 1, 0)
		FormatBtnCaret.BackgroundTransparency = 1
		FormatBtnCaret.Font = Enum.Font.Gotham
		FormatBtnCaret.Text = "▾"
		FormatBtnCaret.TextColor3 = Color3.fromRGB(160, 160, 170)
		FormatBtnCaret.TextSize = 11

		-- Buttons: Cancel & Save
		local ButtonGroup = Instance.new("Frame")
		local ButtonLayout = Instance.new("UIListLayout")
		local CancelBtn = Instance.new("TextButton")
		local CancelCorner = Instance.new("UICorner")
		local CancelStroke = Instance.new("UIStroke")
		local SaveBtn = Instance.new("TextButton")
		local SaveCorner = Instance.new("UICorner")

		ButtonGroup.Name = "ButtonGroup"
		ButtonGroup.Parent = BottomSection
		ButtonGroup.AnchorPoint = Vector2.new(1, 0)
		ButtonGroup.Position = UDim2.new(1, 0, 0, 0)
		ButtonGroup.Size = UDim2.new(0, 160, 1, 0)
		ButtonGroup.BackgroundTransparency = 1

		ButtonLayout.Parent = ButtonGroup
		ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
		ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		ButtonLayout.Padding = UDim.new(0, 8)
		ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Center

		CancelBtn.Name = "CancelBtn"
		CancelBtn.Parent = ButtonGroup
		CancelBtn.LayoutOrder = 1
		CancelBtn.Size = UDim2.new(0, 72, 0, 28)
		CancelBtn.BackgroundColor3 = Color3.fromRGB(54, 55, 63)
		CancelBtn.BorderSizePixel = 0
		CancelBtn.AutoButtonColor = false
		CancelBtn.Font = Enum.Font.GothamMedium
		CancelBtn.Text = "Cancel"
		CancelBtn.TextColor3 = Color3.fromRGB(225, 225, 230)
		CancelBtn.TextSize = 12

		CancelCorner.CornerRadius = UDim.new(0, 6)
		CancelCorner.Parent = CancelBtn

		CancelStroke.Color = Color3.fromRGB(255, 255, 255)
		CancelStroke.Transparency = 0.88
		CancelStroke.Thickness = 1
		CancelStroke.Parent = CancelBtn

		CancelBtn.MouseEnter:Connect(function()
			tw({v = CancelBtn, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundColor3 = Color3.fromRGB(66, 68, 78)}}):Play()
		end)
		CancelBtn.MouseLeave:Connect(function()
			tw({v = CancelBtn, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundColor3 = Color3.fromRGB(54, 55, 63)}}):Play()
		end)

		SaveBtn.Name = "SaveBtn"
		SaveBtn.Parent = ButtonGroup
		SaveBtn.LayoutOrder = 2
		SaveBtn.Size = UDim2.new(0, 76, 0, 28)
		SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
		SaveBtn.BorderSizePixel = 0
		SaveBtn.AutoButtonColor = false
		SaveBtn.Font = Enum.Font.GothamBold
		SaveBtn.Text = "Save"
		SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		SaveBtn.TextSize = 12

		SaveCorner.CornerRadius = UDim.new(0, 6)
		SaveCorner.Parent = SaveBtn

		SaveBtn.MouseEnter:Connect(function()
			tw({v = SaveBtn, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundColor3 = Color3.fromRGB(26, 140, 255)}}):Play()
		end)
		SaveBtn.MouseLeave:Connect(function()
			tw({v = SaveBtn, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundColor3 = Color3.fromRGB(0, 122, 255)}}):Play()
		end)

		-- Toggle Expand / Collapse
		local function setExpanded(expanded)
			isExpanded = expanded
			local targetH = isExpanded and expandedH or compactH
			tw({v = DisclosureChevron, t = 0.25, s = Enum.EasingStyle.Quad, d = "Out", g = {Rotation = isExpanded and 180 or 0}}):Play()
			tw({v = PanelShadow, t = 0.25, s = Enum.EasingStyle.Exponential, d = "Out", g = {Size = UDim2.new(0, 420, 0, targetH + 20)}}):Play()
			if isExpanded then
				BrowserSection.Visible = true
				refreshFileList(SearchInput.Text)
			else
				delay(0.2, function()
					if not isExpanded then BrowserSection.Visible = false end
				end)
			end
		end

		DisclosureBtn.MouseButton1Click:Connect(function()
			setExpanded(not isExpanded)
		end)

		-- Popover Menu Helper (For Format and Where selection)
		local currentPopover = nil
		local function closePopover()
			if currentPopover then
				currentPopover:Destroy()
				currentPopover = nil
			end
		end

		local function openPopover(parentBtn, items, onSelect)
			closePopover()
			local popover = Instance.new("Frame")
			local popCorner = Instance.new("UICorner")
			local popStroke = Instance.new("UIStroke")
			local popLayout = Instance.new("UIListLayout")
			local popPadding = Instance.new("UIPadding")

			popover.Name = "PopoverMenu"
			popover.Parent = PanelCard
			popover.BackgroundColor3 = Color3.fromRGB(36, 38, 46)
			popover.BorderSizePixel = 0
			popover.ZIndex = 260
			popover.Size = UDim2.new(0, parentBtn.AbsoluteSize.X, 0, #items * 26 + 10)

			local parentPos = parentBtn.AbsolutePosition - PanelCard.AbsolutePosition
			local yPos = parentPos.Y + parentBtn.AbsoluteSize.Y + 4
			if yPos + popover.Size.Y.Offset > PanelCard.AbsoluteSize.Y then
				yPos = parentPos.Y - popover.Size.Y.Offset - 4
			end
			popover.Position = UDim2.new(0, parentPos.X, 0, yPos)

			popCorner.CornerRadius = UDim.new(0, 6)
			popCorner.Parent = popover

			popStroke.Color = Color3.fromRGB(255, 255, 255)
			popStroke.Transparency = 0.85
			popStroke.Thickness = 1
			popStroke.Parent = popover

			popLayout.Parent = popover
			popLayout.Padding = UDim.new(0, 2)
			popLayout.SortOrder = Enum.SortOrder.LayoutOrder

			popPadding.Parent = popover
			popPadding.PaddingTop = UDim.new(0, 4)
			popPadding.PaddingBottom = UDim.new(0, 4)
			popPadding.PaddingLeft = UDim.new(0, 4)
			popPadding.PaddingRight = UDim.new(0, 4)

			for idx, item in ipairs(items) do
				local optBtn = Instance.new("TextButton")
				local optCorner = Instance.new("UICorner")

				optBtn.Name = "Option_" .. tostring(idx)
				optBtn.Parent = popover
				optBtn.Size = UDim2.new(1, 0, 0, 24)
				optBtn.BackgroundColor3 = Color3.fromRGB(48, 50, 60)
				optBtn.BackgroundTransparency = 1
				optBtn.BorderSizePixel = 0
				optBtn.AutoButtonColor = false
				optBtn.Font = Enum.Font.GothamMedium
				optBtn.Text = "  " .. tostring(item)
				optBtn.TextColor3 = Color3.fromRGB(220, 220, 225)
				optBtn.TextSize = 11
				optBtn.TextXAlignment = Enum.TextXAlignment.Left

				optCorner.CornerRadius = UDim.new(0, 4)
				optCorner.Parent = optBtn

				optBtn.MouseEnter:Connect(function()
					tw({v = optBtn, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0}}):Play()
				end)
				optBtn.MouseLeave:Connect(function()
					tw({v = optBtn, t = 0.15, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 1}}):Play()
				end)
				optBtn.MouseButton1Click:Connect(function()
					closePopover()
					onSelect(item)
				end)
			end
			currentPopover = popover
		end

		WhereBtn.MouseButton1Click:Connect(function()
			if #Folders > 1 then
				openPopover(WhereBtn, Folders, function(folder)
					selectedFolder = folder
					WhereLabel.Text = folder
					if isExpanded then refreshFileList(SearchInput.Text) end
				end)
			end
		end)

		FormatBtn.MouseButton1Click:Connect(function()
			openPopover(FormatBtn, Formats, function(fmt)
				selectedFormat = fmt
				FormatBtnLabel.Text = getCleanFormatLabel(fmt)
			end)
		end)

		-- Close animation helper
		local isClosing = false
		local function dismissModal(saved)
			if isClosing then return end
			isClosing = true
			closePopover()
			tw({v = SavePanelOverlay, t = 0.2, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 1}}):Play()
			local closeTw = tw({v = PanelCard, t = 0.2, s = Enum.EasingStyle.Quad, d = "Out", g = {GroupTransparency = 1}})
			closeTw:Play()
			closeTw.Completed:Connect(function()
				SavePanelOverlay:Destroy()
			end)
		end

		CancelBtn.MouseButton1Click:Connect(function()
			pcall(OnCancel)
			dismissModal(false)
		end)

		SaveBtn.MouseButton1Click:Connect(function()
			local rawName = NameTextBox.Text
			local cleanName = rawName:gsub("[%\\/%:%*%?%\"%<%>%|]", ""):gsub("^%s+", ""):gsub("%s+$", "")
			if cleanName == "" then
				-- Trigger shake / warning animation on input box
				tw({v = InputStroke, t = 0.1, s = Enum.EasingStyle.Quad, d = "Out", g = {Color = Color3.fromRGB(255, 60, 60), Transparency = 0}}):Play()
				local origPos = InputContainer.Position
				tw({v = InputContainer, t = 0.05, s = Enum.EasingStyle.Sine, d = "InOut", g = {Position = origPos + UDim2.new(0, 4, 0, 0)}}):Play()
				delay(0.05, function()
					tw({v = InputContainer, t = 0.05, s = Enum.EasingStyle.Sine, d = "InOut", g = {Position = origPos - UDim2.new(0, 4, 0, 0)}}):Play()
					delay(0.05, function()
						tw({v = InputContainer, t = 0.05, s = Enum.EasingStyle.Sine, d = "InOut", g = {Position = origPos}}):Play()
						delay(0.3, function()
							tw({v = InputStroke, t = 0.2, s = Enum.EasingStyle.Quad, d = "Out", g = {Color = Color3.fromRGB(255, 255, 255), Transparency = 0.86}}):Play()
						end)
					end)
				end)
				return
			end

			-- Append extension if missing
			local ext = getExtension(selectedFormat)
			local finalFilename = cleanName
			if not finalFilename:lower():find("%" .. ext:lower() .. "$") then
				finalFilename = finalFilename .. ext
			end

			local fullPath = selectedFolder .. "/" .. finalFilename

			-- Auto write to disk if enabled and supported
			if AutoWrite and _writefile and DataToSave ~= nil then
				pcall(function()
					if _makefolder and _isfolder and not _isfolder(selectedFolder) then
						_makefolder(selectedFolder)
					end
					local content = DataToSave
					if type(content) == "table" then
						local okJson, jsonStr = pcall(function() return _Services.HttpService:JSONEncode(content) end)
						if okJson and jsonStr then content = jsonStr else content = tostring(content) end
					end
					_writefile(fullPath, tostring(content))
				end)
			end

			-- Trigger success notification
			pcall(function()
				Tabs:Notify({
					Title = "Saved Successfully",
					Desc = finalFilename .. " saved to " .. selectedFolder,
					Icon = "check",
					Time = 3
				})
			end)

			-- Invoke OnSave callback
			pcall(function()
				OnSave({
					Name = finalFilename,
					BaseName = cleanName,
					Format = selectedFormat,
					Extension = ext,
					Folder = selectedFolder,
					FullPath = fullPath,
					Data = DataToSave
				})
			end)

			dismissModal(true)
		end)

		-- Entrance animation
		tw({v = SavePanelOverlay, t = 0.25, s = Enum.EasingStyle.Quad, d = "Out", g = {BackgroundTransparency = 0.5}}):Play()
		tw({v = PanelCard, t = 0.25, s = Enum.EasingStyle.Quad, d = "Out", g = {GroupTransparency = 0}}):Play()
		if isExpanded then
			refreshFileList(SearchInput.Text)
		end

		return {
			Overlay = SavePanelOverlay,
			Card = PanelCard,
			Close = function() dismissModal(false) end,
			SetExpanded = setExpanded
		}
	end

	Tabs.PromptSave = Tabs.SavePanel

	do
		local ReopenBreadcrumb, ReopenBreadcrumbEnabled -- เนเธซเนเธเธธเนเธก breadcrumb (CloseUIButton) เธเธนเธเธชเธ–เธฒเธเธฐเน€เธเธดเธ”/เธเธดเธ”เนเธ”เน
		local Size_1 = Instance.new("TextButton")

		Size_1.Name = "Size"
		Size_1.Parent = Background_1
		Size_1.Active = true
		Size_1.AnchorPoint = Vector2.new(1, 1)
		Size_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		Size_1.BackgroundTransparency = 1
		Size_1.BorderColor3 = Color3.fromRGB(0,0,0)
		Size_1.BorderSizePixel = 0
		Size_1.Position = UDim2.new(1, 0,1, 0)
		Size_1.Size = UDim2.new(0, 20,0, 20)
		Size_1.Font = Enum.Font.SourceSans
		Size_1.Text = ""
		Size_1.TextSize = 14

		local SizeFrame = Instance.new("Frame")
		local ImageLabel_1 = Instance.new("ImageLabel")
		local UICorner_1 = Instance.new("UICorner")

		SizeFrame.Name = "SizeFrame"
		SizeFrame.Parent = Background_1
		SizeFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
		SizeFrame.BackgroundTransparency = 1
		SizeFrame.BorderColor3 = Color3.fromRGB(0,0,0)
		SizeFrame.BorderSizePixel = 0
		SizeFrame.Size = UDim2.new(1, 0,1, 0)

		ImageLabel_1.Parent = SizeFrame
		ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255,255,255)
		ImageLabel_1.BackgroundTransparency = 1
		ImageLabel_1.BorderColor3 = Color3.fromRGB(0,0,0)
		ImageLabel_1.BorderSizePixel = 0
		ImageLabel_1.Position = UDim2.new(0.5, 0,0.5, 0)
		ImageLabel_1.Size = UDim2.new(0, 100,0, 100)
		ImageLabel_1.Image = Icon_1.Image
		ImageLabel_1.ImageTransparency = 1

		UICorner_1.Parent = SizeFrame
		UICorner_1.CornerRadius = UDim.new(0,17)

		Size_1.MouseButton1Down:Connect(function()
			R = true
		end)

		local isZ = false
		local originalSize, originalPosition

		Minisize_1.MouseButton1Click:Connect(function()
			if not isZ then
				originalSize = Shadow_1.Size
				originalPosition = Shadow_1.Position
				tw({v = Shadow_1, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0, 0, 0, 0)
				}}):Play()
				Minisize_1.Image = CacheImage("rbxassetid://13857981896")
			else
				Minisize_1.Image = Icon_1.Image
				tw({v = Shadow_1, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {
					Size = originalSize,
					Position = originalPosition
				}}):Play()
			end
			isZ = not isZ
		end)

		if not HAA then
			local AP, PAZ = Shadow_1.AbsolutePosition, Shadow_1.Parent.AbsoluteSize
			local NP = UDim2.new((AP.X / PAZ.X),
				Shadow_1.Position.X.Offset,
				(AP.Y / PAZ.Y),
				Shadow_1.Position.Y.Offset)

			Shadow_1.AnchorPoint = Vector2.new(0, 0)
			Shadow_1.Position = NP
			HAA = true
		end

		U.InputEnded:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				R = false
				tw({v = SizeFrame, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {BackgroundTransparency = 1}}):Play()
				tw({v = ImageLabel_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {ImageTransparency = 1}}):Play()
			end
		end)

		U.InputChanged:Connect(function(i)
			if not isZ and R and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
				local nW = math.max(450, i.Position.X - Shadow_1.AbsolutePosition.X)
				local nH = math.max(220, i.Position.Y - Shadow_1.AbsolutePosition.Y)
				local nZ = UDim2.new(0, nW, 0, nH)
				tw({v = Shadow_1, t = 0.05, s = Enum.EasingStyle.Exponential, d = "Out", g = {Size = nZ}}):Play()
				tw({v = SizeFrame, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {BackgroundTransparency = 0.6}}):Play()
				tw({v = ImageLabel_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {ImageTransparency = 0}}):Play()
				ImageLabel_1.Image = Icon_1.Image	
			elseif isZ and R and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
				tw({v = SizeFrame, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {BackgroundTransparency = 0.6}}):Play()
				tw({v = ImageLabel_1, t = 0.15, s = Enum.EasingStyle.Linear, d = "Out", g = {ImageTransparency = 0}}):Play()
				ImageLabel_1.Image = CacheImage('rbxassetid://14906268026')
			end
		end)

		lak(Topbar_1, Shadow_1)

		local isopen = false
		local firsttime = false
		local oSize
		local uiTweening = false
		local function closeui()
			if uiTweening then return end
			uiTweening = true
			task.delay(0.4, function() uiTweening = false end)
			
			isopen = not isopen
			if isopen then
				oSize = Background_1.Size
				local close = tw({
					v = Background_1,
					t = 0.15,
					s = Enum.EasingStyle.Linear,
					d = "InOut",
					g = {
						GroupTransparency = 1,
						Size = oSize - UDim2.fromOffset(5, 5)
					}
				})
				close:Play()
				close.Completed:Wait()
				Shadow_1.Visible = false
				
				-- Hide any open dropdowns when the main UI closes
				if ScreenGui then
					for _, child in ipairs(ScreenGui:GetChildren()) do
						if child.Name == "XinzDropdown" and child.Visible then
							child.Visible = false
						end
					end
				end
			else
				Shadow_1.Visible = true  
				local open = tw({
					v = Background_1,
					t = 0.15,
					s = Enum.EasingStyle.Linear,
					d = "InOut",
					g = {
						GroupTransparency = 0,
						Size = oSize
					}
				})
				open:Play()
			end

			if ReopenBreadcrumb then
				if isopen and ReopenBreadcrumbEnabled then
					ReopenBreadcrumb.Visible = true
					local targetPos = ReopenBreadcrumb.Position
					local startPos
					if CrumbOrientation == "Bottom" then
						startPos = UDim2.new(targetPos.X.Scale, targetPos.X.Offset, targetPos.Y.Scale, targetPos.Y.Offset + 50)
					elseif CrumbOrientation == "Top" then
						startPos = UDim2.new(targetPos.X.Scale, targetPos.X.Offset, targetPos.Y.Scale, targetPos.Y.Offset - 50)
					elseif CrumbOrientation == "Left" then
						startPos = UDim2.new(targetPos.X.Scale, targetPos.X.Offset - 50, targetPos.Y.Scale, targetPos.Y.Offset)
					elseif CrumbOrientation == "Right" then
						startPos = UDim2.new(targetPos.X.Scale, targetPos.X.Offset + 50, targetPos.Y.Scale, targetPos.Y.Offset)
					else
						startPos = UDim2.new(targetPos.X.Scale, targetPos.X.Offset, targetPos.Y.Scale, targetPos.Y.Offset + 50)
					end
					ReopenBreadcrumb.Position = startPos
					tw({
						v = ReopenBreadcrumb,
						t = 0.4,
						s = Enum.EasingStyle.Exponential,
						d = "Out",
						g = {Position = targetPos}
					}):Play()
				else
					local origPos = ReopenBreadcrumb.Position
					local outPos
					if CrumbOrientation == "Bottom" then
						outPos = UDim2.new(origPos.X.Scale, origPos.X.Offset, origPos.Y.Scale, origPos.Y.Offset + 50)
					elseif CrumbOrientation == "Top" then
						outPos = UDim2.new(origPos.X.Scale, origPos.X.Offset, origPos.Y.Scale, origPos.Y.Offset - 50)
					elseif CrumbOrientation == "Left" then
						outPos = UDim2.new(origPos.X.Scale, origPos.X.Offset - 50, origPos.Y.Scale, origPos.Y.Offset)
					elseif CrumbOrientation == "Right" then
						outPos = UDim2.new(origPos.X.Scale, origPos.X.Offset + 50, origPos.Y.Scale, origPos.Y.Offset)
					else
						outPos = UDim2.new(origPos.X.Scale, origPos.X.Offset, origPos.Y.Scale, origPos.Y.Offset + 50)
					end
					
					local outTween = tw({
						v = ReopenBreadcrumb,
						t = 0.3,
						s = Enum.EasingStyle.Exponential,
						d = "In",
						g = {Position = outPos}
					})
					outTween:Play()
					task.delay(0.3, function()
						if not isopen then
							ReopenBreadcrumb.Visible = false
							ReopenBreadcrumb.Position = origPos
						end
					end)
				end
			end

			if not firsttime then
				firsttime = true
				Tabs:Notify({
					Title = Title .. " v" .. Version,
					Desc = 'Press the <font color="#FF77A5" size="14">('..tostring(Keybind):gsub("Enum.KeyCode.", "")..')</font> button to hide and show the UI',
					Time = 10
				})
			end
		end
		Tabs.closeui = closeui

		ChSize_1.MouseButton1Click:Connect(closeui)

		U.InputBegan:Connect(function(i)
			if i.KeyCode == Keybind then
				local focusedTextBox = U:GetFocusedTextBox()
				if not focusedTextBox then
					closeui()
				end
			end
		end)

		local CallTheme = function(v)
			IsTheme = v
			local t = themes[v]
			Library:setTheme({
				['Shadow'] = t.Shadow,
				['Background'] = t.Background,
				['Page'] = t.Page,
				['Main'] = t.Main,
				['Text'] = t.Text,
				['Icon'] = t.Icon,
				['Text & Icon'] = t['Text & Icon'],
				['Function'] = {
					['Toggle'] = {
						['Background'] = t.Function.Toggle.Background,
						['True'] = {
							['Toggle Background'] = t.Function.Toggle.True['Toggle Background'],
							['Toggle Value'] = t.Function.Toggle.True['Toggle Value'],
						},
						['False'] = {
							['Toggle Background'] = t.Function.Toggle.False['Toggle Background'],
							['Toggle Value'] = t.Function.Toggle.False['Toggle Value'],
						}
					},
					['Label'] = {
						['Background'] = t.Function.Label.Background,
					},
					['Dropdown'] = {
						['Background'] = t.Function.Dropdown.Background,
						['Value Background'] = t.Function.Dropdown['Value Background'],
						['Value Stroke'] = t.Function.Dropdown['Value Stroke'],
						['Dropdown Select'] = {
							['Background'] = t.Function.Dropdown['Dropdown Select'].Background,
							['Search'] = t.Function.Dropdown['Dropdown Select'].Search,
							['Item Background'] = t.Function.Dropdown['Dropdown Select']['Item Background'],
						}
					},
					['Slider'] = {
						['Background'] = t.Function.Slider.Background,
						['Value Background'] = t.Function.Slider['Value Background'],
						['Value Stroke'] = t.Function.Slider['Value Stroke'],
						['Slider Bar'] = t.Function.Slider['Slider Bar'],
						['Slider Bar Value'] = t.Function.Slider['Slider Bar Value'],
						['Circle Value'] = t.Function.Slider['Circle Value'],
					},
					['Code'] = {
						['Background'] = t.Function.Code.Background,
						['Background Code'] = t.Function.Code['Background Code'],
						['Background Code Value'] = t.Function.Code['Background Code Value'],
						['ScrollingFrame Code'] = t.Function.Code['ScrollingFrame Code'],
					},
					['Button'] = {
						['Background'] = t.Function.Button.Background,
						['Click'] = t.Function.Button.Click,
					},
					['Textbox'] = {
						['Background'] = t.Function.Textbox.Background,
						['Value Background'] = t.Function.Textbox['Value Background'],
						['Value Stroke'] = t.Function.Textbox['Value Stroke'],
					},
					['Keybind'] = {
						['Background'] = t.Function.Keybind.Background,
						['Value Background'] = t.Function.Keybind['Value Background'],
						['Value Stroke'] = t.Function.Keybind['Value Stroke'],
						['True'] = {
							['Toggle Background'] = t.Function.Keybind.True['Toggle Background'],
							['Toggle Value'] = t.Function.Keybind.True['Toggle Value'],
						},
						['False'] = {
							['Toggle Background'] = t.Function.Keybind.False['Toggle Background'],
							['Toggle Value'] = t.Function.Keybind.False['Toggle Value'],
						}
					},
					['Color Picker'] = {
						['Background'] = t.Function['Color Picker'].Background,
						['Color Select'] = {
							['Background'] = t.Function['Color Picker']['Color Select'].Background,
							['UIStroke'] = t.Function['Color Picker']['Color Select'].UIStroke,
						}
					}
				}
			})
			if Tabs.ActiveTabTitle then
				Tabs.ActiveTabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
			if Tabs.ActiveTabIcon then
				Tabs.ActiveTabIcon.ImageColor3 = t.Main
			end
			if Tabs.ActiveDockBtn then
				Tabs.ActiveDockBtn.ImageColor3 = t.Main
			end
		end
		local ThemeDrop = addDropdownSelect(DropdownValue_1, DropdownValue_1, false, CallTheme, Theme, themes.index)

		Close_1.MouseButton1Click:Connect(function()
			Tabs:Dialog({
				Title = "Do you want to <font color='#FF0000'>close</font> the ui?",
				Button1 = {
					Title = 'Confirm',
					Color = Color3.fromRGB(0, 188, 0),
					Callback = function()
						ScreenGui:Destroy()
					end,
				},
				Button2 = {
					Title = 'Cancel',
					Color = Color3.fromRGB(226, 39, 6),
				}
			})
		end)

		do
			local CloseUI = p.CloseUIButton or { Enabled = true }
			local CloseUIEnabled = CloseUI.Enabled
			if CloseUIEnabled == nil then CloseUIEnabled = true end

			local currentClosedStyle = "Breadcrumb"
			local CloseUIShadow = Instance.new("ImageLabel")
			local UIPaddingCloseUI_1 = Instance.new("UIPadding")
			local BackgroundCloseUI_1 = Instance.new("Frame")
			local UICornerCloseUI_1 = Instance.new("UICorner")
			local Crumb_1 = Instance.new("Frame")
			local UIListLayoutCrumb_1 = Instance.new("UIListLayout")
			local UIPaddingCrumb_1 = Instance.new("UIPadding")
			local HomeBadge_1 = Instance.new("Frame")
			local UICornerHome_1 = Instance.new("UICorner")
			local HomeIcon_1 = Instance.new("ImageLabel")
			local Chevron_1 = Instance.new("ImageLabel")
			local Title_1 = Instance.new("TextLabel")

			CloseUIShadow.Name = "CloseUIShadow"
			CloseUIShadow.Parent = ScreenGui
			CloseUIShadow.BackgroundColor3 = Color3.fromRGB(163,162,165)
			CloseUIShadow.BackgroundTransparency = 1
			CloseUIShadow.AnchorPoint = Vector2.new(0.5, 1)
			CloseUIShadow.Position = UDim2.new(0.5, 0, 0.98, 0)
			CloseUIShadow.Size = UDim2.new(0, 120, 0, 48)
			CloseUIShadow.Image = CacheImage("rbxassetid://1316045217")
			CloseUIShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
			CloseUIShadow.ImageTransparency = 0.5
			CloseUIShadow.ScaleType = Enum.ScaleType.Slice
			CloseUIShadow.SliceCenter = Rect.new(10, 10, 118, 118)
			CloseUIShadow.Visible = false -- เนเธเธงเนเน€เธเธเธฒเธฐเธ•เธญเธ UI เธ–เธนเธเธเนเธญเธ เธเธงเธเธเธธเธกเนเธ”เธข closeui()
			
			local CloseUIScale = Instance.new("UIScale")
			CloseUIScale.Parent = CloseUIShadow
			CloseUIScale.Scale = 1

			addToTheme('Shadow', CloseUIShadow)

			UIPaddingCloseUI_1.Parent = CloseUIShadow
			UIPaddingCloseUI_1.PaddingBottom = UDim.new(0,5)
			UIPaddingCloseUI_1.PaddingLeft = UDim.new(0,5)
			UIPaddingCloseUI_1.PaddingRight = UDim.new(0,5)
			UIPaddingCloseUI_1.PaddingTop = UDim.new(0,5)

			BackgroundCloseUI_1.Name = "BackgroundCloseUI"
			BackgroundCloseUI_1.Parent = CloseUIShadow
			BackgroundCloseUI_1.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
			BackgroundCloseUI_1.BorderSizePixel = 0
			BackgroundCloseUI_1.Size = UDim2.new(1, 0, 1, 0)
			BackgroundCloseUI_1.ClipsDescendants = true

			addToTheme('Background', BackgroundCloseUI_1)

			UICornerCloseUI_1.Parent = BackgroundCloseUI_1
			UICornerCloseUI_1.CornerRadius = UDim.new(1, 0)

			Crumb_1.Name = "Crumb"
			Crumb_1.Parent = BackgroundCloseUI_1
			Crumb_1.BackgroundTransparency = 1
			Crumb_1.Size = UDim2.new(1, 0, 1, 0)

			UIListLayoutCrumb_1.Parent = Crumb_1
			UIListLayoutCrumb_1.FillDirection = Enum.FillDirection.Horizontal
			UIListLayoutCrumb_1.Padding = UDim.new(0, 6)
			UIListLayoutCrumb_1.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayoutCrumb_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayoutCrumb_1.VerticalAlignment = Enum.VerticalAlignment.Center

			UIPaddingCrumb_1.Parent = Crumb_1
			UIPaddingCrumb_1.PaddingLeft = UDim.new(0, 3)
			UIPaddingCrumb_1.PaddingRight = UDim.new(0, 3)
			UIPaddingCrumb_1.PaddingTop = UDim.new(0, 3)
			UIPaddingCrumb_1.PaddingBottom = UDim.new(0, 3)

			HomeBadge_1.Name = "HomeBadge"
			HomeBadge_1.Parent = Crumb_1
			HomeBadge_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HomeBadge_1.BackgroundTransparency = 0.95
			HomeBadge_1.Size = UDim2.new(0, 32, 0, 32)
			HomeBadge_1.LayoutOrder = 1
			
			local UIStroke_Home = Instance.new("UIStroke")
			UIStroke_Home.Parent = HomeBadge_1
			UIStroke_Home.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_Home.Transparency = 0.9

			UICornerHome_1.Parent = HomeBadge_1
			UICornerHome_1.CornerRadius = UDim.new(1, 0)

			HomeIcon_1.Parent = HomeBadge_1
			HomeIcon_1.AnchorPoint = Vector2.new(0.5, 0.5)
			HomeIcon_1.BackgroundTransparency = 1
			HomeIcon_1.Position = UDim2.new(0.5, 0, 0.5, 0)
			HomeIcon_1.Size = UDim2.new(0, 26, 0, 26)
			HomeIcon_1.Image = Icon_1.Image
			HomeIcon_1.ImageRectSize = Icon_1.ImageRectSize
			HomeIcon_1.ImageRectOffset = Icon_1.ImageRectOffset
			HomeIcon_1.ImageColor3 = Color3.fromRGB(255,255,255)

			Chevron_1.Visible = false



			if CloseUI.Icon then
				local IconImg = Instance.new("ImageLabel")
				IconImg.Name = "Icon"
				IconImg.Parent = Crumb_1
				IconImg.BackgroundTransparency = 1
				IconImg.Size = UDim2.new(0, 20, 0, 20)
				IconImg.LayoutOrder = 4
				IconImg.Image = type(CloseUI.Icon) == "number" and "rbxassetid://"..CloseUI.Icon or CloseUI.Icon
				addToTheme('Text & Icon', IconImg)
			end


			local HomeClick = Instance.new("TextButton")
			HomeClick.Name = "HomeClick"
			HomeClick.Parent = HomeBadge_1
			HomeClick.Size = UDim2.new(1, 0, 1, 0)
			HomeClick.BackgroundTransparency = 1
			HomeClick.Text = ""
			HomeClick.ZIndex = 10
			
			local isBreadcrumbMini = false
			local is360CenterMode = false
			local updateCrumbSize
			
			local MoreBtn = Instance.new("ImageButton")
			MoreBtn.Name = "MoreBtn_Special"
			MoreBtn.Parent = Crumb_1
			MoreBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			MoreBtn.BackgroundTransparency = 1
			MoreBtn.Size = UDim2.new(0, 22, 0, 22)
			local _layersIcon = gl("layers")
			MoreBtn.Image = (_layersIcon and _layersIcon.Image ~= "") and _layersIcon.Image or "rbxassetid://10723424505"
			MoreBtn.ImageRectSize = _layersIcon and _layersIcon.ImageRectSize or Vector2.new(0, 0)
			MoreBtn.ImageRectOffset = (_layersIcon and (_layersIcon.ImageRectPosition or _layersIcon.ImageRectOffset)) or Vector2.new(0, 0)
			MoreBtn.ImageColor3 = Color3.fromRGB(180, 195, 255)
			MoreBtn.ZIndex = 50
			MoreBtn.Visible = false
			
			local MoreBg = Instance.new("Frame")
			MoreBg.Name = "IconBg_MoreBtn_Special"
			MoreBg.AnchorPoint = Vector2.new(0.5, 0.5)
			MoreBg.Position = UDim2.new(0.5, 0, 0.5, 0)
			MoreBg.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
			MoreBg.ZIndex = 49
			MoreBg.Visible = false
			local MoreCorner = Instance.new("UICorner")
			MoreCorner.CornerRadius = UDim.new(1, 0)
			MoreCorner.Parent = MoreBg
			local MoreStroke = Instance.new("UIStroke")
			MoreStroke.Color = Color3.fromRGB(120, 140, 255)
			MoreStroke.Transparency = 0.5
			MoreStroke.Parent = MoreBg
			MoreBg.Parent = Crumb_1
			
			MoreBtn.MouseEnter:Connect(function()
				local text = (is360CenterMode or CrumbOrientation == "Center") and "ย่อกลับ (เมนูด้านล่าง)" or "เพิ่มเติม (360° ตรงกลาง)"
				TooltipLabel.Text = text
				local ts = _Services.TextService
				local textBounds = ts:GetTextSize(text, 12, Enum.Font.GothamMedium, Vector2.new(1000, 24))
				TooltipFrame.Size = UDim2.new(0, textBounds.X + 16, 0, 24)
				
				local absPos = MoreBtn.AbsolutePosition
				local absSize = MoreBtn.AbsoluteSize
				if is360CenterMode or CrumbOrientation == "Center" then
					TooltipFrame.Position = UDim2.new(0, absPos.X + absSize.X/2, 0, absPos.Y + absSize.Y + 5)
					TooltipFrame.AnchorPoint = Vector2.new(0.5, 0)
				else
					TooltipFrame.Position = UDim2.new(0, absPos.X + absSize.X/2, 0, absPos.Y - 5)
					TooltipFrame.AnchorPoint = Vector2.new(0.5, 1)
				end
				
				TooltipFrame.Visible = true
				tw({v = TooltipFrame, t = 0.2, s = Enum.EasingStyle.Exponential, d = "Out", g = {BackgroundTransparency = 0}}):Play()
				tw({v = TooltipLabel, t = 0.2, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = 0}}):Play()
			end)
			MoreBtn.MouseLeave:Connect(function()
				tw({v = TooltipFrame, t = 0.2, s = Enum.EasingStyle.Exponential, d = "Out", g = {BackgroundTransparency = 1}}):Play()
				tw({v = TooltipLabel, t = 0.2, s = Enum.EasingStyle.Exponential, d = "Out", g = {TextTransparency = 1}}):Play()
			end)
			
			MoreBtn.MouseButton1Click:Connect(function()
				is360CenterMode = not is360CenterMode
				if is360CenterMode then
					CloseUIShadow.AnchorPoint = Vector2.new(0.5, 0.5)
					tw({v = CloseUIShadow, t = 0.4, s = Enum.EasingStyle.Back, d = "Out", g = {Position = UDim2.new(0.5, 0, 0.5, 0)}}):Play()
				else
					if Tabs.SetCrumbOrientation then
						Tabs.SetCrumbOrientation(CrumbOrientation)
					end
				end
				if updateCrumbSize then updateCrumbSize() end
			end)
			
			local function toggleMini(force)
				if force ~= nil then
					isBreadcrumbMini = force
				else
					isBreadcrumbMini = not isBreadcrumbMini
				end
				
				if currentClosedStyle == "Breadcrumb" then
					for _, child in ipairs(Crumb_1:GetChildren()) do
						if child.Name:match("^DockBtn_") or child.Name == "MoreBtn_Special" then
							child.Visible = not isBreadcrumbMini
						end
					end
				else
					for _, child in ipairs(Crumb_1:GetChildren()) do
						if child.Name:match("^DockBtn_") or child.Name == "MoreBtn_Special" then
							child.Visible = true
						end
					end
				end
				if updateCrumbSize then updateCrumbSize() end
			end

			local animGeneration = 0
			updateCrumbSize = function()
				task.defer(function()
					local dockBtns = {}
					for _, child in ipairs(Crumb_1:GetChildren()) do
						if child.Name:match("^DockBtn_") and child.Name ~= "MoreBtn_Special" then
							table.insert(dockBtns, child)
						end
					end
					
					animGeneration = animGeneration + 1
					local currentGen = animGeneration
					
					local isGooeyMode = currentClosedStyle == "Gooey plus menu" or currentClosedStyle == "Gooey 360° (Center)"
					local is360 = isGooeyMode and (is360CenterMode or CrumbOrientation == "Center" or currentClosedStyle == "Gooey 360° (Center)")
					
					local easingStyle = isGooeyMode and Enum.EasingStyle.Back or Enum.EasingStyle.Exponential
					local duration = isGooeyMode and 0.4 or 0.2
					
					if isGooeyMode then
						UIListLayoutCrumb_1.Parent = nil
						BackgroundCloseUI_1.ClipsDescendants = false
						HomeBadge_1.AnchorPoint = Vector2.new(0.5, 0.5)
						HomeBadge_1.Position = UDim2.new(0.5, 0, 0.5, 0)
						BackgroundCloseUI_1.AnchorPoint = Vector2.new(0.5, 0.5)
						BackgroundCloseUI_1.Position = UDim2.new(0.5, 0, 0.5, 0)
						UIPaddingCrumb_1.PaddingLeft = UDim.new(0, 0)
						UIPaddingCrumb_1.PaddingRight = UDim.new(0, 0)
						UIPaddingCrumb_1.PaddingTop = UDim.new(0, 0)
						UIPaddingCrumb_1.PaddingBottom = UDim.new(0, 0)
						
						MoreBtn.Visible = true
						MoreBg.Visible = true
						
						local allBtns = {}
						for _, btn in ipairs(dockBtns) do
							table.insert(allBtns, btn)
						end
						table.insert(allBtns, MoreBtn)
						
						for _, btn in ipairs(allBtns) do
							btn.AnchorPoint = Vector2.new(0.5, 0.5)
							local bg = btn.Parent:FindFirstChild("IconBg_" .. btn.Name)
							if not bg then
								bg = Instance.new("Frame")
								bg.Name = "IconBg_" .. btn.Name
								bg.AnchorPoint = Vector2.new(0.5, 0.5)
								bg.Position = UDim2.new(0.5, 0, 0.5, 0)
								bg.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
								bg.ZIndex = btn.ZIndex - 1
								local corner = Instance.new("UICorner")
								corner.CornerRadius = UDim.new(1, 0)
								corner.Parent = bg
								bg.Parent = btn.Parent
								if addToTheme then addToTheme('Background', bg) end
							end
							if btn == MoreBtn then
								bg.Visible = true
							elseif btn.Image == "" or btn.Image == CacheImage("rbxassetid://0") then
								bg.Visible = false
							else
								bg.Visible = true
							end
						end
						
						local shadowSpread = 200
						
						if is360 then
							-- โหมด 360 องศาตรงกลางจอ และมีหลายชั้น (Concentric Rings)
							local totalItems = #allBtns
							local layers = {}
							if totalItems <= 5 then
								layers[1] = allBtns
							elseif totalItems <= 10 then
								local c1 = math.ceil(totalItems / 2)
								local l1, l2 = {}, {}
								for idx = 1, c1 do table.insert(l1, allBtns[idx]) end
								for idx = c1 + 1, totalItems do table.insert(l2, allBtns[idx]) end
								layers[1] = l1
								layers[2] = l2
							elseif totalItems <= 16 then
								local c1 = math.min(6, math.ceil(totalItems * 0.45))
								local l1, l2 = {}, {}
								for idx = 1, c1 do table.insert(l1, allBtns[idx]) end
								for idx = c1 + 1, totalItems do table.insert(l2, allBtns[idx]) end
								layers[1] = l1
								layers[2] = l2
							else
								local l1, l2, l3 = {}, {}, {}
								for idx = 1, 5 do table.insert(l1, allBtns[idx]) end
								for idx = 6, 13 do table.insert(l2, allBtns[idx]) end
								for idx = 14, totalItems do table.insert(l3, allBtns[idx]) end
								layers[1] = l1
								layers[2] = l2
								layers[3] = l3
							end
							
							local maxR = (#layers >= 3 and 255) or (#layers == 2 and 180) or 105
							shadowSpread = math.max(200, math.ceil((maxR + 40) * 2))
							
							local itemGlobalIdx = 0
							for layerIdx, layerItems in ipairs(layers) do
								local r = (layerIdx == 1 and 105) or (layerIdx == 2 and 180) or 255
								local m = #layerItems
								local step = 360 / m
								local startAngle = (layerIdx == 1 and -90) or (layerIdx == 2 and (-90 + (180 / m))) or -90
								
								for itemIdx, btn in ipairs(layerItems) do
									itemGlobalIdx = itemGlobalIdx + 1
									local bg = btn.Parent:FindFirstChild("IconBg_" .. btn.Name)
									local deg = startAngle + (itemIdx - 1) * step
									local angle = math.rad(deg)
									local offsetX = math.cos(angle) * r
									local offsetY = math.sin(angle) * r
									
									local delayTime = not isBreadcrumbMini and (((layerIdx - 1) * 0.08) + ((itemIdx - 1) * 0.025)) or (0.015 * (totalItems - itemGlobalIdx))
									
									task.delay(delayTime, function()
										if currentGen ~= animGeneration then return end
										if not isBreadcrumbMini then
											tw({v = btn, t = 0.5, s = Enum.EasingStyle.Back, d = "Out", g = {Position = UDim2.new(0.5, offsetX, 0.5, offsetY), Size = UDim2.new(0, 22, 0, 22), ImageTransparency = 0}}):Play()
											tw({v = bg, t = 0.5, s = Enum.EasingStyle.Back, d = "Out", g = {Position = UDim2.new(0.5, offsetX, 0.5, offsetY), Size = UDim2.new(0, 38, 0, 38), BackgroundTransparency = 0}}):Play()
										else
											tw({v = btn, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 0, 0, 0), ImageTransparency = 1}}):Play()
											tw({v = bg, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}}):Play()
										end
									end)
								end
							end
						else
							-- โหมดส่วนโค้งตามขอบจอ (เช่น Bottom / Top / Left / Right)
							local count = #allBtns
							local baseRadius = 140
							local anglePerItem = 40
							local totalSpread = (count - 1) * anglePerItem
							local maxSpread = 180
							
							if totalSpread > maxSpread then
								totalSpread = maxSpread
								if count > 1 then
									anglePerItem = maxSpread / (count - 1)
								end
							end
							
							local minCenterDist = 50
							local halfAngleRad = math.rad(anglePerItem / 2)
							local minRadius = (count > 1 and halfAngleRad > 0) and (minCenterDist / (2 * math.sin(halfAngleRad))) or baseRadius
							local radius = math.max(baseRadius, math.ceil(minRadius))
							shadowSpread = math.max(200, math.ceil((radius + 35) * 2))
							
							local baseAngle = 0
							if CrumbOrientation == "Bottom" then baseAngle = 270
							elseif CrumbOrientation == "Top" then baseAngle = 90
							elseif CrumbOrientation == "Left" then baseAngle = 0
							elseif CrumbOrientation == "Right" then baseAngle = 180
							end
							
							local actualStartAngle
							local angleStep
							if CrumbOrientation == "Bottom" or CrumbOrientation == "Left" then
								actualStartAngle = baseAngle - (totalSpread / 2)
								angleStep = anglePerItem
							else
								actualStartAngle = baseAngle + (totalSpread / 2)
								angleStep = -anglePerItem
							end
							
							for i, btn in ipairs(allBtns) do
								local bg = btn.Parent:FindFirstChild("IconBg_" .. btn.Name)
								local delayTime = not isBreadcrumbMini and ((i - 1) * 0.025) or ((count - i) * 0.015)
								
								task.delay(delayTime, function()
									if currentGen ~= animGeneration then return end
									if not isBreadcrumbMini then
										local angleDeg = actualStartAngle + (i - 1) * angleStep
										local angle = math.rad(angleDeg)
										local offsetX = math.cos(angle) * radius
										local offsetY = math.sin(angle) * radius
										
										tw({v = btn, t = 0.5, s = Enum.EasingStyle.Back, d = "Out", g = {Position = UDim2.new(0.5, offsetX, 0.5, offsetY), Size = UDim2.new(0, 22, 0, 22), ImageTransparency = 0}}):Play()
										tw({v = bg, t = 0.5, s = Enum.EasingStyle.Back, d = "Out", g = {Position = UDim2.new(0.5, offsetX, 0.5, offsetY), Size = UDim2.new(0, 38, 0, 38), BackgroundTransparency = 0}}):Play()
									else
										tw({v = btn, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 0, 0, 0), ImageTransparency = 1}}):Play()
										tw({v = bg, t = 0.3, s = Enum.EasingStyle.Quad, d = "Out", g = {Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}}):Play()
									end
								end)
							end
						end
						
						if not isBreadcrumbMini then
							if is360 then
								CloseUIShadow.AnchorPoint = Vector2.new(0.5, 0.5)
								tw({v = CloseUIShadow, t = duration, s = easingStyle, d = "Out", g = {Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, shadowSpread, 0, shadowSpread)}}):Play()
							else
								tw({v = CloseUIShadow, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(0, shadowSpread, 0, shadowSpread)}}):Play()
							end
							tw({v = HomeIcon_1, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(0, 32, 0, 32)}}):Play()
							tw({v = HomeBadge_1, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(0, 38, 0, 38)}}):Play()
						else
							tw({v = CloseUIShadow, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(0, 48, 0, 48)}}):Play()
							tw({v = HomeIcon_1, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(0, 26, 0, 26)}}):Play()
							tw({v = HomeBadge_1, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(0, 32, 0, 32)}}):Play()
						end
						tw({v = BackgroundCloseUI_1, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(0, 44, 0, 44)}}):Play()
					else
						UIListLayoutCrumb_1.Parent = Crumb_1
						BackgroundCloseUI_1.ClipsDescendants = true
						HomeBadge_1.AnchorPoint = Vector2.new(0, 0)
						HomeBadge_1.Position = UDim2.new(0, 0, 0, 0)
						BackgroundCloseUI_1.AnchorPoint = Vector2.new(0, 0)
						BackgroundCloseUI_1.Position = UDim2.new(0, 0, 0, 0)
						tw({v = BackgroundCloseUI_1, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(1, 0, 1, 0)}}):Play()
						tw({v = HomeIcon_1, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(0, 26, 0, 26)}}):Play()
						tw({v = HomeBadge_1, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(0, 32, 0, 32)}}):Play()
						
						MoreBtn.Visible = false
						if MoreBg then MoreBg.Visible = false end
						for _, btn in ipairs(dockBtns) do
							btn.AnchorPoint = Vector2.new(0, 0)
							btn.Size = UDim2.new(0, 24, 0, 24)
							btn.ImageTransparency = 0
							local bg = btn.Parent:FindFirstChild("IconBg_" .. btn.Name)
							if bg then bg.Visible = false end
						end

						if CrumbOrientation == "Bottom" or CrumbOrientation == "Top" then
							UIPaddingCrumb_1.PaddingRight = UDim.new(0, isBreadcrumbMini and 3 or 14)
							UIPaddingCrumb_1.PaddingBottom = UDim.new(0, 3)
							UIPaddingCrumb_1.PaddingTop = UDim.new(0, 3)
							UIPaddingCrumb_1.PaddingLeft = UDim.new(0, 3)
							local targetW = (UIListLayoutCrumb_1.AbsoluteContentSize.X / CloseUIScale.Scale) + (isBreadcrumbMini and 16 or 27)
							local w = math.max(48, targetW)
							tw({v = CloseUIShadow, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(0, w, 0, 48)}}):Play()
						else
							UIPaddingCrumb_1.PaddingRight = UDim.new(0, 3)
							UIPaddingCrumb_1.PaddingBottom = UDim.new(0, isBreadcrumbMini and 3 or 14)
							UIPaddingCrumb_1.PaddingTop = UDim.new(0, 3)
							UIPaddingCrumb_1.PaddingLeft = UDim.new(0, 3)
							local targetH = (UIListLayoutCrumb_1.AbsoluteContentSize.Y / CloseUIScale.Scale) + (isBreadcrumbMini and 16 or 27)
							local h = math.max(48, targetH)
							tw({v = CloseUIShadow, t = duration, s = easingStyle, d = "Out", g = {Size = UDim2.new(0, 48, 0, h)}}):Play()
						end
					end
				end)
			end
			UIListLayoutCrumb_1:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCrumbSize)
			delay(0.1, function() toggleMini(true) end)
			
			Tabs.SetCrumbOrientation = function(pos)
				CrumbOrientation = pos
				if pos == "Bottom" then
					is360CenterMode = false
					CloseUIShadow.AnchorPoint = Vector2.new(0.5, 1)
					tw({v = CloseUIShadow, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {Position = UDim2.new(0.5, 0, 0.98, 0)}}):Play()
					UIListLayoutCrumb_1.FillDirection = Enum.FillDirection.Horizontal
				elseif pos == "Top" then
					is360CenterMode = false
					CloseUIShadow.AnchorPoint = Vector2.new(0.5, 0)
					tw({v = CloseUIShadow, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {Position = UDim2.new(0.5, 0, 0, 2)}}):Play()
					UIListLayoutCrumb_1.FillDirection = Enum.FillDirection.Horizontal
				elseif pos == "Left" then
					is360CenterMode = false
					CloseUIShadow.AnchorPoint = Vector2.new(0.5, 0.5)
					tw({v = CloseUIShadow, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {Position = UDim2.new(0.02, 0, 0.5, 0)}}):Play()
					UIListLayoutCrumb_1.FillDirection = Enum.FillDirection.Vertical
				elseif pos == "Right" then
					is360CenterMode = false
					CloseUIShadow.AnchorPoint = Vector2.new(1, 0.5)
					tw({v = CloseUIShadow, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {Position = UDim2.new(0.98, 0, 0.5, 0)}}):Play()
					UIListLayoutCrumb_1.FillDirection = Enum.FillDirection.Vertical
				elseif pos == "Center" then
					is360CenterMode = true
					CloseUIShadow.AnchorPoint = Vector2.new(0.5, 0.5)
					tw({v = CloseUIShadow, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {Position = UDim2.new(0.5, 0, 0.5, 0)}}):Play()
					UIListLayoutCrumb_1.FillDirection = Enum.FillDirection.Horizontal
				end
				updateCrumbSize()
			end

			HomeClick.MouseButton1Click:Connect(function()
				if currentClosedStyle == "Breadcrumb" then
					toggleMini()
				else
					if Tabs.closeui then Tabs.closeui() end
				end
			end)
			
			CloseUIShadow.MouseEnter:Connect(function()
				local isGooeyMode = currentClosedStyle == "Gooey plus menu" or currentClosedStyle == "Gooey 360° (Center)"
				if isGooeyMode or is360CenterMode then
					toggleMini(false) -- Expand
				end
			end)
			
			CloseUIShadow.MouseLeave:Connect(function()
				local isGooeyMode = currentClosedStyle == "Gooey plus menu" or currentClosedStyle == "Gooey 360° (Center)"
				if isGooeyMode or is360CenterMode then
					toggleMini(true) -- Collapse
				end
			end)

			ReopenBreadcrumb = CloseUIShadow
			ReopenBreadcrumbEnabled = CloseUIEnabled
			Tabs.ReopenBreadcrumb = CloseUIShadow

			Tabs.SetClosedUIStyle = function(style)
				currentClosedStyle = style
				if style == "Gooey plus menu" or style == "Gooey 360° (Center)" then
					CloseUIShadow.ImageTransparency = 1
					if style == "Gooey 360° (Center)" then
						is360CenterMode = true
						CloseUIShadow.AnchorPoint = Vector2.new(0.5, 0.5)
						tw({v = CloseUIShadow, t = 0.3, s = Enum.EasingStyle.Exponential, d = "Out", g = {Position = UDim2.new(0.5, 0, 0.5, 0)}}):Play()
					else
						is360CenterMode = false
						if Tabs.SetCrumbOrientation then Tabs.SetCrumbOrientation(CrumbOrientation) end
					end
					toggleMini(true)
				else
					is360CenterMode = false
					CloseUIShadow.ImageTransparency = 0.5
				end
				updateCrumbSize()
			end
		end
	end

		-- Auto-generate Home Tab
		local HomeTab = Tabs:Tab({
			Title = "Home",
			Icon = "house"
		})

		-- Image Carousel (HYPER Active Logo)
		local defaultLogo = CacheImage("https://img2.pic.in.th/HYPER.png")
		local currentLogo = (Icon_1 and Icon_1.Image ~= "" and Icon_1.Image ~= "rbxassetid://136264753381080" and Icon_1.Image ~= "rbxassetid://92567372646337") and Icon_1.Image or defaultLogo

		local CarouselImages = {
			currentLogo,
			currentLogo,
			currentLogo,
		}
		
		local HomeCarousel = HomeTab:Image()
		HomeCarousel:SetImage(CarouselImages[1])
		
		task.spawn(function()
			local idx = 1
			while task.wait(5) do
				if not HomeCarousel then break end
				idx = idx + 1
				if idx > #CarouselImages then idx = 1 end
				
				local s = pcall(function()
					HomeCarousel:SetImage(CarouselImages[idx], true)
				end)
				if not s then break end
			end
		end)

		local plr = _Services.Players.LocalPlayer
		HomeTab:Label({
			Title = "Welcome, " .. (plr and plr.DisplayName or "User") .. "!",
			Desc = "Thanks for using " .. tostring(Title) .. (Version and (" v" .. tostring(Version)) or "")
		})

		HomeTab:Section({
			Title = "System Information"
		})

		HomeTab:Label({
			Title = "User",
			Desc = plr and plr.Name or "Unknown"
		})

		HomeTab:Label({
			Title = "Executor",
			Desc = (identifyexecutor and identifyexecutor()) or "Unknown"
		})

		-- Time updater
		local TimeLabel = HomeTab:Label({
			Title = "Current Time",
			Desc = os.date("%X")
		})
		task.spawn(function()
			while task.wait(1) do
				if not TimeLabel then break end
				local s, e = pcall(function()
					TimeLabel:SetDesc(os.date("%X"))
				end)
				if not s then break end
			end
		end)

		-- Resize Handle
		local ResizeHandle = Instance.new("ImageButton")
		ResizeHandle.Name = "ResizeHandle"
		ResizeHandle.Parent = Background_1
		ResizeHandle.AnchorPoint = Vector2.new(1, 1)
		ResizeHandle.Position = UDim2.new(1, -2, 1, -2)
		ResizeHandle.Size = UDim2.new(0, 15, 0, 15)
		ResizeHandle.BackgroundTransparency = 1
		ResizeHandle.Image = CacheImage("rbxassetid://10901594247")
		ResizeHandle.ImageTransparency = 0.8
		ResizeHandle.ZIndex = 100
		
		make_resize(ResizeHandle, Shadow_1)

		local SettingsTab = Tabs:Tab({ Title = "UI Settings", Icon = "settings", LayoutOrder = 9999 })
		SettingsTab:Keybind({
			Title = "Toggle UI Keybind",
			Desc = "Change the key used to hide/show the UI",
			Key = Keybind,
			KeyChangedCallback = function(key)
				Keybind = key
			end
		})
		SettingsTab:Dropdown({
			Title = "Closed UI Style",
			Desc = "Select the style of the minimized UI",
			List = {"Breadcrumb", "Gooey plus menu", "Gooey 360° (Center)"},
			Value = "Breadcrumb",
			Callback = function(style)
				if Tabs.SetClosedUIStyle then
					Tabs.SetClosedUIStyle(style)
				end
			end
		})

		SettingsTab:Dropdown({
			Title = "Breadcrumb Position",
			Desc = "Change where the closed UI tab is placed",
			List = {"Bottom", "Top", "Left", "Right", "Center"},
			Value = "Bottom",
			Callback = function(pos)
				if Tabs.SetCrumbOrientation then
					Tabs.SetCrumbOrientation(pos)
				end
			end
		})

		local breadcrumbSliderObj = SettingsTab:Slider({
			Title = "Breadcrumb Size",
			Desc = "Adjust the scale of the minimized UI tab",
			Min = 100,
			Max = 200,
			Default = 100,
			Callback = function(val)
				local closeShadow = ScreenGui:FindFirstChild("CloseUIShadow")
				if closeShadow and closeShadow:FindFirstChild("UIScale") then
					tw({v = closeShadow.UIScale, t = 0.15, s = Enum.EasingStyle.Exponential, d = "Out", g = {Scale = val / 100}}):Play()
				end
			end
		})	
		SettingsTab:Button({
			Title = "Reset UI",
			Desc = "Reset UI position and scale",
			Callback = function()
				if Tabs.SetCrumbOrientation then
					Tabs.SetCrumbOrientation("Top")
				end
				if breadcrumbSliderObj then
					breadcrumbSliderObj:SetValue(100)
				end
				Shadow_1.AnchorPoint = Vector2.new(0.5, 0.5)
				Shadow_1.Position = UDim2.new(0.5, 0, 0.5, 0)
			end
		})

		Tabs.Logo = Icon_1.Image
		Library.Logo = Icon_1.Image
		Library._lastTabs = Tabs
		return Tabs
end


function Library:Notify(p)
	if Library._lastTabs and Library._lastTabs.Notify then
		return Library._lastTabs:Notify(p)
	end
end
Library.Notification = Library.Notify

function Library:SavePanel(p)
	if Library._lastTabs and Library._lastTabs.SavePanel then
		return Library._lastTabs:SavePanel(p)
	end
end
Library.PromptSave = Library.SavePanel

return Library


