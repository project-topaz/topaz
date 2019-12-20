require("scripts/globals/missions")
require("scripts/globals/quests")

local thisQuest = tpz.quest.newQuest()

thisQuest.name = "Wayward Waypoints"
thisQuest.log = tpz.quest.log.ADOULIN
thisQuest.quest_id = tpz.quest.id.adoulin.WAYWARD_WAYPOINTS
thisQuest.string_key = tpz.quest.string.adoulin[thisQuest.quest_id]

thisQuest.repeatable = false
thisQuest.var_prefix = "[Q]["..thisQuest.log.."]["..thisQuest.quest_id.."]"
thisQuest.vars =
{
    stage = thisQuest.var_prefix,
    additional =
    {
        -- Bitmask of waypoints calibrated during the second stage.
        ["waypoints"] = { type = tpz.quest.var.CHAR, preserve = false, db_name = 'waypoints' },
    }
}

thisQuest.requirements =
{
    quests =
    { 
        {
            log = tpz.quest.log.ADOULIN,
            quest_id = tpz.quest.id.adoulin.MEGALOMANIAC
        } 
    },
    fame =
    {
        area = tpz.quest.fame.ADOULIN,
        level = 4
    }
}

thisQuest.rewards =
{
    exp = 1000,
    bayld = 500,
    -- TODO: kinetic_units = 3000, -- Kinetic units need to be implemented before we reward them.
    fame_area = tpz.quest.fame.ADOULIN
}

thisQuest.temporary =
{
    items = {},
    key_items =
    {
        tpz.ki.WAYPOINT_SCANNER_KIT,
        tpz.ki.WAYPOINT_RECALIBRATION_KIT
    }
}

-- Additional quest functions
-----------------------------------
thisQuest.CHECK_WAYPOINT = function(player, waypoint)
    -- Make sure player is working on stage 1
    -- Bitmask the bit in the waypoints var for the given waypoint
    -- Check value of the waypoint var, if all are set, advance to stage 2
    -- Return true if we did something
end

-----------------------------------
-- QUEST STAGES
-----------------------------------
thisQuest.stages =
{
    -- [TODO] Stage 0: Speak to Sharuru in Eastern Adoulin to start the quest and receive a Waypoint Scanner Kit KI
    [tpz.quest.stage.STAGE0] =
    {
        [tpz.zone.EASTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Sharuru'] = function(player, npc)
                    -- TODO: Implement Sharuru's portions of the quest
                end
            },
            onEventFinish =
            {
                -- TODO: find Sharuru's events and implement their onFinishes
            }
        }
    },
    -- [TODO] Stage 1: Adjust waypoints at Frontier Stations in Ceizak, Yahse, Foret, Morimar, Yorcia, Marjami, and Kamihr
    [tpz.quest.stage.STAGE1] =
    {
        -- TODO: Find/implement the onTriggers for the Adoulin waypoints
        -- TODO: Implement the event onFinishes for the Adoulin waypoints, just call waypointEventFinish() with their number
    },
    -- [TODO] Stage 2: Try adjusting waypoint in Lower Jeuno
    [tpz.quest.stage.STAGE2] =
    {
        -- TODO: Find/implement the onTriggers for the Lower Jeuno waypoint
        -- TODO: Implement the Lower Jeuno waypoint onFinish events
    },
    -- [TODO] Stage 3: Talk to Sharuru again.
    [tpz.quest.stage.STAGE3] =
    {
        [tpz.zone.EASTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Sharuru'] = function(player, npc)
                    -- TODO: Implement Sharuru's portions of the quest
                end
            },
            onEventFinish =
            {
                -- TODO: find Sharuru's events and implement their onFinishes
            }
        }
    },
    -- Stage 4: Talk to Shipilolo in Western Adoulin and get Waypoint Recalibration Kit KI
    [tpz.quest.stage.STAGE4] =
    {
        [tpz.zone.WESTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Shipilolo'] = function(player, npc)
                    return thisQuest.startEvent(player, 79) -- Gives player Waypoint Recalibration Kit
                end
            },
            onEventFinish =
            {
                [79] = function(player, option) -- Shipilolo upgrading waypoint kit
                    if thisQuest.giveKeyItem(player, tpz.ki.WAYPOINT_RECALIBRATION_KIT) then
                        thisQuest.delKeyItem(tpz.ki.WAYPOINT_SCANNER_KIT)
                        return thisQuest.advanceStage(player)
                    end
                end
            }
        }
    },
    -- [TODO] Stage 5: Try Lower Jeuno waypoint again
    [tpz.quest.stage.STAGE5] =
    {
        -- TODO: Find/implement the onTriggers for the Lower Jeuno waypoint
        -- TODO: Implement the Lower Jeuno waypoint onFinish events
    },
    -- [TODO] Stage 6: Return to Sharuru, quest complete
    [tpz.quest.stage.STAGE6] =
    {
        [tpz.zone.EASTERN_ADOULIN] =
        {
            onTrigger =
            {
                ['Sharuru'] = function(player, npc)
                    -- TODO: Implement Sharuru's portions of the quest
                end
            },
            onEventFinish =
            {
                -- TODO: find Sharuru's events and implement their onFinishes
            }
        }
    }
}

return thisQuest
