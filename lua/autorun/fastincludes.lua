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

fi = {}
fi.Debug = false

_FASTINCLUDES_ = true -- "#define" for checing this addon 

MsgC(Color(0, 255, 0, 255), "[GLua+] ") MsgC(Color(200, 200, 200), "fast_includes.lua\n")

function fi.DebugPrint(txt, tab)
	if not fi.Debug then return end
	
	print("[Debug]"..string.rep("\t", tab or 1), txt)
end

--[[=================
	Single file
=================]]--

function fi.includeCL(file, time_dl)
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
	
	fi.DebugPrint("To client - "..file) // For printing on both sides
end

function fi.includeSH(file, time_dl)
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
	
	fi.DebugPrint("To shared - "..file)
end

function fi.includeSV(file, time_dl)
	if SERVER then 
		
			if time_dl and time_dl ~= 0 then
				timer.Simple(time_dl, function()
					include(file)
				end)
			else
				include(file) 
			end
			
			fi.DebugPrint("To server - "..file)
			
	end
end

--[[=============
	Folders
=============]]--

function fi.includeCLFolder(folder, zone, r)
	local Files, Folders = file.Find(folder.."/*.lua", zone or "LUA")
	
	if #Files == 0 then return false, "folder is empty" end
	
	fi.DebugPrint("Find "..#Files.." files in client folder "..folder, 0)
	
	for k, v in pairs(Files) do
		fi.includeCL(folder.."/"..v)
	end
	if r then
		for k, v in pairs(Folders) do
			fi.includeCLFolder(folder.."/"..v, zone, true)
		end
	end
	
	return true, "true", Files
end

function fi.includeSHFolder(folder, zone, r)
	local Files, Folders = file.Find(folder.."/*.lua", zone or "LUA")
	
	if #Files == 0 then return false, "folder is empty" end
	
	fi.DebugPrint("Find "..#Files.." files in shared folder "..folder, 0)
	
	for k, v in pairs(Files) do
		fi.includeSH(folder.."/"..v)
	end
	
	if r then
		for k, v in pairs(Folders) do
			fi.includeSHFolder(folder.."/"..v, zone, true)
		end
	end
	
	return true, "true", Files
end

function fi.includeSVFolder(folder, zone, r)
	local Files, Folders = file.Find(folder.."/*.lua", zone or "LUA")
	
	if #Files == 0 then return false, "folder is empty" end
	
	fi.DebugPrint("Find "..#Files.." files in server folder "..folder, 0)
	
	for k, v in pairs(Files) do
		fi.includeSV(folder.."/"..v)
	end
	
	if r then
		for k, v in pairs(Folders) do
			fi.includeSVFolder(folder.."/"..v, zone, true)
		end
	end
	
	return true, "true", Files
end

function fi.includeRSFolder(folder, zone, r)
	local Files, Folders = file.Find(folder.."/*.lua", zone or "LUA")
	
	if #Files == 0 then return false, "folder is empty" end
	
	fi.DebugPrint("Find "..#Files.." files in folder "..folder, 0)
	
	for k, v in pairs(Files) do
		if string.Left(v, 3) == "cl_" then
			fi.includeCL(folder.."/"..v)
		elseif string.Left(v, 3) == "sv_" then
			fi.includeSV(folder.."/"..v)
		else
			fi.includeSH(folder.."/"..v)
		end
	end
	
	if r then
		for k, v in pairs(Folders) do
			fi.includeRSFolder(folder.."/"..v, zone, true)
		end
	end
	
	return true, "true", Files
end

--[[=============
	Globals
=============]]

includeCL = fi.includeCL
includeSH = fi.includeSH
includeSV = fi.includeSV

includeCLFolder = fi.includeCLFolder
includeSHFolder = fi.includeSHFolder
includeSVFolder = fi.includeSVFolder

includeRSFolder = fi.includeRSFolder
