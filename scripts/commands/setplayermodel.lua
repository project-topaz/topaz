---------------------------------------------------------------------------------------------------
-- func: setplayermodel <modelid> <slot> <player>
-- desc: Sets the look of the user or target player based on model id offset and slot (for testing).
---------------------------------------------------------------------------------------------------

require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "iit"
}

function onTrigger(caller, entity, model, slot, target)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!setplayermodel <model> <slot> {player}"
    local usage_extended = "Slots: 0=main 1=sub 2=ranged 3=ammo 4=head 5=body 6=hands 7=legs 8=feet"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate model
    if (model == nil) then
        tpz.commands.error(caller, entity, "Invalid model ID.", usage)
        tpz.commands.print(caller, entity, usage_extended)
        return
    end

    -- validate slot
    if (slot == nil or slot < 0 or slot > 8) then
        tpz.commands.error(caller, entity, "Invalid slot ID.", usage)
        tpz.commands.print(caller, entity, usage_extended)
        return
    end

    -- validate target
    local targ
    if (target == nil) then
        targ = entity
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            tpz.commands.error(caller, entity, string.format("Player named '%s' not found!", target), usage)
            tpz.commands.print(caller, entity, usage_extended)
            return
        end
    end

    local slotNameByNum = {
        [0] = "main",
        [1] = "sub",
        [2] = "ranged",
        [3] = "ammo",
        [4] = "head",
        [5] = "body",
        [6] = "hands",
        [7] = "legs",
        [8] = "feet"
    }

    -- set model
    targ:setModelId(model, slot)
    tpz.commands.print(caller, entity, string.format("Set %s's %s slot to model %i.", targ:getName(), slotNameByNum[slot], model))
end
