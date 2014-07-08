/*======================
	Advanced includes
	
	This file for shared side!
	
		Made by SkyAngeLoL
======================*/

/*=================
	Single file
=================*/

// Client side
function includeCL(file)
	if SERVER then 
		
			AddCSLuaFile(file)
		
	else --if CLIENT then 
		
			include(file) 
		
	end
end

// Chared side
function includeSH(file)
	if SERVER then
		
			AddCSLuaFile(file) 
		
	end
	
	include(file)
end

// Server side
function includeSV(file)
	if SERVER then 
		
			include(file) 
		
	end
end

/*=============
	Folder 
=============*/

function includeCLFolder(folder, zone)
	local Files = file.Find(folder.."/*.lua", zone or "LUA")
	if #Files == 0 then return false, "files not found" end
	
	for k, v in pairs(Files) do
		includeSH(folder.."/"..v)
	end
end