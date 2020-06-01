-----------------------------------------
-- ID: 6079
-- plate_of_indi-agi
-- Teaches INDI-AGI
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(775)
end

function onItemUse(target)
    target:addSpell(775)
end
