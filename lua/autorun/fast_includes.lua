/*================================
	Advanced includes
	
	This file for shared side!
	
		Made by SkyAngeLoL
================================*/
/*=====
	
	includeCL("lua/myaddon/client_file.lua") - for client side
	includeSH("lua/myaddon/shared_file.lua") - for shared sides
	includeSV("lua/myaddon/server_file.lua") - for server side

	includeRSFolder("lua/myaddon") - loading all files from folder with tags "cl_" , "sv_" and other...
	
=====*/
/*=================
	Single file
=================*/

fi = fi or {}
fi.UseGlobals = fi.UseGlobals or true // For pre changing variable

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
	local Files = file.Find(folder.."/*.lua", zone or "LUA")
	
	for k, v in pairs(Files) do
		if v:left(3) == "cl_" then
			fi.includeCL(folder.."/"..v)
		elseif v:left(3) == "sv_" then
			fi.includeSV(folder.."/"..v)
		else
			fi.includeSH(folder.."/"..v)
		end
	end
end

/*=============
	Globals
=============*/

if fi.UseGlobals then
	includeCL = fi.includeCL
	includeSH = fi.includeSH
	includeSV = fi.includeSV

	includeCLFolder = fi.includeCLFolder
	includeSHFolder = fi.includeSHFolder
	includeSVFolder = fi.includeSVFolder

	includeRSFolder = fi.includeRSFolder
end