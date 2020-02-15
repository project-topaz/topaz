-----------------------------------------
-- ID: 5838
-- Item: Tube of Clear Salve II
-- Item Effect: Removes most status ailments from Pet
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if not target:hasPet() then
        result = tpz.msg.basic.REQUIRES_A_PET
    end
    return result
end

function onItemUse(target)
    local pet = target:getPet()
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
        if pet:hasStatusEffect(status) then
            pet:delStatusEffect(status)
            removedCount = removedCount + 1
        end
    end
    if pet:hasStatusEffectByFlag(tpz.effectFlag.ERASABLE) then
        pet:eraseStatusEffect(tpz.effectFlag.ERASABLE)
    else
        if removedCount == 0 then
            pet:messageBasic(tpz.msg.basic.NO_EFFECT)
        end
    end
end