-- ============================================================
-- Vape UI Library - usage example
-- ============================================================

-- lib:Window(title, accentColor, closeKeybind)
--   Creates the window. accentColor tints toggles/sliders/etc.
--   closeKeybind (optional, defaults to RightControl) hides/shows
--   the whole UI when pressed. Returns "win", used to make tabs.
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/nondevelopers/Vape-old-UiLibrary/main/vape-old.lua"))()

local win = lib:Window("PREVIEW", Color3.fromRGB(44, 120, 224), Enum.KeyCode.RightControl)

-- win:Tab(title)
--   Adds a tab to the sidebar. Returns "tab", used to add elements
--   to that tab. Call win:Tab(...) again for more tabs.
local tab = win:Tab("Tab 1")

-- tab:Button(title, callback, hasSettings)
--   A simple clickable button; callback runs on click.
--   hasSettings (optional, true/false) adds a "..." to the button -
--   right-click it (PC) or tap the dots (mobile) to open a small
--   panel below it. Button returns an object with :Label(text) to
--   add rows to that panel.
tab:Button("Button", function()
    lib:Notification("Notification", "Hello!", "Hi!")
end)

local button2 = tab:Button("Button 2", function()
    print("Button 2 pressed")
end, true)

button2:Label("Setting 1")
button2:Label("Setting 2")
button2:Label("Setting 3")

-- tab:Toggle(title, default, callback)
--   An on/off switch. default is the starting state (true/false).
--   callback fires with the new state every time it's flipped.
tab:Toggle("Toggle", false, function(t)
    print(t)
end)

-- tab:Slider(title, min, max, default, callback)
--   A draggable number slider. callback fires with the current
--   value while dragging.
tab:Slider("Slider", 0, 100, 30, function(t)
    print(t)
end)

-- tab:Dropdown(title, {options...}, callback)
--   A collapsible list of string options. callback fires with the
--   option that was clicked.
tab:Dropdown("Dropdown", {"Option 1", "Option 2", "Option 3", "Option 4", "Option 5"}, function(t)
    print(t)
end)

-- tab:Colorpicker(title, defaultColor, callback)
--   A hue/saturation/value color picker. callback fires with the
--   chosen Color3 whenever it changes.
tab:Colorpicker("Colorpicker", Color3.fromRGB(255, 0, 0), function(t)
    print(t)
end)

-- tab:Textbox(title, clearOnFocus, callback)
--   A single-line text input. clearOnFocus (true/false) wipes the
--   box when clicked. callback fires with the typed text on enter.
tab:Textbox("Textbox", true, function(t)
    print(t)
end)

-- tab:Bind(title, defaultKeycode, callback)
--   A rebindable keybind - click it, then press a key to change it.
--   callback fires (no arguments) whenever that key is pressed.
tab:Bind("Bind", Enum.KeyCode.RightShift, function()
    print("Pressed!")
end)

-- tab:Label(text)
--   Plain, non-interactive text - useful for section headers or notes.
tab:Label("Label")

-- ============================================================
-- Simple movement examples - speed and jump height, just to show
-- the components actually driving something. Both re-apply
-- whenever the character respawns.
-- ============================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local DEFAULT_WALKSPEED = 16
local DEFAULT_JUMPPOWER = 50

local speedEnabled = false
local speedAmount = 50

local jumpEnabled = false
local jumpAmount = 100

local function GetHumanoid()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return character:WaitForChild("Humanoid")
end

local movement = win:Tab("Movement")

movement:Toggle("Speed", false, function(state)
    speedEnabled = state
    GetHumanoid().WalkSpeed = state and speedAmount or DEFAULT_WALKSPEED
end)

movement:Slider("Speed Amount", 16, 200, speedAmount, function(value)
    speedAmount = value
    if speedEnabled then
        GetHumanoid().WalkSpeed = value
    end
end)

movement:Toggle("Jump Power", false, function(state)
    jumpEnabled = state
    GetHumanoid().JumpPower = state and jumpAmount or DEFAULT_JUMPPOWER
end)

movement:Slider("Jump Amount", 50, 250, jumpAmount, function(value)
    jumpAmount = value
    if jumpEnabled then
        GetHumanoid().JumpPower = value
    end
end)

-- Re-apply after respawning, since a fresh Humanoid resets to defaults
LocalPlayer.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = speedEnabled and speedAmount or DEFAULT_WALKSPEED
    humanoid.JumpPower = jumpEnabled and jumpAmount or DEFAULT_JUMPPOWER
end)

-- ============================================================
-- A second tab used purely to re-theme the UI's accent color
-- ============================================================
local changeclr = win:Tab("Change UI Color")

-- lib:ChangePresetColor(color)
--   Changes the accent color used by toggles/sliders/etc. across
--   the whole window, live.
changeclr:Colorpicker("Change UI Color", Color3.fromRGB(44, 120, 224), function(t)
    lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)
