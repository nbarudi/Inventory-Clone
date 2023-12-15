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
	local SpawnPos = tr.HitPos + Vector(0,0,45)
	local ent = ents.Create( "zombies_hoff_tombstone" )
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
	self:SetSolid( SOLID_VPHYSICS )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	ParticleEffectAttach("vortigaunt_hand_glow", PATTACH_POINT_FOLLOW, self, 1)
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
	if activator ~= self:GetOwner() then
		return
	end
	if self:GetNWBool("bCanUse") then
		self:SetNWBool("bCanUse", false)

		for k,v in pairs(self.Loadout) do
			if !activator:HasWeapon(v) then
				activator:Give(v)
			end
		end
		activator:SetActiveWeapon(activator:GetWeapon(self.Loadout[1]))
		self:Remove()
	end
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

ENT.Loadout = {}
function ENT:SetLoadout(PlayerLoadout)
	for k, wep in pairs(PlayerLoadout) do
		if wep ~= "" and !string.match(wep, "zombies_perk_") then
			table.insert(self.Loadout, wep)
		end
	end
end