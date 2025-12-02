local function Notif(text)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "LimitHub",
            Text = text,
            Icon = "rbxassetid://123767073052336",
            Duration = 5
        })
    end)
end


---------------------------------------------------------------------
--  API LUARMOR (TETAP DIPERTAHANKAN)
---------------------------------------------------------------------
local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()


---------------------------------------------------------------------
--  GAME PLACE ID VALID LIST  (DENGAN DROPDOWN)
---------------------------------------------------------------------
local GameList = {
    ["Garden"] = {id = 126884695634066, script = "c7e7c28da728c6863a012ed2bd46f183"},
    ["Brainrot"] = {id = 109983668079237, script = "6f0b98e1fcdc5802e05d12fb3160357e"},
    ["Brainrot Alt"] = {id = 96342491571673, script = "6f0b98e1fcdc5802e05d12fb3160357e"},
    ["Fish It"] = {id = 121864768012064, script = "f35449c1f3c63953383043ebbce06761"},
    ["99 Night in Forest"] = {id = 126509999114328, script = "5b3e111bc8d15db9ab8ca5fd1d165980"},
    ["Fisch"] = {id = 131716211654599, script = "dff2d7e144df4f300dc3c35ab2b95e6e"},
    ["Fisch Old"] = {id = 16732694052, script = "dff2d7e144df4f300dc3c35ab2b95e6e"},
    ["PvZ Brainrot"] = {id = 127742093697776, script = "d59fe42f0c7c96327ea4f2c4633e3725"},
}


---------------------------------------------------------------------
--   CHECK PLACE AND APPLY SCRIPT ID
---------------------------------------------------------------------
local function checkPlace()
    local id = game.PlaceId
    for name,data in pairs(GameList) do
        if data.id == id then
            api.script_id = data.script
            return true
        end
    end
    Notif("Game Not Supported")
    return false
end

if not checkPlace() then return end


---------------------------------------------------------------------
--  KEY FILE
---------------------------------------------------------------------
local KeyLimit = "LimitHubKey.txt"
local screenGui = Instance.new("ScreenGui", game.CoreGui)



---------------------------------------------------------------------
--  CHECK KEY FUNCTION (TETAP DIPERTAHANKAN)
---------------------------------------------------------------------
local function checkKeyLuarmor(key)
    local status = api.check_key(key)
    print(status)
    if status.code == "KEY_VALID" then
        screenGui:Destroy()
        writefile(KeyLimit, key)
        script_key = key
        Notif("Key Valid")
        task.wait(1)
        api.load_script()
        return true
    elseif status.code == "KEY_HWID_LOCKED" then
        Notif("HWID Locked. Reset for other device!")
    elseif status.code == "KEY_INCORRECT" then
        Notif("Key Invalid.")
    elseif status.code == "KEY_EXPIRED" then
        Notif("Key Expired Please Renew.")
    else
        Notif("Failed: " .. status.message .. " | Code: " .. status.code)
    end
    return false
end


---------------------------------------------------------------------
--  AUTO LOAD SAVED KEY (TETAP DIPERTAHANKAN)
---------------------------------------------------------------------
local function keyIsSaved()
    if isfile(KeyLimit) then
        local savedKey = readfile(KeyLimit)
        local status = api.check_key(savedKey)

        if status.code == "KEY_VALID" then
            screenGui:Destroy()
            Notif("Auto Load Key: " .. status.message)
            script_key = savedKey
            task.wait(1)
            api.load_script()
            return true
        elseif status.code == "KEY_HWID_LOCKED" then
            Notif("HWID Locked. Reset for other device!")
        elseif status.code == "KEY_INCORRECT" then
            Notif("Saved key invalid.")
        elseif status.code == "KEY_EXPIRED" then
            Notif("Saved Key Expired Please Renew.")
        else
            Notif("Failed: " .. status.message .. " | Code: " .. status.code)
        end
    end
    return false
end


---------------------------------------------------------------------
--   UI DESIGN (TIDAK DIUBAH)
---------------------------------------------------------------------
screenGui.Name = "KeyUI"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false

local colors = {
    Main = Color3.fromRGB(35, 31, 55),
    Second = Color3.fromRGB(60, 52, 90),
    Stroke = Color3.fromRGB(120, 110, 180),
    Divider = Color3.fromRGB(90, 80, 130),
    Text = Color3.fromRGB(230, 230, 255),
    TextDark = Color3.fromRGB(160, 160, 200)
}

local function ApplyUI(frame)
    local uicorner = Instance.new("UICorner", frame)
    uicorner.CornerRadius = UDim.new(0, 6)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = colors.Stroke
    stroke.Thickness = 1.2
    stroke.Transparency = 0.4
