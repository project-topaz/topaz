-----------------------------------------
-- ID: 6094
-- plate_of_indi-malaise
-- Teaches INDI-MALAISE
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(790)
end

function onItemUse(target)
    target:addSpell(790)
end
