-----------------------------------------
-- ID: 5435
-- Item: bottle_of_fools_drink
-- Item Effect: When applied, grants UDMGMAGIC -101 and STATUSRES +101 for 60s
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local duration = 60
    local power = 4
    
    local function addShield(target, power, duration)
        target:delStatusEffect(tpz.effect.MAGIC_SHIELD)
        target:addStatusEffect(tpz.effect.MAGIC_SHIELD, power, 0, duration)
    end

    if target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) or target:hasStatusEffect(tpz.effect.MAGIC_SHIELD) then
        local effects = target:getStatusEffects()
        for _, effect in ipairs(effects) do
            if effect:getType() == tpz.effect.MAGIC_SHIELD and effect:getPower() > power then
                target:messageBasic(tpz.msg.basic.NO_EFFECT)
            elseif effect:getType() == tpz.effect.PHYSICAL_SHIELD then
                target:delStatusEffect(tpz.effect.PHYSICAL_SHIELD)
                target:addStatusEffect(tpz.effect.MAGIC_SHIELD, power, 0, duration)
            end
        end
    else
        addShield(target, power, duration)
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.MAGIC_SHIELD)
    end
end
