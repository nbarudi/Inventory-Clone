--- Golden Gun

if SERVER then
   AddCSLuaFile( "shared.lua" )

	--[[resource.AddFile("materials/models/weapons/v_models/powerdeagle/deagle_skin.vmt")
	resource.AddFile("materials/models/weapons/v_models/powerdeagle/deagle_skin.vtf")
	resource.AddFile("materials/models/weapons/v_models/powerdeagle/deagle_skin1_ref.vtf")
	resource.AddFile("materials/models/weapons/v_models/powerdeagle/dot2.vmt")
	resource.AddFile("materials/models/weapons/v_models/powerdeagle/dot2.vtf")
	resource.AddFile("materials/models/weapons/v_models/powerdeagle/line.vmt")
	resource.AddFile("materials/models/weapons/v_models/powerdeagle/line.vtf")
	resource.AddFile("materials/models/weapons/v_models/powerdeagle/suppressor.vmt")
	resource.AddFile("materials/models/weapons/v_models/powerdeagle/suppressor.vtf")
	resource.AddFile("materials/models/v_models/feets/v_hands.vmt")
	resource.AddFile("materials/models/v_models/feets/v_hands.vtf")
	resource.AddFile("materials/models/v_models/feets/v_hands_normal.vtf")

	Pointless code above :D, but we'll keep it.]]--

	resource.AddWorkshop( "233067112" ) -- even easier
end

if CLIENT then
   SWEP.PrintName = "Golden Gun"
   SWEP.Slot      = 6 -- add 1 to get the slot number key

   SWEP.ViewModelFOV  = 72
   SWEP.ViewModelFlip = true
end

SWEP.Base        = "weapon_tttbase"

--- Standard GMod values

SWEP.HoldType      = "pistol"

SWEP.Primary.Delay       = 0.08
SWEP.Primary.Recoil      = 1.2
SWEP.Primary.Automatic   = true
SWEP.Primary.Damage      = 1
SWEP.Primary.Cone        = 0.025
SWEP.Primary.Ammo        = "AR2AltFire"
SWEP.Primary.ClipSize    = 1
SWEP.Primary.ClipMax     = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Sound       = Sound( "Weapon_Deagle.Single" )

SWEP.ViewModel  = "models/weapons/v_powerdeagle.mdl"
SWEP.WorldModel = "models/weapons/w_powerdeagle.mdl"

SWEP.Kind = WEAPON_EQUIP1
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "RPG_Round"
SWEP.CanBuy = { ROLE_DETECTIVE }
SWEP.InLoadoutFor = nil
SWEP.LimitedStock = true
SWEP.AllowDrop = true
SWEP.IsSilent = false
SWEP.NoSights = false

if CLIENT then
   -- Path to the icon material
   SWEP.Icon = "VGUI/ttt/icon_flux_goldengun"

   -- Text shown in the equip menu
   SWEP.EquipMenuData = {
      type = "Weapon",
      desc = "Shoot a traitor, kill a traitor. \nShoot an innocent, kill yourself. \nBe careful."
   };
end

if SERVER then
   resource.AddFile("materials/VGUI/ttt/icon_flux_goldengun.vmt")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	local trace = util.GetPlayerTrace(self.Owner)
	local tr = util.TraceLine(trace)

	if tr.Entity.IsPlayer() then
		if tr.Entity:IsRole(ROLE_TRAITOR) then
			bullet = {}
			bullet.Num = self.Primary.NumberofShots
			bullet.Src = self.Owner:GetShootPos()
			bullet.Dir = self.Owner:GetAimVector()
			bullet.Spread = Vector( 0, 0, 0 )
			bullet.Tracer = 0
			bullet.Force = 3000
			bullet.Damage = 4000
			bullet.AmmoType = self.Primary.Ammo
			self.Owner:FireBullets(bullet)
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			self:TakePrimaryAmmo(1)
			self.Weapon.EmitSound( Sound( "Weapon_Deagle.Single" ) )
			return
		elseif tr.Entity:IsRole(ROLE_INNOCENT) or tr.Entity:IsRole(ROLE_DETECTIVE) then
			self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			self.Weapon:EmitSound( Sound( "Weapon_Deagle.Single" ) )
			self:TakePrimaryAmmo(1)
			if SERVER then
				self.Owner:Kill()
			end
			return
        end
	end
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self:TakePrimaryAmmo(1)
	self.Owner:EmitSound(Sound( "Weapon_Deagle.Single"  ))
	return
end


