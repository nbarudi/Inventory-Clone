AddCSLuaFile( "shared.lua" )

SWEP.Base = "zombies_perk_base"

SWEP.PrintName			= "Electric Cherry"
SWEP.Instructions		= "*bzz zzzz zzz*"
SWEP.Category 		    = "CoD Zombies Perks"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Perk = Perks.ZMB_PERK_ELECTRICCHERRY

function SWEP:OnDrank()
    local ReloadCooldown = ConVarExists("Perks_ElectricCherry_Cooldown") and GetConVar("Perks_ElectricCherry_Cooldown"):GetFloat() or 2.5
    self:GetOwner():SetNWFloat("LastReload", CurTime() - ReloadCooldown)
    if game.SinglePlayer() then
        AddCherryButtonCheckHook()
    else
        net.Start("AddCherryReloadHook")
        net.Send(self:GetOwner())
    end
end

function SWEP:ShouldHavePerk()
    return self:GetOwner():IsValid() and self:GetOwner():Alive()
end

function SWEP:OnLosePerk()
end


if SERVER then
    util.AddNetworkString("AddCherryReloadHook")
    util.AddNetworkString("CherryDamage")
    util.AddNetworkString("CherryReloadSP")

    net.Receive("CherryDamage", function(len, ply)
        if !ply:HasWeapon("zombies_perk_electriccherry") or ply:GetActiveWeapon():Clip1() == ply:GetActiveWeapon():GetMaxClip1() then
            return
        end
        if !ply:GetActiveWeapon():HasAmmo() || ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()) <= ply:GetActiveWeapon():Clip1() then
            return
        end
        local curTime = CurTime()
        local ReloadCooldown = ConVarExists("Perks_ElectricCherry_Cooldown") and GetConVar("Perks_ElectricCherry_Cooldown"):GetFloat() or 2.5
        if curTime - ply:GetNWFloat("LastReload") < ReloadCooldown then
            return
        end
        ply:SetNWFloat("LastReload", curTime)
        local SearchRadius = ConVarExists("Perks_ElectricCherry_Radius") and GetConVar("Perks_ElectricCherry_Radius"):GetInt() or 100
        local entities = ents.FindInSphere(ply:GetPos(), SearchRadius)
        for _, ent in pairs(entities) do
            if ent:IsNPC() or ent:IsPlayer() and ent != ply then
                local fx = EffectData()
                fx:SetOrigin(ent:GetPos() + ent:GetUp() * 25)
                util.Effect("StunstickImpact",fx)
                local Damage = ConVarExists("Perks_ElectricCherry_Damage") and GetConVar("Perks_ElectricCherry_Damage"):GetInt() or 50
                ent:TakeDamage(Damage, ply, self)
                ent:EmitSound("weapons/stunstick/stunstick_fleshhit1.wav")
            end
        end
        local RandSoundTable = 
        {
            "hoff/perks/sfx/spark_xlrg_00.LN50.pc.snd.wav",
            "hoff/perks/sfx/spark_xlrg_01.LN50.pc.snd.wav",
            "hoff/perks/sfx/spark_xlrg_02.LN50.pc.snd.wav"
        }
        local RandSound = table.Random(RandSoundTable)
        ply:EmitSound(RandSound)
        timer.Create("Zapzap" .. ply:SteamID(), 0.1, 5, function()
            local effectpos = ply:GetPos()
            local edata = EffectData()
            edata:SetEntity(ply)
            edata:SetMagnitude(10)
            edata:SetScale(100)
            util.Effect("TeslaHitBoxes", edata)
        end)


     end)
else
    util.PrecacheSound("hoff/perks/sfx/spark_xlrg_00.LN50.pc.snd.wav")
    util.PrecacheSound("hoff/perks/sfx/spark_xlrg_01.LN50.pc.snd.wav")
    util.PrecacheSound("hoff/perks/sfx/spark_xlrg_02.LN50.pc.snd.wav")

    net.Receive("AddCherryReloadHook", function()
        AddCherryButtonCheckHook()
    end)

    net.Receive("CherryReloadSP", function()
        local button = net.ReadInt(16)
        local reloadBind = input.LookupBinding("+reload")
        local reloadKey = input.GetKeyCode(reloadBind)
        if button == reloadKey then
            net.Start("CherryDamage")
            net.SendToServer()
        end
    end)
end

function AddCherryButtonCheckHook()
    hook.Add("PlayerButtonDown", "CherryReloadHook", function(ply, button)
        if ply:Alive() and ply:GetActiveWeapon() and ply:HasWeapon("zombies_perk_electriccherry") then
            local bIsActivelyReloading = ply:GetActiveWeapon():GetActivity() == ACT_VM_RELOAD
            local bIsMaxAmmo = ply:GetActiveWeapon():Clip1() == ply:GetActiveWeapon():GetMaxClip1()
            if bIsMaxAmmo or bIsActivelyReloading then
                return
            end
            timer.Simple(0.1, function()
                if !IsValid(ply) then
                    return
                end
                bIsActivelyReloading = ply:GetActiveWeapon():GetActivity() == ACT_VM_RELOAD
                bIsMaxAmmo = ply:GetActiveWeapon():Clip1() == ply:GetActiveWeapon():GetMaxClip1()
                if bIsMaxAmmo || !bIsActivelyReloading then
                    return
                end
                if game.SinglePlayer() then
                    if button >= 0 then
                        net.Start("CherryReloadSP")
                            net.WriteInt(button, 16)
                        net.Send(ply)
                    end
                else
                    local reloadBind = input.LookupBinding("+reload")
                    local reloadKey = input.GetKeyCode(reloadBind)
                    if button == reloadKey then
                        net.Start("CherryDamage")
                        net.SendToServer()
                    end
                end
            end)
        else
            hook.Remove("PlayerButtonDown", "CherryReloadHook")
        end
    end)
end