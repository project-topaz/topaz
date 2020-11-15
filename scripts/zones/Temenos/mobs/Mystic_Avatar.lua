-----------------------------------
-- Area: Temenos E T
--  Mob: Mystic Avatar
-----------------------------------
require("scripts/globals/limbus");
-----------------------------------

function onMobEngaged(mob,target)
    local mobID = mob:getID();
    if (mobID==16929030) then --Carbuncle (Central Temenos 2nd Floor)
        GetMobByID(16929032):updateEnmity(target);
        GetMobByID(16929031):updateEnmity(target);
        if (IsMobDead(16929033)==true and IsMobDead(16929039)==true) then
            mob:setMod(tpz.mod.FIRESDT, 875);
        else
            mob:setMod(tpz.mod.FIRESDT, 1250);
        end

        if (IsMobDead(16929034)==true and IsMobDead(16929040)==true) then
            mob:setMod(tpz.mod.ICESDT, 875);
        else
            mob:setMod(tpz.mod.ICESDT, 1250);
        end

        if (IsMobDead(16929035)==true and IsMobDead(16929041)==true) then
            mob:setMod(tpz.mod.WINDSDT, 875);
        else
            mob:setMod(tpz.mod.WINDSDT, 1250);
        end

        if (IsMobDead(16929036)==true and IsMobDead(16929042)==true) then
            mob:setMod(tpz.mod.EARTHSDT, 875);
        else
            mob:setMod(tpz.mod.EARTHSDT, 1250);
        end

        if (IsMobDead(16929037)==true and IsMobDead(16929043)==true) then
            mob:setMod(tpz.mod.THUNDERSDT, 875);
        else
            mob:setMod(tpz.mod.THUNDERSDT, 1250);
        end

        if (IsMobDead(16929038)==true and IsMobDead(16929044)==true) then
            mob:setMod(tpz.mod.WATERSDT, 875);
        else
            mob:setMod(tpz.mod.WATERSDT, 1250);
        end

        mob:setMod(tpz.mod.LIGHTSDT, 1250);
        mob:setMod(tpz.mod.DARKSDT, 875);
    end
end

function onMobEngaged(mob, target)
    local mobID = mob:getID()
    if mobID == ID.mob.TEMENOS_C_MOB[2] then --Carbuncle (Central Temenos 2nd Floor)
        GetMobByID(ID.mob.TEMENOS_C_MOB[2]+2):updateEnmity(target)
        GetMobByID(ID.mob.TEMENOS_C_MOB[2]+1):updateEnmity(target)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID = mob:getID()
        local battlefield = mob:getBattlefield()
        if mobID <= ID.mob.TEMENOS_E_MOB[6] + 4 then
            local floor = ((mobID - (ID.mob.TEMENOS_E_MOB[1] + 4)) / 9) + 1
            local crateMask = battlefield:getLocalVar("crateMaskF" .. floor)
            if crateMask == 0 then
                tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[floor])
            end
        elseif mobID >= ID.mob.TEMENOS_C_MOB[2]+9 then
            local element_offset = mobID - ID.mob.TEMENOS_C_MOB[2]+8
            local partner_offset = element_offset % 6 -- Levithan's partner starts at 0
            GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.FIREDEF - 1 + element_offset)
            if GetMobByID(ID.mob.TEMENOS_C_MOB[2] + 3 + partner_offset):isAlive() then
                DespawnMob(ID.mob.TEMENOS_C_MOB[2] + 3 + partner_offset)
                SpawnMob(ID.mob.TEMENOS_C_MOB[2] + 9 + partner_offset)
            end
        end

    end
end
