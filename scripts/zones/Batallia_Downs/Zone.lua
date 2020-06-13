-----------------------------------
--
-- Zone: Batallia_Downs (105)
--
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/icanheararainbow");
require("scripts/globals/chocobo_digging");
require("scripts/globals/missions");
require("scripts/globals/zone");
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end;

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.AHTU);
    GetMobByID(ID.mob.AHTU):setRespawnTime(math.random(900, 10800));

    -- TODO: If the circle is infinite height, use a cube
    zone:registerRegion(1, 357.819, 11, -250.201, 0, 0, 0)
    zone:registerRegion(2, 357.819, 11, -250.201, 0, 0, 0)
    zone:registerRegion(3, 357.819, 11, -250.201, 0, 0, 0)
    zone:registerRegion(4, 357.819, 11, -250.201, 0, 0, 0)
    zone:registerRegion(5, 357.819, 11, -250.201, 0, 0, 0)
    zone:registerRegion(6, 357.819, 11, -250.201, 0, 0, 0)
    zone:registerRegion(7, 357.819, 11, -250.201, 0, 0, 0)
    zone:registerRegion(8, 357.819, 11, -250.201, 0, 0, 0)

end;

function onZoneIn( player, prevZone)
    local cs = -1;

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos( -693.609, -14.583, 173.59, 30);
    end

    if (triggerLightCutscene(player)) then -- Quest: I Can Hear A Rainbow
        cs = 901;
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==1) then
        cs = 903;
    end

    -- TODO: If Full Speed Ahead, send enable packet
    -- Also add FSA status, ticking info

    return cs;
end;

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

local function fsaHelper(player, offset)
    -- If quest status FSA etc.
    -- TODO: remove from map
    -- ID.npc.BLUE_BEAM_BASE + offset
    -- ID.npc.RAPTOR_FOOD_BASE + offset
end

function onRegionEnter( player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function(x) fsaHelper(player, 0) end,
        [2] = function(x) fsaHelper(player, 1) end,
        [3] = function(x) fsaHelper(player, 2) end,
        [4] = function(x) fsaHelper(player, 3) end,
        [5] = function(x) fsaHelper(player, 4) end,
        [6] = function(x) fsaHelper(player, 5) end,
        [7] = function(x) fsaHelper(player, 6) end,
        [8] = function(x) fsaHelper(player, 7) end,
    }
end;

function onEventUpdate( player, csid, option)
    if (csid == 901) then
        lightCutsceneUpdate(player); -- Quest: I Can Hear A Rainbow
    end
end;

function onEventFinish( player, csid, option)
    if (csid == 901) then
        lightCutsceneFinish(player); -- Quest: I Can Hear A Rainbow
    elseif (csid == 903) then
        if (player:getZPos() >  -331) then
            player:updateEvent(0,0,0,0,0,3);
        else
            player:updateEvent(0,0,0,0,0,2);
        end
    end
end;
