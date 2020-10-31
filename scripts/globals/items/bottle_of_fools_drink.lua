-----------------------------------------
-- ID: 5435
-- Item: bottle_of_fools_drink
-- Item Effect: When applied, grants UDMGMAGIC -101 for 60s
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local shieldtype = tpz.effect.MAGIC_SHIELD
    local duration = 60
    local power = 3
    local fakemagicshield = 0

    local function addShield(target, power, duration)
        target:delStatusEffect(tpz.effect.PHYSICAL_SHIELD)
        target:addStatusEffect(shieldtype, power, 0, duration, 0, fakemagicshield)
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, shieldtype)
    end

    if target:hasStatusEffect(shieldtype) then
        local shield = target:getStatusEffect(shieldtype)
        local activeshieldpower = shield:getPower()

        if activeshieldpower > power then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            addShield(target, power, duration)
        end
    else
       addShield(target, power, duration)
    end
end
