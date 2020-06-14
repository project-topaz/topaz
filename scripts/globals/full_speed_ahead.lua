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
    player:setLocalVar("FSA_Food", 0xFF)
    player:setLocalVar("FSA_FoodCount", 0)

    player:addStatusEffectEx(tpz.effect.MOUNTED, tpz.effect.MOUNTED, tpz.mount.QUEST_RAPTOR, 2, 0, true)
end

tpz.full_speed_ahead.tick = function(player)
    player:setLocalVar("FSA_Motivation", player:getLocalVar("FSA_Motivation") - 1)

    local timeLeft = player:getLocalVar("FSA_Time") - os.time()
    local motivation = player:getLocalVar("FSA_Motivation")
    local pep = player:getLocalVar("FSA_Pep")
    local food_byte = player:getLocalVar("FSA_Food")
    local food_count = player:getLocalVar("FSA_FoodCount")

    local food_data = {}
    for i = 0, 7 do 
        if bit.band(player:getLocalVar("FSA_Food"), bit.lshift(1, i)) then
            table.insert(food_data, ID.npc.BLUE_BEAM_BASE + i)
            table.insert(food_data, ID.npc.RAPTOR_FOOD_BASE + i)
        end
    end

    if motivation == 0 then
        player:delStatusEffect(tpz.effect.MOUNTED)
        player:countdown(0) 
        player:enableEntities({})
    else
        player:countdown(timeLeft, "Motivation", motivation, "Pep", pep)
        player:enableEntities(food_data)
    end
end

tpz.full_speed_ahead.onRegionEnter = function(player, index)
    local food_byte = player:getLocalVar("FSA_Food")

    if bit.band(food_byte, bit.lshift(1, index - 1)) then
        local new_food_byte = food_byte - bit.lshift(1, index - 1)
        player:setLocalVar("FSA_Food", new_food_byte)
        player:setLocalVar("FSA_FoodCount", player:getLocalVar("FSA_FoodCount") + 1)
    end
end

tpz.fsa = tpz.full_speed_ahead
