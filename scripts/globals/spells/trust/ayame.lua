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

    -- Keep Hasso up.
    mob:addGambit({ ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.HASSO }, { ai.r.JA, ai.s.SPECIFIC, tpz.ja.HASSO })

    -- Uses Third Eye if it available and she has enmity on a hostile target.
    mob:addGambit({ ai.t.SELF, ai.c.HAS_ENMITY, 0 }, { ai.r.JA, ai.s.SPECIFIC, tpz.ja.THIRD_EYE })

    -- Pump TP with Meditate
    mob:addGambit({ ai.t.SELF, ai.c.TP_LT, 1000 }, { ai.r.JA, ai.s.SPECIFIC, tpz.ja.MEDITATE })

    mob:addGambit( { ai.t.SELF, ai.c.TP_GTE, 1000 }, { ai.r.WS, ai.s.SPECIFIC, tpz.ws.TACHI_ENPI })

    --[[
    -- Uses Meditate if her summoner has over 1000TP and she is under 1000TP.
    mob:addGambit({ -- IF:
                    { ai.s.MASTER, ai.t.TP_GTE, 1000 },
                    -- AND:
                    { ai.s.SELF, ai.t.TP_LT, 1000 }
                },
                    -- THEN:
                {ai.r.JA, ai.rm.SELECT_SPECIFIC, MEDITATE})

    -- Ayame will wait for her summoner to reach 1000TP before opening a skillchain,
    mob:addGambit({ -- IF:
                    { ai.s.MASTER, ai.t.TP_GTE, 1000 },
                    -- AND:
                    { ai.s.SELF, ai.t.TP_GTE, 1000 },
                    -- AND:
                    { ai.s.TARGET, ai.t.NOT_SC_AVAILABLE, 1000 } -- Don't interrupt anything
                },
                    -- THEN:
                    -- ai.t.NOT_SC_AVAILABLE and ai.rm.SELECT_SC_ELEMENT together will pick a WS
                    -- based on Master's last WS. If there isn't any history, it will pick randomly
                {ai.r.WS, ai.rm.SELECT_SC_ELEMENT, 0})

    -- unless she had 3000TP, at which point she will use a random weapon skill.
    mob:addGambit( { ai.s.SELF, ai.t.TP_GTE, 3000 }, { ai.r.WS, ai.rm.SELECT_RANDOM, 0 })
    ]]--
end
