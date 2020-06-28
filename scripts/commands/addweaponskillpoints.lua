---------------------------------------------------------------------------------------------------
-- func: addWeaponSkillPoints <slot> <points> {player}
-- desc: Adds weapon skill points to an equipped item.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "iit"
}

function onTrigger(caller, entity, slot, points, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!addweaponskillpoints <slot> <points> {player} (main=0, sub=1, ranged=2)"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate slot
    if slot < tpz.slot.MAIN or slot > tpz.slot.RANGED then
        tpz.commands.error(caller, entity, "Slot out of range.", usage)
        return
    end

    -- validate points
    if points < 0 then
        tpz.commands.error(caller, entity, "Cannot add negative points.", usage)
        return
    end

    local item = target:getStorageItem(0, 0, slot)
    if item == nil then
        local slotname = slot == 0 and 'main' or slot == 1 and 'sub' or slot == 2 and 'ranged'
        tpz.commands.error(caller, entity, string.format('No weapon equipped in %s slot.', slotname), usage)
        return
    end

    -- add weaponskill points
    if target:addWeaponSkillPoints(slot, points) then
        tpz.commands.print(caller, entity, string.format('Added %s weapon skill points to %s.', points, item:getName()))
    else
        tpz.commands.print(caller, entity, string.format("Could not add weapon skill points to %s.", item:getName()))
    end
end
