-----------------------------------
-- Full Speed Ahead! Helper
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/status")
-----------------------------------

tpz = tpz or {}
tpz.full_speed_ahead = tpz.full_speed_ahead or {}

tpz.full_speed_ahead.duration = 600

tpz.full_speed_ahead.onEffectGain = function(player)
    player:setLocalVar("FSA_Time", os.time() + tpz.full_speed_ahead.duration)
    player:setLocalVar("FSA_Motivation", 100)
    player:setLocalVar("FSA_Pep", 0)
    player:setLocalVar("FSA_Food", 0xFF)
    player:setLocalVar("FSA_FoodCount", 0)
    player:addStatusEffect(tpz.effect.MOUNTED, tpz.mount.QUEST_RAPTOR, 2, 0)
    player:setCharVar("[QUEST]FullSpeedAhead", 2)
end

tpz.full_speed_ahead.onEffectLose = function(player)
    player:delStatusEffect(tpz.effect.MOUNTED)
    player:countdown(0) 
    player:enableEntities({})
end

tpz.full_speed_ahead.tick = function(player)
    player:setLocalVar("FSA_Motivation", player:getLocalVar("FSA_Motivation") - 1)
    player:setLocalVar("FSA_Pep", player:getLocalVar("FSA_Pep") + 1)

    local timeLeft = player:getLocalVar("FSA_Time") - os.time()
    local motivation = player:getLocalVar("FSA_Motivation")
    local pep = player:getLocalVar("FSA_Pep")
    local food_byte = player:getLocalVar("FSA_Food")
    local food_count = player:getLocalVar("FSA_FoodCount")

    local food_data = {}
    for i = 0, 7 do
        if bit.band(food_byte, bit.lshift(1, i)) > 0 then
            table.insert(food_data, ID.npc.BLUE_BEAM_BASE + i)
            table.insert(food_data, ID.npc.RAPTOR_FOOD_BASE + i)
        end
    end

    if motivation <= 0 or timeLeft <= 0 or not player:hasStatusEffect(tpz.effect.MOUNTED) then
        player:delStatusEffect(tpz.effect.FULL_SPEED_AHEAD)
        player:messageSpecial(ID.text.RAPTOR_SPEEDS_OFF)
    else
        player:countdown(timeLeft, "Motivation", motivation, "Pep", pep)
        player:enableEntities(food_data)
    end
end

tpz.full_speed_ahead.onRegionEnter = function(player, index)
    local food_byte = player:getLocalVar("FSA_Food")
    local food_count = player:getLocalVar("FSA_FoodCount")

    if index == 8 and food_count >= 5 then -- Syrillia
        player:startEvent(24) -- End CS and teleport
    else
        if bit.band(food_byte, bit.lshift(1, index - 1)) > 0 then
            local new_food_byte = food_byte - bit.lshift(1, index - 1)
            player:setLocalVar("FSA_Food", new_food_byte)
            player:setLocalVar("FSA_FoodCount", food_count + 1)
        end

        player:messageSpecial(ID.text.RAPTOR_OVERCOME_MUNCHIES, player:getLocalVar("FSA_FoodCount"), 5)

        -- TODO: Find little hearts animation
        --player:entityAnimationPacket("kesus.")
    end
end

tpz.full_speed_ahead.onCheer = function(player)
    local timeLeft = player:getLocalVar("FSA_Time") - os.time()
    local motivation = player:getLocalVar("FSA_Motivation")
    local pep = player:getLocalVar("FSA_Pep")

    local new_motivation = motivation + pep

    player:setLocalVar("FSA_Motivation", new_motivation)
    player:setLocalVar("FSA_Pep", 0)

    player:messageSpecial(ID.text.RAPTOR_SECOND_WIND)

    player:countdown(timeLeft, "Motivation", motivation, "Pep", pep)
end

tpz.full_speed_ahead.completeGame = function(player)
    player:delStatusEffect(tpz.effect.FULL_SPEED_AHEAD)
    player:setCharVar("[QUEST]FullSpeedAhead", 3)
    player:setPos(-104.5, 0, 187.4, 64, 244)
end

tpz.fsa = tpz.full_speed_ahead
