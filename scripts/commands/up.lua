---------------------------------------------------------------------------------------------------
-- func: up <optional number> <optional target>
-- desc: Alters vertical coordinate
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 4,
    parameters = "is"
};

function onTrigger(player, number, target)
    local VALUE = 0;
    local cursor = player:getCursorTarget();
    if (target == nil and cursor == nil) then
        entity = player;
    elseif (target == nil and cursor ~= nil) then
        entity = cursor;
    elseif (target ~= nil and GetPlayerByName(target) == nil) then
        player:PrintToPlayer(string.format("Player named '%s' not found!", target));
        return
    else
        entity = GetPlayerByName(target);
    end

    if (number ~= nil and number > 0) then
        VALUE = entity:getYPos() -number;
    else
        VALUE = entity:getYPos() -0.5;
    end

    entity:setPos(entity:getXPos(), VALUE, entity:getZPos(), entity:getRotPos());
end;
