AddCSLuaFile( "shared.lua" )

SWEP.Base = "zombies_perk_base"

SWEP.PrintName			= "Tombstone"
SWEP.Instructions		= "It's Tombstone!"
SWEP.Category 		    = "CoD Zombies Perks"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Perk = Perks.ZMB_PERK_TOMBSTONE

SWEP.PlayerLoadout = {}

function SWEP:OnDrank()
end

function SWEP:PerkThink()
    self.PlayerLoadout = {}
    for k,wep in pairs(self:GetOwner():GetWeapons()) do
        table.insert(self.PlayerLoadout, k + 1, wep:GetClass())
    end
end

function SWEP:ShouldHavePerk()
    return self:GetOwner():IsValid() and self:GetOwner():Alive()
end

function SWEP:OnLosePerk()
    if CLIENT then
        return
    end

    for k,v in pairs(ents.GetAll()) do
        if v:GetClass() == "zombies_hoff_tombstone" and v:GetNWString("Owner") == self:GetOwner():SteamID() then
            v:Remove()
        end
    end

    local NewTombstone = ents.Create("zombies_hoff_tombstone")
    NewTombstone:SetOwner(self:GetOwner())
    NewTombstone:SetPos(self:GetOwner():GetPos() + Vector(0,0,30))
    NewTombstone:SetAngles(self:GetOwner():GetAngles())
    NewTombstone:SetNWBool("bCanUse", true)
    NewTombstone:SetNWString("Owner", self:GetOwner():SteamID())
    NewTombstone:Spawn()
    NewTombstone:Activate()
    NewTombstone:SetLoadout(self.PlayerLoadout)
end