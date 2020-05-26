-----------------------------------------
-- ID: 6097
-- plate_of_indi-vex
-- Teaches INDI-VEX
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(793)
end

function onItemUse(target)
    target:addSpell(793)
end