end


---------------------------------------------------------------------
--   MAIN FRAME
---------------------------------------------------------------------
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 320, 0, 260)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -120)
mainFrame.BackgroundColor3 = colors.Main
mainFrame.BackgroundTransparency = 0.2
mainFrame.Name = "MainFrame"
ApplyUI(mainFrame)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "LimitHub Key System"
title.TextColor3 = colors.Text
title.Font = Enum.Font.GothamSemibold
title.TextSize = 18


---------------------------------------------------------------------
--   GAME DROPDOWN
---------------------------------------------------------------------
local dropdown = Instance.new("TextButton", mainFrame)
dropdown.Size = UDim2.new(1, -40, 0, 30)
dropdown.Position = UDim2.new(0, 20, 0, 50)
dropdown.BackgroundColor3 = colors.Second
dropdown.TextColor3 = colors.Text
dropdown.Text = "Select Game"
dropdown.Font = Enum.Font.GothamBold
dropdown.TextSize = 14
ApplyUI(dropdown)

local dropdownFrame = Instance.new("Frame", mainFrame)
dropdownFrame.Size = UDim2.new(1, -40, 0, 0)
dropdownFrame.Position = UDim2.new(0, 20, 0, 80)
dropdownFrame.BackgroundTransparency = 1
dropdownFrame.Visible = false

local up = false

dropdown.MouseButton1Click:Connect(function()
    up = not up
    dropdownFrame.Visible = up
end)

local y = 0
for name,data in pairs(GameList) do
    local b = Instance.new("TextButton", dropdownFrame)
    b.Size = UDim2.new(1, 0, 0, 24)
    b.Position = UDim2.new(0, 0, 0, y)
    b.BackgroundColor3 = colors.Second
    b.Text = name
    b.TextColor3 = colors.Text
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    ApplyUI(b)

    y = y + 28

    b.MouseButton1Click:Connect(function()
        dropdown.Text = name
        api.script_id = data.script
        dropdownFrame.Visible = false
    end)
end

dropdownFrame.Size = UDim2.new(1, -40, 0, y)


---------------------------------------------------------------------
--   KEY TEXTBOX
---------------------------------------------------------------------
local keyBox = Instance.new("TextBox", mainFrame)
keyBox.Size = UDim2.new(1, -40, 0, 36)
keyBox.Position = UDim2.new(0, 20, 0, 115)
keyBox.BackgroundColor3 = colors.Second
keyBox.PlaceholderText = "Enter Key"
keyBox.TextColor3 = colors.Text
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
ApplyUI(keyBox)



---------------------------------------------------------------------
--   BUTTON: AUTO GENERATE KEY (TANPA LIMIT)
---------------------------------------------------------------------
local getKeyBtn = Instance.new("TextButton", mainFrame)
getKeyBtn.Size = UDim2.new(1, -40, 0, 32)
getKeyBtn.Position = UDim2.new(0, 20, 0, 160)
getKeyBtn.BackgroundColor3 = colors.Second
getKeyBtn.TextColor3 = colors.Text
getKeyBtn.Text = "Get Key (Instant)"
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 13
ApplyUI(getKeyBtn)

getKeyBtn.MouseButton1Click:Connect(function()
    local newKey = "uYbpFmFElwZdnIPILuATcnOMqKBAfWNb"  -- NO LIMIT KEY
    keyBox.Text = newKey
    Notif("Key Generated!")
end)



---------------------------------------------------------------------
--   BUTTON: CHECK KEY
---------------------------------------------------------------------
local checkKey = Instance.new("TextButton", mainFrame)
checkKey.Size = UDim2.new(1, -40, 0, 32)
checkKey.Position = UDim2.new(0, 20, 0, 200)
checkKey.BackgroundColor3 = colors.Second
checkKey.TextColor3 = colors.Text
checkKey.Text = "Check Key"
checkKey.Font = Enum.Font.GothamBold
checkKey.TextSize = 14
ApplyUI(checkKey)

checkKey.MouseButton1Click:Connect(function()
    local inputKey = keyBox.Text
    if inputKey == "" then
        keyBox.PlaceholderText = "Key invalid!"
        keyBox.Text = ""
        return
    end
    
    local valid = checkKeyLuarmor(inputKey)
    if valid then
        screenGui:Destroy()
    else
        keyBox.Text = ""
        keyBox.PlaceholderText = "Key Invalid!"
    end
end)


---------------------------------------------------------------------
--   AUTO LOAD SAVED KEY
---------------------------------------------------------------------
keyIsSaved()
