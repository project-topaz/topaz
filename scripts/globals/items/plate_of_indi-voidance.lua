-----------------------------------------
-- ID: 6088
-- plate_of_indi-voidance
-- Teaches INDI-VOIDANCE
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(784)
end

function onItemUse(target)
    target:addSpell(784)
end
