-- Пример использования Sm1le UI Library
local Sm1leUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/yourusername/Universal/main/Library.lua'))()

local Window = Sm1leUI:CreateWindow({
    Name = "My Script v1.0",
    Subtitle = "Best Script Ever",
    Theme = "Blood",
    Key = Enum.KeyCode.RightControl
})

local Tab1 = Window:CreateTab("Main", "🏠")
local Tab2 = Window:CreateTab("Settings", "⚙️")

Tab1:CreateSection("Main Features")
Tab1:CreateToggle({
    Name = "Speed Hack",
    Description = "Walk faster",
    Default = false,
    Callback = function(val) print("Speed:", val) end
})

Tab1:CreateSlider({
    Name = "Speed Value",
    Description = "How fast",
    Min = 16,
    Max = 200,
    Default = 50,
    Callback = function(val) print("Speed:", val) end
})

Tab1:CreateButton({
    Name = "Click Me",
    Callback = function() print("Clicked!") end
})

Tab2:CreateDropdown({
    Name = "Theme",
    Description = "Choose theme",
    Options = {"Blood", "Ocean", "Midnight", "Forest", "Sunset"},
    Default = "Blood",
    Callback = function(val) print("Theme:", val) end
})
