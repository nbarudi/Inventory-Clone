AddCSLuaFile( "shared.lua" )

if gmod.GetGamemode().Name == "Trouble in Terrorist Town" then
	SWEP.Base = "weapon_tttbase"
end

SWEP.Author			= "Hoff"
SWEP.Instructions	= "Perk Base"
SWEP.Category 		= "CoD Zombies Perks"
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/hoff/weapons/perkbottles/c_perkbottle.mdl"
SWEP.WorldModel			= "models/hoff/weapons/perkbottles/w_perkbottle.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Delay = 1
SWEP.ViewModelFOV = 70
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= true

SWEP.PrintName			= "Perk Base"
SWEP.Slot				= 6
SWEP.SlotPos			= 20
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= false
SWEP.HoldType = "Slam"

SWEP.ViewModelFlip = false
SWEP.AutoSpawnable = false
SWEP.AllowDrop = false
SWEP.IsSilent = false
SWEP.NoSights = false
SWEP.InLoadoutFor = nil

SWEP.SwayScale = 0.01
SWEP.BobScale = 0.01

SWEP.UseHands = true

Perks =
{
	ZMB_PERK_JUGGERNOG = 0,
	ZMB_PERK_DOUBLETAP = 1,
	ZMB_PERK_PHDFLOPPER = 2,
	ZMB_PERK_STAMINUP = 3,
	ZMB_PERK_VULTUREAID = 4,
	ZMB_PERK_TOMBSTONE = 5,
	ZMB_PERK_ELECTRICCHERRY = 6
}

SWEP.Perk = Perks.ZMB_PERK_JUGGERNOG

hook.Add("Initialize","CreatePerkCVars",function()
	if !ConVarExists("Perks_PerkLimit") then
		CreateConVar("Perks_PerkLimit", 0, { FCVAR_REPLICATED, FCVAR_ARCHIVE })

		CreateConVar("Perks_Jug_BonusHealth", 150, { FCVAR_REPLICATED, FCVAR_ARCHIVE })

		CreateConVar("Perks_VultureAid_SmokeChance", 20, { FCVAR_REPLICATED, FCVAR_ARCHIVE })
		CreateConVar("Perks_VultureAid_AmmoChance", 10, { FCVAR_REPLICATED, FCVAR_ARCHIVE })

		CreateConVar("Perks_DoubleTap_DamageMultiplier", 2, { FCVAR_REPLICATED, FCVAR_ARCHIVE })

		CreateConVar("Perks_ElectricCherry_Damage", 50, { FCVAR_REPLICATED, FCVAR_ARCHIVE })
		CreateConVar("Perks_ElectricCherry_Cooldown", 2.5, { FCVAR_REPLICATED, FCVAR_ARCHIVE })
		CreateConVar("Perks_ElectricCherry_Radius", 100, { FCVAR_REPLICATED, FCVAR_ARCHIVE })

		CreateConVar("Perks_Staminup_RunSpeed", 575, { FCVAR_REPLICATED, FCVAR_ARCHIVE })
		CreateConVar("Perks_Staminup_WalkSpeed", 300, { FCVAR_REPLICATED, FCVAR_ARCHIVE })

		CreateConVar("Perks_PHDFlopper_Magnitude", 75, { FCVAR_REPLICATED, FCVAR_ARCHIVE })

		CreateConVar("Perks_TTT_DoubleTap_EnableFastShoot", 1, { FCVAR_REPLICATED, FCVAR_ARCHIVE })
		CreateConVar("Perks_TTT_DoubleTap_FastShootMultiplier", 2, { FCVAR_REPLICATED, FCVAR_ARCHIVE })
	end
	if CLIENT then
		local function funcCallback(CVar, PreviousValue, NewValue)
			net.Start("Perks_Convars_Change", true)
			net.WriteString(CVar)
			net.WriteFloat(tonumber(NewValue))
			net.SendToServer()
		end
		cvars.AddChangeCallback("Perks_PerkLimit", funcCallback)
		cvars.AddChangeCallback("Perks_Jug_BonusHealth", funcCallback)
		cvars.AddChangeCallback("Perks_VultureAid_SmokeChance", funcCallback)
		cvars.AddChangeCallback("Perks_VultureAid_AmmoChance", funcCallback)
		cvars.AddChangeCallback("Perks_DoubleTap_DamageMultiplier", funcCallback)
		cvars.AddChangeCallback("Perks_ElectricCherry_Damage", funcCallback)
		cvars.AddChangeCallback("Perks_ElectricCherry_Cooldown", funcCallback)
		cvars.AddChangeCallback("Perks_ElectricCherry_Radius", funcCallback)
		cvars.AddChangeCallback("Perks_Staminup_RunSpeed", funcCallback)
		cvars.AddChangeCallback("Perks_Staminup_WalkSpeed", funcCallback)
		cvars.AddChangeCallback("Perks_PHDFlopper_Magnitude", funcCallback)
		cvars.AddChangeCallback("Perks_TTT_DoubleTap_EnableFastShoot", funcCallback)
		cvars.AddChangeCallback("Perks_TTT_DoubleTap_FastShootMultiplier", funcCallback)
	end
end)

