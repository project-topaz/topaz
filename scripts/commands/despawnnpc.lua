-- ---------------------------------------------------------------------------------------------------
-- -- func: despawnmob <mobid-optional>
-- -- desc: Despawns the given mob <t> or mobID)
-- ---------------------------------------------------------------------------------------------------

-- cmdprops =
-- {
    -- permission = 1,
    -- parameters = "i"
-- };

-- function error(player, msg)
    -- player:PrintToPlayer(msg);
    -- player:PrintToPlayer("!despawnnpc	{NPCID}");
-- end;

-- function onTrigger(player, NPCID)

    -- -- validate mobId
    -- local targ;
    -- if (NPCID == nil) then
        -- targ = player:getCursorTarget();
        -- if (targ == nil or not targ:isNPC()) then
            -- error(player,"You must either provide a mobID or target a mob.");
            -- return;
        -- end
    -- else
        -- targ = GetNPCByID(NPCID);
        -- if (targ == nil) then
            -- error(player,"Invalid NPC ID.");
            -- return;
        -- end
    -- end
    
    -- -- despawn mob
    -- DespawnNPC(targ:getID());
    -- player:PrintToPlayer(string.format("Despawned %s %i.",targ:getName(),targ:getID()));

-- end
