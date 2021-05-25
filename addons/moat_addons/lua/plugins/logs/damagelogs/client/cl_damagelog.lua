local outdated = false
/*
http.Fetch("https://api.github.com/repos/Tommy228/TTTDamagelogs/contents/version.md?ref=master", function(body)
	local content = util.JSONToTable(body)
	if not content then return end
	local version = content.content
	if version then
		version = Damagelog.Base64Decode(version)
		local cur_version = string.Explode(".", Damagelog.VERSION)
		local tbl = string.Explode(".", version)
		for i=1,3 do
			tbl[i] = tonumber(tbl[i])
			cur_version[i] = tonumber(cur_version[i])
		end
		if tbl[1] > cur_version[1] then
			outdated = true
		elseif tbl[1] == cur_version[1] and tbl[2] > cur_version[2] then
			outdated = true
		elseif tbl[1] == cur_version[1] and tbl[2] == cur_version[2] and tbl[3] > cur_version[3] then
			outdated = true
		end
	end
end)*/

function Damagelog:OpenMenu()
	local x,y = 665, 680
	if outdated then
		y = y + 30
	end
	self.Menu = vgui.Create("DFrame")
	self.Menu:SetSize(x, y)
	self.Menu:SetTitle("TTT Damagelogs version " .. self.VERSION)
	self.Menu:SetDraggable(true)
	self.Menu:MakePopup()
	self.Menu:SetKeyboardInputEnabled(false)
	self.Menu:Center()
	self.Menu.AboutPos = 0
	self.Menu.AboutPosMax = 95
	self.Menu.AboutState = false
	self.Menu.About = function(self)
		self.AboutState = not self.AboutState
	end
	local old_think = self.Menu.Think
	self.Menu.Think = function(self)
		self.AboutMoving = true
		if self.AboutState and self.AboutPos < self.AboutPosMax then
			self.AboutPos = self.AboutPos + 15
		elseif not self.AboutState and self.AboutPos > 0 then
			self.AboutPos = self.AboutPos - 15
		else
			self.AboutMoving = false
		end
		if old_think then
			old_think(self)
		end
	end
	self.Menu.PaintOver = function(self, w, h)
		local _x,_y,_w,_h = x-200, outdated and 80 or 50, 195, self.AboutPos
		surface.SetDrawColor(color_black)
		surface.DrawRect(_x,_y,_w,_h)
		surface.SetDrawColor(Color(255, 245, 148))
		surface.DrawRect(_x+1, _y+1, _w-2, _h-2)
		if self.AboutPos >= 50 then
			surface.SetFont("DermaDefault")
			surface.SetTextColor(color_black)
			surface.SetTextPos(_x + 5, _y+5)
			surface.DrawText("Created by Tommy228.")
			surface.SetTextPos(_x + 5, _y  + 25)
			surface.DrawText("Code contributors :")
			surface.SetTextPos(_x + 5, _y  + 40)
			surface.DrawText("- Joschasa")
			surface.SetTextPos(_x + 5, _y  + 55)
			surface.DrawText("- Azarym")
			surface.SetTextPos(_x + 5, _y  + 70)
			surface.DrawText("- Pandaman09")
			surface.SetTextPos(_x + 5, _y  + 85)
			surface.DrawText("- Bytewave")
		end
	end
	if outdated then
		local info = vgui.Create("Damagelog_InfoLabel", self.Menu);
		info:SetText("Server owners : this version is outdated! You can get the latest one on http://github.com/Tommy228/TTTDamagelogs");
		info:SetInfoColor("blue");
		info:SetPos(5,30);
		info:SetSize(x-10, 25);		
	end
	self.Tabs = vgui.Create("DPropertySheet", self.Menu)
	self.Tabs:SetPos(5, outdated and 60 or 30)
	self.Tabs:SetSize(x-10, outdated and y-65 or y-35)	
	self:DrawDamageTab(x, y)
	self:DrawShootsTab(x, y)
	self:DrawOldLogs(x, y)
	self:DrawRDMManager(x, y)
	self:DrawSettings(x, y)
	self.About = vgui.Create("DButton", self.Menu)
	self.About:SetPos(x - 60, outdated and 57 or 27)
	self.About:SetSize(55, 19)
	self.About:SetText("▼ About")
	self.About.DoClick = function()
		self.Menu:About()
		self.About:SetText(self.Menu.AboutState and "▲ About" or "▼ About")
	end
