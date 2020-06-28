---------------------------------------------------------------------------------------------------
-- func: messagebasic
-- desc: Injects a message basic packet.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "iii"
}

function onTrigger(caller, entity, msgId, param1, param2)
    local usage = "!messagebasic <message ID> {param1} {param2}"

    -- validate msgId
    if (msgId == nil) then
        tpz.commands.error(caller, entity, "You must provide a message ID.", usage)
        return
    end

    local target = entity:getCursorTarget()
    if target == nil then
        target = entity
    end

    -- inject message packet
    entity:messageBasic(msgId, param1, param2, target)
end
