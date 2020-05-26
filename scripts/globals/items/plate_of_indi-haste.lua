-----------------------------------------
-- ID: 6131
-- plate_of_indi-haste
-- Teaches INDI-HASTE
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(771)
end

function onItemUse(target)
    target:addSpell(771)
end
