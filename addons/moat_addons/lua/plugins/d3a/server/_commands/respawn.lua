COMMAND.Name = "Respawn"
COMMAND.Flag = "h"

COMMAND.Args = {{"player", "Name/SteamID"}}

--[[corpse_find][Finds the corpse of a given player.]
@param  {[PlayerObject]} v       [The player that to find the corpse for.]
--]]
local function corpse_find(v)
	for _, ent in pairs( ents.FindByClass( "prop_ragdoll" )) do
		if ent.uqid == v:UniqueID() and IsValid(ent) then
			return ent or false
		end
	end
end

--[[corpse_remove][removes the corpse given.]
@param  {[Ragdoll]} corpse [The corpse to be removed.]
--]]
local function corpse_remove(corpse)
	CORPSE.SetFound(corpse, false)
	if string.find(corpse:GetModel(), "zm_", 6, true) then
        player.GetByUniqueID( corpse.uqid ):SetNWBool( "body_found", false )
        corpse:Remove()
        SendFullStateUpdate()
	elseif corpse.player_ragdoll then
        player.GetByUniqueID( corpse.uqid ):SetNWBool( "body_found", false )
		corpse:Remove()
        SendFullStateUpdate()
	end
end

COMMAND.Run = function(pl, args, supp)
	--supp[1]:Spawn()

	local v = supp[1]

	if v:Alive() and v:IsSpec() then -- players arent really dead when they are spectating, we need to handle that correctly
		--timer.Destroy("traitorcheck" .. v:SteamID())
		v:ConCommand("ttt_spectator_mode 0") -- just incase they are in spectator mode take them out of it
		timer.Create("respawndelay", 0.1, 0, function() --seems to be a slight delay from when you leave spec and when you can spawn this should get us around that
			local corpse = corpse_find(v) -- run the normal respawn code now
			if corpse then corpse_remove(corpse) end

			v:SpawnForRound( true )
			v:SetCredits( ( (v:GetRole() == ROLE_INNOCENT) and 0 ) or GetConVarNumber("ttt_credits_starting") )

			if v:Alive() then timer.Destroy("respawndelay") return end
		end)
	elseif v:Alive() then
		D3A.Chat.SendToPlayer2( pl, v:Nick() .. " is already alive!" ) 
		return
	else
		--timer.Destroy("traitorcheck" .. v:SteamID())
		local corpse = corpse_find(v)
		if corpse then corpse_remove(corpse) end

		v:SpawnForRound( true )
		v:SetCredits( ( (v:GetRole() == ROLE_INNOCENT) and 0 ) or GetConVarNumber("ttt_credits_starting") )
	end
	
	D3A.Chat.BroadcastStaff2(moat_red,"(Silent)", moat_cyan, D3A.Commands.NameID(pl), moat_white, " has respawned ", moat_green, supp[1]:NameID(), moat_white, ".")
end