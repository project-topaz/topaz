-----------------------------------------
-- ID: 6080
-- plate_of_indi-int
-- Teaches INDI-INT
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(776)
end

function onItemUse(target)
    target:addSpell(776)
end
