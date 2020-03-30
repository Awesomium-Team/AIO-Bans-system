--[[
	This database of players who violate or use third-party software.
	Our development team is trying to improve the quality of the game and get rid of unwanted players.
	
	All rights reserved Awesomium Team.
--]]

AWTeam.Config = {
	system = true, 						-- On/off system
	ban = true,							-- On/off system
	bansystem = "fadmin",				-- Ban system. Available: serverguard; ulx; fadmin
	bantime = 0,						-- Time ban
	delayupdate = 60					-- Delay update API php
}

AWTeam.Menu = {
	ColorBG = Color(62, 69, 76),		-- Color menu
	ColorFont = Color(255, 246, 229),	-- Color font
	ColoButton = Color(33, 133, 197),	-- Color button
	Font = "Default",					-- Custom font or default https://wiki.facepunch.com/gmod/Default_Fonts
	Language = "EN",					-- WIP (is not work)
}

AWTeam.Translate = {
	NameMenu = "All in one - Ban system",
	AddBan = "See/Add ban...",
	Search = "Search...",
	ColumnName = "Name",
	ColumnSteam = "SteamID",
	ColumnReason = "Reason",
}
