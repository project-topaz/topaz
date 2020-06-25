---------------------------------------------------------------------------------------------------
-- func: exec
-- desc: Allows you to execute a Lua string directly from chat.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 4,
    parameters = "s"
}

function onTrigger(caller, player, str)
    local usage = "!exec <Lua string>"

    -- Ensure a command was given..
    if (str == nil or string.len(str) == 0) then
        tpz.commands.error(caller, player, "You must enter a string to execute.", usage)
        return
    end

    -- For safety measures we will nuke the os table..
    local old_os = os
    os = nil

    -- Ensure the command compiles / is valid..
    local scriptObj, err = loadstring(str)
    if (scriptObj == nil) then
        tpz.commands.print(caller, player, "Failed to load the given string.")
        tpz.commands.print(caller, player, err)
        os = old_os
        return
    end

    -- Execute the string..
    local status, err = pcall(scriptObj)
    if (status == false) then
        tpz.commands.print(caller, player, err)
    end

    -- Restore the os table..
    os = old_os
end
