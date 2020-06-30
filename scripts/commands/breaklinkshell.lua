---------------------------------------------------------------------------------------------------
-- func: breaklinkshell
-- desc: Breaks a linkshell and all pearls/sacks
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 6,
    parameters = "s"
}

function onTrigger(caller, player, target)
    local usage = "!breaklinkshell <linkshell name>"

    -- validate target
    if not target then
        tpz.commands.error(caller, player, "You must enter a linkshell name.", usage)
        return
    end

    if player:breakLinkshell(target) then
        tpz.commands.print(caller, player, "Linkshell named \""..target.."\" has been broken!")
    else
        tpz.commands.error(caller, player, string.format("Linkshell named \"%s\" not found!", target), usage)
    end
end
