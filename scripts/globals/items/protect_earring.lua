-----------------------------------------
-- ID: 15838
-- Item: Protect Earring
-- Item Effect: Protect
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local power = 20
    local tier = 1
    local buff = 0
    if target:getMod(tpz.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
        buff = 2 -- 2x Tier from MOD
    end

    local power = power + (buff * tier)

    if (target:addStatusEffect(tpz.effect.PROTECT, power, 0, 1800, 0, 0, tier)) then
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.PROTECT)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
