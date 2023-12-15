AddCSLuaFile( "shared.lua" )

SWEP.Base = "zombies_perk_base"

SWEP.PrintName			= "Vulture Aid"
SWEP.Instructions		= "Get Vulture Aid!"
SWEP.Category 		    = "CoD Zombies Perks"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Kind = WEAPON_EQUIP2
--SWEP.CanBuy = { ROLE_TRAITOR, ROLE_DETECTIVE }
SWEP.LimitedStock = true

if CLIENT then
    SWEP.Icon = "VGUI/ttt/icon_perk_vultureaid"

    SWEP.EquipMenuData = {
        type = "Perk Bottle",
        desc = "Causes players to sometimes drop ammo\nboxes when killed (Unique 1 Perk)"
    };
end

SWEP.Perk = Perks.ZMB_PERK_VULTUREAID

function SWEP:OnDrank()
    self:StartAmmoDropSystem() 
    net.Start("DisplayVultureSmoke")
        net.WriteEntity(self)
    net.Send(self:GetOwner())
end

function SWEP:ShouldHavePerk()
    return self:GetOwner():IsValid() and self:GetOwner():Alive()
end

function SWEP:OnLosePerk()
    hook.Remove("EntityTakeDamage", "VultureAid" .. self:GetOwner():SteamID())
end

function SWEP:StartAmmoDropSystem()
    hook.Add("EntityTakeDamage", "VultureAid" .. self:GetOwner():SteamID(), function(victim, dmginfo)
        if IsValid(victim) then
            local Damage = dmginfo:GetDamage()
            if victim:Health() - Damage > 0 || !victim:IsNPC() then
                return
            end

            local attacker = dmginfo:GetAttacker()
            if SERVER and IsValid(attacker) and attacker:IsPlayer() and attacker:HasWeapon("zombies_perk_vultureaid") then
                local AmmoEnts =
                {
                    "item_ammo_ar2",
                    "item_ammo_ar2_altfire",
                    "item_ammo_pistol",
                    "item_ammo_smg1",
                    "item_ammo_357",
                    "item_ammo_crossbow",
                    "item_box_buckshot",
                    "item_rpg_round",
                    "item_ammo_smg1_grenade"
                }

                local AmmoChance = ConVarExists("Perks_VultureAid_AmmoChance") and GetConVar("Perks_VultureAid_AmmoChance"):GetInt() or 10
                local SmokeChance = ConVarExists("Perks_VultureAid_SmokeChance") and GetConVar("Perks_VultureAid_SmokeChance"):GetInt() or 20
                if math.Rand(0, 100) <= AmmoChance then
                    local AmmoType = attacker:GetActiveWeapon():GetPrimaryAmmoType()
                    local AmmoClass = AmmoEnts[AmmoType]
                    if AmmoClass ~= "" then
                        local AmmoEnt = ents.Create(AmmoClass)
                        AmmoEnt:SetPos(victim:GetPos())
                        AmmoEnt:SetAngles(victim:GetAngles())
                        AmmoEnt:Spawn()
                        AmmoEnt:Activate()
                    end
                end

                if math.Rand(0, 100) <= SmokeChance then
                    local smoke = ents.Create("zombies_hoff_vulture_smoke")
                    smoke:SetPos(victim:GetPos() + Vector(0,0,35))
                    smoke:Spawn()
                    smoke:Activate()
                end
           end
        end
    end) 
end

if SERVER then
    util.AddNetworkString("DisplayVultureSmoke")
else
    net.Receive("DisplayVultureSmoke", function()

        local PerkIcon = "VGUI/entities/zombies_perk_vultureaid_glow"
        local PerkWeapon = net.ReadEntity()
        local OwnerIndex = PerkWeapon.Owner:SteamID()
        local PerkWeaponClass = PerkWeapon:GetClass()
        local bFadeIn = true
        local alpha = 0
        local scroll = 0
        hook.Add("HUDPaint", "VultureAidSmoke"..OwnerIndex, function()
            if !IsValid(PerkWeapon) || !PerkWeapon:ShouldHavePerk() then
                hook.Remove("HUDPaint", "VultureAidSmoke"..OwnerIndex)
                return
            end
        
            if PerkWeapon.Owner:GetNWBool("InVultureSmoke") then
                bFadeIn = true
            else
                bFadeIn = false
            end
        
            if bFadeIn then
                if alpha < 255 then
                    alpha = math.Clamp(alpha + (255 * FrameTime() * 2), 0, 255)
                end
            else
                if alpha > 0 then
                    alpha = math.Clamp(alpha - (255 * FrameTime() * 2), 0, 255)
                end
            end
        
            local FoundPerkInt = -1
            if PerkWeapon.Owner:GetNWString("PerkTable") ~= nil then
                local PerksList = string.Explode(",", PerkWeapon.Owner:GetNWString("PerkTable"))
                for k, It in pairs(PerksList) do
                    if It == PerkWeaponClass then
                        FoundPerkInt = k - 1
                        break
                    end
                end
            end
            if FoundPerkInt ~= -1 then
                local InitialOffset = FoundPerkInt == 0 and 0 or 10
                local PerkIconPosY = (ScrH() - ScrH()/4 - 75) - (FoundPerkInt * (55 + InitialOffset))
        
                surface.SetMaterial(Material("VGUI/entities/vulture_overlay.png"))
                surface.SetDrawColor( 255, 255, 255, math.Clamp(alpha, 0, 200) )
                surface.DrawTexturedRect(0,0,ScrW(), ScrH())   

                local u1, v1 = 0, scroll
                local u2, v2 = 1, scroll + 1
                surface.SetMaterial(Material("VGUI/entities/gobo_smoke_01"))
                surface.SetDrawColor(0, 200, 0, math.Clamp(alpha, 0, 80))
                surface.DrawTexturedRectUV(0, 0, ScrW(), ScrW(), u1, v1, u2, v2)

                scroll = scroll + 0.0005

                surface.SetMaterial(Material(PerkIcon))
                surface.SetDrawColor( 255, 255, 255, alpha )
                surface.DrawTexturedRect(-12.5, PerkIconPosY - 25, 106.1335, 106.1335)

                surface.SetMaterial(Material("VGUI/entities/zm_hud_stink_ani_green"))
                surface.SetDrawColor( 255, 255, 255, alpha )
                surface.DrawTexturedRect(-12.5, PerkIconPosY - 100, 106.1335, 106.1335)
            end
        end)
    end)
end