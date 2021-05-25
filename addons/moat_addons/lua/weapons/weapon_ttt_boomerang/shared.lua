if SERVER then
    AddCSLuaFile("shared.lua")
    --	resource.AddFile("models/boomerang/boomerang.mdl")
    --	resource.AddFile("models/boomerang/v_shuriken.mdl")
end

SWEP.PrintName = "Boomerang"

if CLIENT then
    SWEP.Author = "TheBroomer"
    SWEP.Slot = 1
    SWEP.SlotPos = 2

    SWEP.EquipMenuData = {
        type = "item_weapon",
        desc = "Left click to throw the boomerang brutally, right click to throw it soft and precise (it will bump back from walls)"
    }

    SWEP.ViewModelBoneMods = {
        ["shuriken"] = {
            scale = Vector(0.009, 0.009, 0.009),
            pos = Vector(0, 6.48, 0),
            angle = Angle(0, 0, 0)
        }
    }

    SWEP.VElements = {
        ["boomerang"] = {
            type = "Model",
            model = "models/boomerang/boomerang.mdl",
            bone = "shuriken",
            rel = "",
            pos = Vector(1.557, 7.791, -1.558),
            angle = Angle(-24.546, -73.637, 92.337),
            size = Vector(0.69, 0.69, 0.69),
            color = Color(255, 255, 255, 255),
            surpresslightning = false,
            material = "",
            skin = 0,
            bodygroup = {}
        }
    }

    SWEP.WElements = {
        ["boomerang"] = {
            type = "Model",
            model = "models/boomerang/boomerang.mdl",
            bone = "ValveBiped.Bip01_R_Hand",
            rel = "",
            pos = Vector(5.714, 5.714, -1.558),
            angle = Angle(5.843, 3.506, -82.987),
            size = Vector(0.69, 0.69, 0.69),
            color = Color(255, 255, 255, 255),
            surpresslightning = false,
            material = "",
            skin = 0,
            bodygroup = {}
        }
    }
end

SWEP.Icon = "vgui/entities/boomerang.png"
SWEP.Base = "weapon_tttbase"
SWEP.Weight = 5
SWEP.DrawCrosshair = false
SWEP.Instructions = "Left click to throw a boomerang"
SWEP.Spawnable = false
SWEP.AutoSpawnable = false
SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/boomerang/v_shuriken.mdl"
SWEP.WorldModel = "models/boomerang/boomerang.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.Primary.Delay = 0.9
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Damage = 100
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.Delay = 0.9
SWEP.Secondary.Recoil = 0.5
SWEP.Secondary.Damage = 100
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Kind = WEAPON_EQUIP1
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.LimitedStock = true
SWEP.AllowDelete = false
SWEP.AllowDrop = true
SWEP.Weight = 5

function SWEP:GetViewModelPosition(pos, ang)
    pos = pos + ang:Forward() * 5.48
    pos = pos + ang:Right() * 2.68
    pos = pos + ang:Up() * 1.96

    return pos, ang
end

function SWEP:PrimaryAttack()
    if self.Weapon:Clip1() <= 0 then return end
    self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    local Pos = self.Owner:GetShootPos()
    local trace = self.Owner:GetEyeTrace()
    local targetPos = trace.HitPos

    if trace.HitNonWorld or Pos:Distance(targetPos) > 2000 then
        targetPos = targetPos
    end

    targetPos = Pos + self.Owner:GetAimVector() * 2000
    self.Weapon:EmitSound("weapons/slam/throw.wav")

    if SERVER then
        local boomerang = ents.Create("ent_boomerang")
        boomerang:SetAngles(Angle(20, 0, 90))
        boomerang:SetPos(self.Owner:GetShootPos())
        boomerang:SetOwner(self.Owner)
        boomerang:SetPhysicsAttacker(self.Owner, 10)
        boomerang:SetNW2Vector("targetPos", targetPos)
        boomerang:Spawn()
        boomerang:Activate()
        boomerang.Hits = self.Hits
        local phys = boomerang:GetPhysicsObject()
        phys:SetVelocity(self.Owner:GetAimVector():GetNormalized() * 10000)
        phys:AddAngleVelocity(Vector(0, -1000, 0))
    end

    if SERVER then
        self.Weapon:Remove()
    end
end

