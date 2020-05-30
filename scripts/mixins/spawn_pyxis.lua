-- Sturdy Pyxis Mixin
require("scripts/globals/sturdypyxis")
require("scripts/globals/status")
require("scripts/globals/mixins")


g_mixins = g_mixins or {}

---------------------------------------------------------
--
---------------------------------------------------------
g_mixins.spawn_pyxis = function(mob)
    mob:addListener("DEATH", "DEATH_SPAWN_PYXIS", function(mob, player, isKiller)
        local mobPos = mob:getPos()
        
        if player and not mob:isNM() then
            if mob:getMaster() ~= nil then
                local master = mob:getMaster()
                if master:isMob() then -- sanity check, ensuring the mob killed is not a player's pet.
                    tpz.pyxis.spawnPyxis(player, mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
                end
            else
                tpz.pyxis.spawnPyxis(player, mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
            end
        end
    end)
end

return g_mixins.spawn_pyxis
