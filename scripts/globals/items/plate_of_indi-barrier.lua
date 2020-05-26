-----------------------------------------
-- ID: 6084
-- plate_of_indi-barrier
-- Teaches INDI-BARRIER
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(780)
end

function onItemUse(target)
    target:addSpell(780)
end
