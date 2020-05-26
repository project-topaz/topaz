-----------------------------------------
-- ID: 6099
-- plate_of_indi-slow
-- Teaches INDI-SLOW
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(795)
end

function onItemUse(target)
    target:addSpell(795)
end
