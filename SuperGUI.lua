-- Скрипт для интерфейса Roblox с анимациями и вкладками
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomInterface"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Главное меню вкладок
local tabs = Instance.new("Frame")
tabs.Name = "Tabs"
tabs.Size = UDim2.new(0.2, 0, 1, 0)
tabs.Position = UDim2.new(0, 0, 0, 0)
tabs.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tabs.Parent = screenGui

-- Содержание вкладок
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(0.8, 0, 1, 0)
content.Position = UDim2.new(0.2, 0, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
content.Parent = screenGui

-- Функция для создания вкладки
local function createTab(tabName, tabText, contentText)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName
    tabButton.Size = UDim2.new(1, 0, 0, 50)
    tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabButton.Text = tabText
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 16
    tabButton.Parent = tabs

    local tabContent = Instance.new("Frame")
    tabContent.Name = tabName
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    tabContent.Visible = false
    tabContent.Parent = content

    local contentLabel = Instance.new("TextLabel")
    contentLabel.Size = UDim2.new(1, 0, 1, 0)
    contentLabel.Text = contentText
    contentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextSize = 20
    contentLabel.BackgroundTransparency = 1
    contentLabel.Parent = tabContent

    return tabButton, tabContent
end

-- Создаем вкладки
local tab1Button, tab1Content = createTab("Tab1", "Main Menu", "Welcome to the main menu!")
local tab2Button, tab2Content = createTab("Tab2", "Features", "Here are some cool features!")
local tab3Button, tab3Content = createTab("Tab3", "Settings", "Adjust your settings here!")

-- Система переключения вкладок
local function switchTab(selectedTab)
    for _, frame in pairs(content:GetChildren()) do
        if frame:IsA("Frame") then
            frame.Visible = false -- Скрываем все вкладки
        end
    end
    selectedTab.Visible = true -- Показываем выбранную вкладку
end

-- Анимации для нажатия на кнопки
local function setupButtonAnimation(button, relatedContent)
    button.MouseButton1Click:Connect(function()
        -- Анимация нажатия
        button:TweenSize(
            UDim2.new(1, -10, 0, 45),
            "Out",
            "Quad",
            0.2,
            true,
            function()
                button:TweenSize(
                    UDim2.new(1, 0, 0, 50),
                    "Out",
                    "Quad",
                    0.2
                )
            end
        )
        -- Переключение вкладки
        switchTab(relatedContent)
    end)
end

-- Настройка анимаций для кнопок
setupButtonAnimation(tab1Button, tab1Content)
setupButtonAnimation(tab2Button, tab2Content)
setupButtonAnimation(tab3Button, tab3Content)

-- Отображаем первую вкладку по умолчанию
switchTab(tab1Content)
