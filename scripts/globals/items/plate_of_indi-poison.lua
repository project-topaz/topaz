-----------------------------------------
-- ID: 6074
-- plate_of_indi-poison
-- Teaches INDI-POISON
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(769)
end

function onItemUse(target)
    target:addSpell(769)
end
