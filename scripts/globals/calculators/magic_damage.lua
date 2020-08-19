--------------------------------------
---                                ---
--- Magic Damage Calculator (base) ---
---                                ---
--------------------------------------
require("scripts/globals/data/element")
require("scripts/globals/data/day_weather")
require("scripts/globals/magicburst")

tpz = tpz or {}
tpz.calculators = tpz.calculators or {}

tpz.calculators.MagicDamageCalc = tpz.calculators.MagicDamageCalc or {}
tpz.calculators.MagicDamageCalc.__index = tpz.calculators.MagicDamageCalc

tpz.calculators.MagicDamageCalc.customizable = {
    day_bonus_proc_rate     = 0.33,
    weather_bonus_proc_rate = 0.33,
}


function tpz.calculators.MagicDamageCalc:create(args)
    local object = args or {}
    setmetatable(object, self)

    return object
end

function tpz.calculators.MagicDamageCalc:calculateDamage(caster, target, spell_params, element, num_targets)
    --- https://www.bg-wiki.com/bg/Magic_Damage
    -- Damage is floored every step.
    -- "Damage Dealt is calculated by multiplying the following
    --  terms in order (see above). After each multiplication step,
    --  the product is floored to the next lowest integer before
    --  continuing to the next multiplier. Each term after D starts
    --  with a base of 1.0 and is increased or decreased by caster
    --  and target stats and attributes as well as other effects."

    -- All magic damage use this general formula, generally the only thing that changes this
    -- how base damage is calculated.

    -- Base Damage
    local damage = math.floor(self:getBaseDmg(caster, target, spell_params))

    -- MTDR: Multi Target Damage Reduction
    if spell_params.hasMultipleTargetReduction then
        damage = math.floor(damage * self:getMultiTargetMultiplier(num_targets))
    end

    -- Staff/Potency: Elemental Staves have potency modifiers
    damage = math.floor(damage * self:getStaffMultiplier(caster, element))

    -- Elemental Affinity DMG
    damage = math.floor(damage * self:getAffinityMultiplier(caster, element))

    -- Specific Damage Taken
    local sdt_multiplier = self:getSpecificDamageTakenMultiplier(target, element)
    damage = math.floor(damage * sdt_multiplier)

    -- Resist
    damage = math.floor(damage * self.resistCalculator:getResistMultiplier(caster, target, element, sdt_multiplier))

    -- Nuke Wall
    damage = math.floor(damage * self:getNukeWallMultiplier(target, element))

    -- Day/Weather Bonus
    damage = math.floor(damage * self:getDayWeatherMultiplier(caster, element, spell_params))

    -- Magic Burst
    damage = math.floor(damage * self:getMagicBurstMultiplier(target, element))

    -- Magic Burst Bonuses
    damage = math.floor(damage * self:getMagicBurstBonusMultiplier(caster))

    -- MAB/MDB
    damage = math.floor(damage * self:getMABMDBMultiplier(caster, target, element))

    --- https://www.bg-wiki.com/bg/Magic_Damage#TMDA:_Target_Magic_Damage_Adjustment
    damage = target:magicDmgTaken(damage, element) -- automatically floored because its a C++ int

    -- Cumulative Magic effect
    damage = math.floor(damage * self:getCumulativeMagicMultiplier(target, element))

    return damage
end

function tpz.calculators.MagicDamageCalc:getBaseDmg(caster, target, spell_params)
    -- This varies from Elemental Nuke, to Helix, to Weaponskill, to Blue Magic, to Ninjutsu, etc...
    return 0
end

function tpz.calculators.MagicDamageCalc:getMultiTargetMultiplier(num_targets)
    --- https://www.bg-wiki.com/bg/Magic_Damage#MTDR:_Multiple-Target_Damage_Reduction
    local multiplier = 1.0

    -- 2 <= num_targets <= 10
    if (2 <= num_targets) and (num_targets <= 10) then
        multiplier = 0.9 - (0.05 * num_targets)
    elseif (10 < num_targets) then
        multiplier = 0.4
    end

    return multiplier
end

