-----------------------------------------
-- ID: 6083
-- plate_of_indi-fury
-- Teaches INDI-FURY
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(779)
end

function onItemUse(target)
    target:addSpell(779)
end
