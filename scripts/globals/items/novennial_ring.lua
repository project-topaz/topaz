-----------------------------------------
-- ID: 11666
-- Item: novennial ring
-- Experience point bonus
-----------------------------------------
-- Bonus: +100%
-- Duration: 720 min
-- Max bonus: 9000 exp
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.DEDICATION) == true) or target:getZoneID() == (15 or 45 or 132 or 215 or 216 or 217 or 218 or 253 or 254 or 255) then
        result = 56
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.DEDICATION,100,0,43200,0,9000)
end
