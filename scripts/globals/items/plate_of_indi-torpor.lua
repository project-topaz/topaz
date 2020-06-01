-----------------------------------------
-- ID: 6096
-- plate_of_indi-torpor
-- Teaches INDI-TORPOR
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(792)
end

function onItemUse(target)
    target:addSpell(792)
end
