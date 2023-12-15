COMMAND.Name = "SetWepLevel"
COMMAND.Flag = "h"
COMMAND.CheckRankWeight = true
COMMAND.Args = {{"player", "Name/SteamID"}, {"string", "Weapon Slot", "primary"}, {"number", "Weapon Level", 100}}

COMMAND.Run = function(pl, args, supp)
	target = args[1]
	slot = args[2]
	level = args[3]
	playerTarget = supp[1]

	local pri_wep, sec_wep, melee_wep, powerup, tactical = m_GetLoadout(playerTarget)

	if(string.lower(slot) == "primary") then
		pri_wep.s.l = tonumber(level)

	elseif (string.lower(slot) == "secondary") then
		sec_wep.s.l = tonumber(level)
		
	elseif (string.lower(slot) == "melee") then
		melee_wep.s.l = tonumber(level)

	end

	MOAT_LOADOUT.GivePlayerLoadout(playerTarget, pri_wep, sec_wep, melee_wep, powerup, tactical, true)

end