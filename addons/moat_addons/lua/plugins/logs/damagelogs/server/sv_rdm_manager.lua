
util.AddNetworkString("M_DL_AllowReport")
util.AddNetworkString("M_DL_ReportPlayer")
util.AddNetworkString("M_DL_UpdateReports")
util.AddNetworkString("M_DL_UpdateReport")
util.AddNetworkString("M_DL_NewReport")
util.AddNetworkString("M_DL_UpdateStatus")
util.AddNetworkString("M_DL_SendReport")
util.AddNetworkString("M_DL_SendAnswer")
util.AddNetworkString("M_DL_SendForgive")
util.AddNetworkString("M_DL_GetForgive")
util.AddNetworkString("M_DL_Death")
util.AddNetworkString("M_DL_Answering")
util.AddNetworkString("M_DL_Answering_global")
util.AddNetworkString("M_DL_ForceRespond")
util.AddNetworkString("M_DL_StartReport")
util.AddNetworkString("M_DL_Conclusion")

Damagelog.Reports = Damagelog.Reports or { Current = {} }

if not Damagelog.Reports.Previous then
	if file.Exists("damagelog/prevreports.txt", "DATA") then
		Damagelog.Reports.Previous = util.JSONToTable(file.Read("damagelog/prevreports.txt", "DATA"))
		file.Delete("damagelog/prevreports.txt")
	else
		Damagelog.Reports.Previous = {}
	end
end

local function GetBySteamID(steamid)
	for k,v in pairs(player.GetAll()) do
		if v:SteamID() == steamid then
			return v
		end
	end
end

local function UpdatePreviousReports()
	local tbl = table.Copy(Damagelog.Reports.Current)
	for k,v in pairs(tbl) do
		v.previous = true
	end
	file.Write("damagelog/prevreports.txt", util.TableToJSON(tbl))
end

local Player = FindMetaTable("Player")

function Player:RemainingReports()
	return 2 - #self.Reported
end

