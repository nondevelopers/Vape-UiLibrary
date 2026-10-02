-- Vape UI Library - example
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/nondevelopers/Vape-UiLibrary/main/source.luau"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- lib:Window(title, accentColor, closeKeybind, size, transparency)
--   size          Vector2  window dimensions, default Vector2.new(560, 319)
--   transparency  number   window transparency 0-1, default 0 (opaque)
--                          elements follow automatically: window + 0.3 (0.1 -> 0.4)
local win = lib:Window(
    "Vape Ui Library PREVIEW",
    Color3.fromRGB(44, 120, 224),
    Enum.KeyCode.RightControl,
    Vector2.new(560, 360),  -- custom size
    0.1                     -- slight transparency
)

-- win:Tab(title, icon)  →  returns a tab to add elements to.
--   icon: Lucide name ("settings"), rbxassetid://, or https:// image link.
local tab = win:Tab("Tab 1", "layout-grid")

-- tab:Paragraph(title, text, avatar?)
--   avatar: userId number or username string for a circular thumbnail on the left.
tab:Paragraph("About", "Example UI showing every element in the library.")
tab:Paragraph(
    "Player Info",
    string.format("display: %s\nuser: %s\nuserid: %s",
        LocalPlayer.DisplayName, LocalPlayer.Name, LocalPlayer.UserId),
    LocalPlayer.UserId
)

-- tab:Section(text)  —  accent-colored group header. Returns :Set(newText).
tab:Section("Buttons")

-- tab:Button(title, callback, hasSettings?)
--   hasSettings: adds a "..." panel; use :Label(text) on the returned object to populate it.
tab:Button("Button", function()
    lib:Notification("Notification", "Hello!")
end)

local button2 = tab:Button("Button 2", function()
    print("Button 2 pressed")
end, true)
button2:Label("Setting 1")
button2:Label("Setting 2")
button2:Label("Setting 3")

tab:Section("Controls")

-- tab:Toggle(title, default, callback)
tab:Toggle("Toggle", false, function(t) print(t) end)

-- tab:Slider(title, min, max, start, callback)  —  fires continuously while dragging.
tab:Slider("Slider", 0, 100, 30, function(t) print(t) end)

-- tab:Dropdown(title, optionList, callback)
tab:Dropdown("Dropdown", {"Option 1", "Option 2", "Option 3", "Option 4", "Option 5"}, function(t)
    print(t)
end)

-- tab:Colorpicker(title, defaultColor, callback)
tab:Colorpicker("Colorpicker", Color3.fromRGB(255, 0, 0), function(t) print(t) end)

tab:Section("Text & Binds")

-- tab:Textbox(title, clearOnFocus, callback)  —  callback fires on Enter.
tab:Textbox("Textbox", true, function(t) print(t) end)

-- tab:Bind(title, defaultKeycode, callback)  —  click to rebind; callback fires on key press.
tab:Bind("Bind", Enum.KeyCode.RightShift, function() print("Pressed!") end)

-- tab:Label(text)  —  plain informational text row, no interaction.
tab:Label("Label")

-- ── Settings tab ──────────────────────────────────────────────────────────────
local settings = win:Tab("Settings", "settings")
settings:Section("Appearance")

-- lib:ChangePresetColor(color)  —  re-themes toggles, sliders, tab indicators live.
settings:Colorpicker("Change UI Color", Color3.fromRGB(44, 120, 224), function(t)
    lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)

settings:Section("Danger Zone")

-- lib:Destroy()  —  removes the entire UI. Cannot be reopened without re-running the script.
settings:Button("Fully Close", function() lib:Destroy() end)
