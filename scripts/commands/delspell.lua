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

function onTrigger(caller, entity, spellId, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!delspell <spellID> {player}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate spellId
    if (spellId == nil) then
        tpz.commands.error(caller, entity, "Invalid spellID.", usage)
        return
    end

    -- add spell
    targ:delSpell(spellId)
    tpz.commands.print(caller, entity, string.format("Deleted spell %i from %s.",spellId,targ:getName()))
end
