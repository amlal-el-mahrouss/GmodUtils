
--[[
    LibC
	Copyright Amlal El Mahrouss All rights reserved

    Core functionalities.
]]

LibC = LibC or {}

function LibC:AddCommand(Name, Func, Perms)
    LibC.Promise:Init(function(Name, Func, Perms)
        return isfunction(Func) && istable(Perms) && isstring(Name)
    end, Name, Func, Perms):Do():Then(function(Name)
        concommand.Add(Name, function(target, cmd, args, argStr)
            if target:IsPlayer() && Perms[target:GetUserGroup()] then Func(target, cmd, args, argStr); end
        end);

        LibC:Log(Color(0, 122, 0), "Added ", Name, " to commands list!");
        return true;
    end, Name):Catch();
end