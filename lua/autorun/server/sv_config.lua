
--[[
    LibC
	Copyright Amlal El Mahrouss All rights reserved

    Core functionalities.
]]

LibC = LibC or {}

-- Configuration classes
-- Very useful.
LibC.Config = {};

function LibC.Config:Append(Path, MakeTable, Where)
    if !self.Active then return false end

    local configs = file.Find(Path .. "*", Where or "DATA");

    for _, cfg in ipairs(configs) do
        local cfg = util.JSONToTable(file.Read(Path .. cfg, Where or "DATA"));
        if !MakeTable then self.Data = cfg; LibC:Log("Replace config to Config!"); break end
        self.Data[#self.Data + 1] = cfg;
    end

    return true
end

function LibC.Config:Init(Name)
    if !IsValid(Name) then return {} end

    local proto = setmetatable({}, LibC.Config);
    proto.__index = LibC.Config;
    proto.Append = LibC.Config.Append;

    proto.Active = true;
    proto.Name = Name;
    proto.Data = {};

    LibC:Log("CFG Added " .. Name);
    return proto
end
