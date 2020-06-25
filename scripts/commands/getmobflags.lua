---------------------------------------------------------------------------------------------------
-- func: getmobflags <optional MobID>
-- desc: Used to get a mob's entity flags for testing.
--       MUST either target a mob first or else specify a Mob ID.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "i"
}

function onTrigger(caller, player, target)
    local targ = tpz.commands.getTargetMob(caller, player, target)

    -- set flags
    local flags = targ:getMobFlags()
    tpz.commands.print(caller, player, string.format("%s's flags: %u", targ:getName(), flags))
end
