---------------------------------------------------------------------------------------------------
-- func: mount <mount ID> {player}
-- desc: Adds mounted status effect and sets mount by ID
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "sst"
};

function onTrigger(caller, entity, mount, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!mount <mount ID> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- Default to Chocobo (0)
    if (mount == nil) then
        mount = 0
    end

    -- validate mount
    mount = tonumber(mount) or tpz.mount[string.upper(mount)]
    if (mount == nil or mount < 0 or mount > 27) then
        tpz.commands.error(caller, entity, "Invalid mount ID.", usage)
        return
    end

    targ:addStatusEffectEx(tpz.effect.MOUNTED, tpz.effect.MOUNTED, mount, 0, 0, true)
end