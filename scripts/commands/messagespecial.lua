---------------------------------------------------------------------------------------------------
-- func: messagespecial
-- desc: Injects a message special packet.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "iiiii"
}

function onTrigger(caller, entity, msgId, param1, param2, param3, param4, param5)
    local usage = "!messagespecial <message ID> {param1} {param2} {param3} {param4} {param5}"

    -- validate msgId
    if (msgId == nil) then
        tpz.commands.error(caller, entity, "You must provide a message ID.", usage)
        return
    end

    -- inject message special packet
    if (param5 ~= nil) then
        entity:messageSpecial(msgId, param1, param2, param3, param4, param5)
    elseif (param4 ~= nil) then
        entity:messageSpecial(msgId, param1, param2, param3, param4)
    elseif (param3 ~= nil) then
        entity:messageSpecial(msgId, param1, param2, param3)
    elseif (param2 ~= nil) then
        entity:messageSpecial(msgId, param1, param2)
    elseif (param1 ~= nil) then
        entity:messageSpecial(msgId, param1)
    else
        entity:messageSpecial(msgId)
    end
end
