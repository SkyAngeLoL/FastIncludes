/*================================
	Advanced includes
	
	This file for shared side!
	
		Made by SkyAngeLoL
================================*/
/*

*/
/*=================
	Single file
=================*/

fi = {}

function fi.includeCL(file)
	if SERVER then 
		
			AddCSLuaFile(file)
		
	else --if CLIENT then 
		
			include(file) 
		
	end
end

function fi.includeSH(file)
	if SERVER then
		
			AddCSLuaFile(file) 
		
	end
	
	include(file)
end

function fi.includeSV(file)
	if SERVER then 
		
			include(file) 
		
	end
end

/*=============
	Folders
=============*/

function fi.includeCLFolder(folder, zone)
	local Files = file.Find(folder.."/*.lua", zone or "LUA")
	if #Files == 0 then return false, "folder is empty" end
	
	for k, v in pairs(Files) do
		fi.includeCL(folder.."/"..v)
	end
end

function fi.includeSHFolder(folder, zone)
	local Files = file.Find(folder.."/*.lua", zone or "LUA")
	if #Files == 0 then return false, "folder is empty" end
	
	for k, v in pairs(Files) do
		fi.includeSH(folder.."/"..v)
	end
end

function fi.includeSVFolder(folder, zone)
	local Files = file.Find(folder.."/*.lua", zone or "LUA")
	if #Files == 0 then return false, "folder is empty" end
	
	for k, v in pairs(Files) do
		fi.includeSV(folder.."/"..v)
	end
end

function fi.includeRSFolder(folder, zone)
	
end

/*=============
	Globals
=============*/

includeCL = fi.includeCL
includeSH = fi.includeSH
includeSV = fi.includeSV

includeCLFolder = fi.includeCLFolder
includeSHFolder = fi.includeSHFolder
includeSVFolder = fi.includeSVFolder

includeRSFolder = fi.includeRSFolder