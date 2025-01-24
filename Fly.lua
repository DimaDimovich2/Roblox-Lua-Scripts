-- Создаем основное окно
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем фрейм для меню
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Создаем заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.BorderSizePixel = 0
Title.Text = "Fly Hack"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Parent = MainFrame

-- Создаем кнопку Fly
local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(1, 0, 0, 50)
FlyButton.Position = UDim2.new(0, 0, 0, 40)
FlyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FlyButton.BorderSizePixel = 0
FlyButton.Text = "Fly"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.TextScaled = true
FlyButton.Parent = MainFrame

-- Функция для включения полета
local function enableFly()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")

    local FlySpeed = 1
    local Toggle = true

    local function fly()
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
    end

    FlyButton.MouseButton1Click:Connect(function()
        Toggle = not Toggle
        if Toggle then
            FlyButton.Text = "Flying..."
        else
            FlyButton.Text = "Fly"
        end
    end)

    fly()
end

-- Включаем функцию полета при загрузке скрипта
enableFly()
