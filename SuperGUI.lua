-- Скрипт для красивого интерфейса с анимацией и закругленными углами
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Создание главного ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomInterface"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Главное окно
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui

-- Закругленные углы для окна
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

-- Заголовок окна
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 15)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Custom Interface"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 15)
closeCorner.Parent = closeButton

-- Область контента
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, -30)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
contentFrame.Parent = mainFrame

-- Вкладки
local tabButtonsFrame = Instance.new("Frame")
tabButtonsFrame.Name = "TabButtonsFrame"
tabButtonsFrame.Size = UDim2.new(1, 0, 0, 40)
tabButtonsFrame.BackgroundTransparency = 1
tabButtonsFrame.Parent = contentFrame

-- Функция для создания вкладки
local function createTab(tabName, tabText)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName
    tabButton.Size = UDim2.new(0, 100, 0, 30)
    tabButton.Position = UDim2.new(0, (#tabButtonsFrame:GetChildren() - 1) * 110, 0, 5)
    tabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Text = tabText
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 14
    tabButton.Parent = tabButtonsFrame

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = tabButton

    local tabContent = Instance.new("Frame")
    tabContent.Name = tabName
    tabContent.Size = UDim2.new(1, 0, 1, -40)
    tabContent.Position = UDim2.new(0, 0, 0, 40)
    tabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tabContent.Visible = false
    tabContent.Parent = contentFrame

    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 15)
    contentCorner.Parent = tabContent

    return tabButton, tabContent
end

-- Создаем вкладки
local tab1Button, tab1Content = createTab("Tab1", "Main")
local tab2Button, tab2Content = createTab("Tab2", "Features")
local tab3Button, tab3Content = createTab("Tab3", "Settings")

-- Вкладка по умолчанию
tab1Content.Visible = true

-- Переключение вкладок
local function switchTab(selectedTab)
    for _, frame in pairs(contentFrame:GetChildren()) do
        if frame:IsA("Frame") and frame.Name ~= "TabButtonsFrame" then
            frame.Visible = false
        end
    end
    selectedTab.Visible = true
end

-- Добавление функций для кнопок
tab1Button.MouseButton1Click:Connect(function() switchTab(tab1Content) end)
tab2Button.MouseButton1Click:Connect(function() switchTab(tab2Content) end)
tab3Button.MouseButton1Click:Connect(function() switchTab(tab3Content) end)

-- Закрытие окна
closeButton.MouseButton1Click:Connect(function()
    mainFrame:TweenPosition(
        UDim2.new(0.5, -200, -1, 0),
        "Out",
        "Quad",
        0.5,
        true,
        function()
            screenGui:Destroy()
        end
    )
end)

-- Перетаскивание окна
local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
