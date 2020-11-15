---------------------------------------------------------------------------------------------------
-- func: setskill <skill name or ID> <skill level> <target>
-- desc: sets target's level of specified skill
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "sit"
}

function onTrigger(caller, entity, skillName, skillLV, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!setskill <skill name or ID> <skill level> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    if (skillName == nil) then
        tpz.commands.error(caller, entity, "You must specify a skill to set!", usage)
        return
    end

    if skillLV == nil then
        tpz.commands.error(caller, entity, "You must specify the new skill level to set.", usage)
        return
    end


    local skillID = tonumber(skillName) or tpz.skill[string.upper(skillName)]
    if skillID == nil or skillID == 0 or (skillID > 12 and skillID < 25)
    or skillID == 46 or skillID == 47 or skillID > 57 then
        tpz.commands.error(caller, entity, "You must specify a valid skill.")
        return
    end

    targ:setSkillLevel(skillID, skillLV*10)
    targ:messageBasic(53, skillID, skillLV)
    if (targ:getID() ~= caller) then
        tpz.commands.print(caller, entity, string.format("%s's new skillID '%s' Skill: %s", targ:getName(), skillName, (targ:getCharSkillLevel(skillID)/10)..".0"))
    end
end
