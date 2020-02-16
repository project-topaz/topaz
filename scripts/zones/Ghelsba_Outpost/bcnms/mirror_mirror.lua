-----------------------------------
-- Area: Ghelsba Outpost
-- Name: Mirror Mirror - Adventuring Fellow Quest
-----------------------------------
local ID = require("scripts/zones/Ghelsba_Outpost/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/pets")

-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

-- After registering the BCNM via bcnmRegister(bcnmid)
function onBattlefieldRegister(player,battlefield)
end;

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function onBattlefieldEnter(player,battlefield)
end;

-- Leaving the BCNM by every mean possible, given by the LeaveCode
-- 1=Select Exit on circle
-- 2=Winning the BC
-- 3=Disconnected or warped out
-- 4=Losing the BC
-- via bcnmLeave(1) or bcnmLeave(2). LeaveCodes 3 and 4 are called
-- from the core when a player disconnects or the time limit is up, etc

function onBattlefieldLeave(player,battlefield,leavecode)
    local fellowParam = getFellowParam(player)

    if leavecode == tpz.battlefield.leaveCode.WON then --play end CS. Need time and battle id for record keeping + storage
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), battlefield:getLocalVar("[cs]bit"), 5, 0, fellowParam)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end;

function onEventUpdate(player,csid,option)
    local fellowParam = getFellowParam(player)

    if csid == 32001 then
        if player:getFellow() ~= nil then
            player:despawnFellow()
        end
        player:updateEvent(140,0,5,197,0,1048578,0,fellowParam)
    end
end;

function onEventFinish(player,csid,option)
    if csid == 32001 and option ~= 0 and player:getCharVar("[Quest]Mirror_Mirror") == 2 then
        player:setCharVar("[Quest]Mirror_Mirror",3)
        SetServerVariable("[Mirror_Mirror]BCNMmobHP", 0)
    end
end;