end

concommand.Add("damagelog", function()
	Damagelog:OpenMenu()
end)

Damagelog.pressed_key = false
function Damagelog:Think()
	if input.IsKeyDown(self.Key) and not self.pressed_key then
		self.pressed_key = true
		if not IsValid(self.Menu) then
			self:OpenMenu()
		else
			if self:IsRecording() then
				self:StopRecording()
				self.Menu:SetVisible(true)
			else
				self.Menu:Close()
			end
		end
	elseif self.pressed_key and not input.IsKeyDown(self.Key) then
		self.pressed_key = false
	end
end

hook.Add("Think", "Think_Damagelog", function()
	Damagelog:Think()
end)

function Damagelog:StrRole(role)
	return LANG.GetRawTranslation(role_strings[role] or "innocent")
end

net.Receive("M_DL_InformSuperAdmins", function()
	local nick = net.ReadString()
	if nick then
		chat.AddText(Color(255,62,62), nick, color_white, " is alive and has loaded the logs of the current round.")
	end
end)

net.Receive("M_DL_Ded", function()
--	if (true) then return end
	
	if Damagelog.RDM_Manager_Enabled and cvars.Bool("ttt_dmglogs_rdmpopups") and net.ReadUInt(1,1) == 1 then
	
	 	if LocalPlayer().IsGhost and LocalPlayer():IsGhost() then return end
	
		local death_reason = net.ReadString()
		
		if not death_reason  then return end
	
		local frame = vgui.Create("DFrame")
		frame:SetSize(250, 120)
		frame:SetTitle("(note : you can disable this popup on F1)")
		frame:ShowCloseButton(false)
		frame:Center()
	
		local reason = vgui.Create("DLabel", frame)
		reason:SetText("You were killed by "..death_reason)
		reason:SizeToContents()
		reason:SetPos(5, 32)
	
		local report = vgui.Create("DButton", frame)
		report:SetPos(5, 55)
		report:SetSize(240, 25)
		report:SetText("Open the report menu")
		report.DoClick = function()
			net.Start("M_DL_StartReport")
			net.SendToServer()
			frame:Close()
		end
	
		local report_icon = vgui.Create("DImageButton", report)
		report_icon:SetMaterial("materials/icon16/report_go.png")
		report_icon:SetPos(1, 5)
		report_icon:SizeToContents()
	
		local close = vgui.Create("DButton", frame)
		close:SetPos(5, 85)
		close:SetSize(240, 25)	
		close:SetText("This was not RDM.")
		close.DoClick = function()
			frame:Close()
		end
	
		local close_icon = vgui.Create("DImageButton", close)
		close_icon:SetPos(2, 5)
		close_icon:SetMaterial("materials/icon16/cross.png")
		close_icon:SizeToContents()
	
		frame:MakePopup()
		
		chat.AddText(Color(255,62,62), "[RDM Manager] ", Color(255,255, 255), "You died! Open the report menu using the ", Color(98,176,255), Damagelog.RDM_Manager_Command, Color(255, 255, 255), " command.")
		
	end
	
end)

hook.Add("StartChat", "Damagelog_StartChat", function()
	if IsValid(Damagelog.Menu) then
		Damagelog.Menu:SetPos(ScrW() - Damagelog.Menu:GetWide(), ScrH()/2 - Damagelog.Menu:GetTall()/2)
	end
end)

hook.Add("FinishChat", "Damagelog_FinishChat", function()
	if IsValid(Damagelog.Menu) then
		Damagelog.Menu:Center()
	end
end)
