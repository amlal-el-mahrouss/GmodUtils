
--[[
    LibC - LibClassic - The standard ClassiC Library
	Copyright Amlal El Mahrouss & ClassiC all rights reserved

    Promise and core functionalities.
]]

LibC = LibC or {}

-- MySQLOO Wrapper
-- Default Database Interface
LibC.SQL = LibC.SQL or {
    SQLite = false,
    Enable = false,
    Database = {} -- TODO DO THIS
}

function LibC.SQL:Init(sqlite, database)
    if !isstring(database) then return {} end
    LibC:Log("-------------------------------------------");
    LibC:Log("Setting up new Database...");
    LibC:Log("-------------------------------------------");

    local proto = setmetatable({}, LibC.SQL)
    proto.__index = LibC.SQL
    proto.SQLite = sqlite
    proto.Enable = true
    if !sqlite then proto.Database = util.JSONToTable(file.Read(database, "DATA")) or {} end

    return proto
end

--[[
    Configuration interface
]]
LibC.Config = LibC.Config or {
    Name = "Configuration",
    Active = false,
    Data = {}
}

function LibC.Config:IsActive()
    return self.Active
end

function LibC.Config:GetName()
    return self.Name
end

function LibC.Config:Add(path, makeTable, where)
    local configs = file.Find(path .. "*", where or "DATA");

    for _, cfg in ipairs(configs) do
        local cfg = util.JSONToTable(file.Read(path .. cfg, where or "DATA"));
        if !makeTable then self.Data = cfg LibC:Log("Replace cfg to Config!"); break end
        self.Data[#self.Data + 1] = cfg;

        LibC:Log(Color(182, 122, 43),"Added cfg to Config!");
    end
end

function LibC.Config:Init(name, blob, where)
    if !isstring(blob) then return {} end
    LibC:Log("-------------------------------------------");
    LibC:Log("Setting up new Config...");
    LibC:Log("-------------------------------------------");
    
    local proto = setmetatable({}, LibC.Config);
    proto.__index = LibC.Config;
    proto.Active = true;
    proto.Name = name;
    proto.Data = util.JSONToTable(file.Read(blob, where or "DATA")) or {};
    proto.Add = LibC.Config.Add;

    proto.IsActive =  LibC.Config.IsActive;
    proto.GetName =  LibC.Config.GetName;

    return proto
end