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

function onTrigger(caller, player, id, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!deleffect <effect> {player}"

    -- validate effect
    id = tonumber(id) or tpz.effect[string.upper(id)]
    if (id == nil) then
        tpz.commands.error(caller, player, "Invalid effect.", usage)
        return
    elseif (id == 0) then
        id = 1
    end

    -- delete status effect
    targ:delStatusEffect(id)
    if (targ:getID() ~= caller) then
        tpz.commands.print(caller, player, string.format("Removed effect %i from %s.", id, targ:getName()))
    end
end
