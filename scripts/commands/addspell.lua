---------------------------------------------------------------------------------------------------
-- func: addspell <spellID> <player>
-- desc: adds the ability to use a spell to the player
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "it"
}

function onTrigger(caller, player, spellId, target)
    local targ = tpz.commands.getTargetPC(caller, player, target)
    local usage = "!addspell <spellID> {player}"

    -- validate spellId
    if (spellId == nil) then
        tpz.commands.error(caller, player, "Invalid spellID.", usage)
        return
    end

    -- add spell
    local save = true
    local silent = false
    targ:addSpell(spellId, silent, save)
    tpz.commands.print(caller, player, string.format("Added spell %i to %s.",spellId,targ:getName()))
end
