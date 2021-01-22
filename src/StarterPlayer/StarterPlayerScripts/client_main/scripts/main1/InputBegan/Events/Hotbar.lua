--[[
IsKeyboard = IsKeyboard;
IsMouse = IsMouse;
Input = IsMouse and UIT or IsKeyboard and KC;

]]
return function(Input)
    print(Input.Input.Name)
end