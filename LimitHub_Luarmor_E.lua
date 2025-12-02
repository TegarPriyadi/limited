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


local screenGui = Instance.new("ScreenGui", game.CoreGui)
local function keyIsSaved()
        screenGui:Destroy()
        Notif("Auto Load Key: KEY_VALID")
        script_key = "uYbpFmFElwZdnIPILuATcnOMqKBAfWNb"
        task.wait(2)
        return true
    end
end


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

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 320, 0, 240)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -120)
mainFrame.BackgroundColor3 = colors.Main
mainFrame.BackgroundTransparency = 0.2
mainFrame.Name = "MainFrame"
ApplyUI(mainFrame)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Key System"
title.TextColor3 = colors.Text
title.Font = Enum.Font.GothamSemibold
title.TextSize = 18

local divider = Instance.new("Frame", mainFrame)
divider.Size = UDim2.new(1, -40, 0, 1)
divider.Position = UDim2.new(0, 20, 0, 42)
divider.BackgroundColor3 = colors.Divider
divider.BackgroundTransparency = 0.3
divider.BorderSizePixel = 0


local footer = Instance.new("TextLabel", mainFrame)
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 0.85, 0)
footer.BackgroundTransparency = 1
footer.Text = "LimitHub | discord.gg/limithub"
footer.TextColor3 = colors.TextDark
footer.Font = Enum.Font.Gotham
footer.TextSize = 12
footer.TextTransparency = 0.3
footer.TextYAlignment = Enum.TextYAlignment.Center
footer.TextWrapped = false


keyIsSaved()
