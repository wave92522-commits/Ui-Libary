return function()
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")

    local Themes = {
        Blood = {
            ACCENT = Color3.fromRGB(255,0,0), ACCENT2 = Color3.fromRGB(0,0,0),
            BG = Color3.fromRGB(20,5,5), BG2 = Color3.fromRGB(30,8,8), BG3 = Color3.fromRGB(45,12,12),
            TXT = Color3.fromRGB(255,240,240), SUB = Color3.fromRGB(200,150,150),
            Stroke = Color3.fromRGB(120,15,15), SwitchOff = Color3.fromRGB(45,12,12),
            TitleGrad1 = Color3.fromRGB(255,0,0), TitleGrad2 = Color3.fromRGB(0,0,0),
            ByGrad1 = Color3.fromRGB(255,80,80), ByGrad2 = Color3.fromRGB(0,0,0)
        },
        Ocean = {
            ACCENT = Color3.fromRGB(0,100,255), ACCENT2 = Color3.fromRGB(0,0,40),
            BG = Color3.fromRGB(5,8,20), BG2 = Color3.fromRGB(8,12,30), BG3 = Color3.fromRGB(12,18,45),
            TXT = Color3.fromRGB(235,240,255), SUB = Color3.fromRGB(140,160,200),
            Stroke = Color3.fromRGB(15,40,120), SwitchOff = Color3.fromRGB(12,18,45),
            TitleGrad1 = Color3.fromRGB(0,150,255), TitleGrad2 = Color3.fromRGB(0,0,50),
            ByGrad1 = Color3.fromRGB(0,180,255), ByGrad2 = Color3.fromRGB(0,0,50)
        },
        Midnight = {
            ACCENT = Color3.fromRGB(140,0,255), ACCENT2 = Color3.fromRGB(5,0,20),
            BG = Color3.fromRGB(8,5,20), BG2 = Color3.fromRGB(14,8,30), BG3 = Color3.fromRGB(22,12,45),
            TXT = Color3.fromRGB(240,235,255), SUB = Color3.fromRGB(160,140,200),
            Stroke = Color3.fromRGB(50,10,120), SwitchOff = Color3.fromRGB(22,12,45),
            TitleGrad1 = Color3.fromRGB(170,50,255), TitleGrad2 = Color3.fromRGB(10,0,30),
            ByGrad1 = Color3.fromRGB(180,80,255), ByGrad2 = Color3.fromRGB(10,0,30)
        },
        Forest = {
            ACCENT = Color3.fromRGB(0,200,50), ACCENT2 = Color3.fromRGB(0,15,0),
            BG = Color3.fromRGB(5,15,5), BG2 = Color3.fromRGB(8,22,8), BG3 = Color3.fromRGB(12,32,12),
            TXT = Color3.fromRGB(235,255,235), SUB = Color3.fromRGB(140,200,140),
            Stroke = Color3.fromRGB(15,80,15), SwitchOff = Color3.fromRGB(12,32,12),
            TitleGrad1 = Color3.fromRGB(0,255,80), TitleGrad2 = Color3.fromRGB(0,20,0),
            ByGrad1 = Color3.fromRGB(50,255,100), ByGrad2 = Color3.fromRGB(0,20,0)
        },
        Sunset = {
            ACCENT = Color3.fromRGB(255,120,0), ACCENT2 = Color3.fromRGB(20,3,0),
            BG = Color3.fromRGB(18,8,3), BG2 = Color3.fromRGB(28,12,5), BG3 = Color3.fromRGB(42,18,8),
            TXT = Color3.fromRGB(255,245,235), SUB = Color3.fromRGB(200,160,120),
            Stroke = Color3.fromRGB(100,30,5), SwitchOff = Color3.fromRGB(42,18,8),
            TitleGrad1 = Color3.fromRGB(255,150,30), TitleGrad2 = Color3.fromRGB(30,5,0),
            ByGrad1 = Color3.fromRGB(255,170,50), ByGrad2 = Color3.fromRGB(30,5,0)
        },
        System = {
            ACCENT = Color3.fromRGB(0,200,200), ACCENT2 = Color3.fromRGB(0,20,20),
            BG = Color3.fromRGB(3,15,15), BG2 = Color3.fromRGB(5,22,22), BG3 = Color3.fromRGB(8,32,32),
            TXT = Color3.fromRGB(220,255,255), SUB = Color3.fromRGB(130,200,200),
            Stroke = Color3.fromRGB(10,80,80), SwitchOff = Color3.fromRGB(8,32,32),
            TitleGrad1 = Color3.fromRGB(0,255,255), TitleGrad2 = Color3.fromRGB(0,30,30),
            ByGrad1 = Color3.fromRGB(50,255,255), ByGrad2 = Color3.fromRGB(0,30,30)
        }
    }

    local function corner(p, r)
        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(0, r)
        c.Parent = p
        return c
    end

    local function pad(p, t, b, l, r)
        local u = Instance.new("UIPadding")
        u.PaddingTop = UDim.new(0, t)
        u.PaddingBottom = UDim.new(0, b)
        u.PaddingLeft = UDim.new(0, l)
        u.PaddingRight = UDim.new(0, r)
        u.Parent = p
        return u
    end

    local function gradient(p, c1, c2, rot)
        local g = Instance.new("UIGradient")
        g.Color = ColorSequence.new(c1, c2)
        g.Rotation = rot or 0
        g.Parent = p
        return g
    end

    local Library = {}

    function Library:CreateWindow(config)
        config = config or {}
        local Window = {}
        local Tabs = {}
        local Pages = {}
        local ActiveTab = nil
        local AllRows = {}

        local Theme = Themes[config.Theme or "Blood"]
        local ACCENT = Theme.ACCENT
        local BG = Theme.BG
        local BG2 = Theme.BG2
        local BG3 = Theme.BG3
        local TXT = Theme.TXT
        local SUB = Theme.SUB

        local parent = (gethui and gethui()) or game:GetService("CoreGui")
        local gui = Instance.new("ScreenGui")
        gui.Name = config.Name or "Sm1leLib"
        gui.ResetOnSpawn = false
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.IgnoreGuiInset = true
        gui.Parent = parent

        local main = Instance.new("Frame")
        main.Size = config.Size or UDim2.fromOffset(520, 440)
        main.Position = UDim2.fromScale(0.5, 0.5)
        main.AnchorPoint = Vector2.new(0.5, 0.5)
        main.BackgroundColor3 = BG
        main.BorderSizePixel = 0
        main.ClipsDescendants = true
        main.Parent = gui
        corner(main, 16)

        local mst = Instance.new("UIStroke", main)
        mst.Color = Theme.Stroke
        mst.Thickness = 1.5

        local header = Instance.new("Frame")
        header.Size = UDim2.new(1, 0, 0, 56)
        header.BackgroundColor3 = BG2
        header.BorderSizePixel = 0
        header.Parent = main
        corner(header, 16)

        local hfix = Instance.new("Frame")
        hfix.Size = UDim2.new(1, 0, 0, 16)
        hfix.Position = UDim2.new(0, 0, 1, -16)
        hfix.BackgroundColor3 = BG2
        hfix.BorderSizePixel = 0
        hfix.Parent = header

        local logo = Instance.new("TextLabel")
        logo.Size = UDim2.fromOffset(40, 40)
        logo.Position = UDim2.fromOffset(14, 8)
        logo.BackgroundTransparency = 1
        logo.Font = Enum.Font.GothamBold
        logo.Text = config.Logo or "🏃"
        logo.TextSize = 28
        logo.Parent = header

        local titleC = Instance.new("TextLabel")
        titleC.Size = UDim2.fromOffset(200, 22)
        titleC.Position = UDim2.fromOffset(58, 11)
        titleC.BackgroundTransparency = 1
        titleC.Font = Enum.Font.GothamBold
        titleC.TextSize = 19
        titleC.TextColor3 = TXT
        titleC.Text = config.Title or "LIBRARY"
        titleC.TextXAlignment = Enum.TextXAlignment.Left
        titleC.Parent = header
        gradient(titleC, Theme.TitleGrad1, Theme.TitleGrad2, 0)

        local byLabel = Instance.new("TextLabel")
        byLabel.Size = UDim2.fromOffset(100, 16)
        byLabel.Position = UDim2.fromOffset(58, 29)
        byLabel.BackgroundTransparency = 1
        byLabel.Font = Enum.Font.GothamBlack
        byLabel.TextSize = 11
        byLabel.TextColor3 = TXT
        byLabel.Text = config.Subtitle or "by Dev"
        byLabel.TextXAlignment = Enum.TextXAlignment.Left
        byLabel.Parent = header
        gradient(byLabel, Theme.ByGrad1, Theme.ByGrad2, 0)

        local statusL = Instance.new("TextLabel")
        statusL.Size = UDim2.fromOffset(280, 14)
        statusL.Position = UDim2.fromOffset(58, 44)
        statusL.BackgroundTransparency = 1
        statusL.Font = Enum.Font.GothamMedium
        statusL.TextSize = 9
        statusL.TextColor3 = SUB
        statusL.Text = config.Status or "Ready"
        statusL.TextXAlignment = Enum.TextXAlignment.Left
        statusL.Parent = header

        local function createHeaderButton(text, xOffset)
            local b = Instance.new("TextButton")
            b.Size = UDim2.fromOffset(28, 28)
            b.Position = UDim2.new(1, xOffset, 0, 14)
            b.BackgroundColor3 = BG3
            b.Text = text
            b.TextColor3 = TXT
            b.Font = Enum.Font.GothamBold
            b.TextSize = 15
            b.AutoButtonColor = true
            b.Parent = header
            corner(b, 8)
            return b
        end

        local closeB = createHeaderButton("✕", -40)
        local minB = createHeaderButton("—", -74)

        local body = Instance.new("Frame")
        body.Size = UDim2.new(1, 0, 1, -56)
        body.Position = UDim2.fromOffset(0, 56)
        body.BackgroundTransparency = 1
        body.Parent = main

        local side = Instance.new("Frame")
        side.Size = UDim2.new(0, 140, 1, 0)
        side.BackgroundColor3 = BG2
        side.BorderSizePixel = 0
        side.Parent = body
        pad(side, 12, 12, 10, 10)

        local sl = Instance.new("UIListLayout", side)
        sl.Padding = UDim.new(0, 6)
        sl.SortOrder = Enum.SortOrder.LayoutOrder

        local content = Instance.new("Frame")
        content.Size = UDim2.new(1, -140, 1, 0)
        content.Position = UDim2.fromOffset(140, 0)
        content.BackgroundTransparency = 1
        content.Parent = body

        function Window:SelectTab(name)
            ActiveTab = name
            for n, m in pairs(Tabs) do
                local on = (n == name)
                TweenService:Create(m.btn, TweenInfo.new(0.18), {
                    BackgroundColor3 = on and BG3 or BG2
                }):Play()
                m.accent.Visible = on
                m.lbl.TextColor3 = on and TXT or SUB
            end
            for n, p in pairs(Pages) do
                p.Visible = (n == name)
                if p.Visible then
                    p.CanvasPosition = Vector2.new(0, 0)
                end
            end
        end

        local tabOrder = 0

        function Window:CreateTab(name, icon)
            tabOrder = tabOrder + 1

            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, 0, 0, 40)
            b.BackgroundColor3 = BG2
            b.AutoButtonColor = false
            b.Text = ""
            b.LayoutOrder = tabOrder
            b.Parent = side
            corner(b, 10)

            local acc = Instance.new("Frame")
            acc.Size = UDim2.fromOffset(3, 20)
            acc.Position = UDim2.fromOffset(0, 10)
            acc.BackgroundColor3 = ACCENT
            acc.BorderSizePixel = 0
            acc.Visible = false
            acc.Parent = b
            corner(acc, 2)

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -16, 1, 0)
            lbl.Position = UDim2.fromOffset(14, 0)
            lbl.BackgroundTransparency = 1
            lbl.Font = Enum.Font.GothamMedium
            lbl.TextSize = 13.5
            lbl.TextColor3 = SUB
            lbl.Text = (icon or "") .. "  " .. name
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = b

            Tabs[name] = { btn = b, accent = acc, lbl = lbl }

            b.MouseEnter:Connect(function()
                if ActiveTab ~= name then
                    b.BackgroundColor3 = BG3
                end
            end)
            b.MouseLeave:Connect(function()
                if ActiveTab ~= name then
                    b.BackgroundColor3 = BG2
                end
            end)
            b.MouseButton1Click:Connect(function()
                Window:SelectTab(name)
            end)

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
            pad(page, 14, 50, 16, 14)
            page.BottomImage = ""
            page.TopImage = ""
            page.ScrollBarImageTransparency = 0

            local pl = Instance.new("UIListLayout", page)
            pl.Padding = UDim.new(0, 9)
            pl.SortOrder = Enum.SortOrder.LayoutOrder

            Pages[name] = page

            if tabOrder == 1 then
                Window:SelectTab(name)
            end

            local Tab = {}
            local rowOrder = 0

            function Tab:CreateToggle(config)
                config = config or {}
                rowOrder = rowOrder + 1

                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 46)
                row.BackgroundColor3 = BG2
                row.BorderSizePixel = 0
                row.LayoutOrder = rowOrder
                row.Parent = page
                corner(row, 10)

                local st = Instance.new("UIStroke", row)
                st.Color = Theme.Stroke
                st.Thickness = 1
                st.Transparency = 0.3

                local t = Instance.new("TextLabel")
                t.Size = UDim2.new(1, -70, 0, 18)
                t.Position = UDim2.fromOffset(12, 6)
                t.BackgroundTransparency = 1
                t.Font = Enum.Font.GothamMedium
                t.TextSize = 13.5
                t.TextColor3 = TXT
                t.Text = config.Name or "Toggle"
                t.TextXAlignment = Enum.TextXAlignment.Left
                t.Parent = row

                local d = Instance.new("TextLabel")
                d.Size = UDim2.new(1, -70, 0, 13)
                d.Position = UDim2.fromOffset(12, 25)
                d.BackgroundTransparency = 1
                d.Font = Enum.Font.Gotham
                d.TextSize = 10.5
                d.TextColor3 = SUB
                d.Text = config.Description or ""
                d.TextXAlignment = Enum.TextXAlignment.Left
                d.Parent = row

                local sw = Instance.new("Frame")
                sw.Size = UDim2.fromOffset(44, 24)
                sw.Position = UDim2.new(1, -56, 0.5, -12)
                sw.BackgroundColor3 = Theme.SwitchOff
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

                local state = config.Default or false

                local function render()
                    TweenService:Create(sw, TweenInfo.new(0.18), {
                        BackgroundColor3 = state and ACCENT or Theme.SwitchOff
                    }):Play()
                    TweenService:Create(knob, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
                        Position = state and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3)
                    }):Play()
                    TweenService:Create(st, TweenInfo.new(0.18), {
                        Color = state and ACCENT or Theme.Stroke
                    }):Play()
                end

                btn.MouseButton1Click:Connect(function()
                    state = not state
                    render()
                    if config.Callback then
                        config.Callback(state)
                    end
                end)

                render()
                table.insert(AllRows, {
                    type = "toggle",
                    row = row,
                    st = st,
                    t = t,
                    d = d,
                    sw = sw,
                    knob = knob,
                    state = state
                })
            end

            function Tab:CreateSlider(config)
                config = config or {}
                rowOrder = rowOrder + 1

                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 70)
                row.BackgroundColor3 = BG2
                row.BorderSizePixel = 0
                row.LayoutOrder = rowOrder
                row.Parent = page
                corner(row, 10)

                local t = Instance.new("TextLabel")
                t.Size = UDim2.new(1, -70, 0, 18)
                t.Position = UDim2.fromOffset(12, 8)
                t.BackgroundTransparency = 1
                t.Font = Enum.Font.GothamMedium
                t.TextSize = 13.5
                t.TextColor3 = TXT
                t.Text = config.Name or "Slider"
                t.TextXAlignment = Enum.TextXAlignment.Left
                t.Parent = row

                local valLabel = Instance.new("TextLabel")
                valLabel.Size = UDim2.fromOffset(60, 18)
                valLabel.Position = UDim2.new(1, -72, 0, 8)
                valLabel.BackgroundTransparency = 1
                valLabel.Font = Enum.Font.GothamBold
                valLabel.TextSize = 13
                valLabel.TextColor3 = ACCENT
                valLabel.Text = tostring(config.Default or 0)
                valLabel.TextXAlignment = Enum.TextXAlignment.Right
                valLabel.Parent = row

                local d = Instance.new("TextLabel")
                d.Size = UDim2.new(1, -24, 0, 13)
                d.Position = UDim2.fromOffset(12, 28)
                d.BackgroundTransparency = 1
                d.Font = Enum.Font.Gotham
                d.TextSize = 10.5
                d.TextColor3 = SUB
                d.Text = config.Description or ""
                d.TextXAlignment = Enum.TextXAlignment.Left
                d.Parent = row

                local bar = Instance.new("Frame")
                bar.Size = UDim2.new(1, -24, 0, 8)
                bar.Position = UDim2.fromOffset(12, 48)
                bar.BackgroundColor3 = BG3
                bar.BorderSizePixel = 0
                bar.Parent = row
                corner(bar, 4)

                local minVal = config.Min or 0
                local maxVal = config.Max or 100
                local state = config.Default or minVal
                local ratio = (state - minVal) / (maxVal - minVal)

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
                local inputConnection

                local function updateSlider(input)
                    local relX = math.clamp(
                        (input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X,
                        0, 1
                    )
                    state = minVal + math.floor((maxVal - minVal) * relX + 0.5)
                    fill.Size = UDim2.fromScale(relX, 1)
                    dot.Position = UDim2.new(relX, -8, 0.5, -8)
                    valLabel.Text = tostring(state)
                    if config.Callback then
                        config.Callback(state)
                    end
                end

                local function startDrag(input)
                    dragging = true
                    if inputConnection then
                        inputConnection:Disconnect()
                    end
                    inputConnection = UserInputService.InputChanged:Connect(function(input2)
                        if dragging and (input2.UserInputType == Enum.UserInputType.MouseMovement or input2.UserInputType == Enum.UserInputType.Touch) then
                            updateSlider(input2)
                        end
                    end)
                    updateSlider(input)
                end

                local function stopDrag()
                    dragging = false
                    if inputConnection then
                        inputConnection:Disconnect()
                        inputConnection = nil
                    end
                end

                hitArea.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        startDrag(input)
                    end
                end)
                hitArea.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        stopDrag()
                    end
                end)
                dot.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        startDrag(input)
                    end
                end)
                dot.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        stopDrag()
                    end
                end)

                table.insert(AllRows, {
                    type = "slider",
                    row = row,
                    t = t,
                    valLabel = valLabel,
                    d = d,
                    bar = bar,
                    fill = fill,
                    dot = dot,
                    state = state
                })
            end

            function Tab:CreateButton(config)
                config = config or {}
                rowOrder = rowOrder + 1

                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 46)
                row.BackgroundColor3 = BG2
                row.BorderSizePixel = 0
                row.LayoutOrder = rowOrder
                row.Parent = page
                corner(row, 10)

                local btn = Instance.new("TextButton")
                btn.Size = UDim2.fromScale(1, 1)
                btn.BackgroundColor3 = ACCENT
                btn.Text = config.Name or "Button"
                btn.TextColor3 = TXT
                btn.Font = Enum.Font.GothamBold
                btn.TextSize = 14
                btn.Parent = row
                corner(btn, 10)

                btn.MouseButton1Click:Connect(function()
                    if config.Callback then
                        config.Callback()
                    end
                end)

                table.insert(AllRows, { type = "button", row = row, btn = btn })
            end

            function Tab:CreateTextbox(config)
                config = config or {}
                rowOrder = rowOrder + 1

                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 60)
                row.BackgroundColor3 = BG2
                row.BorderSizePixel = 0
                row.LayoutOrder = rowOrder
                row.Parent = page
                corner(row, 10)

                local t = Instance.new("TextLabel")
                t.Size = UDim2.new(1, -24, 0, 18)
                t.Position = UDim2.fromOffset(12, 6)
                t.BackgroundTransparency = 1
                t.Font = Enum.Font.GothamMedium
                t.TextSize = 13.5
                t.TextColor3 = TXT
                t.Text = config.Name or "Textbox"
                t.TextXAlignment = Enum.TextXAlignment.Left
                t.Parent = row

                local d = Instance.new("TextLabel")
                d.Size = UDim2.new(1, -24, 0, 13)
                d.Position = UDim2.fromOffset(12, 24)
                d.BackgroundTransparency = 1
                d.Font = Enum.Font.Gotham
                d.TextSize = 10.5
                d.TextColor3 = SUB
                d.Text = config.Description or ""
                d.TextXAlignment = Enum.TextXAlignment.Left
                d.Parent = row

                local box = Instance.new("TextBox")
                box.Size = UDim2.new(1, -24, 0, 24)
                box.Position = UDim2.fromOffset(12, 38)
                box.BackgroundColor3 = BG3
                box.TextColor3 = TXT
                box.Font = Enum.Font.GothamBold
                box.TextSize = 12
                box.Text = config.Default or ""
                box.PlaceholderText = config.Placeholder or "Enter text..."
                box.PlaceholderColor3 = SUB
                box.Parent = row
                corner(box, 8)

                box.FocusLost:Connect(function(ep)
                    if config.Callback then
                        config.Callback(box.Text)
                    end
                    if ep then
                        box.Text = config.Default or ""
                    end
                end)

                table.insert(AllRows, { type = "textbox", row = row, t = t, d = d, box = box })
            end

            function Tab:CreateSection(text)
                rowOrder = rowOrder + 1
                local l = Instance.new("TextLabel")
                l.Size = UDim2.new(1, 0, 0, 0)
                l.AutomaticSize = Enum.AutomaticSize.Y
                l.BackgroundTransparency = 1
                l.Font = Enum.Font.Gotham
                l.TextSize = 11.5
                l.TextColor3 = SUB
                l.TextWrapped = true
                l.RichText = true
                l.TextXAlignment = Enum.TextXAlignment.Left
                l.Text = text or ""
                l.LayoutOrder = rowOrder
                l.Parent = page
                table.insert(AllRows, { type = "section", label = l })
            end

            return Tab
        end

        function Window:SetTheme(themeName)
            if not Themes[themeName] then return end
            Theme = Themes[themeName]
            ACCENT = Theme.ACCENT
            BG = Theme.BG
            BG2 = Theme.BG2
            BG3 = Theme.BG3
            TXT = Theme.TXT
            SUB = Theme.SUB

            main.BackgroundColor3 = BG
            mst.Color = Theme.Stroke
            header.BackgroundColor3 = BG2
            hfix.BackgroundColor3 = BG2
            side.BackgroundColor3 = BG2

            if titleC:FindFirstChildOfClass("UIGradient") then
                titleC:FindFirstChildOfClass("UIGradient"):Destroy()
            end
            gradient(titleC, Theme.TitleGrad1, Theme.TitleGrad2, 0)
            titleC.TextColor3 = TXT

            if byLabel:FindFirstChildOfClass("UIGradient") then
                byLabel:FindFirstChildOfClass("UIGradient"):Destroy()
            end
            gradient(byLabel, Theme.ByGrad1, Theme.ByGrad2, 0)
            byLabel.TextColor3 = TXT

            statusL.TextColor3 = SUB
            closeB.BackgroundColor3 = BG3
            closeB.TextColor3 = TXT
            minB.BackgroundColor3 = BG3
            minB.TextColor3 = TXT

            for name, tabData in pairs(Tabs) do
                local on = (ActiveTab == name)
                tabData.btn.BackgroundColor3 = on and BG3 or BG2
                tabData.accent.BackgroundColor3 = ACCENT
                tabData.lbl.TextColor3 = on and TXT or SUB
            end

            for _, page in pairs(Pages) do
                page.ScrollBarImageColor3 = ACCENT
            end
        end

        local minimized = false
        minB.MouseButton1Click:Connect(function()
            minimized = not minimized
            TweenService:Create(main, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                Size = minimized and UDim2.fromOffset(520, 56) or (config.Size or UDim2.fromOffset(520, 440))
            }):Play()
            body.Visible = not minimized
        end)

        function Window:Destroy()
            gui:Destroy()
        end

        closeB.MouseButton1Click:Connect(function()
            Window:Destroy()
        end)

        local dragging = false
        local dragStart, startPos

        header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = main.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                main.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)

        if config.ToggleKey then
            UserInputService.InputBegan:Connect(function(input, gpe)
                if gpe then return end
                if input.KeyCode == config.ToggleKey then
                    main.Visible = not main.Visible
                end
            end)
        end

        return Window
    end

    return Library
end
