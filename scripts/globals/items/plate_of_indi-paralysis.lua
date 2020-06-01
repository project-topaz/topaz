-----------------------------------------
-- ID: 6100
-- plate_of_indi-paralysis
-- Teaches INDI-PARALYSIS
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(796)
end

function onItemUse(target)
    target:addSpell(796)
end
