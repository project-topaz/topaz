-----------------------------------------
-- Trust: Shantotto
-----------------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/trust")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1019)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0,
                        ai.r.MA, ai.s.MB_ELEMENT, tpz.magic.spellFamily.NONE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0,
                        ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.NONE, 30)

    tpz.trust.synergyMessage(mob, {
        [904] = tpz.trust.message_offset.SYNERGY_1, -- Ajido-Marujido
        [935] = tpz.trust.message_offset.SYNERGY_2, -- Star Sibyl
        [952] = tpz.trust.message_offset.SYNERGY_3, -- Koru-Moru
        [989] = tpz.trust.message_offset.SYNERGY_4, -- King of Hearts
    })
end

function onMobDespawn(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DESPAWN)
end
function onMobDeath(mob)
    tpz.trust.message(mob, tpz.trust.message_offset.DEATH)
end
