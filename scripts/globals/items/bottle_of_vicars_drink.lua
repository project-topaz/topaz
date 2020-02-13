-----------------------------------------
-- ID: 5439
-- Item: Bottle of Vicar's Drink
-- Item Effect: Removes most status ailments AoE
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local removedCount = 0
    local removable =
    {
        tpz.effect.PETRIFICATION,
        tpz.effect.SILENCE,
        tpz.effect.BIND,
        tpz.effect.BANE,
        tpz.effect.CURSE_II,
        tpz.effect.CURSE,
        tpz.effect.PARALYSIS,
        tpz.effect.PLAGUE,
        tpz.effect.POISON,
        tpz.effect.DISEASE,
        tpz.effect.BLINDNESS
    }
    for _, status in pairs(removable) do
        if target:hasStatusEffect(status) then
            target:delStatusEffect(status)
            removedCount = removedCount + 1
        end
    end
    if target:hasStatusEffectByFlag(tpz.effectFlag.ERASABLE) then
        target:eraseStatusEffect(tpz.effectFlag.ERASABLE)
    else
        if removedCount == 0 then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        end
    end
end