require("scripts/globals/missions")
require("scripts/globals/quests")

local thisQuest = tpz.quest.newQuest()

thisQuest.name = "Fertile Ground"
thisQuest.log = tpz.quest.log.ADOULIN
thisQuest.quest_id = tpz.quest.id.adoulin.FERTILE_GROUND
thisQuest.string_key = tpz.quest.string.adoulin[thisQuest.quest_id]

thisQuest.repeatable = false
thisQuest.var_prefix = "[Q]["..thisQuest.log.."]["..thisQuest.quest_id.."]"
thisQuest.vars =
{
    stage = thisQuest.var_prefix,
    additional = {}
}

thisQuest.requirements =
{
    quests =
    {
        {
            log = tpz.quest.log.ADOULIN,
            quest_id = tpz.quest.id.adoulin.THE_OLD_MAN_AND_THE_HARPOON
        }
    },
    fame =
    {
        area = tpz.quest.fame.ADOULIN,
        level = 2
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
    key_items = {tpz.ki.BOTTLE_OF_FERTILIZER_X}
}

-----------------------------------
-- QUEST STAGES
-----------------------------------
thisQuest.stages =
{
    -- [TODO] Stage 0: Talk to Chalvava, Rala Waterways, to begin the quest
    [tpz.quest.stage.STAGE0] =
    {
        [tpz.zone.RALA_WATERWAYS] =
        {
            onTrigger =
            {
                ['Chalvava'] = function(player, npc)
                    -- TODO: Implement Chalvava's portions of the quest
                    return true
                end
            },
            onEventFinish =
            {
                -- TODO: Implement Chalvava's portions of the quest
            }
        }
    },
    -- Stage 1: Talk to Shipilolo, Western Adoulin, to get Bottle of Fertilizer X KI
    [tpz.quest.stage.STAGE1] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Shipilolo'] = function(player, npc)
                    return thisQuest.startEvent(player, 2850) -- Gives Bottle of Fertilizer X to player
                end
            },
            onEventFinish =
            {
                [2850] = function(player, option)
                    -- Shipilolo, giving Bottle of Fertilizer X
                    if thisQuest.giveKeyItem(player, tpz.ki.BOTTLE_OF_FERTILIZER_X) then
                        return thisQuest.advanceStage(player)
                    end
                end
            }
        },
        [tpz.zone.RALA_WATERWAYS] =
        {
            onTrigger =
            {
                ['Chalvava'] = function(player, npc)
                    -- TODO: Implement Chalvava's portions of the quest
                    return true
                end
            }
        }
    },
    -- [TODO] Stage 2: Talk to Chalvava again, quest complete
    [tpz.quest.stage.STAGE2] =
    {
        [tpz.zone.RALA_WATERWAYS] =
        {
            onTrigger =
            {
                ['Chalvava'] = function(player, npc)
                    -- TODO: Implement Chalvava's portions of the quest
                    return true
                end
            },
            onEventFinish =
            {
                -- TODO: Implement Chalvava's portions of the quest
            }
        }
    }
}

return thisQuest
