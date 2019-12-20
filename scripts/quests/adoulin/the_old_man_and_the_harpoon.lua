require("scripts/globals/missions")
require("scripts/globals/quests")

local thisQuest = tpz.quest.newQuest()

thisQuest.name = "The Old Man and the Harpoon"
thisQuest.log = tpz.quest.log.ADOULIN
thisQuest.quest_id = tpz.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON
thisQuest.string_key = tpz.quest.string.adoulin[thisQuest.quest_id]

thisQuest.repeatable = false
thisQuest.var_prefix = "[Q]["..thisQuest.log.."]["..thisQuest.quest_id.."]"
thisQuest.vars =
{
    stage = thisQuest.var_prefix,
    additional =
    {
        --['name'] = { type = tpz.quest.var.CHAR, preserve = false, db_name = 'some_var' },
    }
}

thisQuest.requirements =
{
    missions =
    {
        {
            mission_log = ADOULIN,
            mission_id = tpz.mission.id.soa.LIFE_ON_THE_FRONTIER
        }
    },
    fame =
    {
        area = tpz.quest.fame.ADOULIN,
        level = 1
    }
}

thisQuest.rewards =
{
    exp = 500,
    bayld = 300,
    fame_area = tpz.quest.fame.ADOULIN
}

thisQuest.temporary =
{
    items = {},
    key_items = {tpz.ki.BROKEN_HARPOON, tpz.ki.EXTRAVAGANT_HARPOON},
    --seen_events =
    --{
        --{tpz.zone.WESTERN_ADOULIN, 2541}
    --}
}

-----------------------------------
-- QUEST STAGES
-----------------------------------
thisQuest.stages =
{
    -- Stage 0: Talk to Jorin, Western Adoulin, to get Broken Harpoon KI and start quest
    [tpz.quest.stage.STAGE0] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Jorin'] = function(player, npc)
                    if thisQuest.checkRequirements(player) then
                        -- Starting quest, his harpoon is broken
                        return thisQuest.startEvent(player, 2540) 
                    end
                end
            },
            onEventFinish =
            {
                [2540] = function(player, option)
                    -- Jorin, starting quest
                    if thisQuest.giveKeyItem(player, tpz.ki.BROKEN_HARPOON) then
                        return thisQuest.begin(player)
                    end
                end
            }
        }
    },
    -- Stage 1: Talk to Shipilolo, Western Adoulin, to exchange Broken Harpoon KI for Extravagant Harpoon KI
    [tpz.quest.stage.STAGE1] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Jorin'] = function(player, npc)
                    -- Begs player to hurry up
                    return thisQuest.startEvent(player, 2541) 
                end,
                ['Shipilolo'] = function(player, npc)
                    -- Upgrading Broken Harpoon to Extravagant Harpoon
                    return thisQuest.startEvent(player, 2543) 
                end
            },
            onEventFinish =
            {
                [2543] = function(player, option)
                    -- Shipilolo, fixes Broken Harpoon and advances quest
                    if thisQuest.giveKeyItem(player, tpz.ki.EXTRAVAGANT_HARPOON) then
                        thisQuest.delKeyItem(player, tpz.ki.BROKEN_HARPOON)
                        return thisQuest.advanceStage(player)
                    end
                end
            }
        }
    },
    -- Stage 2: Talk to Jorin, to give him Extravagant Harpoon and finish quest
    [tpz.quest.stage.STAGE2] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Jorin'] = function(player, npc)
                    -- Giving Jorin the Extravagant Harpoon
                    return thisQuest.startEvent(player, 2542) 
                end
            },
            onEventFinish =
            {
                [2542] = function(player, option)
                    -- Jorin, finishing quest
                    if thisQuest.complete(player) then
                        thisQuest.delKeyItem(player, tpz.ki.EXTRAVAGANT_HARPOON)
                        return true
                    end
                end
            }
        }
    }
}

return thisQuest
