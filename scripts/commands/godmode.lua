---------------------------------------------------------------------------------------------------
-- func: godmode
-- desc: Toggles god mode on the player, granting them several special abilities.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 2,
    parameters = ""
}

function onTrigger(caller, entity)
    if (entity:getCharVar("GodMode") == 0) then
        -- Toggle GodMode on..
        entity:setCharVar("GodMode", 1)

        -- Add bonus effects to the player..
        entity:addStatusEffect(tpz.effect.MAX_HP_BOOST,1000,0,0)
        entity:addStatusEffect(tpz.effect.MAX_MP_BOOST,1000,0,0)
        entity:addStatusEffect(tpz.effect.MIGHTY_STRIKES,1,0,0)
        entity:addStatusEffect(tpz.effect.HUNDRED_FISTS,1,0,0)
        entity:addStatusEffect(tpz.effect.CHAINSPELL,1,0,0)
        entity:addStatusEffect(tpz.effect.PERFECT_DODGE,1,0,0)
        entity:addStatusEffect(tpz.effect.INVINCIBLE,1,0,0)
        entity:addStatusEffect(tpz.effect.ELEMENTAL_SFORZO,1,0,0)
        entity:addStatusEffect(tpz.effect.MANAFONT,1,0,0)
        entity:addStatusEffect(tpz.effect.REGAIN,300,0,0)
        entity:addStatusEffect(tpz.effect.REFRESH,99,0,0)
        entity:addStatusEffect(tpz.effect.REGEN,99,0,0)

        -- Add bonus mods to the player..
        entity:addMod(tpz.mod.RACC,2500)
        entity:addMod(tpz.mod.RATT,2500)
        entity:addMod(tpz.mod.ACC,2500)
        entity:addMod(tpz.mod.ATT,2500)
        entity:addMod(tpz.mod.MATT,2500)
        entity:addMod(tpz.mod.MACC,2500)
        entity:addMod(tpz.mod.RDEF,2500)
        entity:addMod(tpz.mod.DEF,2500)
        entity:addMod(tpz.mod.MDEF,2500)

        -- Heal the player from the new buffs..
        entity:addHP(50000)
        entity:setMP(50000)
    else
        -- Toggle GodMode off..
        entity:setCharVar("GodMode", 0)

        -- Remove bonus effects..
        entity:delStatusEffect(tpz.effect.MAX_HP_BOOST)
        entity:delStatusEffect(tpz.effect.MAX_MP_BOOST)
        entity:delStatusEffect(tpz.effect.MIGHTY_STRIKES)
        entity:delStatusEffect(tpz.effect.HUNDRED_FISTS)
        entity:delStatusEffect(tpz.effect.CHAINSPELL)
        entity:delStatusEffect(tpz.effect.PERFECT_DODGE)
        entity:delStatusEffect(tpz.effect.INVINCIBLE)
        entity:delStatusEffect(tpz.effect.ELEMENTAL_SFORZO)
        entity:delStatusEffect(tpz.effect.MANAFONT)
        entity:delStatusEffect(tpz.effect.REGAIN)
        entity:delStatusEffect(tpz.effect.REFRESH)
        entity:delStatusEffect(tpz.effect.REGEN)

        -- Remove bonus mods..
        entity:delMod(tpz.mod.RACC,2500)
        entity:delMod(tpz.mod.RATT,2500)
        entity:delMod(tpz.mod.ACC,2500)
        entity:delMod(tpz.mod.ATT,2500)
        entity:delMod(tpz.mod.MATT,2500)
        entity:delMod(tpz.mod.MACC,2500)
        entity:delMod(tpz.mod.RDEF,2500)
        entity:delMod(tpz.mod.DEF,2500)
        entity:delMod(tpz.mod.MDEF,2500)
    end
end
