-----------------------------------
--
-- tpz.effect.HEALING
-- Activated through the /heal command
--
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------

function onEffectGain(target,effect)
    target:setAnimation(33)

    -- Dances with Luopans
    if target:getLocalVar("GEO_DWL_Locus_Area") == 1 and target:getCharVar("GEO_DWL_Luopan") == 0 then
        local ID = zones[target:getZoneID()]
        target:messageSpecial(ID.text.ENERGIES_COURSE)

        local maxWaitTime = 480  -- Max wait of 8 minutes
        local secondsPerTick = GetHealingTickDelay()  -- NOTE: This value is server configurable.
        local minWaitTime = math.min(3 * secondsPerTick, maxWaitTime)
        local waitTimeInSeconds = math.random(minWaitTime, maxWaitTime)
        target:setLocalVar("GEO_DWL_Resting", os.time() + waitTimeInSeconds)
        target:timer(waitTimeInSeconds * 1000, function(target)
            local finishTime = target:getLocalVar("GEO_DWL_Resting")
            if finishTime > 0 and os.time() >= finishTime then
                local ID = zones[target:getZoneID()]
                target:messageSpecial(ID.text.MYSTICAL_WARMTH)  -- You feel a mystical warmth welling up inside you!
                target:setLocalVar("GEO_DWL_Resting", 0)
                target:setCharVar("GEO_DWL_Luopan", 1)
            end
        end)
    end
end

function onEffectTick(target,effect)

    if target:getObjType() == tpz.objType.FELLOW then
        local master        = target:getMaster()
        local ID            = require("scripts/zones/"..master:getZoneName().."/IDs")
        local optionsMask   = master:getFellowValue("optionsMask")
        local personality   = target:getLocalVar("personality")
        local mpNotice      = target:getLocalVar("mpNotice")
        local mpp           = target:getMP() / target:getMaxMP() * 100
        local mpSignals     = false
            if bit.band(optionsMask, bit.lshift(1,2)) == 4 then mpSignals = true end

        if mpp >= 67 and mpNotice == 1 and mpSignals == true then
            master:showText(target, ID.text.FELLOW_MESSAGE_OFFSET + 45 + personality)
            target:setLocalVar("mpNotice", 0)
        elseif mpp < 67 and mpNotice ~= 1 then
            target:setLocalVar("mpNotice", 1)
        end
    end

    local healtime = effect:getTickCount()

    if healtime > 2 then
        -- curse II also known as "zombie"
        if not(target:hasStatusEffect(tpz.effect.DISEASE)) and target:hasStatusEffect(tpz.effect.PLAGUE) == false and target:hasStatusEffect(tpz.effect.CURSE_II) == false then
            local healHP = 0
            if target:getContinentID() == 1 and target:hasStatusEffect(tpz.effect.SIGNET) then
                healHP = 10 + (3 * math.floor(target:getMainLvl() / 10)) + (healtime - 2) * (1 + math.floor(target:getMaxHP() / 300)) + target:getMod(tpz.mod.HPHEAL)
            else
                target:addTP(HEALING_TP_CHANGE)
                healHP = 10 + (healtime - 2) + target:getMod(tpz.mod.HPHEAL)
            end

            target:addHP(healHP)
            target:updateEnmityFromCure(target, healHP)
            target:addMP(12 + ((healtime - 2) * (1 + target:getMod(tpz.mod.CLEAR_MIND))) + target:getMod(tpz.mod.MPHEAL))
        end
    end
end

function onEffectLose(target,effect)
    target:setAnimation(0)
    target:delStatusEffect(tpz.effect.LEAVEGAME)

    -- Dances with Luopans
    target:setLocalVar("GEO_DWL_Resting", 0)
end
