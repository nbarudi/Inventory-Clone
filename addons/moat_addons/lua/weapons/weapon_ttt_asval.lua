
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
~ file: addons/moat_addons/lua/weapons/weapon_ttt_asval.lua ~

]]

AddCSLuaFile()
SWEP.HoldType = "ar2"
SWEP.PrintName = "AS VAL"
SWEP.Slot = 2
SWEP.Base = "weapon_tttbase"
DEFINE_BASECLASS("weapon_tttbase")
SWEP.Kind = WEAPON_HEAVY
SWEP.ENUM = 7
SWEP.HeadshotMultiplier = 2
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Delay = 0.07
SWEP.Primary.Recoil = 0.8
SWEP.Primary.Cone = 0.020
SWEP.Primary.Damage = 17
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 120
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Sound = Sound("weapons/Mosh&Naajzzz AS-VAL/val-1.wav") -- Script that calls the primary fire sound
SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"
SWEP.UseHands = true
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_notmic_val.mdl" -- Weapon view model
SWEP.WorldModel = "models/weapons/w_notmic_val.mdl" -- Weapon world model
SWEP.DeploySpeed = 1
SWEP.ReloadSpeed = 1.2
SWEP.IronSightsPos = Vector(-2.393, 0, 1.45)
SWEP.IronSightsAng = Vector(-1.731, 0, 0)
SWEP.ReloadAnim = {
    DefaultReload = {
        Anim = "base_reloadempty",
        Time = 1.2,
    },
    ReloadEmpty = {
        Anim = "base_reloadempty",
        Time = 2.2,
    }
}
function SWEP:ScaleDamage()
end