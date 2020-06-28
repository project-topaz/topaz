---------------------------------------------------------------------------------------------------
-- func: getcraftRank <craft skill or ID> {player}
-- desc: returns target's RANK of specified craft skill
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "st"
}

function onTrigger(caller, entity, craftName, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!getcraftRank <craft skill or ID> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    if craftName == nil then
        tpz.commands.error(caller, entity, "You must specify a craft skill to check!", usage)
        return
    end

    local skillID = tonumber(craftName) or tpz.skill[string.upper(craftName)]
    local targ = nil

    if skillID == nil or skillID < 48 or skillID > 57 then
        tpz.commands.error(caller, entity, "You must specify a valid craft skill.", usage)
        return
    end

    tpz.commands.print(caller, entity, string.format("%s's current skillID '%s' rank: %u", targ:getName(), craftName, targ:getSkillRank(skillID)))
end
