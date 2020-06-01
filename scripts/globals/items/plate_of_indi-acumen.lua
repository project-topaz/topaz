-----------------------------------------
-- ID: 6085
-- plate_of_indi-acumen
-- Teaches INDI-ACUMEN
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(781)
end

function onItemUse(target)
    target:addSpell(781)
end
