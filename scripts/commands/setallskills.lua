---------------------------------------------------------------------------------------------------
-- func: setallskills <skill level> <target>
-- desc: sets target's level for all skills
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "is"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!setallskills <skill level> {player}")
end

function onTrigger(player, skillLV, target)
    if skillLV == nil then
        error(player, "You must specify the new skill level to set.")
        return
    end
	
	--prevent wrong input
	if (tonumber(skillLV) == nil) or (skillLV <= 1 or skillLV >= 500) then
        error(player, "Specify a valid skillevel!")
		return
    end	

	local skillID = 1
    local targ

    if target == nil then
        if player:getCursorTarget() == nil then
            targ = player
        else
            if player:getCursorTarget():isPC() then
                targ = player:getCursorTarget()
            else
                error(player, "You must target a player or specify a name.")
                return
            end
        end
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            player:PrintToPlayer(string.format("Player named '%s' not found!", target))
            return
        end
    end
    
-- Repeat for all skill but skip the spare skill ID-slots.
	repeat
		if skillID == 13 then
			skillID = 25
		end
		targ:setSkillLevel(skillID, skillLV*10)
		targ:messageBasic(53, skillID, skillLV)
		if targ ~= player then
		end
		skillID = skillID + 1
	until (skillID > 44)
	player:PrintToPlayer(string.format("%s's skills set to %s", targ:getName(), (targ:getCharSkillLevel(skillID-1)/10)))
end