if SERVER then
	util.AddNetworkString("perkBGBlur")
	util.AddNetworkString("DisplayPerkIcon")
	util.AddNetworkString("Perks_Convars_Change")

	net.Receive("Perks_Convars_Change", function(len, ply)
		if !ply:IsAdmin() then
			return
		end
		local cvar_name = net.ReadString()
		local cvar_val = net.ReadFloat()
		RunConsoleCommand(cvar_name, cvar_val)
	end)
else
	hook.Add("PopulateToolMenu", "AddPerkSettingsPanel", function()
		spawnmenu.AddToolMenuOption("Utilities", "Hoff's Addons", "PerkSettingsPanel", "Perk Setup", "", "", function(cpanel)

			if !game.SinglePlayer() and !LocalPlayer():IsAdmin() then
				cpanel:AddControl("Label", {Text = "Only admins can change these settings!"})
				return
			end

			cpanel:NumSlider("Perk Limit", "Perks_PerkLimit", 0, 7, 0)
			cpanel:NumSlider("Juggernog Bonus HP", "Perks_Jug_BonusHealth", 1, 5000, 0)
			cpanel:NumSlider("Double Tap Multiplier", "Perks_DoubleTap_DamageMultiplier", 1, 500, 0)
			cpanel:NumSlider("Stamin-Up Walk Speed", "Perks_Staminup_WalkSpeed", 1, 1000, 0)
			cpanel:NumSlider("Stamin-Up Run Speed", "Perks_Staminup_RunSpeed", 1, 1000, 0)
			cpanel:NumSlider("PHD Flopper Magnitude", "Perks_PHDFlopper_Magnitude", 1, 1000, 0)
			cpanel:NumSlider("Vulture Aid Smoke Chance", "Perks_VultureAid_SmokeChance", 1, 100, 0)
			cpanel:NumSlider("Vulture Aid Ammo Chance", "Perks_VultureAid_AmmoChance", 1, 100, 0)
			cpanel:NumSlider("Electric Cherry Damage", "Perks_VultureAid_AmmoChance", 1, 5000, 0)
			cpanel:NumSlider("Electric Cherry Cooldown", "Perks_VultureAid_AmmoChance", 1, 100, 0)
			cpanel:NumSlider("Electric Cherry Radius", "Perks_ElectricCherry_Radius", 1, 1000, 0)
		end)
	end)
end

sound.Add({
	name = "Weapon_PerkBottle.Open",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = "hoff/perks/perksacola/bottle/openmn_00.wav"
})

sound.Add({
	name = "Weapon_PerkBottle.Swallow",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = "hoff/perks/perksacola/bottle/swallowmn_00.wav"
})

sound.Add({
	name = "Weapon_PerkBottle.Break",
	channel = CHAN_WEAPON,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = "hoff/perks/perksacola/bottle/breakmn_00.wav"
})

