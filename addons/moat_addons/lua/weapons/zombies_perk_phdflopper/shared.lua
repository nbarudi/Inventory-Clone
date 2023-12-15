AddCSLuaFile( "shared.lua" )

SWEP.Base = "zombies_perk_base"

SWEP.PrintName			= "PHD Flopper"
SWEP.Instructions		= "Damn straight."
SWEP.Category 		    = "CoD Zombies Perks"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = { ROLE_TRAITOR, ROLE_DETECTIVE }
SWEP.LimitedStock = true

if CLIENT then
    SWEP.Icon = "VGUI/ttt/icon_perk_phdflopper"

    SWEP.EquipMenuData = {
        type = "Perk Bottle",
        desc = "Remove all fall damage, and create a\nsmall explosion when you land from a\nsemi-high fall while crouching. (Unique 1 Perk)"
    };
end

SWEP.Perk = Perks.ZMB_PERK_PHDFLOPPER

SWEP.DoubleTapDamageMultiplier = 2

function SWEP:OnDrank()
    hook.Add("EntityTakeDamage", "PHDFlopper" .. self:GetOwner():SteamID(), function(target, dmginfo)
        if target:IsPlayer() and target:HasWeapon("zombies_perk_phdflopper") then
            if dmginfo:IsFallDamage() and target:Crouching() then
                local explode = ents.Create( "env_explosion" )
                explode:SetPos( target:GetPos() )
                explode:SetOwner( target )
                explode:Spawn()
                local Magnitude = ConVarExists("Perks_PHDFlopper_Magnitude") and GetConVar("Perks_PHDFlopper_Magnitude"):GetString() or 75
                explode:SetKeyValue( "iMagnitude", Magnitude )
                explode:Fire( "Explode", 0, 0 )
                explode:EmitSound( "weapon_AWP.Single", 400, 400 )
            end
            if dmginfo:IsFallDamage() or (dmginfo:IsExplosionDamage() and dmginfo:GetAttacker() == target) then
                dmginfo:SetDamage(0)
            end
        end
    end)
end

function SWEP:ShouldHavePerk()
    return self:GetOwner():IsValid() and self:GetOwner():Alive()
end

function SWEP:OnLosePerk()
    hook.Remove("EntityTakeDamage", "PHDFlopper" .. self:GetOwner():SteamID())
end