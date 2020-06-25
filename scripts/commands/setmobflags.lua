---------------------------------------------------------------------------------------------------
-- func: setmobflags <flags> <optional MobID>
-- desc: Used to manipulate a mob's nameflags for testing.
--       MUST either target a mob first or else specify a Mob ID.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function onTrigger(caller, player, flags, target)
    local usage = "!setmobflags <flags> {mob ID}"
    local targ = tpz.commands.getTargetMob(caller, player, target)

    -- validate flags
    if (flags == nil) then
        tpz.commands.error(caller, player, "You must supply a flags value.", usage)
        return
    end

    if targ == nil then
        tpz.commands.error(player, caller, "You must either supply a mob ID or target a mob.", usage)
        return
    end

    -- set flags
    player:setMobFlags(flags, targ:getID())
    tpz.commands.print(caller, player, string.format("Set %s %i flags to %i.", targ:getName(), targ:getID(), flags))
end
