
include("shared.lua")

ENT.StartPos = Vector(0,0,0)
function ENT:Initialize()

	self.Color = Color( 255, 255, 255, 255 )
	if LocalPlayer():HasWeapon("zombies_perk_vultureaid") then
		local fx = EffectData()
		fx:SetOrigin(self:GetPos())
		util.Effect("vulture_aid_smoke",fx)
	end
end

function ENT:Draw()
	self:DrawModel()
end