function tpz.calculators.MagicDamageCalc:getStaffMultiplier(caster, element)
    --- https://www.bg-wiki.com/bg/Magic_Damage#Staff
    local multiplier = 1.0

    multiplier = multiplier + (caster:getMod(tpz.element.maps.to_potency[element]) / 100)

    return multiplier
end

function tpz.calculators.MagicDamageCalc:getAffinityMultiplier(caster, element)
    --- https://www.bg-wiki.com/bg/Magic_Damage#Affinity
    local multiplier      = 1.0

    if element ~= tpz.element.NONE then
        local affinity_mod_id = tpz.element.maps.to_affinity_dmg[element]
        local affinity_mod    = caster:getMod(affinity_mod_id)

        if affinity_mod > 0 then
            -- 0.10 for the first level
            -- 0.05 for the subsequent levels
            multiplier = multiplier + 0.10 + ((affinity_mod - 1) * 0.05)
        end
    end

    return multiplier
end

function tpz.calculators.MagicDamageCalc:getSpecificDamageTakenMultiplier(target, element)
    --- https://www.bg-wiki.com/bg/Magic_Damage#Specific_Damage_Taken
    local multiplier = 0.0

    if element ~= tpz.element.NONE then
        local sdt_mod_id = tpz.element.maps.to_sdt[element]
        multiplier       = multiplier + (target:getMod(sdt_mod_id) / 1000)
    end

    return multiplier
end

function tpz.calculators.MagicDamageCalc:getNukeWallMultiplier(target, element)
    --- https://www.bg-wiki.com/bg/Magic_Damage#Consecutive_Elemental_Damage_Penalty
    local multiplier = 1.0

    if target:isNM() and target:hasStatusEffect(tpz.element.maps.to_nukewall_effect[element]) then
        -- 60% penalty...
        multiplier = 0.40
        -- TODO: once rune fencer is in, the penalty is only 30%
        --  if rayke_element == element then multiplier = 0.7; end
    end

    return multiplier
end

function tpz.calculators.MagicDamageCalc:getDayWeatherMultiplier(caster, element, spell_params)
    --- https://www.bg-wiki.com/bg/Magic_Damage#Day_.26_Weather
    local day_element     = VanadielDayElement()
    local weather         = caster:getWeather()
    local weather_element = tpz.weather.maps.to_element[weather]
    local multiplier      = 1.0

    -- determine if we should force day/weather bonuses (ie, Obis)
    local force_bonuses = self:shouldForceDayWeatherProc(caster, element)

    -- handle day bonuses
    if day_element == element then
        -- matching elements
        multiplier = multiplier + (caster:getMod(tpz.mod.DAY_NUKE_BONUS) / 100) -- things like Sorcerer's Tonban and/or Zodiac Ring

        if force_bonuses
        or math.random() < (spell_params.day_bonus_proc_rate or tpz.calculators.MagicDamageCalc.customizable.day_bonus_proc_rate) then
            multiplier = multiplier + 0.10
        end

    elseif day_element == tpz.element.maps.to_ascendant_element[element] then
        -- opposing / ascendant elements
        if force_bonuses
        or math.random() < (spell_params.day_bonus_proc_rate or tpz.calculators.MagicDamageCalc.customizable.day_bonus_proc_rate) then
            multiplier = multiplier - 0.10
        end
    end

    -- handle weather bonuses
    if element == weather_element then
        -- matching elements
        if force_bonuses
        or math.random() < (spell_params.weather_bonus_proc_rate or tpz.calculators.MagicDamageCalc.customizable.weather_bonus_proc_rate) then
            -- if the weather is single if its mod is even, double if its odd
            if weather % 2 == 0 then
                multiplier = multiplier + 0.10
            else
                multiplier = multiplier + 0.25
            end
        end

        -- do iridescence in its own roll until told otherwise
        if caster:getMod(tpz.mod.IRIDESCENCE) >= 1
        and (force_bonuses or math.random() < (spell_params.weather_bonus_proc_rate or tpz.calculators.MagicDamageCalc.customizable.weather_bonus_proc_rate)) then
            multiplier = multiplier + 0.10
        end
    elseif element == tpz.element.maps.to_ascendant_element[weather_element] then
        -- opposing / ascendant elements
        if force_bonuses
        or math.random() < (spell_params.weather_bonus_proc_rate or tpz.calculators.MagicDamageCalc.customizable.weather_bonus_proc_rate) then
            -- if the weather is single if its mod is even, double if its odd
            if weather % 2 == 0 then
                multiplier = multiplier - 0.10
            else
                multiplier = multiplier - 0.25
            end
        end
    end

    -- day/weather caps at 1.4
    multiplier = math.min(multiplier, 1.4)

    -- TODO: unknown if Twilight Cape should be outside of the cap?
    -- TODO: Also, Twilight Cape should trigger on either but present mod triggers only for day

    return multiplier
