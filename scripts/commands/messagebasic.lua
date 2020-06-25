---------------------------------------------------------------------------------------------------
-- func: messagebasic
-- desc: Injects a message basic packet.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "iii"
}

function onTrigger(caller, player, msgId, param1, param2)
    local usage = "!messagebasic <message ID> {param1} {param2}"

    -- validate msgId
    if (msgId == nil) then
        tpz.commands.error(caller, player, "You must provide a message ID.", usage)
        return
    end

    local target = player:getCursorTarget()
    if target == nil then
        target = player
    end

    -- inject message packet
    player:messageBasic(msgId, param1, param2, target)
end
