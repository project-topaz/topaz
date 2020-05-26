-----------------------------------------
-- Trust: Ayame
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1005)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addGambit(
    {
        {
            {
                { ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.HASSO }
            },
            {
                { ai.r.JA, ai.s.SPECIFIC, tpz.ja.HASSO }
            }
        }
    })

    mob:addGambit(
    {
        {
            {
                { ai.t.SELF, ai.c.HAS_ENMITY, 0 }
            },
            {
                { ai.r.JA, ai.s.SPECIFIC, tpz.ja.THIRD_EYE }
            }
        }
    })
end
