---------------------------------------------------------------------------------------------------
-- func: goto
-- desc: Goes to the target player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function onTrigger(caller, entity, target, forceZone)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!goto <player> {forceZone}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must enter a player name.", usage)
        return
    end

    -- validate forceZone
    if forceZone then
        if forceZone ~= 0 and forceZone ~= 1 then
            tpz.commands.error(caller, entity, "If provided, forceZone must be 1 (true) or 0 (false).", usage)
            return
        end
    else
        forceZone = 1
    end

    -- if we found this player, they're on the same zone server
    -- if they're in mog house, goto them instead of setPos
    if targ and not targ:isInMogHouse() then
        entity:setPos(targ:getXPos(), targ:getYPos(), targ:getZPos(), targ:getRotPos(), forceZone == 1 and targ:getZoneID() or nil)
    elseif not entity:gotoPlayer(targ) then
        tpz.commands.error(caller, entity, string.format("Player named: %s not found!"), target, usage)
    end
end
