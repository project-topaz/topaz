-----------------------------------------
-- ID: 6077
-- plate_of_indi-dex
-- Teaches INDI-DEX
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(773)
end

function onItemUse(target)
    target:addSpell(773)
end
