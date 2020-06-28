---------------------------------------------------------------------------------------------------
-- func: setmobflags <flags> <optional MobID>
-- desc: Used to manipulate a mob's nameflags for testing.
--       MUST either target a mob first or else specify a Mob ID.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "sn"
}

function onTrigger(caller, entity, flags, target)
    local targ = tpz.commands.getTargetMob(caller, entity, target)
    local usage = "!setmobflags <flags> {mob ID}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a valid mobID.", usage)
        return
    end

    -- validate flags
    if (flags == nil) then
        tpz.commands.error(caller, entity, "You must supply a flags value.", usage)
        return
    end

    if targ == nil then
        tpz.commands.error(caller, entity, "You must either supply a mob ID or target a mob.", usage)
        return
    end

    -- set flags
    entity:setMobFlags(flags, targ:getID())
    tpz.commands.print(caller, entity, string.format("Set %s %i flags to %i.", targ:getName(), targ:getID(), flags))
end
