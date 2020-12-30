return function (a)
    assert(a:IsA("InputObject"), "Expected input object got")
    local KC, UIS, UIT, POS,DA = a.KeyCode,a.UserInputState,a.UserInputType,a.Position,a.Delta
    local IsKeyboardCharacter = KC ~= Enum.KeyCode.Unknown
    local IsKeyboard = KC ~= Enum.KeyCode.Unknown and UIT == Enum.UserInputType.Keyboard
    local IsMouse = UIT.Name:sub(1,5):lower() == "mouse"

    return {
        IsKeyboard = IsKeyboard;
        IsMouse = IsMouse;
        Input = IsMouse and UIT or IsKeyboard and KC;
    }
end
