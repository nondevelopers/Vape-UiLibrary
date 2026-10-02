-- Vape UI Library - example
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/nondevelopers/Vape-UiLibrary/main/source.luau"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Accent color: white, or black when the theme is Light.
local THEME = "Dark"  -- "Dark", "Light" or "Black"
local function accentFor(theme)
    return theme == "Light" and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
end

-- lib:Window(title, accentColor, closeKeybind, size, transparency, theme)
--   size          Vector2  window dimensions, default Vector2.new(560, 319)
--   transparency  number   window transparency 0-1, default 0 (opaque)
--                          elements follow automatically: window + 0.25 (0.1 -> 0.35)
--   theme         string   "Dark" (default), "Light" or "Black"
local win = lib:Window(
    "Vape Ui Library PREVIEW",
    accentFor(THEME),
    Enum.KeyCode.RightControl,
    Vector2.new(560, 360),  -- custom size
    0.1,                    -- slight transparency
    THEME                   -- starting theme
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

tab:Section("Text & Binds")

-- tab:Textbox(title, clearOnFocus, callback)  —  callback fires on Enter.
tab:Textbox("Textbox", true, function(t) print(t) end)

-- tab:Bind(title, defaultKeycode, callback)  —  click to rebind; callback fires on key press.
tab:Bind("Bind", Enum.KeyCode.RightShift, function() print("Pressed!") end)

-- tab:Label(text)  —  plain informational text row, no interaction.
tab:Label("Label")

-- ── Updates tab (changelog, newest first) ─────────────────────────────────────
local updates = win:Tab("Updates", "history")

updates:Paragraph("10/02/2026",
    "[+] rounded the window and elements slightly.\n" ..
    "[+] added Light, Dark and Black themes, with a smooth fade when switching.\n" ..
    "[+] added lib:SetTheme(name) and lib:GetTheme().\n" ..
    "[+] added theme dropdown to the Settings tab.\n" ..
    "[+] added theme option to lib:Window.\n" ..
    "[+] added smooth animations: window fade in/out, tab content slide.\n" ..
    "[+] added Updates tab to the example script.\n" ..
    "[+] colorpicker now defaults to white.\n" ..
    "[+] \"Change UI Color\" now defaults to white, and switches to black when the theme is Light.\n" ..
    "[+] added :Set(color) to colorpickers, to set them from code.\n" ..
    "[+] fixed colorpicker selectors starting in the wrong position.\n" ..
    "[+] toggle knob now turns dark when the accent color is very light.\n" ..
    "[-] removed the demo Colorpicker from the example script.\n" ..
    "[+] redesigned dropdown options as rounded buttons with a hover effect, and an accent bar and check on the picked option.\n" ..
    "[+] added window transparency option, elements follow at window + 0.25.\n" ..
    "[+] added window size option (Vector2).\n" ..
    "[+] redesigned Label to look like plain text instead of a button.\n" ..
    "[+] moved Section headers higher.\n" ..
    "[+] simplified the example script comments.\n" ..
    "[+] fixed colorpicker box and textbox field position on custom window sizes.\n" ..
    "[+] close and minimize buttons now fade in on hover when the window is transparent.")

updates:Paragraph("07/18/2026",
    "[+] added support lucide icons for button, toggle.")

updates:Paragraph("07/17/2026",
    "[+] added lucide icons.\n" ..
    "[-] removed Movement tab.\n" ..
    "[+] added paragraphs, with avatar.\n" ..
    "[+] added drag to the mobile close/open button.")

updates:Paragraph("07/16/2026",
    "[+] added setting tab, with change theme, fully close ui.\n" ..
    "[-] removed change theme tab.\n" ..
    "[+] added section code.\n" ..
    "[+] added movement tab.\n" ..
    "[+] updated the example script.")

updates:Paragraph("07/15/2026",
    "[+] fixed color picker not working for mobile.\n" ..
    "[+] fixed slider.\n" ..
    "[+] added minimize button, close button.\n" ..
    "[+] added a button for mobile users only to hide/show the ui.")

-- ── Settings tab ──────────────────────────────────────────────────────────────
local settings = win:Tab("Settings", "settings")
settings:Section("Appearance")

-- lib:ChangePresetColor(color)  —  re-themes toggles, sliders, tab indicators live.
local accentPicker = settings:Colorpicker("Change UI Color", accentFor(THEME), function(t)
    lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)

-- lib:SetTheme("Dark" | "Light" | "Black")  —  fades the whole UI to the new theme.
-- picker:Set(color)  —  sets a colorpicker from code (here: accent follows the theme).
settings:Dropdown("Theme", {"Dark", "Light", "Black"}, function(t)
    lib:SetTheme(t)
    accentPicker:Set(accentFor(t))
end)

settings:Section("Danger Zone")

-- lib:Destroy()  —  removes the entire UI. Cannot be reopened without re-running the script.
settings:Button("Fully Close", function() lib:Destroy() end)
