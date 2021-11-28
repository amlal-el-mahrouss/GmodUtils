
--[[
    LibC
	Copyright Amlal El Mahrouss All rights reserved

    Core functionalities.
]]

LibC = LibC or {}
LibC.Config = {};

function LibC.Config:Append(Path, MakeTable, Where)
    if !self.Active then return false end

    local configs = file.Find(Path .. "*", Where or "DATA");

    for _, cfg in ipairs(configs) do
        local cfg = util.JSONToTable(file.Read(Path .. cfg, Where or "DATA"));

        if !MakeTable then self.Data = cfg; LibC:Log("Replaced Configuration.."); break end
        table.insert(self.Data, cfg);
    end

    return true
end

function LibC.Config:Add(Metadata)
    if !istable(Metadata) then Metadata = { Metadata }; end
    table.Add(self.Data, Metadata)
end

function LibC.Config:Write()
    for _, data in ipairs(self.Data) do 
        file.Append(self.Name .. ".json", util.TableToJSON(data)); 
    end
end

function LibC.Config:Init(Name)
    if !isstring(Name) then return nil end
    
    local proto = setmetatable({}, LibC.Config);
    proto.__index = LibC.Config;
    proto.Append = LibC.Config.Append;
    proto.Add = LibC.Config.Add;
    proto.Write = LibC.Config.Write;

    proto.Active = true;
    proto.Name = Name;
    proto.Data = {};

    LibC:Log("CFG Added " .. Name);
    return proto
end