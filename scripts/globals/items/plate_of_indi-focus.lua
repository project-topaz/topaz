-----------------------------------------
-- ID: 6089
-- plate_of_indi-focus
-- Teaches INDI-FOCUS
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(785)
end

function onItemUse(target)
    target:addSpell(785)
end
