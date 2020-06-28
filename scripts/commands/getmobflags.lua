---------------------------------------------------------------------------------------------------
-- func: getmobflags <optional MobID>
-- desc: Used to get a mob's entity flags for testing.
--       MUST either target a mob first or else specify a Mob ID.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "n"
}

function onTrigger(caller, entity, target)
    local targ = tpz.commands.getTargetMob(caller, entity, target)
    local usage = "!getmobflags {mobID}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a valid mobID.", usage)
        return
    end

    -- get flags
    local flags = targ:getMobFlags()
    tpz.commands.print(caller, entity, string.format("%s's flags: %u", targ:getName(), flags))
end
