local convar = CreateClientConVar("moat_ui_sounds", 1, true, false)
sfx = sfx or {}

function sfx.Dustbin()
    if (convar:GetInt() > 0) then
        cdn.PlayURL"https://tttweb.bungo.ca/ttt/drops/decon_notify.mp3"
    end
end

function sfx.Cut()
    if (convar:GetInt() > 0) then
        cdn.PlayURL("https://tttweb.bungo.ca/ttt/misc/tttsounds/cut.ogg")
    end
end

function sfx.Tick()
    if (convar:GetInt() > 0) then
        cdn.PlayURL("https://tttweb.bungo.ca/ttt/misc/tttsounds/cut.ogg", .1)
    end
end

function sfx.Bells()
    if (convar:GetInt() > 0) then
        cdn.PlayURL"https://tttweb.bungo.ca/ttt/misc/tttsounds/message.ogg"
    end
end

function sfx.Subtract()
    if (convar:GetInt() > 0) then
        cdn.PlayURL"https://tttweb.bungo.ca/ttt/misc/tttsounds/click4.ogg"
    end
end

function sfx.Add()
    if (convar:GetInt() > 0) then
        cdn.PlayURL"https://tttweb.bungo.ca/ttt/misc/tttsounds/click5.ogg"
    end
end

function sfx.Max()
    if (convar:GetInt() > 0) then
        cdn.PlayURL"https://tttweb.bungo.ca/ttt/misc/tttsounds/click6.ogg"
    end
end

function sfx.Agree()
    if (convar:GetInt() > 0) then
        cdn.PlayURL"https://tttweb.bungo.ca/ttt/misc/tttsounds/accept.mp3"
    end
end

function sfx.Decline()
    if (convar:GetInt() > 0) then
        cdn.PlayURL"https://tttweb.bungo.ca/ttt/misc/tttsounds/decline.wav"
    end
end

function sfx.Hover()
    if (convar:GetInt() > 0) then
        LocalPlayer():EmitSound("moatsounds/pop1.wav")
    end
end

function sfx.Click1()
    if (convar:GetInt() > 0) then
        LocalPlayer():EmitSound("moatsounds/pop2.wav")
    end
end

function sfx.Click2()
    if (convar:GetInt() > 0) then
        cdn.PlayURL"https://tttweb.bungo.ca/ttt/misc/tttsounds/appear-online.ogg"
    end
end

function sfx.HoverSound(s, func)
    s._OnCursorEntered = s._OnCursorEntered or s.OnCursorEntered

    s.OnCursorEntered = function(s)
        if (convar:GetInt() > 0) then
            if (func) then
                func()
            else
                LocalPlayer():EmitSound"moatsounds/pop1.wav"
            end
        end

        if (s._OnCursorEntered) then
            s._OnCursorEntered(s)
        end
    end
end

function sfx.ClickSound(s, func)
    s._OnMousePressed = s._OnMousePressed or s.OnMousePressed

    s.OnMousePressed = function(s, key)
        if (convar:GetInt() > 0) then
            if (key == MOUSE_LEFT) then
                if (func) then
                    func()
                else
                    LocalPlayer():EmitSound"moatsounds/pop2.wav"
                end
            elseif (key == MOUSE_RIGHT) then
                if (func) then
                    func()
                else
                    cdn.PlayURL"https://tttweb.bungo.ca/ttt/misc/tttsounds/appear-online.ogg"
                end
            end
        end

        if (s._OnMousePressed) then
            s._OnMousePressed(s, key)
        end
    end
end

function sfx.SoundEffects(s, func)
    sfx.HoverSound(s, func)
    sfx.ClickSound(s, func)

    return s
end