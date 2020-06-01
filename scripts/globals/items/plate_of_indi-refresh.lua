-----------------------------------------
-- ID: 6075
-- plate_of_indi-refresh
-- Teaches INDI-REFRESH
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(770)
end

function onItemUse(target)
    target:addSpell(770)
end
