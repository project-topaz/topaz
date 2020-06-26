-----------------------------------------
-- Trust: Volker
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/spell_data")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addSimpleGambit(ai.t.MASTER, ai.c.HPP_LT, 50,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.PROVOKE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.TP_GTE, 1000,
                        ai.r.WS, ai.s.SPECIFIC, tpz.ws.RED_LOTUS_BLADE)

    tpz.trust.synergyMessage(mob, {
        [tpz.magic.spell.NAJI] = tpz.trust.message_offset.SYNERGY_1,
        [tpz.magic.spell.CID] = tpz.trust.message_offset.SYNERGY_2,
        [tpz.magic.spell.KLARA] = tpz.trust.message_offset.SYNERGY_3,
    })
end

function onMobDespawn(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DEATH)
end
