-----------------------------------------
-- ID: 6087
-- plate_of_indi-precision
-- Teaches INDI-PRECISION
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(783)
end

function onItemUse(target)
    target:addSpell(783)
end
