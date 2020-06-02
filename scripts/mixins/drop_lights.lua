require("scripts/globals/mixins")
require("scripts/globals/status")
require("scripts/globals/moblights")

g_mixins = g_mixins or {}

---------------------------------------------------------
-- Drops Lights
---------------------------------------------------------
g_mixins.drop_lights = function(mob)
    mob:addListener("ABYSSEA_MAGIC_TAKE", "ABYSSEA_MAGIC_DEATH_CHECK", function(target, caster, spell)
        if target:getHP() <= 0 then
            DropLights(caster, target:getName(), "magical", target)
        end 
    end)

    mob:addListener("ABYSSEA_WEAPONSKILL_TAKE", "ABYSSEA_WS_DEATH_CHECK", function(target, user, wsid)
        local magicalWS =
        {
            19,20,30,34,47,51,58,74,107,114,133,139,148,149,161,172,177,186,187,189,217,218,220,
        }

        local wsType = "ws_physical"

        if target:getHP() <= 0 then
            for i = 1, #magicalWS do
                if wsid == magicalWS[i] then
                    wsType = "ws_magical"
                    break
                end
            end
            DropLights(user, target:getName(), wsType, target)
        end 
    end)

    mob:addListener("ABYSSEA_ABILITY_TAKE", "ABYSSEA_ABILITY_DEATH_CHECK", function(mob, user, ability, action)
        if mob:getHP() <= 0 then
            DropLights(user, mob:getName(), "physical")
        end
    end)

    mob:addListener("ABYSSEA_ATTACKED_DEATH", "ABYSSEA_PHYSICAL_DEATH_CHECK", function(target, attacker)
        if target:getHP() <= 0 then
            DropLights(attacker, target:getName(), "physical", target)
        end
    end)

    mob:addListener("DEATH", "ABYSSEA_DEATH_NO_ACTION", function(mob, player, isKiller)
        DropLights(attacker, mob:getName(), "physical", mob)
    end)
end

return g_mixins.drop_lights