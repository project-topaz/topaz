-----------------------------------------
-- ID: 6090
-- plate_of_indi-attunement
-- Teaches INDI-ATTUNEMENT
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(786)
end

function onItemUse(target)
    target:addSpell(786)
end
