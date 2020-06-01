-----------------------------------------
-- ID: 6098
-- plate_of_indi-languor
-- Teaches INDI-LANGUOR
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(794)
end

function onItemUse(target)
    target:addSpell(794)
end
