-----------------------------------------------------------------
---                                                           ---
--- Elemental Skill Damage Calculator (extends Magic Damage)  ---
---                                                           ---
--- We need a separate one for damage since damage is         ---
--- generally all INT based, but enfeebles could be INT or    ---
--- MND.                                                      ---
-----------------------------------------------------------------
require("scripts/globals/calculators/magic_damage")

tpz.calculators.ElementalSkillDamage = tpz.calculators.ElementalSkillDamage or tpz.calculators.MagicDamageCalc:create()
tpz.calculators.ElementalSkillDamage.__index = tpz.calculators.ElementalSkillDamage

function tpz.calculators.ElementalSkillDamage:create(args)
    local object = tpz.calculators.MagicDamageCalc:create(args)
    setmetatable(object, self)

    return object
end

function tpz.calculators.ElementalSkillDamage:calculateDamage(caster, target, spell_params, element, num_targets)
    local damage = tpz.calculators.MagicDamageCalc.calculateDamage(self, caster, target, spell_params, element, num_targets)

    -- Ebullience
    damage = damage * self:getEbullienceMultiplier(caster)

    return damage
end

--------------------------------------
---- Spell Base Damage Calculation ---
-----------------------------------------------------------------------------
---- This design defaults to retail. However, if you want to customize it ---
---- by passing your own V/M/dINT_adjustment tables, I recommend that you ---
---- pass a custom calculateVMIndex() function as well.                   ---
-----------------------------------------------------------------------------
function tpz.calculators.ElementalSkillDamage:getBaseDmg(caster, target, spell_params)
    --- https://www.bg-wiki.com/bg/Magic_Damage#D:_INT-adjusted_Base_Damage
    local dINT    = caster:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT)
    local VMIndex = self:calculateVMIndex(dINT)
    local V       = spell_params.V[VMIndex]
    local M       = spell_params.M[VMIndex]

    -- Need to adjust dINT for the M multiplication step
    -- Function needs to support passing in a custom adjustment table for certain nukes (tier 1s, -ra spells, etc)
    -- but most follow the the default params
    local dINT_adjustment = spell_params.dINT_adjustment or {0, 50, 100, 200}

    dINT = dINT - dINT_adjustment[VMIndex]

    return (caster:getMod(tpz.mod.MAGIC_DAMAGE) + V + (dINT * M))
end

function tpz.calculators.ElementalSkillDamage:calculateVMIndex(dStat)
    local VMIndex = 1

    if dStat <= 49 then
        VMIndex = 1
    elseif 50 <= dStat and dStat <= 99 then
        VMIndex = 2
    elseif 100 <= dStat and dStat <= 199 then
        VMIndex = 3
    elseif 200 <= dStat then
        VMIndex = 4
    end

    return VMIndex
end

function tpz.calculators.ElementalSkillDamage:getEbullienceMultiplier(caster)
    --- https://www.bg-wiki.com/bg/Ebullience
    local multiplier = 1.0

    if caster:hasStatusEffect(tpz.effect.EBULLIENCE) then
        multiplier = multiplier + (caster:getMod(tpz.mod.EBULLIENCE_AMOUNT) / 100)
        -- has to be deleted here because core does not check for if its a damage spell
        caster:delStatusEffect(tpz.effect.EBULLIENCE)
    end

    return multiplier
end