-------------------------------
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
-------------------------------

--------------------
-- Spawn Function --
--------------------
function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos
	local ent = ents.Create( "zombies_hoff_vulture_smoke" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent.Owner = ply

	return ent
end

----------------
-- Initialize --
----------------
function ENT:Initialize()
	self:SetModel( "models/hoff/weapons/perkbottles/w_tombstone.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	self:SetModelScale(0.001)

	self:StartEffect()
end

function ENT:StartEffect()
	local effectDuration = 8
	local radius = 50
	local weapon = "zombies_perk_vultureaid"

	-- Timer to check for players in range
	timer.Create("VultureSmokeCheck" .. self:EntIndex(), 0.1, 0, function()
		if !IsValid(self) then return end
		for _, ply in ipairs(player.GetAll()) do
			if ply:GetPos():Distance(self:GetPos()) <= radius then
				if ply:HasWeapon(weapon) and ply:GetWeapon(weapon):GetNWBool("bPerkIsActive") then
					-- Player has the required weapon, apply FL_NOTARGET flag
					ply:SetNWBool("InVultureSmoke", true)
					ply:SetDSP(14, false)
					ply:AddFlags(FL_NOTARGET)
				elseif ply:GetNWBool("InVultureSmoke") then
					-- Player does not have the required weapon, remove FL_NOTARGET flag
					ply:SetNWBool("InVultureSmoke", false)
					ply:RemoveFlags(FL_NOTARGET)
					ply:SetDSP(0, false)
				end
			elseif ply:GetNWBool("InVultureSmoke") then
				self:CheckOutOfRangePlayer(ply, radius)
			end
		end
	end)

	-- Timer to remove FL_NOTARGET flag after effect duration
	timer.Simple(effectDuration, function()
		if !IsValid(self) then return end

		for _, ply in ipairs(player.GetAll()) do
			self:CheckOutOfRangePlayer(ply, radius)
		end

		timer.Destroy("VultureSmokeCheck" .. self:EntIndex())
		self:Remove()
	end)
end

function ENT:CheckOutOfRangePlayer(ply, radius)
	if !IsValid(self) || !IsValid(ply) || !ply:IsPlayer() then
		return
	end
	if ply:GetNWBool("InVultureSmoke") then
		local isInsideAnotherSmoke = false
		for _, ent in ipairs(ents.FindByClass("zombies_hoff_vulture_smoke")) do
			if ent != self and IsValid(ent) and ply:GetPos():Distance(ent:GetPos()) <= radius then
				isInsideAnotherSmoke = true
				break
			end
		end

		if !isInsideAnotherSmoke then
			ply:SetNWBool("InVultureSmoke", false)
			ply:RemoveFlags(FL_NOTARGET)
			ply:SetDSP(0, false)
		end
	end
end

-----------------
-- Take Damage -- 
-----------------
function ENT:OnTakeDamage( dmginfo )
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

-----------
-- Touch --
-----------
function ENT:Touch(ent)

end

--------------------
-- PhysicsCollide -- 
--------------------
function ENT:PhysicsCollide( data, physobj )
end