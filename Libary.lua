--[[
    SM1LE UI LIBRARY v1.0
    by SM1LER
    GitHub: github.com/yourusername/Universal
]]

local Sm1leUI = {}

-- Сервисы
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")

-- Интро
local function showIntro(name, subtitle, callback)
    local introGui = Instance.new("ScreenGui")
    introGui.Name = "Sm1leIntro"
    introGui.ResetOnSpawn = false
    introGui.IgnoreGuiInset = true
    introGui.Parent = CoreGui

    local introFrame = Instance.new("Frame")
    introFrame.Size = UDim2.new(1, 0, 1, 0)
    introFrame.BackgroundColor3 = Color3.fromRGB(10, 2, 2)
    introFrame.BorderSizePixel = 0
    introFrame.Parent = introGui

    local introTitle = Instance.new("TextLabel")
    introTitle.Size = UDim2.new(0, 500, 0, 100)
    introTitle.Position = UDim2.new(0.5, -250, 0.5, -50)
    introTitle.BackgroundTransparency = 1
    introTitle.Text = name or "SM1LE UI"
    introTitle.Font = Enum.Font.GothamBlack
    introTitle.TextSize = 60
    introTitle.TextColor3 = Color3.fromRGB(220, 20, 20)
    introTitle.TextTransparency = 1
    introTitle.Parent = introFrame

    local introSubtitle = Instance.new("TextLabel")
    introSubtitle.Size = UDim2.new(0, 300, 0, 40)
    introSubtitle.Position = UDim2.new(0.5, -150, 0.5, 60)
    introSubtitle.BackgroundTransparency = 1
    introSubtitle.Text = subtitle or "UI Library"
    introSubtitle.Font = Enum.Font.Gotham
    introSubtitle.TextSize = 24
    introSubtitle.TextColor3 = Color3.fromRGB(200, 140, 140)
    introSubtitle.TextTransparency = 1
    introSubtitle.Parent = introFrame

    local introVersion = Instance.new("TextLabel")
    introVersion.Size = UDim2.new(0, 200, 0, 25)
    introVersion.Position = UDim2.new(0.5, -100, 0.5, 95)
    introVersion.BackgroundTransparency = 1
    introVersion.Text = "by SM1LER"
    introVersion.Font = Enum.Font.GothamMedium
    introVersion.TextSize = 16
    introVersion.TextColor3 = Color3.fromRGB(255, 70, 70)
    introVersion.TextTransparency = 1
    introVersion.Parent = introFrame

    local fadeIn = TweenService:Create(introTitle, TweenInfo.new(1, Enum.EasingStyle.Quint), {TextTransparency = 0})
    local fadeInSub = TweenService:Create(introSubtitle, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0.4), {TextTransparency = 0})
    local fadeInVer = TweenService:Create(introVersion, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0.7), {TextTransparency = 0})
    local scaleUp = TweenService:Create(introTitle, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 70})
    local fadeOut = TweenService:Create(introFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1})

    fadeIn:Play()
    fadeInSub:Play()
    fadeInVer:Play()
    fadeIn.Completed:Wait()
    scaleUp:Play()
    scaleUp.Completed:Wait()
    task.wait(0.3)
    fadeOut:Play()
    fadeOut.Completed:Wait()
    introGui:Destroy()
    
    if callback then callback() end
end

-- Утилиты
local function corner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r)
    c.Parent = p
    return c
end

local function gradient(p, c1, c2, rot)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rot or 0
    g.Parent = p
    return g
end

