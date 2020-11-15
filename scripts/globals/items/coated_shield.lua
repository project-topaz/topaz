-----------------------------------------
-- ID: 15838
-- Item: Coated Shield
-- Item Effect: Shell
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local power = 27 -- power/256 handled below before passing final DMGMAGIC value
    local tier = 1
    local buff = 0
    if target:getMod(tpz.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
        buff = 1 -- Adds the tier as a bonus to power before calculation
    end
    local power = utils.roundup((power + (buff * tier)) / 2.56) -- takes the result and converts it back to a usable DMGMAGIC value
    if (target:addStatusEffect(tpz.effect.SHELL, power, 0, 1800, 0, 0, tier)) then
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.SHELL)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
