--[[
	This database of players who violate or use third-party software.
	Our development team is trying to improve the quality of the game and get rid of unwanted players.
	
	All rights reserved Awesomium Team.
--]]

concommand.Add("AIO_Table",function()
	PrintTable(AWTeam.BanList)
end)

if AWTeam.Config.system == true then
	if AWTeam.Config.ban == true then
		timer.Simple(AWTeam.Config.delayupdate+1, function()
			AWTeam.DebugPrint("Launch ban system...")
			if AWTeam.Config.bansystem == "serverguard" then
				for k, v in pairs(AWTeam.BanList) do
					AWTeam.DebugPrint("[SG] Baning: "..v.name.." ("..v.steamid.." ) for "..AWTeam.Config.bantime..". Reason: "..v.reason..".")
					serverguard.command.Run("ban", false, v.steamid, AWTeam.Config.bantime, v.reason)
				end
			end

			if AWTeam.Config.bansystem == "ulx" then
				for k, v in pairs(AWTeam.BanList) do
					AWTeam.DebugPrint("[ULX] Baning: "..v.name.." ("..v.steamid..") for "..AWTeam.Config.bantime..". Reason: "..v.reason..".")
					RunConsoleCommand("ulx", "banid", v.steamid, AWTeam.Config.bantime, v.reason)
					--ULib.addBan(v.SteamID,AWTeam.Config.bantime,v.reason,v.name,"AIO Ban")
				end
			end
			
			if AWTeam.Config.bansystem == "fadmin" then
				for k, v in pairs(AWTeam.BanList) do
					AWTeam.DebugPrint("[FAdmin] Baning: "..v.name.." ("..v.steamid..") for "..AWTeam.Config.bantime..". Reason: "..v.reason..".")
					RunConsoleCommand("fadmin", "ban", v.steamid, AWTeam.Config.bantime, v.reason)
				end
			end
		end)
	end
end