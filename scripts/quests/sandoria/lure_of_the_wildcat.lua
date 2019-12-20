require("scripts/globals/quests")
require("scripts/globals/zone")

local this_quest = {}
local name = "LURE_OF_THE_WILDCAT"
local logid = tpz.quest.log.SANDORIA
local id = tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT

this_quest.id = id
this_quest.name = name

this_quest.repeatable = false
this_quest.vars =
{
    main = "[Q]".."["..logid.."]".."["..id.."]",
    preserve_main_on_complete = false, -- do we keep main var on quest completion
    additional =
    {
        ["name"] = { id = 1, type = tpz.quests.enums.var_types.LOCAL_VAR, repeatable = false, preserve_on_complete = false },
    }
}

this_quest.rewards =
{
    sets =
    {
        [1] =
        {
            title = tpz.title.NEW_ADVENTURER,
            keyitems = { tpz.ki.DARK_KEY },
            items = { itemid = 17440, qty = 1 }
        }
    }
}

this_quest.npcs =
{
    [tpz.zone.SOUTHERN_SAN_DORIA] =
    {
        ["Amutiyaal"] =
        {
            onTrade = function(player, npc, trade)
            end,
            onTrigger = function(player, npc)
            end,
            onEventUpdate = function(player, csid, option)
            end,
            onEventFinish = function(player, csid, option)
            end
        }
    }
}

tpz.quests.quests[logid][name] = this_quest
return this_quest
