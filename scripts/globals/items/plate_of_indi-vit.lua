-----------------------------------------
-- ID: 6078
-- plate_of_indi-vit
-- Teaches INDI-VIT
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(774)
end

function onItemUse(target)
    target:addSpell(774)
end
