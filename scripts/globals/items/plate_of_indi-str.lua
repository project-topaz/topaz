-----------------------------------------
-- ID: 6076
-- plate_of_indi-str
-- Teaches INDI-STR
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(772)
end

function onItemUse(target)
    target:addSpell(772)
end
