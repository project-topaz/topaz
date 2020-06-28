---------------------------------------------------------------------------------------------------
-- func: addeffect
-- desc: Removes the given effect from the given player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function onTrigger(caller, entity, id, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!deleffect <effect> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate effect
    id = tonumber(id) or tpz.effect[string.upper(id)]
    if (id == nil) then
        tpz.commands.error(caller, entity, "Invalid effect.", usage)
        return
    elseif (id == 0) then
        id = 1
    end

    -- delete status effect
    targ:delStatusEffect(id)
    if (targ:getID() ~= caller) then
        tpz.commands.print(caller, entity, string.format("Removed effect %i from %s.", id, targ:getName()))
    end
end
