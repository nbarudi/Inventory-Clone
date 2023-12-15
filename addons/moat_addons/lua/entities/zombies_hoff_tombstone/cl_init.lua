
include('shared.lua')

ENT.StartPos = Vector(0,0,0)
function ENT:Initialize()

	self.Color = Color( 255, 255, 255, 255 )
	self.StartPos = self:GetPos()
end

function ENT:Draw()
	local sin = math.sin(RealTime() * 1.5) * 3
	local ang = Angle(0, RealTime() * 50, 0)
	self:SetAngles(ang)
	self:SetPos(self.StartPos + Vector(0,0,sin))
	self:DrawModel()
end

