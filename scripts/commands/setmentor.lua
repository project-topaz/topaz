---------------------------------------------------------------------------------------------------
-- func: setmentor <MentorMode> <target>
-- desc: 0 = Not a mentor, 1 = Unlocked but inactive, 2 = Unlocked & flag on.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function onTrigger(caller, player, mentorMode, target)
    local usage = "!setmerits <amount> {player}"
    local usage_extended = "mode: 0 = Not a mentor, 1 = Unlocked but inactive."
    local targ = tpz.commands.getTargetPC(player, target)

    -- validate mode
    if (mentorMode == nil or mentorMode < 0 or mentorMode > 1) then
        tpz.commands.error(caller, player, "Invalid mode.", usage)
        tpz.commands.print(caller, player, usage_extended)
        return
    end

    -- set mentor mode
    targ:setMentor(mentorMode)
end
