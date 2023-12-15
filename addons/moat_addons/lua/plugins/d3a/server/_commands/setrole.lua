COMMAND.Name = "SetRole"
COMMAND.Flag = "h"

COMMAND.Args = {{"player", "Name/SteamID"}, {"string", "Role"}}

name_to_id = {
	["innocent"] = 0,
	["traitor"] = 1,
	["detective"] = 2,
	["jester"] = 3,
	["killer"] = 4,
	["doctor"] = 5,
	["beacon"] = 6,
	["survivor"] = 7,
	["hitman"] = 8,
	["bodyguard"] = 9,
	["veteran"] = 10,
	["xenomorph"] = 11,
	["witchdoctor"] = 12,
}

COMMAND.Run = function(pl, args, supp)
	
	for i,id in pairs(name_to_id) do
		print(i .. " | " .. id .. " | " .. args[2])
		if i == args[2] then
			supp[1]:SetRole(name_to_id[args[2]])
			SendFullStateUpdate()
			D3A.Chat.BroadcastStaff2(moat_red, "(Silent)", moat_cyan, D3A.Commands.Name(pl), moat_white, " set the role of ", moat_green, supp[1]:Name(), moat_white, " to " , moat_green, args[2], moat_white, ".")
		end
	end
	
	//D3A.Chat.Broadcast2(moat_cyan, D3A.Commands.Name(pl), moat_white, " set the health of ", moat_green, supp[1]:Name(), moat_white, " to ", moat_green, args[2], moat_white, ".")
end