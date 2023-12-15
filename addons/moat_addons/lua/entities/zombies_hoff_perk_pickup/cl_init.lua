
include('shared.lua')

function ENT:Initialize()

	self.Color = Color( 255, 255, 255, 255 )
	self.StartPos = self:GetPos()

end

function ENT:Draw()
	local ang = Angle(15, RealTime() * 50, 0)
	self:SetAngles(ang)
	self:DrawModel()
end