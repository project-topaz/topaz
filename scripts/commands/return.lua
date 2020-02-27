---------------------------------------------------------------------------------------------------
-- func: return <player>
-- desc: Warps GM or target player to their previous zone
---------------------------------------------------------------------------------------------------
require("scripts/globals/zone")
-----------------------------------

cmdprops =
{
    permission = 2,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!return {player}")
end

function onTrigger(player, target)

    -- validate target
    local targ
    if (target == nil) then
        targ = player
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format( "Player named '%s' not found!", target ) )
            return
        end
    end

    -- get previous zone
    zoneId = targ:getCharVar("prev_bringzone");
    if (zoneId == nil or zoneId == tpz.zone.UNKNOWN or zoneId == tpz.zone.RESIDENTIAL_AREA) then
        error(player, "Previous zone was a Mog House or there was a problem fetching the ID.")
        return
    end

    -- zone target
	local x_pos = targ:getCharVar("prev_x");
	local y_pos = targ:getCharVar("prev_y");
	local z_pos = targ:getCharVar("prev_z");
	local rot_pos = targ:getCharVar("prev_rot");
	targ:setPos( x_pos, y_pos, z_pos, rot_pos, zoneId );
    if (targ:getID() ~= player:getID()) then
        player:PrintToPlayer( string.format( "%s was returned to their previous position in zone %i.", targ:getName(), zoneId ) );
    end
end