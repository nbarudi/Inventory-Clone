COMMAND.Name = "SetKarma"
COMMAND.Flag = "s"

COMMAND.Args = {{"player", "Name/SteamID"}, {"number", "Karma"}}

COMMAND.Run = function(pl, args, supp)
	
	supp[1]:SetLiveKarma(tonumber(args[2]))
	supp[1]:SetBaseKarma(tonumber(args[2]))
	D3A.Chat.BroadcastStaff2(moat_red, "(Silent)", moat_cyan, D3A.Commands.Name(pl), moat_white, " set the karma of ", moat_green, supp[1]:Name(), moat_white, " to " , moat_green, args[2], moat_white, ".")
	//D3A.Chat.Broadcast2(moat_cyan, D3A.Commands.Name(pl), moat_white, " set the health of ", moat_green, supp[1]:Name(), moat_white, " to ", moat_green, args[2], moat_white, ".")
end