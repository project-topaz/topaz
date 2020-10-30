-----------------------------------------
-- ID: 5845
-- Item: bottle_of_fanatics_tonic
-- Item Effect: When applied, grants PDT -50% for 60s
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local duration = 60
    local power = 0
    local wsmitigation = 0

    local function addShield(target, power, duration)
        target:delStatusEffect(tpz.effect.MAGIC_SHIELD)
        target:addStatusEffect(tpz.effect.PHYSICAL_SHIELD, power, 0, duration, 0, wsmitigation)
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