end

function tpz.calculators.MagicDamageCalc:shouldForceDayWeatherProc(caster, element)
    local force_bonuses = false

    if  caster:getMod(tpz.element.maps.to_dayweather_bonus[element]) > 0 then
        force_bonuses = true
    end

    return force_bonuses
end

function tpz.calculators.MagicDamageCalc:getMagicBurstMultiplier(target, element)
    --- https://www.bg-wiki.com/bg/Magic_Damage#MB:_Magic_Burst
    local skillchainTier, weaponSkillCount = FormMagicBurst(element, target)
    local multiplier = 1.0

    -- TODO: https://www.bg-wiki.com/bg/Resist#SDT_and_Magic_Bursting
    --       The research here seems contradictory in a way.
    --       At 100% SDT (ie, neutral) the multiplier would look like 0.95.
    --       However, it seems correct at 150% SDT as it claims the multiplier would be 1.85.
    if skillchainTier > 0 then
        -- MB = 1.25 + (0.1 * X) where X is number of ws
        -- However, starting at 1.35 accounts for chainbind magic bursts being 1.25 becuase their weaponSkillCount is 0.
        multiplier = 1.35 + ((weaponSkillCount - 1) * 0.1)
    end

    return multiplier
end

function tpz.calculators.MagicDamageCalc:getMagicBurstBonusMultiplier(caster)
    --- https://www.bg-wiki.com/bg/Magic_Damage#MBB:_Magic_Burst_Bonus
    local multiplier = 1.0

    -- Gear and Atma will likely use the same mod
    multiplier = multiplier + (self:getMagicBurstBonusMod(caster) / 100)

    -- Cap at 1.4 for non-trait
    multiplier = math.min(multiplier, 1.4)

    -- Add the trait
    multiplier = multiplier + (caster:getMod(tpz.mod.MAG_BURST_BONUS_TRAIT) / 100)

    return multiplier
end

function tpz.calculators.MagicDamageCalc:getMagicBurstBonusMod(caster)
    return caster:getMod(tpz.mod.MAG_BURST_BONUS)
end

function tpz.calculators.MagicDamageCalc:getMABMDBMultiplier(caster, target, element)
    --- https://www.bg-wiki.com/bg/Magic_Damage#MAB.2FMDB:_Magic_Attack_Bonus_.2F_Magic_Defense_Bonus
    -- MAB comes in general and elemental specific forms (atmas)
    local MAB = 1 + (self:getMAB(caster, element) / 100)
    local MDB = 1 + (target:getMod(tpz.mod.MDEF) / 100)

    return MAB/MDB
end

function tpz.calculators.MagicDamageCalc:getMAB(caster, element)
    return (
        caster:getMod(tpz.mod.MATT)                             +
        caster:getMod(tpz.element.maps.to_matk[element]) +
        caster:getMerit(tpz.element.maps.to_blm_mab_merits[element])
    )
end

function tpz.calculators.MagicDamageCalc:getCumulativeMagicMultiplier(target, element)
    --- https://www.bg-wiki.com/bg/Category:Cumulative_Magic
    local multiplier = 1.0
    local effect     = target:getStatusEffect(tpz.effect.CUMULATIVE_MAGIC_BONUS, element)

    if effect ~= nil then
        multiplier = multiplier + (effect:getPower() * 0.05)
    end

    -- caps at 25%
    multiplier = math.min(multiplier, 1.25)

    return multiplier
end