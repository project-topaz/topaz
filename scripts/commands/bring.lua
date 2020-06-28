---------------------------------------------------------------------------------------------------
-- func: bring <player>
-- desc: Brings the target to the player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "ti"
}

function onTrigger(caller, entity, target, forceZone)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!bring <player> {forceZone}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must enter a player name.", usage)
        return
    end

    -- validate forceZone
    if (forceZone ~= nil) then
        if (forceZone ~= 0 and forceZone ~= 1) then
            tpz.commands.error(caller, entity, "If provided, forceZone must be 1 (true) or 0 (false).", usage)
            return
        end
    else
        forceZone = 1
    end
    -- bring target
	targ:setCharVar("prev_x",targ:getXPos());
	targ:setCharVar("prev_y", targ:getYPos());
	targ:setCharVar("prev_z", targ:getZPos());
	targ:setCharVar("prev_rot", targ:getRotPos());
	targ:setCharVar("prev_bringzone", targ:getZoneID())
	if (targ:getZoneID() ~= entity:getZoneID() or forceZone == 1) then
        targ:gotoPlayer(caller)
    else
        targ:setPos(entity:getXPos(), entity:getYPos(), entity:getZPos(), entity:getRotPos())
    end
end