-- Основная функция создания окна
function Sm1leUI:CreateWindow(config)
    config = config or {}
    local name = config.Name or "Sm1le Hub"
    local subtitle = config.Subtitle or "UI Library"
    local theme = config.Theme or "Blood"
    local key = config.Key or Enum.KeyCode.RightControl
    
    -- Темы
    local Themes = {
        Blood = {
            ACCENT = Color3.fromRGB(255,0,0),
            BG = Color3.fromRGB(20,5,5), BG2 = Color3.fromRGB(30,8,8), BG3 = Color3.fromRGB(45,12,12),
            TXT = Color3.fromRGB(255,240,240), SUB = Color3.fromRGB(200,150,150),
            Stroke = Color3.fromRGB(120,15,15), SwitchOff = Color3.fromRGB(45,12,12),
            TitleGrad1 = Color3.fromRGB(255,0,0), TitleGrad2 = Color3.fromRGB(0,0,0),
            ByGrad1 = Color3.fromRGB(255,80,80), ByGrad2 = Color3.fromRGB(0,0,0)
        },
        Ocean = {
            ACCENT = Color3.fromRGB(0,100,255),
            BG = Color3.fromRGB(5,8,20), BG2 = Color3.fromRGB(8,12,30), BG3 = Color3.fromRGB(12,18,45),
            TXT = Color3.fromRGB(235,240,255), SUB = Color3.fromRGB(140,160,200),
            Stroke = Color3.fromRGB(15,40,120), SwitchOff = Color3.fromRGB(12,18,45),
            TitleGrad1 = Color3.fromRGB(0,150,255), TitleGrad2 = Color3.fromRGB(0,0,50),
            ByGrad1 = Color3.fromRGB(0,180,255), ByGrad2 = Color3.fromRGB(0,0,50)
        },
        Midnight = {
            ACCENT = Color3.fromRGB(140,0,255),
            BG = Color3.fromRGB(8,5,20), BG2 = Color3.fromRGB(14,8,30), BG3 = Color3.fromRGB(22,12,45),
            TXT = Color3.fromRGB(240,235,255), SUB = Color3.fromRGB(160,140,200),
            Stroke = Color3.fromRGB(50,10,120), SwitchOff = Color3.fromRGB(22,12,45),
            TitleGrad1 = Color3.fromRGB(170,50,255), TitleGrad2 = Color3.fromRGB(10,0,30),
            ByGrad1 = Color3.fromRGB(180,80,255), ByGrad2 = Color3.fromRGB(10,0,30)
        },
        Forest = {
            ACCENT = Color3.fromRGB(0,200,50),
            BG = Color3.fromRGB(5,15,5), BG2 = Color3.fromRGB(8,22,8), BG3 = Color3.fromRGB(12,32,12),
            TXT = Color3.fromRGB(235,255,235), SUB = Color3.fromRGB(140,200,140),
            Stroke = Color3.fromRGB(15,80,15), SwitchOff = Color3.fromRGB(12,32,12),
            TitleGrad1 = Color3.fromRGB(0,255,80), TitleGrad2 = Color3.fromRGB(0,20,0),
            ByGrad1 = Color3.fromRGB(50,255,100), ByGrad2 = Color3.fromRGB(0,20,0)
        },
        Sunset = {
            ACCENT = Color3.fromRGB(255,120,0),
            BG = Color3.fromRGB(18,8,3), BG2 = Color3.fromRGB(28,12,5), BG3 = Color3.fromRGB(42,18,8),
            TXT = Color3.fromRGB(255,245,235), SUB = Color3.fromRGB(200,160,120),
            Stroke = Color3.fromRGB(100,30,5), SwitchOff = Color3.fromRGB(42,18,8),
            TitleGrad1 = Color3.fromRGB(255,150,30), TitleGrad2 = Color3.fromRGB(30,5,0),
            ByGrad1 = Color3.fromRGB(255,170,50), ByGrad2 = Color3.fromRGB(30,5,0)
        }
    }
    
    local currentTheme = Themes[theme] or Themes.Blood
    local ACCENT = currentTheme.ACCENT
    local BG = currentTheme.BG; local BG2 = currentTheme.BG2; local BG3 = currentTheme.BG3
    local TXT = currentTheme.TXT; local SUB = currentTheme.SUB
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "Sm1leUI"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.IgnoreGuiInset = true
    gui.Parent = CoreGui
    
    local main = Instance.new("Frame")
    main.Size = UDim2.fromOffset(620, 500)
    main.Position = UDim2.fromScale(0.5, 0.5)
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = BG
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Parent = gui
    corner(main, 16)
    
    local mst = Instance.new("UIStroke", main)
    mst.Color = currentTheme.Stroke
    mst.Thickness = 1.5
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 56)
    header.BackgroundColor3 = BG2
    header.BorderSizePixel = 0
    header.Parent = main
    corner(header, 16)
    
    local logo = Instance.new("TextLabel")
    logo.Size = UDim2.fromOffset(40, 40)
    logo.Position = UDim2.fromOffset(14, 8)
    logo.BackgroundTransparency = 1
    logo.Font = Enum.Font.GothamBold
    logo.Text = "🌐"
    logo.TextSize = 28
    logo.Parent = header
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.fromOffset(200, 22)
    titleLabel.Position = UDim2.fromOffset(58, 11)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 19
    titleLabel.TextColor3 = TXT
    titleLabel.Text = name
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header
    gradient(titleLabel, currentTheme.TitleGrad1, currentTheme.TitleGrad2, 0)
    
    local byLabel = Instance.new("TextLabel")
    byLabel.Size = UDim2.fromOffset(100, 16)
    byLabel.Position = UDim2.fromOffset(58, 29)
    byLabel.BackgroundTransparency = 1
    byLabel.Font = Enum.Font.GothamBlack
    byLabel.TextSize = 11
    byLabel.TextColor3 = TXT
    byLabel.Text = "by SM1LER"
    byLabel.TextXAlignment = Enum.TextXAlignment.Left
    byLabel.Parent = header
    gradient(byLabel, currentTheme.ByGrad1, currentTheme.ByGrad2, 0)
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.fromOffset(280, 14)
    statusLabel.Position = UDim2.fromOffset(58, 44)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamMedium
    statusLabel.TextSize = 9
    statusLabel.TextColor3 = SUB
    statusLabel.Text = subtitle
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = header
    
    -- Кнопки закрытия/сворачивания
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.fromOffset(28, 28)
    closeBtn.Position = UDim2.new(1, -40, 0, 14)
    closeBtn.BackgroundColor3 = BG3
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = TXT
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 15
    closeBtn.AutoButtonColor = true
    closeBtn.Parent = header
    corner(closeBtn, 8)
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
        if Sm1leUI.OnDestroy then Sm1leUI.OnDestroy() end
    end)
    
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.fromOffset(28, 28)
    minBtn.Position = UDim2.new(1, -74, 0, 14)
    minBtn.BackgroundColor3 = BG3
    minBtn.Text = "—"
    minBtn.TextColor3 = TXT
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 15
    minBtn.AutoButtonColor = true
    minBtn.Parent = header
    corner(minBtn, 8)
    
    local body = Instance.new("Frame")
    body.Size = UDim2.new(1, 0, 1, -56)
    body.Position = UDim2.fromOffset(0, 56)
    body.BackgroundTransparency = 1
    body.Parent = main
    
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 150, 1, 0)
    sidebar.BackgroundColor3 = BG2
    sidebar.BorderSizePixel = 0
    sidebar.Parent = body
    local sl = Instance.new("UIListLayout", sidebar)
    sl.Padding = UDim.new(0, 6)
    sl.SortOrder = Enum.SortOrder.LayoutOrder
    local sp = Instance.new("UIPadding", sidebar)
    sp.PaddingTop = UDim.new(0, 12)
    sp.PaddingBottom = UDim.new(0, 12)
    sp.PaddingLeft = UDim.new(0, 10)
    sp.PaddingRight = UDim.new(0, 10)
    
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -150, 1, 0)
    content.Position = UDim2.fromOffset(150, 0)
    content.BackgroundTransparency = 1
    content.Parent = body
    
    -- Переменные
    local tabs = {}
    local currentTab = nil
    local tabCount = 0
    local notified = false
    
    -- Функция выбора вкладки
    local function selectTab(name)
        currentTab = name
        for n, tab in pairs(tabs) do
            local on = (n == name)
            TweenService:Create(tab.Button, TweenInfo.new(0.18), {BackgroundColor3 = on and BG3 or BG2}):Play()
            tab.Accent.Visible = on
            tab.Label.TextColor3 = on and TXT or SUB
            tab.Page.Visible = on
            if on then tab.Page.CanvasPosition = Vector2.new(0, 0) end
        end
    end
    
    -- Создание вкладки
    local window = {}
    
    function window:CreateTab(tabName, icon)
        tabCount = tabCount + 1
        
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, 0, 0, 40)
        tabBtn.BackgroundColor3 = BG2
        tabBtn.AutoButtonColor = false
        tabBtn.Text = ""
        tabBtn.LayoutOrder = tabCount
        tabBtn.Parent = sidebar
        corner(tabBtn, 10)
        
        local accent = Instance.new("Frame")
        accent.Size = UDim2.fromOffset(3, 20)
        accent.Position = UDim2.fromOffset(0, 10)
        accent.BackgroundColor3 = ACCENT
        accent.BorderSizePixel = 0
        accent.Visible = false
        accent.Parent = tabBtn
        corner(accent, 2)
        
        local tabLabel = Instance.new("TextLabel")
        tabLabel.Size = UDim2.new(1, -16, 1, 0)
        tabLabel.Position = UDim2.fromOffset(14, 0)
        tabLabel.BackgroundTransparency = 1
        tabLabel.Font = Enum.Font.GothamMedium
        tabLabel.TextSize = 13.5
        tabLabel.TextColor3 = SUB
        tabLabel.Text = (icon or "📄") .. "  " .. tabName
        tabLabel.TextXAlignment = Enum.TextXAlignment.Left
        tabLabel.Parent = tabBtn
        
        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 3
        page.ScrollBarImageColor3 = ACCENT
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        page.ScrollingDirection = Enum.ScrollingDirection.Y
        page.Visible = false
        page.Parent = content
        page.BottomImage = ""
        page.TopImage = ""
        
        local pp = Instance.new("UIPadding", page)
        pp.PaddingTop = UDim.new(0, 14)
        pp.PaddingBottom = UDim.new(0, 50)
        pp.PaddingLeft = UDim.new(0, 16)
        pp.PaddingRight = UDim.new(0, 14)
        
        local pl = Instance.new("UIListLayout", page)
        pl.Padding = UDim.new(0, 9)
        pl.SortOrder = Enum.SortOrder.LayoutOrder
        
        tabs[tabName] = {
            Button = tabBtn,
            Accent = accent,
            Label = tabLabel,
            Page = page,
            Layout = pl,
            RowOrder = 0
        }
        
        tabBtn.MouseEnter:Connect(function()
            if currentTab ~= tabName then tabBtn.BackgroundColor3 = BG3 end
        end)
        tabBtn.MouseLeave:Connect(function()
            if currentTab ~= tabName then tabBtn.BackgroundColor3 = BG2 end
        end)
        tabBtn.MouseButton1Click:Connect(function() selectTab(tabName) end)
        
        if tabCount == 1 then selectTab(tabName) end
        
        local tabAPI = {}
        
        function tabAPI:CreateSection(text)
            tabs[tabName].RowOrder = tabs[tabName].RowOrder + 1
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 0, 0)
            lbl.AutomaticSize = Enum.AutomaticSize.Y
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 12
            lbl.TextColor3 = SUB
            lbl.TextWrapped = true
            lbl.RichText = true
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Text = text
            lbl.LayoutOrder = tabs[tabName].RowOrder
            lbl.Parent = page
        end
        
        function tabAPI:CreateToggle(config)
            local label = config.Name or "Toggle"
            local desc = config.Description or ""
            local default = config.Default or false
            local callback = config.Callback or function() end
            local flag = config.Flag or label
            
            tabs[tabName].RowOrder = tabs[tabName].RowOrder + 1
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 46)
            row.BackgroundColor3 = BG2
            row.BorderSizePixel = 0
            row.LayoutOrder = tabs[tabName].RowOrder
            row.Parent = page
            corner(row, 10)
            
            local st = Instance.new("UIStroke", row)
            st.Color = currentTheme.Stroke
            st.Thickness = 1
            st.Transparency = 0.3
            
            local t = Instance.new("TextLabel")
            t.Size = UDim2.new(1, -70, 0, 18)
            t.Position = UDim2.fromOffset(12, 6)
            t.BackgroundTransparency = 1
            t.Font = Enum.Font.GothamMedium
            t.TextSize = 13.5
            t.TextColor3 = TXT
            t.Text = label
            t.TextXAlignment = Enum.TextXAlignment.Left
            t.Parent = row
            
            local d = Instance.new("TextLabel")
            d.Size = UDim2.new(1, -70, 0, 13)
            d.Position = UDim2.fromOffset(12, 25)
            d.BackgroundTransparency = 1
            d.Font = Enum.Font.Gotham
            d.TextSize = 10.5
            d.TextColor3 = SUB
            d.Text = desc
            d.TextXAlignment = Enum.TextXAlignment.Left
            d.Parent = row
            
            local sw = Instance.new("Frame")
            sw.Size = UDim2.fromOffset(44, 24)
            sw.Position = UDim2.new(1, -56, 0.5, -12)
            sw.BackgroundColor3 = currentTheme.SwitchOff
            sw.BorderSizePixel = 0
            sw.Parent = row
            corner(sw, 12)
            
            local knob = Instance.new("Frame")
            knob.Size = UDim2.fromOffset(18, 18)
            knob.Position = UDim2.fromOffset(3, 3)
            knob.BackgroundColor3 = TXT
            knob.BorderSizePixel = 0
            knob.Parent = sw
            corner(knob, 9)
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.fromScale(1, 1)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = row
            
            local enabled = default
            local function render()
                TweenService:Create(sw, TweenInfo.new(0.18), {BackgroundColor3 = enabled and ACCENT or currentTheme.SwitchOff}):Play()
                TweenService:Create(knob, TweenInfo.new(0.18, Enum.EasingStyle.Back), {Position = enabled and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3)}):Play()
                TweenService:Create(st, TweenInfo.new(0.18), {Color = enabled and ACCENT or currentTheme.Stroke}):Play()
            end
            render()
            
            btn.MouseButton1Click:Connect(function()
                enabled = not enabled
                render()
                callback(enabled)
            end)
            
            return {
                Set = function(val) enabled = val; render() end,
                Get = function() return enabled end
            }
        end
        
        function tabAPI:CreateSlider(config)
            local label = config.Name or "Slider"
            local desc = config.Description or ""
            local minVal = config.Min or 0
            local maxVal = config.Max or 100
            local default = config.Default or 50
            local callback = config.Callback or function() end
            local flag = config.Flag or label
            
            tabs[tabName].RowOrder = tabs[tabName].RowOrder + 1
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 70)
            row.BackgroundColor3 = BG2
            row.BorderSizePixel = 0
            row.LayoutOrder = tabs[tabName].RowOrder
            row.Parent = page
            corner(row, 10)
            
            local t = Instance.new("TextLabel")
            t.Size = UDim2.new(1, -70, 0, 18)
            t.Position = UDim2.fromOffset(12, 8)
            t.BackgroundTransparency = 1
            t.Font = Enum.Font.GothamMedium
            t.TextSize = 13.5
            t.TextColor3 = TXT
            t.Text = label
            t.TextXAlignment = Enum.TextXAlignment.Left
            t.Parent = row
            
            local valLabel = Instance.new("TextLabel")
            valLabel.Size = UDim2.fromOffset(60, 18)
            valLabel.Position = UDim2.new(1, -72, 0, 8)
            valLabel.BackgroundTransparency = 1
            valLabel.Font = Enum.Font.GothamBold
            valLabel.TextSize = 13
            valLabel.TextColor3 = ACCENT
            valLabel.Text = tostring(default)
            valLabel.TextXAlignment = Enum.TextXAlignment.Right
            valLabel.Parent = row
            
            local d = Instance.new("TextLabel")
            d.Size = UDim2.new(1, -24, 0, 13)
            d.Position = UDim2.fromOffset(12, 28)
            d.BackgroundTransparency = 1
            d.Font = Enum.Font.Gotham
            d.TextSize = 10.5
            d.TextColor3 = SUB
            d.Text = desc
            d.TextXAlignment = Enum.TextXAlignment.Left
            d.Parent = row
            
            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -24, 0, 8)
            bar.Position = UDim2.fromOffset(12, 48)
            bar.BackgroundColor3 = BG3
            bar.BorderSizePixel = 0
            bar.Parent = row
            corner(bar, 4)
            
            local ratio = (default - minVal) / (maxVal - minVal)
            local fill = Instance.new("Frame")
            fill.Size = UDim2.fromScale(ratio, 1)
            fill.BackgroundColor3 = ACCENT
            fill.BorderSizePixel = 0
            fill.Parent = bar
            corner(fill, 4)
            
            local dot = Instance.new("TextButton")
            dot.Size = UDim2.fromOffset(16, 16)
            dot.Position = UDim2.new(ratio, -8, 0.5, -8)
            dot.BackgroundColor3 = TXT
            dot.Text = ""
            dot.Parent = bar
            corner(dot, 8)
            dot.ZIndex = 2
            
            local hitArea = Instance.new("TextButton")
            hitArea.Size = UDim2.new(1, 0, 1, 0)
            hitArea.BackgroundTransparency = 1
            hitArea.Text = ""
            hitArea.Parent = bar
            
            local dragging = false
            local inputCon = nil
            local currentVal = default
            
            local function update(input)
                local relX = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                currentVal = minVal + math.floor((maxVal - minVal) * relX + 0.5)
                fill.Size = UDim2.fromScale(relX, 1)
                dot.Position = UDim2.new(relX, -8, 0.5, -8)
                valLabel.Text = tostring(currentVal)
                callback(currentVal)
            end
            
            local function startDrag(input)
                dragging = true
                if inputCon then inputCon:Disconnect() end
                inputCon = UserInputService.InputChanged:Connect(function(i)
                    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                        update(i)
                    end
                end)
                update(input)
            end
            
            local function stopDrag()
                dragging = false
                if inputCon then inputCon:Disconnect(); inputCon = nil end
            end
            
            hitArea.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    startDrag(i)
                end
            end)
            hitArea.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    stopDrag()
                end
            end)
            dot.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    startDrag(i)
                end
            end)
            dot.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    stopDrag()
                end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.TouchEnded) and dragging then
                    stopDrag()
                end
            end)
            
            return {
                Set = function(val)
                    currentVal = math.clamp(val, minVal, maxVal)
                    local r = (currentVal - minVal) / (maxVal - minVal)
                    fill.Size = UDim2.fromScale(r, 1)
                    dot.Position = UDim2.new(r, -8, 0.5, -8)
                    valLabel.Text = tostring(currentVal)
                end,
                Get = function() return currentVal end
            }
        end
        
        function tabAPI:CreateButton(config)
            local label = config.Name or "Button"
            local callback = config.Callback or function() end
            
            tabs[tabName].RowOrder = tabs[tabName].RowOrder + 1
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 40)
            btn.BackgroundColor3 = ACCENT
            btn.BorderSizePixel = 0
            btn.Text = label
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 14
            btn.LayoutOrder = tabs[tabName].RowOrder
            btn.Parent = page
            corner(btn, 10)
            
            btn.MouseButton1Click:Connect(callback)
        end
        
        function tabAPI:CreateDropdown(config)
            local label = config.Name or "Dropdown"
            local desc = config.Description or ""
            local options = config.Options or {}
            local default = config.Default or options[1]
            local callback = config.Callback or function() end
            local flag = config.Flag or label
            
            tabs[tabName].RowOrder = tabs[tabName].RowOrder + 1
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 46)
            row.BackgroundColor3 = BG2
            row.BorderSizePixel = 0
            row.LayoutOrder = tabs[tabName].RowOrder
            row.Parent = page
            corner(row, 10)
            
            local t = Instance.new("TextLabel")
            t.Size = UDim2.new(1, -70, 0, 18)
            t.Position = UDim2.fromOffset(12, 6)
            t.BackgroundTransparency = 1
            t.Font = Enum.Font.GothamMedium
            t.TextSize = 13.5
            t.TextColor3 = TXT
            t.Text = label
            t.TextXAlignment = Enum.TextXAlignment.Left
            t.Parent = row
            
            local d = Instance.new("TextLabel")
            d.Size = UDim2.new(1, -70, 0, 13)
            d.Position = UDim2.fromOffset(12, 25)
            d.BackgroundTransparency = 1
            d.Font = Enum.Font.Gotham
            d.TextSize = 10.5
            d.TextColor3 = SUB
            d.Text = desc
            d.TextXAlignment = Enum.TextXAlignment.Left
            d.Parent = row
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.fromOffset(100, 24)
            btn.Position = UDim2.new(1, -112, 0, 12)
            btn.BackgroundColor3 = BG3
            btn.TextColor3 = TXT
            btn.Font = Enum.Font.GothamMedium
            btn.TextSize = 12
            btn.Text = default
            btn.Parent = row
            corner(btn, 8)
            
            local idx = table.find(options, default) or 1
            btn.MouseButton1Click:Connect(function()
                idx = idx % #options + 1
                btn.Text = options[idx]
                callback(options[idx])
            end)
            
            return {
                Set = function(val)
                    local i = table.find(options, val)
                    if i then idx = i; btn.Text = val end
                end,
                Get = function() return btn.Text end
            }
        end
        
        return tabAPI
    end
    
    -- Drag
    local drag, sp, si
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drag = true
            sp = main.Position
            si = i.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then drag = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local dd = i.Position - si
            main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + dd.X, sp.Y.Scale, sp.Y.Offset + dd.Y)
        end
    end)
    
    -- Minimize
    local mini = false
    minBtn.MouseButton1Click:Connect(function()
        mini = not mini
        TweenService:Create(main, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = mini and UDim2.fromOffset(620, 56) or UDim2.fromOffset(620, 500)
        }):Play()
        body.Visible = not mini
    end)
    
    -- Key toggle
    UserInputService.InputBegan:Connect(function(i, gpe)
        if gpe then return end
        if i.KeyCode == key then main.Visible = not main.Visible end
    end)
    
    -- Показать интро и затем окно
    main.Visible = false
    showIntro(name, subtitle, function()
        main.Visible = true
    end)
    
    return window
end

-- Возвращаем библиотеку
return Sm1leUI
