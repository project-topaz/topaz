-----------------------------------------
-- Spell: Warp II
-- Transports player to their home point. Can cast on allies.
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    if target:isPC() then
        return 0
    else
        return tpz.msg.basic.MAGIC_CANNOT_BE_CAST
    end

end

function onSpellCast(caster,target,spell)
    if target:isPC() then
        target:addStatusEffectEx(tpz.effect.TELEPORT,0,tpz.teleport.id.WARP,0,3.4)
        spell:setMsg(tpz.msg.basic.MAGIC_TELEPORT)
        return 0
    end
end
