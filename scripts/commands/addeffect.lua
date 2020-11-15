---------------------------------------------------------------------------------------------------
-- func: addeffect
-- desc: Adds the given effect to the given player.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/teleports")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "stssss"
}

function onTrigger(caller, entity, id, target, power, duration, subid, subPower)
    local targ = tpz.commands.getTargetPC(caller, entity, target)
    local usage = "!addeffect <effect> {player} {power} {duration} {subid} {subPower}"

    if (targ == nil) then
        tpz.commands.error(caller, entity, "You must target or enter a player name.", usage)
        return
    end

    -- validate effect
    if (id == nil) then
        tpz.commands.error(caller, entity, "Invalid effect.", usage)
        return
    end

    -- validate power
    if (power < 0) then
        tpz.commands.error(caller, entity, "Invalid power.", usage)
        return
    end

    -- validate duration
    if (duration < 0) then
        tpz.commands.error(caller, entity, "Invalid duration.", usage)
        return
    end

    -- validate subId
    if (subId < 0) then
        tpz.commands.error(caller, entity, "Invalid subId.", usage)
        return
    end

    -- validate subPower
    if (subPower < 0) then
        tpz.commands.error(caller, entity, "Invalid subPower.", usage)
        return
    end

    -- add effect
    if (targ:addStatusEffect(id, power, 3, duration, subid, subPower)) then
        targ:messagePublic(280, targ, id, id)
    else
        targ:messagePublic(283, targ, id)
    end
end
