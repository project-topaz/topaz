-----------------------------------------
-- Trust: Ayame
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/spell_data")
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
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.HASSO,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.HASSO)

    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.THIRD_EYE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.TP_LT, 1000,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.MEDITATE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.TP_GTE, 1000,
                        ai.r.WS, ai.s.SPECIFIC, tpz.ws.TACHI_ENPI)

    tpz.trust.synergyMessage(mob, {
        [tpz.magic.spell.NAJI] = tpz.trust.message_offset.SYNERGY_1,
        [tpz.magic.spell.GILGAMESH] = tpz.trust.message_offset.SYNERGY_2,
    })
end

function onMobDespawn(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DEATH)
end