SWEP.Offset = {
	Pos = {
		Up = -4,
		Right = 3,
		Forward = 3,
	},
	Ang = {
		Up = 0,
		Right = 180,
		Forward = 0,
	}
}
function SWEP:DrawWorldModel( )
	if !IsValid( self:GetOwner() ) then
		self:DrawModel( )
		return
	end

	local bone = self:GetOwner():LookupBone( "ValveBiped.Bip01_R_Hand" )
	if !bone then
		self:DrawModel( )
		return
	end

	local pos, ang = self:GetOwner():GetBonePosition( bone )
	pos = pos + ang:Right() * self.Offset.Pos.Right + ang:Forward() * self.Offset.Pos.Forward + ang:Up() * self.Offset.Pos.Up
	ang:RotateAroundAxis( ang:Right(), self.Offset.Ang.Right )
	ang:RotateAroundAxis( ang:Forward(), self.Offset.Ang.Forward )
	ang:RotateAroundAxis( ang:Up(), self.Offset.Ang.Up )

	self:SetRenderOrigin( pos )
	self:SetRenderAngles( ang )

	self:DrawModel()
end

function SWEP:Initialize()
	self:SetHoldType("Slam")
end

function SWEP:ChangeTextureGroup( textureGroup )
	self.TextureGroup = textureGroup
	self:SetNWInt("textureGroup", textureGroup)
	self:GetOwner():GetViewModel():SetSkin(textureGroup)
	self:SetSkin(textureGroup)
end

local previousAngles = Angle(0,0,0) -- initialize the previous angles to zero
function SWEP:CalcView( ply, origin, angles, fov )
	local AttachmentID = self:LookupAttachment("tag_camera")
	local Attachment = self:GetAttachment(AttachmentID)
	if Attachment then
		local NewAng = Attachment.Ang - self:GetAngles()
		previousAngles = LerpAngle(0.1, previousAngles, NewAng)
		angles:Add(previousAngles)
	end
	return origin, angles, fov
end


function SWEP:Deploy()

	self:SetNWBool("bPerkIsActive", false)

	self:SetHoldType("Slam")
	self:ChangeTextureGroup(self.Perk)

	self:SendWeaponAnim(ACT_VM_IDLE)

	timer.Simple(0.01, function()
		if IsValid(self) and IsValid(self:GetOwner()) then
			self:SendWeaponAnim(ACT_VM_DRAW)
			self:ResetSequence(self:LookupSequence("pullout"))
			self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		end
	end)

	self:GetOwner():SetNWBool("bIsDrinkingPerk",true)

	timer.Simple(1.95,function()
		if IsValid(self) and IsValid(self:GetOwner()) and self:GetOwner():Alive() and SERVER then
			net.Start( "perkBGBlur" )
			net.Send(self:GetOwner())
		end
	end)

	timer.Simple(2.7,function()
		if IsValid(self) and IsValid(self:GetOwner()) and self:GetOwner():Alive() then
			self:GetOwner():EmitSound("hoff/perks/perksacola/bottle/belchmn_00.wav")
			self:OnDrank()
			self:AddPerkToPlayer()
			self:SetNWBool("bPerkIsActive", true)
			local EntIndex = self:EntIndex()
			timer.Create("PerkTimer" .. EntIndex, 0.1, 0, function()
				//if IsValid(self) then
				if !IsValid(self) then
					timer.Remove("PerkTimer" .. EntIndex)
				else
					if !self:ShouldHavePerk() then
						self:LosePerk()
					else
						self:PerkThink()
					end
				end
				//end
			end)

			if self:GetNWString("OldWeaponClass") ~= nil then
				self:GetOwner():SetNWBool("bIsDrinkingPerk",false)
				local OldWeaponClass = self:GetNWString("OldWeaponClass")
				if self:GetOwner():HasWeapon(OldWeaponClass) then
					self:GetOwner():SelectWeapon(OldWeaponClass)
				end
			end
		end
	end)
end

function SWEP:GetRelaventPerkIcon()
	if self.Perk == Perks.ZMB_PERK_JUGGERNOG then
		return "VGUI/entities/zombies_perk_juggernog"
	elseif self.Perk == Perks.ZMB_PERK_DOUBLETAP then
		return "VGUI/entities/zombies_perk_doubletap"
	elseif self.Perk == Perks.ZMB_PERK_ELECTRICCHERRY then
		return "VGUI/entities/zombies_perk_electriccherry"
	elseif self.Perk == Perks.ZMB_PERK_PHDFLOPPER then
		return "VGUI/entities/zombies_perk_phdflopper"
	elseif self.Perk == Perks.ZMB_PERK_STAMINUP then
		return "VGUI/entities/zombies_perk_staminup"
	elseif self.Perk == Perks.ZMB_PERK_TOMBSTONE then
		return "VGUI/entities/zombies_perk_tombstone"
	elseif self.Perk == Perks.ZMB_PERK_VULTUREAID then
		return "VGUI/entities/zombies_perk_vultureaid"
	end
