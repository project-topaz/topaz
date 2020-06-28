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

function onTrigger(caller, entity, target)
    local usage = "!breaklinkshell <linkshell name>"

    -- validate target
    if not target then
        tpz.commands.error(caller, entity, "You must enter a linkshell name.", usage)
        return
    end

    if entity:breakLinkshell(target) then
        tpz.commands.print(caller, entity, "Linkshell named \""..target.."\" has been broken!")
    else
        tpz.commands.error(caller, entity, string.format("Linkshell named \"%s\" not found!", target), usage)
    end
end
