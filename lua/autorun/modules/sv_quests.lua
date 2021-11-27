
hook.Add("PlayerDeath", "Badass Quest Listener", function(victim, inflictor, attacker)
    if PowerRounds.CurrentPR then return end
    if attacker == victim then return end

    if victim:GetNWBool("QuestCompleted", false) && !victim:GetNWBool("QuestPending", false) then
        local bag = ents.Create("Bag");
        bag:SetOwner(attacker);
        bag:Spawn();
        bag:SetPos(attacker:GetPos());
    end

    attacker:AddFrags(1);
end)

hook.Add("PlayerSpawn", "Season I Badass", function(ply)
    ply:SetModel("models/joshers/badasses/Playermodels/barney_closed.mdl");
end)

hook.Add("PlayerSpawn", "Eeason I Spawns", function(ply)
    if game.GetMap() == "gm_scarface" then
        local spawns = {
            Vector(6235.225586, 673.747375, 312.031250),
            Vector(6485.663086, 1159.584229, 312.031250),
            Vector(5000.013184, 2044.255615, 48.031250),
            Vector(4746.824707, 1684.926636, 48.031250),
            Vector(4370.151367, 2654.523926, 48.031250),
            Vector(2389.984619, 2707.520020, -13.328598),
            Vector(1348.371582, 3026.766846, 24.031250),
            Vector(1137.962769, 1667.052490, -89.968750),
            Vector(1453.847656, -267.475464, 100.031250),
            Vector(-190.337585, 563.087219, -79.968750),
        }
    
        ply:SetPos(spawns[1, math.random(1, #spawns)]);
    end
end)