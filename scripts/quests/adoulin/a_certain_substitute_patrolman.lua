require("scripts/globals/missions")
require("scripts/globals/quests")

local thisQuest = tpz.quest.newQuest()

thisQuest.name = "A Certain Substitute Patrolman"
thisQuest.log = tpz.quest.log.ADOULIN
thisQuest.quest_id = tpz.quest.id.adoulin.A_CERTAIN_SUBSTITUTE_PATROLMAN
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
    exp = 1000,
    bayld = 500,
    fame_area = tpz.quest.fame.ADOULIN
}

thisQuest.temporary =
{
    items = {},
    key_items = {tpz.ki.WESTERN_ADOULIN_PATROL_ROUTE}
}

-- Additional quest functions
-----------------------------------
thisQuest.GO_PATROL = function(player, npc)
    -- Rising Solstice yelling at the player to go patrol
    return thisQuest.startEvent(player, 2551)
end

-----------------------------------
-- QUEST STAGES
-----------------------------------
thisQuest.stages =
{
    -- Stage 0: Talk to Rising Solstice, Western Adoulin, to begin the quest
    [tpz.quest.stage.STAGE0] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Rising_Solstice'] = function(player, npc)
                    if thisQuest.checkRequirements(player) then
                        return thisQuest.startEvent(player, 2550) -- Starts Quest: 'A Certain Substitute Patrolman'
                    end
                end
            },
            onEventFinish =
            {
                [2550] = function(player, option) -- Rising Solstice starting quest
                    if thisQuest.giveKeyItem(player, tpz.ki.WESTERN_ADOULIN_PATROL_ROUTE) then
                        return thisQuest.begin(player)
                    end
                end
            }
        }
    },
    -- Stage 1: Talk to Zaoso, Western Adoulin
    [tpz.quest.stage.STAGE1] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Rising_Solstice'] = thisQuest.GO_PATROL,
                ['Zaoso'] = function(player, npc)
                    return thisQuest.startEvent(player, 2553) -- Reports to player, and advances quest
                end
            },
            onEventFinish =
            {
                [2553] = function(player, option) -- Zaoso progressing quest
                    return thisQuest.advanceStage(player)
                end
            }
        }
    },
    -- Stage 2: Talk to Clemmar, Western Adoulin
    [tpz.quest.stage.STAGE2] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Rising_Solstice'] = thisQuest.GO_PATROL,
                ['Clemmar'] = function(player, npc)
                    return thisQuest.startEvent(player, 2554) -- Reports to player, and advances quest
                end
            },
            onEventFinish =
            {
                [2554] = function(player, option) -- Clemmar progressing quest
                    return thisQuest.advanceStage(player)
                end
            }
        }
    },
    -- Stage 3: Talk to Kongramm, Western Adoulin
    [tpz.quest.stage.STAGE3] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Rising_Solstice'] = thisQuest.GO_PATROL,
                ['Kongramm'] = function(player, npc)
                    return thisQuest.startEvent(player, 2555) -- Reports to player, and advances quest
                end
            },
            onEventFinish =
            {
                [2555] = function(player, option) -- Kongramm progressing quest
                    return thisQuest.advanceStage(player)
                end
            }
        }
    },
    -- Stage 4: Talk to Virsaint, Western Adoulin
    [tpz.quest.stage.STAGE4] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Rising_Solstice'] = thisQuest.GO_PATROL,
                ['Virsaint'] = function(player, npc)
                    return thisQuest.startEvent(player, 2556) -- Reports to player, and advances quest
                end
            },
            onEventFinish =
            {
                [2556] = function(player, option) -- Virsaint progressing quest
                    return thisQuest.advanceStage(player)
                end
            }
        }
    },
    -- Stage 5: Talk to Shipilolo, Western Adoulin
    [tpz.quest.stage.STAGE5] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Rising_Solstice'] = thisQuest.GO_PATROL,
                ['Shipilolo'] = function(player, npc)
                    return thisQuest.startEvent(player, 2557) -- Reports to player, and advances quest
                end
            },
            onEventFinish =
            {
                [2557] = function(player, option) -- Shipilolo progressing quest
                    return thisQuest.advanceStage(player)
                end
            }
        }
    },
    -- Stage 6: Talk to Dangueubert, Western Adoulin
    [tpz.quest.stage.STAGE6] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Rising_Solstice'] = thisQuest.GO_PATROL,
                ['Dangueubert'] = function(player, npc)
                    return thisQuest.startEvent(player, 2558) -- Reports to player, and advances quest
                end
            },
            onEventFinish =
            {
                [2558] = function(player, option) -- Dangueubert progressing quest
                    return thisQuest.advanceStage(player)
                end
            }
        }
    },
    -- Stage 7: Talk to Nylene, Western Adoulin
    [tpz.quest.stage.STAGE7] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Rising_Solstice'] = thisQuest.GO_PATROL,
                ['Nylene'] = function(player, npc)
                    return thisQuest.startEvent(player, 2559) -- Reports to player, and advances quest
                end
            },
            onEventFinish =
            {
                [2559] = function(player, option) -- Nylene progressing quest
                    return thisQuest.advanceStage(player)
                end
            }
        }
    },
    -- Stage 8: Talk to Rising Solstice again, quest complete
    [tpz.quest.stage.STAGE8] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Rising_Solstice'] = function(player, npc)
                    return thisQuest.startEvent(player, 2552) -- Finishes quest
                end
            },
            onEventFinish =
            {
                [2552] = function(player, option) -- Rising Solstice finishing quest
                    if thisQuest.complete(player) then
                        return thisQuest.delKeyItem(tpz.ki.WESTERN_ADOULIN_PATROL_ROUTE)
                    end
                end
            }
        }
    }
}

return thisQuest
