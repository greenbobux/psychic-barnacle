
return function (UI_Type,BODY)
    print(UI_Type)
    local is = BODY ~= nil
    if UI_Type.type == "Frame" then
        return UI_Type.main(
        {FadeTime = 1,
        Desired = {
        Transparency = is and BODY.Transparency or 0;
        Color = Color3.new(0,0,0)
        };
        Default = {
            Transparency = is and BODY.Default.Transparency or 1,
        };
       })

    end
end