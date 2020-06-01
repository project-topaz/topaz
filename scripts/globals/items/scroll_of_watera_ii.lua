-----------------------------------------
-- ID: 4706
-- Scroll of Enlight
-- Teaches the white magic Enlight
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(839)
end

function onItemUse(target)
    target:addSpell(839)
end
