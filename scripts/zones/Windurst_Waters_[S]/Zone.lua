-----------------------------------
--
-- Zone: Windurst_Waters_[S] (94)
--
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters_[S]/IDs")
require("scripts/globals/chocobo")
-----------------------------------

function onInitialize(zone)
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
<<<<<<< HEAD
        player:setPos(157 + math.random(1,5), -5, -62, 192)
=======
        player:setPos(157 + math.random(1, 5), -5, -62, 192)
>>>>>>> 7da047a... Merge pull request #369 from TeoTwawki/master
        if player:getMainJob() ~= player:getCharVar("PlayerMainJob") and player:getGMLevel() == 0 then
            cs = 30004
        end
        player:setCharVar("PlayerMainJob", 0)
    end

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end