end

hook.Add( "PlayerSwitchWeapon", "PerkBottleSwitchPrevious", function( ply, oldWeapon, newWeapon )
	for k,wep in pairs(ply:GetWeapons()) do
		if string.match(wep:GetClass(), "zombies_perk_") then
			wep:OnWeaponSwitch(oldWeapon, newWeapon)
		end
	end
	if !string.match(newWeapon:GetClass(), "zombies_perk_") then
		return
	end
	local PerkLimit = (ConVarExists("Perks_PerkLimit") and GetConVar("Perks_PerkLimit"):GetInt() or 0)
	local PerkTable = {}
	if ply:GetNWString("PerkTable", "") and #ply:GetNWString("PerkTable", "") > 0 then
		PerkTable = string.Explode(",", ply:GetNWString("PerkTable"))
	end
	if PerkLimit > 0 and !table.IsEmpty(PerkTable) then
		if table.Count(PerkTable) >= PerkLimit then
			return true
		end
	end
	if IsValid(newWeapon) then
		if newWeapon:GetNWBool("bPerkIsActive") then
			return true
		end
		if IsValid(oldWeapon) then
			newWeapon:SetNWString("OldWeaponClass", oldWeapon:GetClass())
		end
	end
end )

if CLIENT then
	net.Receive("perkBGBlur", function(len)
		local BlurTime = 0.2
		local MaxBlur = 4
		local startTime = 0
		local matBlurScreen = Material("pp/blurscreen")
		local function perkBlurHUD()
			local currentTime = CurTime()
			if startTime == 0 then
				startTime = currentTime
			end

			if CurTime() >= startTime + BlurTime then
				blur = 0
				hook.Remove("HUDPaint", "perkBlurPaint" .. LocalPlayer():EntIndex())
			end

			surface.SetMaterial(matBlurScreen)
			surface.SetDrawColor(255, 255, 255)
			matBlurScreen:SetFloat("$blur", MaxBlur)
			matBlurScreen:Recompute()
			if render then render.UpdateScreenEffectTexture() end
			surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		end
		hook.Add( "HUDPaint", "perkBlurPaint" .. LocalPlayer():EntIndex(), perkBlurHUD )
	end)

	net.Receive("DisplayPerkIcon", function()
		local PerkIcon = net.ReadString()
		local PerkWeapon = net.ReadEntity()
		local OwnerIndex = PerkWeapon.Owner:SteamID()
		local PerkWeaponClass = PerkWeapon:GetClass()

		hook.Add( "HUDPaint", PerkWeaponClass .. OwnerIndex, function()
			if !IsValid(PerkWeapon) || !PerkWeapon:ShouldHavePerk() then
				hook.Remove("HUDPaint", PerkWeaponClass .. OwnerIndex)
				return
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
				local InitialOffset = FoundPerkInt == 0 and 0 || 10
				local PerkIconPosY = (ScrH() - ScrH() / 4 - 75) - (FoundPerkInt * (55 + InitialOffset))

				surface.SetMaterial(Material(PerkIcon))
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.DrawTexturedRect(15, PerkIconPosY, 55, 55)
			end
		end)
	end)
end

function SWEP:Holster()
	if self:GetOwner():GetNWBool("bIsDrinkingPerk") then
		return false
	else
		return true
	end
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:ShouldDropOnDie()
	return false
end

hook.Add("PlayerDroppedWeapon", "StopDropPerk", function(owner, wep)
	if IsValid(wep) then
		if string.match(wep:GetClass(), "zombies_perk_") and owner:GetNWBool("bIsDrinkingPerk") then
			return
		else
			for k, ItWep in pairs(owner:GetWeapons()) do
				if string.match(ItWep:GetClass(), "zombies_perk_") then
					ItWep:OnWeaponDropped(wep)
				end
			end
		end
	end
end)

