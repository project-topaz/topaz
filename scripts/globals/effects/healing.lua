-----------------------------------
--
-- tpz.effect.HEALING
-- Activated through the /heal command
--
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
-----------------------------------

function onEffectGain(target,effect)
    target:setAnimation(33)
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
end
