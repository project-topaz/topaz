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

function onTrigger(caller, player, lv)
    local usage = "!setmoblevel <level>"
    local target = player:getCursorTarget()

    -- set level
    if target and target:isMob() then
        tpz.commands.print(caller, player, string.format("Old MainJob(jID: %s) LV: %i / SubJob(jID: %s) LV: %i ",
            target:getMainJob(), target:getMainLvl(), target:getSubJob(), target:getSubLvl()), tpz.msg.channel.SYSTEM_3
        )

        target:setMobLevel(lv)

        tpz.commands.print(caller, player, string.format("New MainJob(jID: %s) LV: %i / SubJob(jID: %s) LV: %i ",
            target:getMainJob(), target:getMainLvl(), target:getSubJob(), target:getSubLvl()), tpz.msg.channel.SYSTEM_3
        )
    else
        tpz.commands.error(caller, player, "must target a monster first!", usage)
    end
end
