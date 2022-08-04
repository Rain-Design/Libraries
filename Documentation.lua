Library.Flags -- table with the flags
Library.DefaultColor -- change that at the beginning of the script if you want to change the color of sliders, toggles etc.. (you can't change it after setting them **yet**)

Library:Window({
    Text = string
})

Library:Notification({
    Text = string
    Duration = number
    Color = color3
})

Window:Label({
    Text = string
    Color = color3
})

Label:Set({
    Text = string
    Color = color3
})

Window:Button({
    Text = string
    Callback = function
})

Window:Toggle({
    Text = string
    Flag = string
    Default = boolean
    Callback = function
})

Toggle:Set({
    Bool = boolean
})

Window:Keybind({
    Text = string
    Default = enum keycode
    Callback = function
})

Window:Slider({
    Text = string
    Flag = string
    Postfix = string -- \\ (Postfix is what appears after the value of the slider)
    Default = number
    Minimum = number
    Maximum = number
    Callback = function
})

-- \\ Slider doesn't have a Set function yet but i'll make one soon

Window:Dropdown({
    Text = string
    List = table
    Callback = function
})

Window:Prompt({
    Text = string
    OnConfirm = function
    OnCancel = function
})
