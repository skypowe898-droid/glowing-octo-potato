
-- CTD TRADE CALCULATOR V2
-- Camera Tower Defense | Delta

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "CTD_TradeCalculator"
gui.ResetOnSpawn = false
gui.DisplayOrder = 1
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 290, 0, 340)
main.Position = UDim2.new(0.5, -145, 0.5, -170)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.ZIndex = 1
main.Parent = gui

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0,10)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(190,20,35)
stroke.Thickness = 2

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-70,0,40)
title.BackgroundTransparency = 1
title.Text = "CTD TRADE CALCULATOR"
title.TextColor3 = Color3.fromRGB(255,50,50)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.ZIndex = 2
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(150,20,20)
close.ZIndex = 3
close.Parent = main

local reopen = Instance.new("TextButton")
reopen.Size = UDim2.new(0,100,0,35)
reopen.Position = UDim2.new(0,10,0.5,-17)
reopen.Text = "OPEN CTD"
reopen.TextColor3 = Color3.new(1,1,1)
reopen.BackgroundColor3 = Color3.fromRGB(130,20,20)
reopen.Visible = false
reopen.Parent = gui

close.MouseButton1Click:Connect(function()
    main.Visible = false
    reopen.Visible = true
end)

reopen.MouseButton1Click:Connect(function()
    main.Visible = true
    reopen.Visible = false
end)

-- MOVABLE WINDOW
local dragging = false
local dragStart, startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local function label(text,y)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1,-20,0,25)
    l.Position = UDim2.new(0,10,0,y)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.new(1,1,1)
    l.TextSize = 14
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 2
    l.Parent = main
    return l
end

local function textbox(placeholder,y)
    local t = Instance.new("TextBox")
    t.Size = UDim2.new(1,-20,0,30)
    t.Position = UDim2.new(0,10,0,y)
    t.BackgroundColor3 = Color3.fromRGB(40,40,40)
    t.TextColor3 = Color3.new(1,1,1)
    t.PlaceholderText = placeholder
    t.Text = ""
    t.TextSize = 13
    t.ZIndex = 2
    t.Parent = main
    return t
end

label("TU UNIDAD",45)
local unit1 = textbox("Nombre de tu unidad",70)
local value1 = textbox("Valor de tu unidad",105)

label("UNIDAD DEL OTRO JUGADOR",145)
local unit2 = textbox("Nombre de su unidad",170)
local value2 = textbox("Valor de su unidad",205)

local result = label("RESULTADO: ESPERANDO",255)
result.TextColor3 = Color3.fromRGB(255,200,50)

local compare = Instance.new("TextButton")
compare.Size = UDim2.new(1,-20,0,35)
compare.Position = UDim2.new(0,10,0,290)
compare.Text = "CALCULAR TRADE"
compare.BackgroundColor3 = Color3.fromRGB(150,20,20)
compare.TextColor3 = Color3.new(1,1,1)
compare.Font = Enum.Font.GothamBold
compare.ZIndex = 2
compare.Parent = main

compare.MouseButton1Click:Connect(function()
    local a = tonumber(value1.Text)
    local b = tonumber(value2.Text)

    if not a or not b then
        result.Text = "INGRESA VALORES VALIDOS"
        return
    end

    if a > b then
        result.Text = "WIN: TU OFERTA ES MAYOR"
    elseif a < b then
        result.Text = "LOSS: SU OFERTA ES MAYOR"
    else
        result.Text = "FAIR: VALORES IGUALES"
    end
end)

print("CTD TRADE CALCULATOR V2 LOADED")
