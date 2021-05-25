AddCSLuaFile()

if CLIENT then
   SWEP.PrintName = "Veteran's Sidekick"
   SWEP.Slot = 6
   SWEP.Icon = "vgui/ttt/icon_revolver"
   SWEP.IconLetter = "f"
end

-- Always derive from weapon_tttbase
SWEP.Base = "weapon_tttbase"

-- Standard GMod values
SWEP.HoldType = "pistol"

SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 1
SWEP.Primary.Recoil = 0.8
SWEP.Primary.Cone = 0.0025
SWEP.Primary.Damage = 1000
SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = 5
SWEP.Primary.ClipMax = SWEP.Primary.ClipSize
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize
SWEP.Primary.Sound = Sound( "Weapon_DetRev.Single" )

-- Model properties
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = Model( "models/weapons/c_357.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_357.mdl" )

SWEP.IronSightsPos = Vector ( -4.64, -3.96, 0.68 )
SWEP.IronSightsAng = Vector ( 0.214, -0.1767, 0 )

-- TTT config values

-- Kind specifies the category this weapon is in. Players can only carry one of
-- each. Can be: WEAPON_... MELEE, PISTOL, HEAVY, NADE, CARRY, EQUIP1, EQUIP2 or ROLE.
-- Matching SWEP.Slot values: 0      1       2     3      4      6       7        8
SWEP.Kind = WEAPON_EQUIP1

-- If AutoSpawnable is true and SWEP.Kind is not WEAPON_EQUIP1/2, then this gun can
-- be spawned as a random weapon.
SWEP.AutoSpawnable = false

-- The AmmoEnt is the ammo entity that can be picked up when carrying this gun.
SWEP.AmmoEnt = "none"

-- CanBuy is a table of ROLE_* entries like ROLE_TRAITOR and ROLE_DETECTIVE. If
-- a role is in this table, those players can buy this.

-- InLoadoutFor is a table of ROLE_* entries that specifies which roles should
-- receive this weapon as soon as the round starts. In this case, none.
SWEP.InLoadoutFor = { ROLE_VETERAN }

-- If LimitedStock is true, you can only buy one per round.
SWEP.LimitedStock = true

-- If AllowDrop is false, players can't manually drop the gun with Q
SWEP.AllowDrop = false

-- If IsSilent is true, victims will not scream upon death.
SWEP.IsSilent = false

-- If NoSights is true, the weapon won't have ironsights
SWEP.NoSights = false

function SWEP:OnDrop()
   self:Remove()
end

-- Precache custom sounds
function SWEP:Precache()
   util.PrecacheSound( "weapons/det_revolver/revolver-fire.wav" )
end

-- Give the primary sound an alias
sound.Add ( {
   name = "Weapon_DetRev.Single",
   channel = CHAN_USER_BASE + 10,
   volume = 1.0,
   sound = "weapons/det_revolver/revolver-fire.wav"
} )