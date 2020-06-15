-----------------------------------
--
-- tpz.effect.MOUNTED
--
-----------------------------------
require("scripts/globals/full_speed_ahead")
require("scripts/globals/status")
-----------------------------------

function onEffectGain(target,effect)
    --[[
        Retail sends a music change packet (packet ID 0x5F) in both cases.
    ]]

    if effect:getPower() == 0 then
        target:ChangeMusic(4,212)
        target:setAnimation(tpz.anim.CHOCOBO)
    else
        target:ChangeMusic(4,84)
        target:setAnimation(tpz.anim.MOUNT)
    end
end

-- Only called in quest: Full Speed Ahead!
-- Other uses of this status don't specify a tick
function onEffectTick(target,effect)
    if target:getLocalVar("FSA_Motivation") > 0 then
        tpz.fsa.tick(target)
    end
end

function onEffectLose(target,effect)
    target:setAnimation(tpz.anim.NONE)
end
