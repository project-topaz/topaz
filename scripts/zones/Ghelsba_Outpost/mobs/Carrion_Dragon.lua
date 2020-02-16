-----------------------------------
-- Area: Ghelsba Outpost
--  MOB: Hut Door
-- Involved in Quest: Mirror Mirror
-----------------------------------
local ID = require("scripts/zones/Ghelsba_Outpost/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.SOUND_RANGE, 20)
end

function onMobFight(mob, target)
    if mob:getHPP() <= 75 and mob:getID() == ID.mob.CARRION_DRAGON then
        SetServerVariable("[Mirror_Mirror]BCNMmobHP", mob:getHP())
        DespawnMob(mob:getID())
        SpawnMob(ID.mob.CARRION_DRAGON + 1)
        local players = mob:getBattlefield():getPlayers()
        for i,player in pairs(players) do
            player:disengage()
            local fellowParam = getFellowParam(player)
            player:startEvent(32004,140,0,5,0,0,0,0,fellowParam)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end

function onEventUpdate(player,csid,option)
    local players = player:getBattlefield():getPlayers()
    local fellowParam = getFellowParam(player)

    if csid == 32004 then
        for i,player in pairs(players) do
            player:updateEvent(140,0,5,0,0,1048578,0,fellowParam)
        end
    end
end

function onEventFinish(player,csid,option)
    if csid == 32004 then
        local mob = GetMobByID(ID.mob.CARRION_DRAGON + 1)
        local players = player:getBattlefield():getPlayers()
        mob:setHP(GetServerVariable("[Mirror_Mirror]BCNMmobHP"))
        mob:setPos(-189, -10, 42)
        for i,player in pairs(players) do
            player:setLocalVar("triggerFellow", 1) -- no greeting on spawn
            player:setLocalVar("FellowDisengage", 1) -- fellow cannot sync disengage
            player:spawnFellow(player:getFellowValue("fellowid"))
            player:getFellow():setPos(-197, -10, 40.5)
            player:timer(20000, function(player) player:fellowAttack(mob) end)
        end
    end
end
