-----------------------------------------
-- ID: 14810
-- Item: Signal Pearl
-- Calls forth an adventuring fellow
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    if target:getFellow() ~= nil or target:hasStatusEffect(tpz.effect.LEVEL_RESTRICTION)
        or target:hasStatusEffect(tpz.effect.LEVEL_SYNC)then
            return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    local result = tpz.msg.basic.CANT_BE_USED_IN_AREA -- Default is fail.
    local targetZone = target:getZoneID()
    local validZoneList =
    {
        2,4,5,7,11,12,24,25,51,52,61,68,79,100,101,102,103,104,105,106,107,108,
        109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,
        127,128,141,142,143,145,147,149,151,153,157,158,159,160,161,162,166,167,
        169,172,173,174,176,184,190,191,192,193,194,195,196,197,198,200,204,205,
        208,212,213
    }
    for i, validZone in ipairs(validZoneList) do
        if validZone == targetZone then
            result = 0
            break
        end
    end

    return result
end

function onItemUse(target)
    target:spawnFellow(target:getFellowValue("fellowid"))
    target:setFellowValue("bond", target:getFellowValue("Bond")+1)
end
