-----------------------------------------
-- ID: 6081
-- plate_of_indi-mnd
-- Teaches INDI-MND
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(777)
end

function onItemUse(target)
    target:addSpell(777)
end