function SWEP:LosePerk()
	if !IsValid(self) || !IsValid(self:GetOwner()) || CLIENT then
		return
	end
	self:SetNWBool("bPerkIsActive", false)
	self:RemovePerkFromPlayer()
	self:OnLosePerk()
	self:GetOwner():StripWeapon(self:GetClass())
end

function SWEP:AddPerkToPlayer()
	if !IsValid(self) || !IsValid(self:GetOwner()) then
		return
	end

	if SERVER then
		if self:GetRelaventPerkIcon() ~= "" then
			net.Start( "DisplayPerkIcon" )
				net.WriteString(self:GetRelaventPerkIcon())
				net.WriteEntity(self)
			net.Send(self:GetOwner())
		end

		local PerkTable = {self:GetClass()}

		if self:GetOwner():GetNWString("PerkTable") then
			PerkTable = string.Explode(",", self:GetOwner():GetNWString("PerkTable"))
		end
		if !table.HasValue(PerkTable, self:GetClass()) then
			table.insert(PerkTable, self:GetClass())
		end

		local StringedPerks = ""
		for k,v in pairs(PerkTable) do
			if v ~= "" then
				StringedPerks = StringedPerks .. v
				if k < table.Count(PerkTable) then
					StringedPerks = StringedPerks .. ","
				end
			end
		end
		self:GetOwner():SetNWString("PerkTable", StringedPerks)
	end
end

function SWEP:Remove()
	self:RemovePerkFromPlayer()
end

function SWEP:RemovePerkFromPlayer()
	if !IsValid(self) || !IsValid(self:GetOwner()) then
		return
	end

	local PerkTable = {self:GetClass()}

	if self:GetOwner():GetNWString("PerkTable") then
		PerkTable = string.Explode(",", self:GetOwner():GetNWString("PerkTable"))
	end

	if table.HasValue(PerkTable, self:GetClass()) then
		table.RemoveByValue(PerkTable, self:GetClass())
	end

	local StringedPerks = ""
	for k,v in pairs(PerkTable) do
		if v ~= "" then
			StringedPerks = StringedPerks .. v
			if k < table.Count(PerkTable) then
				StringedPerks = StringedPerks .. ","
			end
		end
	end

	self:GetOwner():SetNWString("PerkTable", StringedPerks)
end

hook.Add( "PlayerDeath", "PerkDeathHook", function( victim, inflictor, attacker )
	if victim:GetNWBool("bIsDrinkingPerk") then
		victim:SetNWBool("bIsDrinkingPerk", false)
	end
	if victim:GetNWString("PerkTable") ~= nil then
		victim:SetNWString("PerkTable", nil)
	end
end )

hook.Add( "PlayerCanPickupWeapon", "CanGetPerk", function( ply, weapon )
	if ( ply:HasWeapon( weapon:GetClass() ) and string.match(weapon:GetClass(), "zombies_perk_") ) then
		return false
	end
	if ply:HasWeapon( weapon:GetClass() ) || IsValid(ply) and IsValid(ply:GetActiveWeapon()) then
		if string.match(ply:GetActiveWeapon():GetClass(), "zombies_perk_") then
			return false
		end
	end
	if ply:GetNWBool("bIsDrinkingPerk") then
		return false
	end
	if string.match(weapon:GetClass(), "zombies_perk_") then
		local PerkLimit = ConVarExists("Perks_PerkLimit") and GetConVar("Perks_PerkLimit"):GetInt() or 0
		local PerkTable = {}
		if ply:GetNWString("PerkTable") and #ply:GetNWString("PerkTable") > 0 then
			PerkTable = string.Explode(",", ply:GetNWString("PerkTable"))
		end
		if PerkLimit > 0 and table.Count(PerkTable) >= PerkLimit then
			return false
		end
	end
end )

function SWEP:WasBought(buyer)
	buyer:SelectWeapon(self:GetClass())
end

function SWEP:IsEquipment()
	return true
end

-- override functions

function SWEP:OnDrank()
end

function SWEP:ShouldHavePerk()
	return false
end

function SWEP:OnLosePerk()
end

function SWEP:PerkThink()
end

function SWEP:OnWeaponSwitch(OldWeapon, NewWeapon)
end

function SWEP:OnWeaponDropped(DroppedWeapon)
end