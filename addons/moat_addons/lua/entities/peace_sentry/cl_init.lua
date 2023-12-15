
include('shared.lua')

	
ENT.RenderGroup = RENDERGROUP_OPAQUE


local Mat, ColorBlue, White = Material("sprites/light_glow02_add"), Color(0, 0, 250, 255), Color(255, 255, 255, 255)

function ENT:Initialize()

end

function ENT:Draw()

	self:DrawModel()
	render.SetMaterial(Mat)
	local pos, ang = self:GetBonePosition(3)
	
	render.DrawSprite(pos+ang:Up()*5+ang:Right()*-5.5+ang:Forward()*-7.25, 16, 16, ColorBlue, White)

end
