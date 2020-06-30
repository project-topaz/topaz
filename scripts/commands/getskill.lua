---------------------------------------------------------------------------------------------------
-- func: getskill <skill name or ID> <target>
-- desc: returns target's level of specified skill
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 3,
    parameters = "st"
}

function onTrigger(caller, player, skillName, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!getskill <skill name or ID> {player}"

    if (skillName == nil) then
        tpz.commands.error(caller, player, "You must specify a skill to check!", usage)
        return
    end

    local skillID = tonumber(skillName) or tpz.skill[string.upper(skillName)]
    if skillID == nil or skillID == 0 or (skillID > 12 and skillID < 25)
    or skillID == 46 or skillID == 47 or skillID > 57 then
        tpz.commands.error(caller, player, "You must specify a valid skill.", usage)
        return
    end

    -- Trying to break this wide line in any other more reasonable way results in lua throwing errors.. Parsing bug.
    tpz.commands.print(caller, player, string.format("%s's current skillID '%s' Skill: %s (real value: %s)",
    targ:getName(), skillName, (targ:getCharSkillLevel(skillID)/10) .. ".x", targ:getCharSkillLevel(skillID)))
end
