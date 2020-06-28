---------------------------------------------------------------------------------------------------
-- func: addspell <spellID> <player>
-- desc: adds the ability to use a spell to the player
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "it"
}

function onTrigger(caller, entity, spellId, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!addspell <spellID> {player}"

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
    local save = true
    local silent = false
    targ:addSpell(spellId, silent, save)
    tpz.commands.print(caller, entity, string.format("Added spell %i to %s.",spellId,targ:getName()))
end
