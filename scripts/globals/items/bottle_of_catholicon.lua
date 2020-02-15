-----------------------------------------
-- ID: 4206
-- Item: Catholicon
-- Item Effect: This elixir is known for its ability to cure most status ailments.
-- Removes up to three negative side effects.
-- Does not remove Curse, Doom, or Amnesia.
-- It can be used on any player, Even those not in your own Party.
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
            if removedCount == 3 then
                break
            end
        end
    end
    if target:hasStatusEffectByFlag(tpz.effectFlag.ERASABLE) and removedCount < 3 then
        for i=1, (3 - removedCount) do
            target:eraseStatusEffect(tpz.effectFlag.ERASABLE)
            removedCount = removedCount + 1
            if removedCount == 3 then
                break
            end
        end
    end
    if removedCount == 0 then
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end