--[[
	This database of players who violate or use third-party software.
	Our development team is trying to improve the quality of the game and get rid of unwanted players.
	
	All rights reserved Awesomium Team.
--]]

timer.Create( "AWTeam_RefreshTimer_ID"..math.Rand( 5, 999999 ), AWTeam.Config.delayupdate, 0, function()
	http.Fetch("https://awteam.pw/bansys/api.php?t=ban", function(body, len, headers, code)
		AWTeam.BanList = util.JSONToTable(body)
	end)
end )
