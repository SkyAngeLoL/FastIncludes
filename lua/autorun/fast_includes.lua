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

function includeCL(file)
	if SERVER then 
		
			AddCSLuaFile(file)
		
	else --if CLIENT then 
		
			include(file) 
		
	end
end

function includeSH(file)
	if SERVER then
		
			AddCSLuaFile(file) 
		
	end
	
	include(file)
end

function includeSV(file)
	if SERVER then 
		
			include(file) 
		
	end
end

/*=============
	Folders
=============*/

function includeCLFolder(folder, zone)
	local Files = file.Find(folder.."/*.lua", zone or "LUA")
	if #Files == 0 then return false, "files not found" end
	
	for k, v in pairs(Files) do
		includeCL(folder.."/"..v)
	end
end

function includeSHFolder(folder, zone)
	local Files = file.Find(folder.."/*.lua", zone or "LUA")
	if #Files == 0 then return false, "files not found" end
	
	for k, v in pairs(Files) do
		includeSH(folder.."/"..v)
	end
end

function includeSVFolder(folder, zone)
	local Files = file.Find(folder.."/*.lua", zone or "LUA")
	if #Files == 0 then return false, "files not found" end
	
	for k, v in pairs(Files) do
		includeSV(folder.."/"..v)
	end
end

function includeRSFolder(folder, zone)
	
end