---------------------------------------------------------------------------------------------------
-- func: setmoblevel
-- desc: Sets the target monsters level.
---------------------------------------------------------------------------------------------------

require("scripts/globals/msg")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function onTrigger(caller, entity, lv)
    local usage = "!setmoblevel <level>"
    local target = entity:getCursorTarget()

    -- set level
    if target and target:isMob() then
        tpz.commands.print(caller, entity, string.format("Old MainJob(jID: %s) LV: %i / SubJob(jID: %s) LV: %i ",
            target:getMainJob(), target:getMainLvl(), target:getSubJob(), target:getSubLvl()), tpz.msg.channel.SYSTEM_3
        )

        target:setMobLevel(lv)

        tpz.commands.print(caller, entity, string.format("New MainJob(jID: %s) LV: %i / SubJob(jID: %s) LV: %i ",
            target:getMainJob(), target:getMainLvl(), target:getSubJob(), target:getSubLvl()), tpz.msg.channel.SYSTEM_3
        )
    else
        tpz.commands.error(caller, entity, "must target a monster first!", usage)
    end
end
