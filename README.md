# Sm1le UI Library

Простая и красивая UI библиотека для Roblox скриптов.

## Быстрый старт

```lua
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/wave92522-commits/Ui-Libary/refs/heads/main/Libary.lua'))()

local Window = Library:CreateWindow({
    Name = "My Script",
    Subtitle = "v1.0",
    Theme = "Blood",
    Key = Enum.KeyCode.RightControl
})

local Tab = Window:CreateTab("Main", "🏠")

Tab:CreateToggle({
    Name = "Feature",
    Description = "Toggle something",
    Default = false,
    Callback = function(val) end
})

Tab:CreateSlider({
    Name = "Slider",
    Description = "Adjust value",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(val) end
})

Tab:CreateButton({
    Name = "Click Me",
    Callback = function() end
})
