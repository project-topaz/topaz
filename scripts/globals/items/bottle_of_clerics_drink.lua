-----------------------------------------
-- ID: 5395
-- Item: Bottle of Cleric's Drink
-- Item Effect: Removes most status ailments AoE
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:forMembersInRange(10, function(member)
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
            if member:hasStatusEffect(status) then
                member:delStatusEffect(status)
                removedCount = removedCount + 1
            end
        end
        if member:hasStatusEffectByFlag(tpz.effectFlag.ERASABLE) then
            member:eraseStatusEffect(tpz.effectFlag.ERASABLE)
        else
            if removedCount == 0 then
                member:messageBasic(tpz.msg.basic.NO_EFFECT)
            end
        end
    end)

end