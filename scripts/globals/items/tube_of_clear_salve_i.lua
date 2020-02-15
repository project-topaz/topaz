-----------------------------------------
-- ID: 5837
-- Item: Tube of Clear Salve I
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
    if target:hasStatusEffect(tpz.effect.MEDICINE) then
        result = tpz.msg.basic.ITEM_NO_USE_MEDICATED
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
            if removedCount == 2 then
                break
            end
        end
    end
    if pet:hasStatusEffectByFlag(tpz.effectFlag.ERASABLE) and removedCount < 2 then
        for i=1, (2 - removedCount) do
            pet:eraseStatusEffect(tpz.effectFlag.ERASABLE)
            removedCount = removedCount + 1
            if removedCount == 2 then
                break
            end
        end
    end
    if removedCount == 0 then
        pet:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end