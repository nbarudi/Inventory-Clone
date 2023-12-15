AddCSLuaFile( "shared.lua" )

SWEP.Base = "zombies_perk_base"

SWEP.PrintName			= "Stamin-Up"
SWEP.Instructions		= "Oh yeah, drink it baby."
SWEP.Category 		    = "CoD Zombies Perks"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Kind = WEAPON_EQUIP2
--SWEP.CanBuy = { ROLE_TRAITOR, ROLE_DETECTIVE }
SWEP.LimitedStock = true

if CLIENT then
    SWEP.Icon = "VGUI/ttt/icon_perk_staminup"

    SWEP.EquipMenuData = {
        type = "Perk Bottle",
        desc = "Stamin-Up makes you walk and sprint much\nfaster (Unique 1 Perk)"
    };
end

SWEP.Perk = Perks.ZMB_PERK_STAMINUP

SWEP.CachedSpeeds = {0, 0}

function SWEP:OnDrank()
    self.CachedSpeeds[0] = self:GetOwner():GetWalkSpeed()
    self.CachedSpeeds[1] = self:GetOwner():GetRunSpeed()

    local WalkSpeed = ConVarExists("Perks_Staminup_WalkSpeed") and GetConVar("Perks_Staminup_WalkSpeed"):GetInt() or 300
    local RunSpeed = ConVarExists("Perks_Staminup_RunSpeed") and GetConVar("Perks_Staminup_RunSpeed"):GetInt() or 575
    self:GetOwner():SetWalkSpeed(WalkSpeed)
    self:GetOwner():SetRunSpeed(RunSpeed)
end

function SWEP:ShouldHavePerk()

    if !self:GetOwner():IsValid() then
        return false
    end

    if !self:GetOwner():Alive() then
        return false
    end

    local WalkSpeed = ConVarExists("Perks_Staminup_WalkSpeed") and GetConVar("Perks_Staminup_WalkSpeed"):GetInt() or 300
    local RunSpeed = ConVarExists("Perks_Staminup_RunSpeed") and GetConVar("Perks_Staminup_RunSpeed"):GetInt() or 575
    return self:GetOwner():GetWalkSpeed() == WalkSpeed and self:GetOwner():GetRunSpeed() == RunSpeed
end

function SWEP:OnLosePerk()
end

function SWEP:OnRemove()
    if self:GetOwner():IsValid() and self:GetOwner():Alive() then
        self:GetOwner():SetWalkSpeed(self.CachedSpeeds[0])
        self:GetOwner():SetRunSpeed(self.CachedSpeeds[1])
    end
end