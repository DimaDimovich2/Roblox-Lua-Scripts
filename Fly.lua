-- Создаем основное окно
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем фрейм для меню
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Создаем заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.BorderSizePixel = 0
Title.Text = "Cheat Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Parent = MainFrame

-- Функция для создания кнопок
local function createButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 10, 0, 10)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Функция для добавления кнопок в меню
local function addButtonToMenu(button, index)
    button.Position = UDim2.new(0, 10, 0, 50 + (index * 50))
    button.Parent = MainFrame
end

-- Функции читов
local function fly()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")

    local FlySpeed = 1
    local Toggle = true

    local BodyGyro = Instance.new("BodyGyro", Character.PrimaryPart)
    BodyGyro.P = 9e4
    BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    BodyGyro.cframe = Character.PrimaryPart.CFrame

    local BodyVelocity = Instance.new("BodyVelocity", Character.PrimaryPart)
    BodyVelocity.velocity = Vector3.new(0, 0, 0)
    BodyVelocity.maxForce = Vector3.new(4000, 4000, 4000)

    game:GetService("RunService").Stepped:Connect(function()
        if Toggle then
            Humanoid.PlatformStand = true
            local moveDirection = (
                (game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (FlySpeed * 10)) +
                (game.Workspace.CurrentCamera.CoordinateFrame.upVector * (FlySpeed * 10))
            )
            BodyVelocity.velocity = moveDirection
        else
            Humanoid.PlatformStand = false
            BodyVelocity.velocity = Vector3.new(0, 0, 0)
        end
    end)

    return function()
        Toggle = not Toggle
    end
end

local function speedHack()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    Humanoid.WalkSpeed = 50
end

local function jumpHack()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    Humanoid.JumpPower = 100
end

local function infiniteJump()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local infiniteJumpConnection

    infiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
        Humanoid:Move(Vector3.new(0, 50, 0), true)
    end)

    return function()
        infiniteJumpConnection:Disconnect()
    end
end

local function noClip()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    for _, part in ipairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

local function esp()
    local Players = game:GetService("Players")
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local Box = Instance.new("BoxHandleAdornment", player.Character:WaitForChild("HumanoidRootPart"))
            Box.Adornee = player.Character:WaitForChild("HumanoidRootPart")
            Box.AlwaysOnTop = true
            Box.ZIndex = 0
            Box.Size = player.Character:WaitForChild("HumanoidRootPart").Size + Vector3.new(4, 4, 4)
            Box.Color3 = Color3.new(1, 0, 0)
        end
    end
end

local function killAll()
    local Players = game:GetService("Players")
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            player.Character:BreakJoints()
        end
    end
end

local function godMode()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    Humanoid.MaxHealth = math.huge
    Humanoid.Health = math.huge
end

local function freezeAll()
    local Players = game:GetService("Players")
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            player.Character:WaitForChild("HumanoidRootPart").Anchored = true
        end
    end
end

local function teleportToPlayer()
    local Players = game:GetService("Players")
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = player.Character:WaitForChild("HumanoidRootPart").CFrame
        end
    end
end

-- Создаем кнопки и добавляем их в меню
local flyButton = createButton("Fly", fly())
local speedButton = createButton("Speed Hack", speedHack)
local jumpButton = createButton("Jump Hack", jumpHack)
local infiniteJumpButton = createButton("Infinite Jump", infiniteJump())
local noClipButton = createButton("No Clip", noClip)
local espButton = createButton("ESP", esp)
local killAllButton = createButton("Kill All", killAll)
local godModeButton = createButton("God Mode", godMode)
local freezeAllButton = createButton("Freeze All", freezeAll)
local teleportButton = createButton("Teleport to Player", teleportToPlayer)

addButtonToMenu(flyButton, 1)
addButtonToMenu(speedButton, 2)
addButtonToMenu(jumpButton, 3)
addButtonToMenu(infiniteJumpButton, 4)
addButtonToMenu(noClipButton, 5)
addButtonToMenu(espButton, 6)
addButtonToMenu(killAllButton, 7)
addButtonToMenu(godModeButton, 8)
addButtonToMenu(freezeAllButton, 9)
addButtonToMenu(teleportButton, 10)

-- Обработка респавна
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("HumanoidRootPart")
    MainFrame.Visible = true
end)
