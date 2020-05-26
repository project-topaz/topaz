-----------------------------------------
-- ID: 6086
-- plate_of_indi-fend
-- Teaches INDI-FEND
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(782)
end

function onItemUse(target)
    target:addSpell(782)
end
