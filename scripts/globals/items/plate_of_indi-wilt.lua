-----------------------------------------
-- ID: 6091
-- plate_of_indi-wilt
-- Teaches INDI-WILT
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(787)
end

function onItemUse(target)
    target:addSpell(787)
end
