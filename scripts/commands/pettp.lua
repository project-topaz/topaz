---------------------------------------------------------------------------------------------------
-- func: pettp
-- desc: Sets the players pet tp.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function onTrigger(caller, entity, tp)
    local usage = "!pettp {amount}"

    -- validate target
    local targ = entity:getPet()
    if (targ == nil) then
        tpz.commands.error(caller, entity, "You do not have a pet.", usage)
        return
    end

    -- validate tp amount
    if (tp == nil or tp < 0) then
        tpz.commands.error(caller, entity, "Invalid amount of tp.", usage)
        return
    end

    -- set pet tp
    targ:setTP(tp)
end
