-----------------------------------------
-- ID: 6092
-- plate_of_indi-frailty
-- Teaches INDI-FRAILTY
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(788)
end

function onItemUse(target)
    target:addSpell(788)
end
