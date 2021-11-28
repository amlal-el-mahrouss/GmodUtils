
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Automatic includes.
]]

LibC = LibC or {}

LibC.RootDirectory = "autorun/modules/";
LibC.SoundDirectory = "sound/";
LibC.ContentDirectory = "content/";

function LibC:Find(root, res)
    local files, dir = file.Find( root .. "*", "LUA" )

    for _, file in ipairs(files) do
        if !res then
            local prefix = string.lower( string.Left( file, 3 ) )
            if prefix == "sh_" || prefix == "cl_" then AddCSLuaFile( LibC.RootDirectory .. file ) LibC:Log( "[AUTOLOAD] ADDCS: " .. file ) end
            if prefix == "cl_" then LibC:Log( "[AUTOLOAD] SKIPPING CLIENTSIDE...") continue end
    
            include( LibC.RootDirectory .. file );
            LibC:Log("[AUTOLOAD] INCLUDE: " .. file); 
        else
            resource.AddSingleFile( "addons/LibC/" .. LibC.SoundDirectory .. file);
            LibC:Log("[AUTOLOAD] ADD RES: " .. file);
        end
    end
end

local function ldModules()
    LibC:Log("Reloading modules...");
    LibC:Find(LibC.RootDirectory);
    LibC:Find(LibC.SoundDirectory, true);
    LibC:Find(LibC.ContentDirectory, true);
end

LibC:AddCommand("ld", function()
    ldModules();
end, {["fondateur"] = { true }});

hook.Add("Initialize", "Module load init", function()
    ldModules();
end)