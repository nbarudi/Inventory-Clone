
-------------------------------
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
-------------------------------

ENT.Perks =
{
	"zombies_perk_doubletap",
	"zombies_perk_juggernog",
	"zombies_perk_phdflopper",
	"zombies_perk_staminup",
	"zombies_perk_tombstone",
	"zombies_perk_vultureaid",
	"zombies_perk_electriccherry"
}

function ENT:Initialize()
	self:SetModel( "models/hoff/weapons/perkbottles/w_pickup_perkbottle.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	self:DrawShadow(false)
	self:SetModelScale(1.5)

	self:SetNWBool("bCanUse", true)

	ParticleEffectAttach("vortigaunt_hand_glow", PATTACH_POINT_FOLLOW, self, 1)
	self:EmitSound("hoff/perks/glow.wav")
	timer.Create("LoopGlowSound" .. self:EntIndex(), 2, 0, function()
		if IsValid(self) then
			self:EmitSound("hoff/perks/glow.wav")
		end
	end)

	self:StartFlashing()

	timer.Create("CheckNearbyPlayers" .. self:EntIndex(), 0.1, 0, function()
		if !IsValid(self) then
			return
		end
		local NearbyEnts = ents.FindInSphere(self:GetPos(), 25)
		for k,v in pairs(NearbyEnts) do
			if v:IsPlayer() then
				self:CheckPickupPerk(v)
			end
		end
	end)
end

function ENT:StartFlashing()
	local DelayBeforeFlash = 5
	local FlashInterval = 0.5
	local FlashSpeed = 0.04
	local DespawnDelay = 10

	timer.Simple(DelayBeforeFlash, function()
		if !IsValid(self) then
			return
		end
		-- Start flashing
		timer.Create("FlashTimer" .. self:EntIndex(), FlashInterval, 0, function()
			if !IsValid(self) then
				return
			end
			FlashInterval = FlashInterval - FlashSpeed
			if FlashInterval < 0.1 then
				FlashInterval = 0.1
			end
			if self:GetColor().a == 255 then
				self:SetRenderMode(RENDERMODE_TRANSALPHA)
				self:SetColor(Color(255, 255, 255, 0))
			else
				self:SetRenderMode(RENDERMODE_NORMAL)
				self:SetColor(Color(255, 255, 255, 255))
			end
			timer.Adjust("FlashTimer" .. self:EntIndex(), FlashInterval)
		end)
	end)

	-- After 10 seconds, play sound, remove entity
	timer.Simple(DespawnDelay, function()
		if !IsValid(self) then
			return
		end
		timer.Destroy("LoopGlowSound" .. self:EntIndex())
		timer.Destroy("FlashTimer" .. self:EntIndex())
		self:StopSound("hoff/perks/glow.wav")
		self:EmitSound("hoff/perks/despawn.wav")
		self:Remove()
	end)
end

-- On Remove --

function ENT:OnRemove()
	if !IsValid(self) then
		return
	end
	timer.Destroy("LoopGlowSound" .. self:EntIndex())
	self:StopSound("hoff/perks/glow.wav")
end

function ENT:CheckPickupPerk(ply)

	if !IsValid(self) then
		return
	end

	if !ply:IsPlayer() then
		return
	end

	if ply:GetNWBool("bIsDrinkingPerk") || (IsValid(ply:GetActiveWeapon()) and string.match(ply:GetActiveWeapon():GetClass(), "zombies_perk_")) then
		return
	end

	if !self:GetNWBool("bCanUse") then
		return
	end

	local PerkLimit = ConVarExists("Perks_PerkLimit") and GetConVar("Perks_PerkLimit"):GetInt() or 0
	local PerkTable = {}
	if ply:GetNWString("PerkTable") then
		PerkTable = string.Explode(",", ply:GetNWString("PerkTable"))
	end
	if PerkLimit > 0 and table.Count(PerkTable) >= PerkLimit then
		return
	end

	self:SetNWBool("bCanUse", false)

	local PerkCopy = self.Perks

	local bValidPerkFound = false
	while !bValidPerkFound and table.Count(PerkCopy) > 0 do

		if !IsValid(self) then
			return
		end

		if table.Count(PerkCopy) <= 0 then
			bValidPerkFound = true
			break
		end

		local RandPerk = table.Random(PerkCopy)
		if !ply:HasWeapon(RandPerk) then
			bValidPerkFound = true
			timer.Destroy("LoopGlowSound" .. self:EntIndex())
			self:StopSound("hoff/perks/glow.wav")
			self:EmitSound("hoff/perks/gasp.wav")
			ply:Give(RandPerk)
			ply:SelectWeapon(RandPerk)
			ply:SetNWBool("bIsDrinkingPerk", true)
		else
			table.RemoveByValue(PerkCopy, RandPerk)
		end

		if !IsValid(ply) then
			bValidPerkFound = true
			self:SetNWBool("bCanUse", true)
		end
	end

	if table.Count(PerkCopy) > 0 then
		self:Remove()
	end
end

-----------
-- Touch --
-----------
function ENT:Touch(ply)
end

--------------------
-- Spawn Function --
--------------------
function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + Vector(0,0,45)
	local ent = ents.Create( "zombies_hoff_perk_pickup" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent.Owner = ply

	return ent
end

-----------------
-- Take Damage -- 
-----------------
function ENT:OnTakeDamage( dmginfo )
	self:TakePhysicsDamage( dmginfo )
end

------------
-- On use --
------------
function ENT:Use( activator, caller )
end

-----------
-- Think --
-----------
function ENT:Think()

end

--------------------
-- PhysicsCollide -- 
--------------------
function ENT:PhysicsCollide( data, physobj )

end