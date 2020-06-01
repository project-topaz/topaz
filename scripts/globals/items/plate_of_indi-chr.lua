-----------------------------------------
-- ID: 6082
-- plate_of_indi-chr
-- Teaches INDI-CHR
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(778)
end

function onItemUse(target)
    target:addSpell(778)
end
