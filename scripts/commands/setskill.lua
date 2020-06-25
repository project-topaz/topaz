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

function onTrigger(caller, player, skillName, skillLV, target)
    local usage = "!setskill <skill name or ID> <skill level> {player}"
    local targ = tpz.commands.getTargetPC(caller, player, target)

    if (skillName == nil) then
        tpz.commands.error(caller, player, "You must specify a skill to set!", usage)
        return
    end

    if skillLV == nil then
        tpz.commands.error(caller, player, "You must specify the new skill level to set.", usage)
        return
    end


    local skillID = tonumber(skillName) or tpz.skill[string.upper(skillName)]
    if skillID == nil or skillID == 0 or (skillID > 12 and skillID < 25)
    or skillID == 46 or skillID == 47 or skillID > 57 then
        error(player, "You must specify a valid skill.")
        return
    end

    targ:setSkillLevel(skillID, skillLV*10)
    targ:messageBasic(53, skillID, skillLV)
    if targ ~= player then
        tpz.commands.print(caller, player, string.format("%s's new skillID '%s' Skill: %s", targ:getName(), skillName, (targ:getCharSkillLevel(skillID)/10)..".0"))
    end
end
