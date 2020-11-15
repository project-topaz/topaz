-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Pygmytoise
-----------------------------------
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    --[[
    Attempt to Aproximate retail damage ratios,
    the current resist rates can't do the job..
    What retail appears to do per info on BG is FORCE a minimum resist teir
    along with a damage bonus on ice (all spell get a partial resist).
    These are annoyingly x/256 scaled.
    ]]
    mob:setMod(tpz.mod.FIRERES, 128)
    mob:setMod(tpz.mod.ICERES, 52)
    mob:setMod(tpz.mod.WINDRES, 128)
    mob:setMod(tpz.mod.EARTHRES, 200)
    mob:setMod(tpz.mod.THUNDERRES, 200)
    mob:setMod(tpz.mod.WATERRES, 128)
    mob:setMod(tpz.mod.LIGHTRES, 128)
    mob:setMod(tpz.mod.DARKRES, 128)
end

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 770, 2, tpz.regime.type.GROUNDS)
end
