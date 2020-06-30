---------------------------------------------------------------------------------------------------
-- func: delspell <spellID> <player>
-- desc: Removes a spell from the players spell list.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "it"
}

function onTrigger(caller, player, spellId, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!delspell <spellID> {player}"

    -- validate spellId
    if (spellId == nil) then
        tpz.commands.error(caller, player, "Invalid spellID.", usage)
        return
    end

    -- add spell
    targ:delSpell(spellId)
    tpz.commands.print(caller, player, string.format("Deleted spell %i from %s.",spellId,targ:getName()))
end