function Player:UpdateReports()
	if not self:CanUseRDMManager() then return end
	local tbl = util.TableToJSON(Damagelog.Reports)
	if not tbl then return end
	local compressed = util.Compress(tbl)
	if not compressed then return end
	net.Start("M_DL_UpdateReports")
	net.WriteUInt(#compressed, 32)
	net.WriteData(compressed, #compressed)
	net.Send(self)
end

net.Receive("M_DL_UpdateReports", function(_, ply)
	ply:UpdateReports()
end)

function Player:NewReport(report)
	if not self:CanUseRDMManager() then return end
	net.Start("M_DL_NewReport")
	net.WriteTable(report)
	net.Send(self)
end

function Player:UpdateReport(previous, index)
	if not self:CanUseRDMManager() then return end
	local tbl = previous and Damagelog.Reports.Previous[index] or Damagelog.Reports.Current[index]
	if not tbl then return end
	net.Start("M_DL_UpdateReport")
	net.WriteUInt(previous and 1 or 0, 1)
	net.WriteUInt(index, 8)
	net.WriteTable(tbl)
	net.Send(self)
end

function Player:SendReport(tbl)
	if tbl.chat_opened then return end
	net.Start("M_DL_SendReport")
	net.WriteTable(tbl)
	net.Send(self)
end

hook.Add("PlayerSay", "Damagelog_RDMManager", function(ply, text, teamOnly)
	if Damagelog.RDM_Manager_Enabled then
		if (string.Left(string.lower(text), #Damagelog.RDM_Manager_Command) == Damagelog.RDM_Manager_Command) then
			Damagelog:StartReport(ply)
			return ""
		elseif (Damagelog.Respond_Command and string.Left(string.lower(text), #Damagelog.Respond_Command) == Damagelog.Respond_Command) then
			net.Start("M_DL_Death")
			net.Send(ply)
		end
	end
end)

hook.Add("TTTBeginRound", "Damagelog_RDMManger", function()
	for k,v in pairs(player.GetHumans()) do
		if not v.CanReport then
			v.CanReport = true
		end
		table.Empty(v.Reported)
	end
end)

net.Receive("M_DL_StartReport", function(length, ply)
	Damagelog:StartReport(ply)
end)

function Damagelog:StartReport(ply)
	if not IsValid(ply) then return end
	-- local found = false
	-- for k,v in pairs(player.GetHumans()) do
	-- 	if v:CanUseRDMManager() then
	-- 		found = true
	-- 		break
	-- 	end
	-- end
	-- if not found then
	-- 	ply:Damagelog_Notify(DAMAGELOG_NOTIFY_ALERT, "No admins online!", 4, "buttons/weapon_cant_buy.wav")
	-- 	return
	-- end
	if not ply.CanReport then
		ply:Damagelog_Notify(DAMAGELOG_NOTIFY_ALERT, "You need to play before being able to report!", 4, "buttons/weapon_cant_buy.wav")
	else
		local remaining_reports = ply:RemainingReports()
		if remaining_reports <= 0 then
			ply:Damagelog_Notify(DAMAGELOG_NOTIFY_ALERT, "You can only report twice per round!", 4, "buttons/weapon_cant_buy.wav")
		else
			net.Start("M_DL_AllowReport")
			if ply.DeathDmgLog and ply.DeathDmgLog[Damagelog.CurrentRound] then
				net.WriteUInt(1, 1)
				net.WriteTable(ply.DeathDmgLog[Damagelog.CurrentRound])
			else
				net.WriteUInt(0,1);
			end
			net.Send(ply)
		end
	end
end

net.Receive("M_DL_ReportPlayer", function(_len, ply)
	if (ply.NextReportTime and ply.NextReportTime > CurTime()) then
		return
	end

	ply.NextReportTime = CurTime() + 1
	
	local attacker = net.ReadEntity()
	local message = net.ReadString()
	if (not message or string.len(message) > 300) then
		return
	end

	if ply:RemainingReports() <= 0 or not ply.CanReport then return end
	if attacker == ply then return end
	if not IsValid(attacker) then 
		ply:Damagelog_Notify(DAMAGELOG_NOTIFY_ALERT, "Error reporting : Invalid attacker entity!", 5, "buttons/weapon_cant_buy.wav")
		return 
	end
	if not attacker:GetNW2Bool("PlayedSRound", true) then
		ply:Damagelog_Notify(DAMAGELOG_NOTIFY_ALERT, "You can't report spectators!", 5, "buttons/weapon_cant_buy.wav")
		return
	end
	if table.HasValue(ply.Reported, attacker) then
		ply:Damagelog_Notify(DAMAGELOG_NOTIFY_ALERT, "You have already reported this player!", 5, "buttons/weapon_cant_buy.wav")
		return 
	end
	table.insert(ply.Reported, attacker)
	local index = table.insert(Damagelog.Reports.Current, {
		victim = ply:SteamID(),
		victim_nick = ply:Nick(),
		attacker = attacker:SteamID(),
		attacker_nick = attacker:Nick(),
		message = message,
		response = false,
		status = RDM_MANAGER_WAITING_FOR_ATTACKER,
		admin = false,
		round = Damagelog.CurrentRound,
		chat_open = false,
		logs = ply.DeathDmgLog and ply.DeathDmgLog[Damagelog.CurrentRound] or false,
		conclusion = false
	})
	Damagelog.Reports.Current[index].index = index
	for k,v in pairs(player.GetHumans()) do
		if v:CanUseRDMManager() then
			if v:IsActive() then
				v:Damagelog_Notify(DAMAGELOG_NOTIFY_ALERT, "A new report has been created! (#"..index..") !", 5, "ui/vote_failure.wav")
			else
				v:Damagelog_Notify(DAMAGELOG_NOTIFY_ALERT, ply:Nick().." has reported "..attacker:Nick().. " (#"..index..") !", 5, "ui/vote_failure.wav")
			end
			v:NewReport(Damagelog.Reports.Current[index])
		end
	end
	attacker:SendReport(Damagelog.Reports.Current[index])
	if not attacker:CanUseRDMManager() then
		attacker:Damagelog_Notify(DAMAGELOG_NOTIFY_ALERT, ply:Nick().." has reported you!", 5, "ui/vote_failure.wav")
	end
	ply:Damagelog_Notify(DAMAGELOG_NOTIFY_ALERT, "You have reported "..attacker:Nick(), 5, "")
	UpdatePreviousReports()
end)

net.Receive("M_DL_UpdateStatus", function(_len, ply)
	local previous = net.ReadUInt(1) == 1
	local index = net.ReadUInt(16)
	local status = net.ReadUInt(4)
	if not ply:CanUseRDMManager() then return end
	local tbl = previous and Damagelog.Reports.Previous[index] or Damagelog.Reports.Current[index]
	if not tbl then return end
	if tbl.status == status then return end
	tbl.status = status
	tbl.admin = status == RDM_MANAGER_WAITING and false or ply:Nick()
	local msg
	hook.Run("RDMManagerReportStatusUpdate", ply, index, status)
	if status == RDM_MANAGER_WAITING then
		msg = ply:Nick().." has set the report #"..index.." to Waiting."
	elseif status == RDM_MANAGER_PROGRESS then
		msg = ply:Nick().." is now dealing with the report #"..index.."."
		for k,v in pairs(player.GetAll()) do
			if v:SteamID() == tbl.victim then
				v:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, ply:Nick().." is now handling your report.", 5, "ui/vote_yes.wav")
			end
		end
	elseif status == RDM_MANAGER_FINISHED then
		msg = ply:Nick().." has set the report #"..index.." to Finished."
	end
	for k,v in pairs(player.GetHumans()) do
		if v:CanUseRDMManager() then	
			if v != ply then
				v:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, msg, 5, "")
			end
			v:UpdateReport(previous, index)
		end
	end
	UpdatePreviousReports()
end)

net.Receive("M_DL_Conclusion", function(_len, ply)
	local notify = net.ReadUInt(1) == 0
	local previous = net.ReadUInt(1) == 1
	local index = net.ReadUInt(16)
	local conclusion = net.ReadString()
	if not ply:CanUseRDMManager() then return end
	local tbl = previous and Damagelog.Reports.Previous[index] or Damagelog.Reports.Current[index]
	if not tbl then return end
	if notify and tbl.status != RDM_MANAGER_FINISHED and tbl.status != RDM_MANAGER_CANCELED then
		ply:Damagelog_Notify(DAMAGELOG_NOTIFY_ALERT, "This report is not finished!", 5, "buttons/weapon_cant_buy.wav")
		return 
	end
	tbl.conclusion = conclusion
	for k,v in pairs(player.GetHumans()) do
		if v:CanUseRDMManager() then	
			if notify and v != ply then
				v:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, ply:Nick().." has set a conclusion to the report #"..index..".", 5, "")
			end
			v:UpdateReport(previous, index)
		end
	end
	UpdatePreviousReports()
end)	

hook.Add("PlayerAuthed", "RDM_Manager", function(ply)
	ply.Reported = {}
	for _,tbl in pairs(Damagelog.Reports) do
		for k,v in pairs(tbl) do
			if v.attacker == ply:SteamID() and not v.response then
				ply:SendReport(v)
			end
		end
	end
end)

hook.Add("PlayerDeath", "RDM_Manager", function(ply)
	net.Start("M_DL_Death")
	net.Send(ply)
end)

hook.Add("TTTEndRound", "RDM_Manager", function()
	for k,v in pairs(player.GetAll()) do
		net.Start("M_DL_Death")
		net.Send(v)
	end
end)

local waiting_forgive = {}

net.Receive("M_DL_SendAnswer", function(_, ply)
	local previous = net.ReadUInt(1) != 1
	local text = net.ReadString()
	local index = net.ReadUInt(16)
	local tbl = previous and Damagelog.Reports.Previous[index] or Damagelog.Reports.Current[index]
	if not tbl then return end
	if tbl.chat_opened then return end
	if ply:SteamID() != tbl.attacker then return end
	if (not text or string.len(text) > 300) then
		return
	end
	
	tbl.response = text
	tbl.status = RDM_MANAGER_WAITING_FOR_VICTIM
	for k,v in pairs(player.GetHumans()) do
		if v:CanUseRDMManager() then
			v:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, (v:IsActive() and "The reported player " or ply:Nick()).." has answered to the report #"..index.."!", 5, "ui/vote_yes.wav")
			v:UpdateReport(previous, index)
		end
	end
	local victim = GetBySteamID(tbl.victim)
	if IsValid(victim) then
		net.Start("M_DL_SendForgive")
		net.WriteUInt(previous and 1 or 0, 1)
		net.WriteUInt(index, 16)
		net.WriteString(tbl.attacker_nick)
		net.WriteString(text)
		net.Send(victim)
	end
	UpdatePreviousReports()
end)

net.Receive("M_DL_GetForgive", function(_, ply)
	local forgive = net.ReadUInt(1) == 1
	local previous = net.ReadUInt(1) == 1
	local index = net.ReadUInt(16)
	local tbl = previous and Damagelog.Reports.Previous[index] or Damagelog.Reports.Current[index]
	if tbl.chat_opened then return end
	if not tbl then return end
	if ply:SteamID() != tbl.victim then return end
	if forgive then
		tbl.status = RDM_MANAGER_CANCELED
		tbl.conclusion = "(Auto) "..ply:Nick().." has canceled to the report."
	else
		tbl.status = RDM_MANAGER_WAITING
	end
	for k,v in pairs(player.GetHumans()) do
		if v:CanUseRDMManager() then	
			if forgive then
				if v:IsActive() then
					v:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, "The report #"..index.." has been canceled by the victim!", 5, "ui/vote_yes.wav")
				else
					v:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, ply:Nick().." has canceled the report #"..index.." !", 5, "ui/vote_yes.wav")
				end
			else
				if v:IsActive() then
					v:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, "The victim did not forgive the attacker on the report #"..index.." !", 5, "ui/vote_yes.wav")
				else
					v:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, ply:Nick().." did not forgive "..tbl.attacker_nick.." on the report #"..index.." !", 5, "ui/vote_yes.wav")
				end
			end
			v:UpdateReport(previous, index)
		end
	end
	if forgive then
		ply:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, "You decided to cancel the report.", 5, "ui/vote_yes.wav")
	else
		ply:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, "You decided to keep the report.", 5, "ui/vote_yes.wav")
	end
	local attacker = GetBySteamID(tbl.attacker)
	if IsValid(attacker) then
		if forgive then
			attacker:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, ply:Nick().." decided to cancel the report.", 5, "ui/vote_yes.wav")
		else
			attacker:Damagelog_Notify(DAMAGELOG_NOTIFY_INFO, ply:Nick().." does not want to forgive you.", 5, "ui/vote_yes.wav")
		end
	end
	UpdatePreviousReports()
	
	hook.Call( "TTTDLog_Decide", nil, ply, IsValid( attacker ) and attacker or tbl.attacker, forgive, index )
end)

net.Receive("M_DL_Answering", function(_len, ply)
	if (ply.NextAnswerTime and ply.NextAnswerTime > CurTime()) then
		return
	end

	ply.NextAnswerTime = CurTime() + 1

	net.Start("M_DL_Answering_global")
	net.WriteString(ply:Nick())
	net.Broadcast()
end)

net.Receive("M_DL_ForceRespond", function(_len, ply)
	local index = net.ReadUInt(16)
	local previous = net.ReadUInt(1) == 1
	if not ply:CanUseRDMManager() then return end
	local tbl = previous and Damagelog.Reports.Previous[index] or Damagelog.Reports.Current[index]
	if not tbl then return end
	if not tbl.response then
		local attacker = GetBySteamID(tbl.attacker)
		if IsValid(attacker) then
			net.Start("M_DL_Death")
			net.Send(attacker)
		end
	end
end)
