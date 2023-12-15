AddCSLuaFile( "shared.lua" )

SWEP.Base = "zombies_perk_base"

SWEP.PrintName			= "Juggernog"
SWEP.Instructions		= "Reach for Juggernog tonight!"
SWEP.Category 		    = "CoD Zombies Perks"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = { ROLE_TRAITOR, ROLE_DETECTIVE }
SWEP.LimitedStock = true

if CLIENT then
    SWEP.Icon = "VGUI/ttt/icon_perk_juggernog"

    SWEP.EquipMenuData = {
        type = "Perk Bottle",
        desc = "150 health granted on consumption (Unique 1 Perk)"
    };
end

SWEP.Perk = Perks.ZMB_PERK_JUGGERNOG

function SWEP:OnDrank()
    local BonusHealth = ConVarExists("Perks_Jug_BonusHealth") and GetConVar("Perks_Jug_BonusHealth"):GetInt() or 150
    self:GetOwner():SetHealth(self:GetOwner():Health() + BonusHealth)
end

function SWEP:ShouldHavePerk()
    return self:GetOwner():IsValid() and self:GetOwner():Alive() and self:GetOwner():Health() > self:GetOwner():GetMaxHealth()
end

function SWEP:OnLosePerk()
end