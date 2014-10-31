--[[================================
	Advanced includes
	
	This file for shared side!
	
		Made by SkyAngeLoL
================================]]--
--[[=====
	
	includeCL("lua/myaddon/client_file.lua") - for client side
	includeSH("lua/myaddon/shared_file.lua") - for shared sides
	includeSV("lua/myaddon/server_file.lua") - for server side

	includeRSFolder("lua/myaddon") - loading all files from folder with tags "cl_" , "sv_" and other...
	
=====]]--

fastincludes = {}
fastincludes.Debug = false

MsgC(Color(0, 255, 0, 255), "[GLua+] ") MsgC(Color(200, 200, 200), "fastincludes.lua\n")

function fastincludes.DebugPrint(txt, tab)
	if not fastincludes.Debug then return end
	
	print("[Debug]"..string.rep("\t", tab or 1), txt)
end

--[[=================
	Single file
=================]]--

function fastincludes.includeCL(file, time_dl)
	if SERVER then 
		
			AddCSLuaFile(file)
		
	else --if CLIENT then 
			
			if time_dl and time_dl ~= 0 then
				timer.Simple(time_dl, function()
					include(file)
				end)
			else
				include(file) 
			end
			
	end
	
	fastincludes.DebugPrint("To client - "..file) // For printing on both sides
end

function fastincludes.includeSH(file, time_dl)
	if SERVER then
		
			AddCSLuaFile(file) 
		
	end
	
	if time_dl and time_dl ~= 0 then
		timer.Simple(time_dl, function()
			include(file)
		end)
	else
		include(file) 
	end
	
	fastincludes.DebugPrint("To shared - "..file)
end

function fastincludes.includeSV(file, time_dl)
	if SERVER then 
		
			if time_dl and time_dl ~= 0 then
				timer.Simple(time_dl, function()
					include(file)
				end)
			else
				include(file) 
			end
			
			fastincludes.DebugPrint("To server - "..file)
			
	end
end

--[[=============
	Folders
=============]]--

function fastincludes.includeCLFolder(folder, zone, r)
	local Files, Folders = file.Find(folder.."/*.lua", zone or "LUA")
	
	if #Files == 0 then return false, "folder is empty" end
	
	fastincludes.DebugPrint("Find "..#Files.." files in client folder "..folder, 0)
	
	for k, v in pairs(Files) do
		fastincludes.includeCL(folder.."/"..v)
	end
	if r then
		for k, v in pairs(Folders) do
			fastincludes.includeCLFolder(folder.."/"..v, zone, true)
		end
	end
	
	return true, "true", Files
end

function fastincludes.includeSHFolder(folder, zone, r)
	local Files, Folders = file.Find(folder.."/*.lua", zone or "LUA")
	
	if #Files == 0 then return false, "folder is empty" end
	
	fastincludes.DebugPrint("Find "..#Files.." files in shared folder "..folder, 0)
	
	for k, v in pairs(Files) do
		fastincludes.includeSH(folder.."/"..v)
	end
	
	if r then
		for k, v in pairs(Folders) do
			fastincludes.includeSHFolder(folder.."/"..v, zone, true)
		end
	end
	
	return true, "true", Files
end

function fastincludes.includeSVFolder(folder, zone, r)
	local Files, Folders = file.Find(folder.."/*.lua", zone or "LUA")
	
	if #Files == 0 then return false, "folder is empty" end
	
	fastincludes.DebugPrint("Find "..#Files.." files in server folder "..folder, 0)
	
	for k, v in pairs(Files) do
		fastincludes.includeSV(folder.."/"..v)
	end
	
	if r then
		for k, v in pairs(Folders) do
			fastincludes.includeSVFolder(folder.."/"..v, zone, true)
		end
	end
	
	return true, "true", Files
end

function fastincludes.includeRSFolder(folder, zone, r)
	local Files, Folders = file.Find(folder.."/*.lua", zone or "LUA")
	
	if #Files == 0 then return false, "folder is empty" end
	
	fastincludes.DebugPrint("Find "..#Files.." files in folder "..folder, 0)
	
	for k, v in pairs(Files) do
		if string.Left(v, 3) == "cl_" then
			fastincludes.includeCL(folder.."/"..v)
		elseif string.Left(v, 3) == "sv_" then
			fastincludes.includeSV(folder.."/"..v)
		else
			fastincludes.includeSH(folder.."/"..v)
		end
	end
	
	if r then
		for k, v in pairs(Folders) do
			fastincludes.includeRSFolder(folder.."/"..v, zone, true)
		end
	end
	
	return true, "true", Files
end

--[[=============
	Globals
=============]]

includeCL = fastincludes.includeCL
includeSH = fastincludes.includeSH
includeSV = fastincludes.includeSV

includeCLFolder = fastincludes.includeCLFolder
includeSHFolder = fastincludes.includeSHFolder
includeSVFolder = fastincludes.includeSVFolder

includeRSFolder = fastincludes.includeRSFolder
