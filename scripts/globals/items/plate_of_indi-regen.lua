-----------------------------------------
-- ID: 6073
-- plate_of_indi-regen
-- Teaches INDI-REGEN
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(768)
end

function onItemUse(target)
    target:addSpell(768)
end
