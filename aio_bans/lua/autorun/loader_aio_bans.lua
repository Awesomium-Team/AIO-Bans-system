--[[
	This database of players who violate or use third-party software.
	Our development team is trying to improve the quality of the game and get rid of unwanted players.
	
	All rights reserved Awesomium Team.
--]]

AWTeam = {}
AWTeam.Table = {}
AWTeam.Config = AWTeam.Config or {}
AWTeam.Menu = AWTeam.Menu or {}
AWTeam.Translate = AWTeam.Translate or {}
AWTeam.Translate.RU = AWTeam.Translate.RU or {}
AWTeam.Translate.EN = AWTeam.Translate.EN or {}
AWTeam.BanList = {}

AWTeam.Version = "1.0.0"

local color_debug_text = Color(255,255,255)
local color_debug_client = Color(245,184,0)
local color_debug_server = Color(0,200,255)
local color_error = Color(255,30,30)
local color_error_text = Color(190,190,190)
local path = "aio_bans/"

-- Debug mode
AWTeam.debug = true

-- Debug print
function AWTeam.DebugPrint(...)
	if not AWTeam.debug then return end

	local s="";
	for k,v in ipairs{...}do
		local part;

		if type(v) == "table" then
			part=util.TableToJSON(v)
		elseif type(v) == "Entity" and v:IsPlayer() and IsValid(v) then
			part=v:Nick()
		else
			part=tostring(v)
		end

		s=s.." "..part
	end
	s=s.."\n";

	MsgC(SERVER and color_debug_server or color_debug_client,"[AIO Ban]")
	MsgC(color_debug_text,s)

	return 0
end

-- Error reporting
function AWTeam.Error(error,...)
	local s="";
	for k,v in ipairs{...}do
		local part;

		if type(v) == "table" then
			part=util.TableToJSON(v)
		elseif type(v) == "Entity" and v:IsPlayer() and IsValid(v) then
			part=v:Nick()
		else
			part=tostring(v)
		end

		s=s.." "..part
	end
	s=s.."\n";

	MsgC(color_error,"[AIO Ban] ERROR: ")
	MsgC(color_debug_text,error);
	MsgC(color_error_text," "..s);

	hook.Call("AWRPLibError",GAMEMODE,error,s)

	return -1
end

AWTeam.DebugPrint("Initializing @ Version "..AWTeam.Version)

function AWTeam.Include(name, folder, runtype)

	if not runtype then
		runtype = string.Left(name, 2)
	end

	if not runtype or ( runtype ~= "sv" and runtype ~= "sh" and runtype ~= "cl" ) then AWTeam.Error("INCLUDE_NO_PREFIX","Could not include file, no prefix!") return false end

	path = ""

	if folder then
		path = path .. folder .. "/"
	end

	path = path .. name

	if SERVER then
		if runtype == "sv" then
			AWTeam.DebugPrint("> Loading... "..path)
			include(path)
		elseif runtype == "sh" then
			AWTeam.DebugPrint("> Loading... "..path)
			include(path)
			AddCSLuaFile(path)
		elseif runtype == "cl" then
			AddCSLuaFile(path)
		end
	elseif CLIENT then
		if (runtype == "sh" or runtype == "cl") then
			AWTeam.DebugPrint("> Loading... "..path)
			include(path)
		end
	end

	return true
end


function AWTeam.IncludeFolder(folder,runtype)
	AWTeam.DebugPrint("Initializing "..folder)

	local exp=(string.Explode("/",folder,false))[1]

	for k,v in pairs(file.Find(folder.."/*.lua","LUA")) do
		AWTeam.Include(v, folder, runtype)
	end
end

if SERVER then
	AWTeam.include_cl = AddCSLuaFile 
	AWTeam.include_sv = include ;
	AWTeam.include_sh = function( ... ) AWTeam.include_cl( ... ) AWTeam.include_sv( ... ) end 
elseif CLIENT then
	AWTeam.include_cl = include ;
	AWTeam.include_sv = function() end
	AWTeam.include_sh = include ;
end

AWTeam.IncludeFolder ("aio_bans")