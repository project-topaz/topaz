-----------------------------------------
-- ID: 6101
-- plate_of_indi-gravity
-- Teaches INDI-GRAVITY
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(797)
end

function onItemUse(target)
    target:addSpell(797)
end
