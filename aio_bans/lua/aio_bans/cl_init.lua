--[[
	This database of players who violate or use third-party software.
	Our development team is trying to improve the quality of the game and get rid of unwanted players.
	
	All rights reserved Awesomium Team.
--]]

function SeeBadUserMenu()
	local BadUserMenu = vgui.Create("DFrame")
	BadUserMenu:SetPos(ScrW()/2-200,ScrH())
	BadUserMenu:SetSize(400,500)
	BadUserMenu:MoveTo(ScrW()/2-200, ScrH()/2-250, 0.5, 0, 6)
	BadUserMenu:SetTitle("")
	BadUserMenu:MakePopup()
	BadUserMenu:ShowCloseButton(false)
	BadUserMenu.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,AWTeam.Menu.ColorBG)
		draw.RoundedBox(0,0,0,w,20,Color(0,0,0,150))
		draw.RoundedBox(0,0,20,w,5,Color(0,0,0,180))
		draw.DrawText(AWTeam.Translate.NameMenu,AWTeam.Menu.Font,5,5,AWTeam.Menu.FontColor)
	end
	
	local CloseButton = vgui.Create("DButton",BadUserMenu)
	CloseButton:SetPos(BadUserMenu:GetWide()-50,0)
	CloseButton:SetSize(50,25)
	CloseButton:SetText("")
	CloseButton.Paint = function(s,w,h)
		s.Alpha = 0
		if s.Depressed then
			s.Alpha = 150
		elseif s.Hovered then
			s.Alpha = 100
		else end
		draw.RoundedBox(0,0,0,w,h,Color(255, 127, 102))
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,s.Alpha))
		draw.RoundedBox(0,0,20,w,5,Color(0,0,0,50))
		draw.DrawText("X",AWTeam.Menu.Font,w/2,h/2-6,AWTeam.Menu.FontColor,1)
	end
	CloseButton.DoClick = function()
		BadUserMenu:MoveTo(ScrW()/2-200, ScrH(), 0.5, 0, 6)
		timer.Simple(0.8,function()
			BadUserMenu:Remove()
		end)
	end
	
	local SendBan = vgui.Create("DButton", BadUserMenu)
	SendBan:SetPos(BadUserMenu:GetWide()-135,0)
	SendBan:SetSize(85,25)
	SendBan:SetText("")
	SendBan.Paint = function(s,w,h)
		s.Alpha = 0
		if s.Depressed then
			s.Alpha = 150
		elseif s.Hovered then
			s.Alpha = 100
		else end
		draw.RoundedBox(0,0,0,w,h,AWTeam.Menu.ColoButton)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,s.Alpha))
		draw.RoundedBox(0,0,20,w,5,Color(0,0,0,50))
		draw.DrawText(AWTeam.Translate.AddBan,AWTeam.Menu.Font,w/2,h/2-6,AWTeam.Menu.FontColor,1)
	end
	SendBan.DoClick = function()
		BadUserMenu:Remove()
		gui.OpenURL("https://awteam.pw/bansys")
	end
	
	local BadUserPanel = vgui.Create("Panel", BadUserMenu)
	BadUserPanel:SetPos(5,30)
	BadUserPanel:SetSize(BadUserMenu:GetWide()-10,BadUserMenu:GetTall()-35)
	
	local BadUserColum = vgui.Create("DListView",BadUserPanel)
	BadUserColum:SetPos(0,0)
	BadUserColum:SetSize(BadUserPanel:GetWide(),BadUserPanel:GetTall())
	BadUserColum:SetMultiSelect(false)
	--BadUserColum:AddColumn(AWTeam.Translate.ColumnName)
	local c = BadUserColum:AddColumn( AWTeam.Translate.ColumnName )
	c.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,50))
	end
	c:SetWidth(80)
	--BadUserColum:AddColumn(AWTeam.Translate.ColumnSteam)
	local c = BadUserColum:AddColumn( AWTeam.Translate.ColumnSteam )
	c.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,100))
	end
	c:SetWidth(100)
	--BadUserColum:AddColumn(AWTeam.Translate.ColumnReason)
	local c = BadUserColum:AddColumn( AWTeam.Translate.ColumnReason )
	c.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,50))
	end
	c:SetWidth(150)
	BadUserColum.Paint = function(s,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
	end
	--[[
	BadUserColum.Paint = function(s, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(0,0,0,150))
		for i=0, table.Count(AWTeam.BanList) do
			if(i%2 == 0) then
				draw.RoundedBox(0,0,0+i*16.9,w,17,Color(0,0,0,100))
			else
				draw.RoundedBox(0,0,0+i*16.9,w,17,Color(0,0,0,150))
			end
		end
	end
	--]]
	
	for k,v in pairs(AWTeam.BanList) do
		BadUserColum:AddLine(v.name,v.steamid,v.reason)
	end
	BadUserColum.OnRowRightClick = function(panel, index, row)
		if(isnumber(BadUserColum:GetSelectedLine())) then
			local MenuButtonOptions = DermaMenu()
			MenuButtonOptions:AddOption(OptionCopyClipboard, function() 
				SetClipboardText(row:GetValue(1).." ("..row:GetValue(2)..")")
			end)
			MenuButtonOptions:Open()
		end
	end
	BadUserColum.DoDoubleClick = function(panel, index, row)
		SetClipboardText(row:GetValue(1).." ("..row:GetValue(2)..")")
	end
	
	local SearchBadUser = vgui.Create("DTextEntry", BadUserMenu)
	SearchBadUser:SetPos(BadUserMenu:GetWide()-235,0)
	SearchBadUser:SetSize(100,25)
	SearchBadUser:SetText(AWTeam.Translate.Search)
	SearchBadUser:SetEnterAllowed(true)
	SearchBadUser:SetEditable(true)
	SearchBadUser.OnGetFocus = function(self)
		self:SetValue("")
	end
	SearchBadUser.OnChange = function()
		local Searcher = SearchBadUser:GetValue()
		
		BadUserColum:Clear()
		
		if Searcher == "" then
			for k,v in pairs(AWTeam.BanList) do
				BadUserColum:AddLine(v.name,v.steamid,v.reason)
			end

			return
		end
		
		for k,v in pairs(AWTeam.BanList) do
			if string.find(v.name, Searcher) or string.find(v.steamid, Searcher) or string.find(v.reason, Searcher) then
				BadUserColum:AddLine(v.name,v.steamid,v.reason)
			end
		end
	end
	
end

concommand.Add("AIO_Ban",function()
	SeeBadUserMenu()
end)

hook.Add( "OnPlayerChat", "AWTeamBadPlayer", function( ply, StrText, Team, Dead )
    StrText = string.lower(StrText)
    if (StrText == "!aio_bans" or StrText == "!aio_ban" or StrText == "/aio_ban" or StrText == "/aio_bans") then
		if ply ~= LocalPlayer() then return end
        SeeBadUserMenu()
        return true
    end
end)
