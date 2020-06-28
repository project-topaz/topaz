---------------------------------------------------------------------------------------------------
-- func: hide
-- desc: Hides the GM from other players.
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 2,
    parameters = "s"
}

function onTrigger(caller, entity, cmd)
    -- Obtain the players hide status..
    local isHidden = entity:getCharVar("GMHidden")
    if (cmd ~= nil) then
        if (cmd == "status") then
            tpz.commands.print(caller, entity, string.format('Current hide status: %s', tostring(isHidden)))
            return
        end
    end

    -- Toggle the hide status..
    if (isHidden == 0) then
        isHidden = 1
    else
        isHidden = 0
    end

    -- If hidden animate us beginning our hide..
    if (isHidden == 1) then
        entity:setCharVar("GMHidden", 1)
        entity:setGMHidden(true)
        tpz.commands.print(caller, entity, "You are now GM hidden from other players.")
    else
        entity:setCharVar("GMHidden", 0)
        entity:setGMHidden(false)
        tpz.commands.print(caller, entity, "You are no longer GM hidden from other players.")
    end
end
