-----------------------------------
-- Full Speed Ahead! Helper
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/status")
-----------------------------------

tpz = tpz or {}
tpz.full_speed_ahead = tpz.full_speed_ahead or {}

tpz.full_speed_ahead.onZoneIn = function(player)
    player:setLocalVar("FSA_Time", os.time() + 600)
    player:setLocalVar("FSA_Motivation", 100)
    player:setLocalVar("FSA_Pep", 100)

    player:addStatusEffectEx(tpz.effect.MOUNTED, tpz.effect.MOUNTED, tpz.mount.QUEST_RAPTOR, 2, 0, true)
end

tpz.full_speed_ahead.tick = function(player)
    player:setLocalVar("FSA_Motivation", player:getLocalVar("FSA_Motivation") - 1)

    local timeLeft = player:getLocalVar("FSA_Time") - os.time()
    local motivation = player:getLocalVar("FSA_Motivation")
    local pep = player:getLocalVar("FSA_Pep")

    player:countdown(timeLeft, "Motivation", motivation, "Pep", pep)

    local entity_data = {}
    for i = 0, 7 do 
        table.insert(entity_data, ID.npc.BLUE_BEAM_BASE + i)
        table.insert(entity_data, ID.npc.RAPTOR_FOOD_BASE + i) 
    end

    player:enableEntities(entity_data)

    if motivation == 0 then
        player:countdown(0)
        player:delStatusEffect(tpz.effect.MOUNTED)
        player:enableEntities({})
    end
end

tpz.full_speed_ahead.onRegionEnter = function(player, index)
    printf("onRegionEnter")
end

tpz.fsa = tpz.full_speed_ahead