function SWEP:SecondaryAttack()
    if self.Weapon:Clip1() <= 0 then return end
    self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    local Pos = self.Owner:GetShootPos()
    local trace = self.Owner:GetEyeTrace()
    local targetPos = trace.HitPos

    if trace.HitWorld and Pos:Distance(targetPos) < 2000 then
        targetPos = targetPos - ((Pos - targetPos):GetNormalized() * 10)
    else
        targetPos = Pos + self.Owner:GetAimVector() * 2000
    end

    targetPos = Pos + self.Owner:GetAimVector() * 2000
    self.Weapon:EmitSound("weapons/slam/throw.wav")

    if SERVER then
        local boomerang = ents.Create("ent_boomerangclose")
        boomerang:SetAngles(Angle(20, 0, 90))
        boomerang:SetPos(self.Owner:GetShootPos())
        boomerang:SetOwner(self.Owner)
        boomerang:SetPhysicsAttacker(self.Owner, 10)
        boomerang:SetNW2Vector("targetPos", targetPos)
        boomerang:Spawn()
        boomerang:Activate()
        boomerang.Hits = self.Hits
        boomerang.LastVelocity = self.Owner:GetAimVector()
        local phys = boomerang:GetPhysicsObject()
        phys:SetVelocity(self.Owner:GetAimVector():GetNormalized() * 10000)
        phys:AddAngleVelocity(Vector(0, -1000, 0))
    end

    if SERVER then
        self.Weapon:Remove()
    end
end

--[[*******************************************************

	SWEP Construction Kit base code

		Created by Clavus

	Available for public use, thread at:

	   facepunch.com/threads/1032378

	   

	   

	DESCRIPTION:

		This script is meant for experienced scripters 

		that KNOW WHAT THEY ARE DOING. Don't come to me 

		with basic Lua questions.

		

		Just copy into your SWEP or SWEP base of choice

		and merge with your own code.

		

		The SWEP.VElements, SWEP.WElements and

		SWEP.ViewModelBoneMods tables are all optional

		and only have to be visible to the client.

*******************************************************]]
function SWEP:Initialize()
    self.Hits = 0

    if CLIENT then
        -- Create a new table for every weapon instance
        self.VElements = table.FullCopy(self.VElements)
        self.WElements = table.FullCopy(self.WElements)
        self.ViewModelBoneMods = table.FullCopy(self.ViewModelBoneMods)
        self:CreateModels(self.VElements) -- create viewmodels
        self:CreateModels(self.WElements) -- create worldmodels

        -- init view model bone build function
        if IsValid(self.Owner) then
            local vm = self.Owner:GetViewModel()

            if IsValid(vm) then
                self:ResetBonePositions(vm)

                -- Init viewmodel visibility
                if (self.ShowViewModel == nil or self.ShowViewModel) then
                    vm:SetColor(Color(255, 255, 255, 255))
                else
                    -- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
                    vm:SetColor(Color(255, 255, 255, 1))
                    -- ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
                    -- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
                    vm:SetMaterial("Debug/hsv")
                end
            end
        end
    end
end

function SWEP:Holster()
    if CLIENT and IsValid(self.Owner) then
        local vm = self.Owner:GetViewModel()

        if IsValid(vm) then
            self:ResetBonePositions(vm)
        end
    end

    return true
end

function SWEP:RemoveModels(tab)
    if (not tab) then return end

    for k, v in pairs(tab) do
        if (IsValid(v.modelEnt)) then
            v.modelEnt:Remove()
            v.modelEnt = nil
        end
    end
end

function SWEP:OnRemove()
    if (CLIENT) then
        self:RemoveModels(self.VElements)
        self:RemoveModels(self.WElements)
    end

    self:Holster()
end

