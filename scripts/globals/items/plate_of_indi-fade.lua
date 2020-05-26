-----------------------------------------
-- ID: 6093
-- plate_of_indi-fade
-- Teaches INDI-FADE
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(789)
end

function onItemUse(target)
    target:addSpell(789)
end
