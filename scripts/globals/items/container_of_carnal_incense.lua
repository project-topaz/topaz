-----------------------------------------
-- ID: 5243
-- Item: container_of_carnal_incense
-- Item Effect: When applied, grants UPDT -100% for 20s
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local duration = 20
    local power = 2

    local function addShield(target, power, duration)
        target:delStatusEffect(tpz.effect.MAGIC_SHIELD)
        target:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, power, 0, duration)
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.PHYSICAL_SHIELD)
    end

    if target:hasStatusEffect(tpz.effect.PHYSICAL_SHIELD) then
        local effects = target:getStatusEffects()
        for _, effect in ipairs(effects) do
            if effect:getType() == tpz.effect.PHYSICAL_SHIELD and effect:getPower() > power then
                target:messageBasic(tpz.msg.basic.NO_EFFECT) break
            elseif effect:getType() == tpz.effect.PHYSICAL_SHIELD and effect:getPower() <= power then
                addShield(target, power, duration) break
            end
        end
    else
       addShield(target, power, duration)
    end
end
