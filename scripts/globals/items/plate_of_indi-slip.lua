-----------------------------------------
-- ID: 6095
-- plate_of_indi-slip
-- Teaches INDI-SLIP
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(791)
end

function onItemUse(target)
    target:addSpell(791)
end
