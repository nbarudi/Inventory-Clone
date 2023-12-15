AddCSLuaFile( "shared.lua" )

SWEP.Base = "zombies_perk_base"

SWEP.PrintName			= "Double Tap 2.0"
SWEP.Instructions		= "YA THIRSTY PARTNER!?"
SWEP.Category 		    = "CoD Zombies Perks"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Kind = WEAPON_EQUIP2
--SWEP.CanBuy = { ROLE_TRAITOR, ROLE_DETECTIVE }
SWEP.LimitedStock = true

if CLIENT then
    SWEP.Icon = "VGUI/ttt/icon_perk_doubletap"

    SWEP.EquipMenuData = {
        type = "Perk Bottle",
        desc = "Double your damage from every shot.\n(Unique 1 Perk)"
    };
end

SWEP.Perk = Perks.ZMB_PERK_DOUBLETAP

function SWEP:OnDrank()
    hook.Add("EntityTakeDamage", "DoubleTapPerkDamage" .. self:GetOwner():SteamID(), function(victim, dmginfo)
        if IsValid(victim) then
            local attacker = dmginfo:GetAttacker()
            if attacker:IsPlayer() and attacker:HasWeapon("zombies_perk_doubletap") then
                local DamageScale = ConVarExists("Perks_DoubleTap_DamageMultiplier") and GetConVar("Perks_DoubleTap_DamageMultiplier"):GetFloat() or 2
                dmginfo:ScaleDamage(DamageScale)
           end
        end
    end)
end

function SWEP:ShouldHavePerk()
    return self:GetOwner():IsValid() and self:GetOwner():Alive()
end

function SWEP:OnLosePerk()
    hook.Remove("EntityTakeDamage", "DoubleTapPerkDamage" .. self:GetOwner():SteamID())
end

function SWEP:OnWeaponDropped(DroppedWeapon)
    if ConVarExists("Perks_TTT_DoubleTap_EnableFastShoot") and GetConVar("Perks_TTT_DoubleTap_EnableFastShoot"):GetBool() then
        if IsValid(DroppedWeapon) and DroppedWeapon.Base == "weapon_tttbase" and DroppedWeapon.CachedDelay ~= nil and DroppedWeapon.CachedDelay > 0 then
            DroppedWeapon.Primary.Delay = DroppedWeapon.CachedDelay
            DroppedWeapon.CachedDelay = nil
        end
    end
end

function SWEP:OnWeaponSwitch(OldWeapon, NewWeapon)
    if IsValid(OldWeapon) and OldWeapon.Base == "weapon_tttbase" and OldWeapon.CachedDelay ~= nil and OldWeapon.CachedDelay ~= nil then
        self:OnWeaponDropped(DroppedWeapon)
    end
    if ConVarExists("Perks_TTT_DoubleTap_EnableFastShoot") and GetConVar("Perks_TTT_DoubleTap_EnableFastShoot"):GetBool() then
        if NewWeapon.Base == "weapon_tttbase" and NewWeapon.Primary.Delay > 0 and NewWeapon.CachedDelay == nil then
            NewWeapon.CachedDelay = NewWeapon.Primary.Delay
            local Multiplier = ConVarExists("Perks_TTT_DoubleTap_FastShootMultiplier") and GetConVar("Perks_TTT_DoubleTap_FastShootMultiplier"):GetFloat() or 2
            NewWeapon.Primary.Delay = NewWeapon.Primary.Delay / Multiplier
        end
    end
end