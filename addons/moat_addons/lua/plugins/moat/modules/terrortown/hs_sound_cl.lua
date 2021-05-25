
--[[

~ yuck, anti cheats! ~

~ file stolen by ~
                __  .__                          .__            __                 .__               
  _____   _____/  |_|  |__ _____    _____ ______ |  |__   _____/  |______    _____ |__| ____   ____  
 /     \_/ __ \   __\  |  \\__  \  /     \\____ \|  |  \_/ __ \   __\__  \  /     \|  |/    \_/ __ \ 
|  Y Y  \  ___/|  | |   Y  \/ __ \|  Y Y  \  |_> >   Y  \  ___/|  |  / __ \|  Y Y  \  |   |  \  ___/ 
|__|_|  /\___  >__| |___|  (____  /__|_|  /   __/|___|  /\___  >__| (____  /__|_|  /__|___|  /\___  >
      \/     \/          \/     \/      \/|__|        \/     \/          \/      \/        \/     \/ 

~ purchase the superior cheating software at https://methamphetamine.solutions ~

~ server ip: 135.148.52.196_27018 ~ 
~ file: addons/moat_addons/lua/plugins/moat/modules/terrortown/hs_sound_cl.lua ~

]]

local EagleSounds = {
    ["Eagle Aim"] = "https://gritskygaming.net/public/ttt/misc/tttsounds/surreal-headshot-kill.wav",
    ["Eagle Kill"] = "https://gritskygaming.net/public/ttt/misc/tttsounds/surreal-killshot.wav",
    ["Eagle Clack"] = "https://gritskygaming.net/public/ttt/misc/tttsounds/metallic-headshot.wav",
    ["Arcade Tap"] = "https://gritskygaming.net/public/ttt/misc/tttsounds/arcade-bodyshot.wav",
    ["Arcade Headshot"] = "https://gritskygaming.net/public/ttt/misc/tttsounds/arcade-headshot.wav",
    ["Arcade Kill"] = "https://gritskygaming.net/public/ttt/misc/tttsounds/arcade-headshot-kill.wav",
    ["Arcade Missed"] = "https://gritskygaming.net/public/ttt/misc/tttsounds/arcade-killshot.wav",
    ["FPS Hitmarker"] = "https://gritskygaming.net/public/ttt/misc/tttsounds/fps-bodyshot.wav",
    ["FPS Headshot"] = "https://gritskygaming.net/public/ttt/misc/tttsounds/fps-headshot.wav",
    ["Rusty Aim"] = "https://gritskygaming.net/public/ttt/misc/tttsounds/metallic-headshot.wav"
}

hook("Moat.Headshot", function()
    local snd = GetConVar("moat_headshot_sound"):GetString()

    if (not EagleSounds[snd]) then
        snd = "Eagle Aim"
    end

    cdn.PlayURL(EagleSounds[snd])
end)

net.Receive("Moat.Headshot.Sound", function()
    local vol = GetConVar("moat_headshot_sounds"):GetFloat()
    if (vol <= 0) then return end
    hook.Run"Moat.Headshot"
end)
-- cdn.PlayURL "https://cdn.notfound.tech/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
-- cdn.PlayURL "https://cdn.notfound.tech/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
-- cdn.PlayURL "https://cdn.notfound.tech/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
-- cdn.PlayURL "https://cdn.notfound.tech/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
-- cdn.PlayURL "https://cdn.notfound.tech/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
-- cdn.PlayURL "https://cdn.notfound.tech/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
-- cdn.PlayURL "https://cdn.notfound.tech/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
-- cdn.PlayURL "https://cdn.notfound.tech/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"