if CLIENT then
    SWEP.vRenderOrder = nil

    function SWEP:ViewModelDrawn()
        local vm = self.Owner:GetViewModel()
        if not IsValid(vm) then return end
        if (not self.VElements) then return end
        self:UpdateBonePositions(vm)

        if (not self.vRenderOrder) then
            -- we build a render order because sprites need to be drawn after models
            self.vRenderOrder = {}

            for k, v in pairs(self.VElements) do
                if (v.type == "Model") then
                    table.insert(self.vRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.vRenderOrder, k)
                end
            end
        end

        for k, name in ipairs(self.vRenderOrder) do
            local v = self.VElements[name]

            if (not v) then
                self.vRenderOrder = nil
                break
            end

            if (v.hide) then continue end
            local model = v.modelEnt
            local sprite = v.spriteMaterial
            if (not v.bone) then continue end
            local pos, ang = self:GetBoneOrientation(self.VElements, v, vm)
            if (not pos) then continue end

            if (v.type == "Model" and IsValid(model)) then
                model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                model:SetAngles(ang)
                --model:SetModelScale(v.size)
                local matrix = Matrix()
                matrix:Scale(v.size)
                model:EnableMatrix("RenderMultiply", matrix)

                if (v.material == "") then
                    model:SetMaterial("")
                elseif (model:GetMaterial() ~= v.material) then
                    model:SetMaterial(v.material)
                end

                if (v.skin and v.skin ~= model:GetSkin()) then
                    model:SetSkin(v.skin)
                end

                if (v.bodygroup) then
                    for k, v in pairs(v.bodygroup) do
                        if (model:GetBodygroup(k) ~= v) then
                            model:SetBodygroup(k, v)
                        end
                    end
                end

                if (v.surpresslightning) then
                    render.SuppressEngineLighting(true)
                end

                render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
                render.SetBlend(v.color.a / 255)
                model:DrawModel()
                render.SetBlend(1)
                render.SetColorModulation(1, 1, 1)

                if (v.surpresslightning) then
                    render.SuppressEngineLighting(false)
                end
            elseif (v.type == "Sprite" and sprite) then
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                render.SetMaterial(sprite)
                render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
            elseif (v.type == "Quad" and v.draw_func) then
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                cam.Start3D2D(drawpos, ang, v.size)
                v.draw_func(self)
                cam.End3D2D()
            end
        end
    end

    SWEP.wRenderOrder = nil

    function SWEP:DrawWorldModel()
        if (self.ShowWorldModel == nil or self.ShowWorldModel) then
            self:DrawModel()
        end

        if (not self.WElements) then return end

        if (not self.wRenderOrder) then
            self.wRenderOrder = {}

            for k, v in pairs(self.WElements) do
                if (v.type == "Model") then
                    table.insert(self.wRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.wRenderOrder, k)
                end
            end
        end

        if (IsValid(self.Owner)) then
            bone_ent = self.Owner
        else
            -- when the weapon is dropped
            bone_ent = self
        end

        for k, name in pairs(self.wRenderOrder) do
            local v = self.WElements[name]

            if (not v) then
                self.wRenderOrder = nil
                break
            end

            if (v.hide) then continue end
            local pos, ang

            if (v.bone) then
                pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent)
            else
                pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand")
            end

            if (not pos) then continue end
            local model = v.modelEnt
            local sprite = v.spriteMaterial

            if (v.type == "Model" and IsValid(model)) then
                model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                model:SetAngles(ang)
                --model:SetModelScale(v.size)
                local matrix = Matrix()
                matrix:Scale(v.size)
                model:EnableMatrix("RenderMultiply", matrix)

                if (v.material == "") then
                    model:SetMaterial("")
                elseif (model:GetMaterial() ~= v.material) then
                    model:SetMaterial(v.material)
                end

                if (v.skin and v.skin ~= model:GetSkin()) then
                    model:SetSkin(v.skin)
                end

                if (v.bodygroup) then
                    for k, v in pairs(v.bodygroup) do
                        if (model:GetBodygroup(k) ~= v) then
                            model:SetBodygroup(k, v)
                        end
                    end
                end

                if (v.surpresslightning) then
                    render.SuppressEngineLighting(true)
                end

                render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
                render.SetBlend(v.color.a / 255)
                model:DrawModel()
                render.SetBlend(1)
                render.SetColorModulation(1, 1, 1)

                if (v.surpresslightning) then
                    render.SuppressEngineLighting(false)
                end
            elseif (v.type == "Sprite" and sprite) then
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                render.SetMaterial(sprite)
                render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
            elseif (v.type == "Quad" and v.draw_func) then
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                ang:RotateAroundAxis(ang:Up(), v.angle.y)
                ang:RotateAroundAxis(ang:Right(), v.angle.p)
                ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                cam.Start3D2D(drawpos, ang, v.size)
                v.draw_func(self)
                cam.End3D2D()
            end
        end
    end

    function SWEP:GetBoneOrientation(basetab, tab, ent, bone_override)
        local bone, pos, ang

        if (tab.rel and tab.rel ~= "") then
            local v = basetab[tab.rel]
            if (not v) then return end
            -- Technically, if there exists an element with the same name as a bone
            -- you can get in an infinite loop. Let's just hope nobody's that stupid.
            pos, ang = self:GetBoneOrientation(basetab, v, ent)
            if (not pos) then return end
            pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)
        else
            bone = ent:LookupBone(bone_override or tab.bone)
            if (not bone) then return end
            pos, ang = Vector(0, 0, 0), Angle(0, 0, 0)
            local m = ent:GetBoneMatrix(bone)

            if (m) then
                pos, ang = m:GetTranslation(), m:GetAngles()
            end

            if (IsValid(self.Owner) and self.Owner:IsPlayer() and ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
                ang.r = -ang.r -- Fixes mirrored models
            end
        end

        return pos, ang
    end

    function SWEP:CreateModels(tab)
        if (not tab) then return end

        -- Create the clientside models here because Garry says we can't do it in the render hook
        for k, v in pairs(tab) do
            if (v.type == "Model" and v.model and v.model ~= "" and (not IsValid(v.modelEnt) or v.createdModel ~= v.model) and string.find(v.model, ".mdl") and file.Exists(v.model, "GAME")) then
                v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)

                if (IsValid(v.modelEnt)) then
                    v.modelEnt:SetPos(self:GetPos())
                    v.modelEnt:SetAngles(self:GetAngles())
                    v.modelEnt:SetParent(self)
                    v.modelEnt:SetNoDraw(true)
                    v.createdModel = v.model
                else
                    v.modelEnt = nil
                end
            elseif (v.type == "Sprite" and v.sprite and v.sprite ~= "" and (not v.spriteMaterial or v.createdSprite ~= v.sprite) and file.Exists("materials/" .. v.sprite .. ".vmt", "GAME")) then
                local name = v.sprite .. "-"

                local params = {
                    ["$basetexture"] = v.sprite
                }

                -- make sure we create a unique name based on the selected options
                local tocheck = {"nocull", "additive", "vertexalpha", "vertexcolor", "ignorez"}

                for i, j in pairs(tocheck) do
                    if (v[j]) then
                        params["$" .. j] = 1
                        name = name .. "1"
                    else
                        name = name .. "0"
                    end
                end

                v.createdSprite = v.sprite
                v.spriteMaterial = CreateMaterial(name, "UnlitGeneric", params)
            end
        end
    end

    local allbones
    local hasGarryFixedBoneScalingYet = false

    function SWEP:UpdateBonePositions(vm)
        if self.ViewModelBoneMods then
            if (not vm:GetBoneCount()) then return end
            -- !! WORKAROUND !! //
            -- We need to check all model names :/
            local loopthrough = self.ViewModelBoneMods

            if (not hasGarryFixedBoneScalingYet) then
                allbones = {}

                for i = 0, vm:GetBoneCount() do
                    local bonename = vm:GetBoneName(i)

                    if (self.ViewModelBoneMods[bonename]) then
                        allbones[bonename] = self.ViewModelBoneMods[bonename]
                    else
                        allbones[bonename] = {
                            scale = Vector(1, 1, 1),
                            pos = Vector(0, 0, 0),
                            angle = Angle(0, 0, 0)
                        }
                    end
                end

                loopthrough = allbones
            end

            -- !! ----------- !! //
            for k, v in pairs(loopthrough) do
                local bone = vm:LookupBone(k)
                if (not bone) then continue end
                -- !! WORKAROUND !! //
                local s = Vector(v.scale.x, v.scale.y, v.scale.z)
                local p = Vector(v.pos.x, v.pos.y, v.pos.z)
                local ms = Vector(1, 1, 1)

                if (not hasGarryFixedBoneScalingYet) then
                    local cur = vm:GetBoneParent(bone)

                    while (cur >= 0) do
                        local pscale = loopthrough[vm:GetBoneName(cur)].scale
                        ms = ms * pscale
                        cur = vm:GetBoneParent(cur)
                    end
                end

                s = s * ms

                -- !! ----------- !! //
                if vm:GetManipulateBoneScale(bone) ~= s then
                    vm:ManipulateBoneScale(bone, s)
                end

                if vm:GetManipulateBoneAngles(bone) ~= v.angle then
                    vm:ManipulateBoneAngles(bone, v.angle)
                end

                if vm:GetManipulateBonePosition(bone) ~= p then
                    vm:ManipulateBonePosition(bone, p)
                end
            end
        else
            self:ResetBonePositions(vm)
        end
    end

    function SWEP:ResetBonePositions(vm)
        if (not vm:GetBoneCount()) then return end

        for i = 0, vm:GetBoneCount() do
            vm:ManipulateBoneScale(i, Vector(1, 1, 1))
            vm:ManipulateBoneAngles(i, Angle(0, 0, 0))
            vm:ManipulateBonePosition(i, Vector(0, 0, 0))
        end
    end

    --[[*************************

		Global utility code

	*************************]]
    -- Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
    -- Does not copy entities of course, only copies their reference.
    -- WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
    function table.FullCopy(tab)
        if (not tab) then return nil end
        local res = {}

        for k, v in pairs(tab) do
            if (type(v) == "table") then
                res[k] = table.FullCopy(v) -- recursion ho!
            elseif (type(v) == "Vector") then
                res[k] = Vector(v.x, v.y, v.z)
            elseif (type(v) == "Angle") then
                res[k] = Angle(v.p, v.y, v.r)
            else
                res[k] = v
            end
        end

        return res
    end
end