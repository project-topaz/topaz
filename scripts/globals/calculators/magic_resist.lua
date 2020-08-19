--------------------------------------
---                                ---
--- Magic Resist Calculator (base) ---
---                                ---
--------------------------------------
require("scripts/globals/data/element")
require("scripts/globals/status")
require("scripts/globals/magicburst")
require("scripts/globals/utils")

tpz = tpz or {}
tpz.calculators = tpz.calculators or {}

tpz.calculators.MagicResistCalc = tpz.calculators.MagicResistCalc or {}
tpz.calculators.MagicResistCalc.__index = tpz.calculators.MagicResistCalc

function tpz.calculators.MagicResistCalc:create(args)
    local object = args or {}
    setmetatable(object, self)

    return object
end

function tpz.calculators.MagicResistCalc:getResistMultiplier(caster, target, element, sdt_multiplier)
    --- https://www.bg-wiki.com/bg/Magic_Damage#Resist
    local multiplier = 1.0

    -- Make sure target doesn't have magic shield, if they do, short circuit all this calculation
    if target:hasStatusEffect(tpz.effect.MAGIC_SHIELD, 0) == false then
        local magic_hit_rate = self:getMagicHitRate(caster, target, element)
        local resist_index   = self:calculateResistRateIndex(magic_hit_rate)
        local resist_rates   = self.resist_rates or {1/8, 1/4, 1/2, 1/1}

        -- This may seem convoluted but it supports custom resist rates
        multiplier = resist_rates[resist_index]

        -- Handle SDT (if the reduction is 50% or less, halve it)
        if element ~= tpz.element.NONE and sdt_multiplier <= 0.5 then
            multiplier = multiplier / 2
        end
    else
        multiplier = 0.0
    end

    return multiplier
end

function tpz.calculators.MagicResistCalc:getMagicHitRate(caster, target, element)
    --- https://www.bg-wiki.com/bg/Magic_Hit_Rate
    -- Old version had a level correction involved, seems to be nothing "concrete" about that on BG-Wiki,
    -- so, I'm leaving it out... for now
    local dMAcc          = self:getSpellMagicAcc(caster, target, element) - self:getTargetMagicEva(target, element)
    local magic_hit_rate = 0.50

    if dMAcc < 0 then
        magic_hit_rate = magic_hit_rate + (math.floor(dMAcc / 2) / 100)
    else
        magic_hit_rate = magic_hit_rate + (dMAcc / 100 )
    end

    -- TODO: level correction? needs research
    -- BG-Wiki Comment is that it is like hitrate, which is between 20% and 95%... so we'll adopt that here
    return utils.clamp(magic_hit_rate, 0.20, 0.95)
end

function tpz.calculators.MagicResistCalc:calculateResistRateIndex(magic_hit_rate)
    local one_eighth   = (1-magic_hit_rate)^3
    local one_fourth   = (1-magic_hit_rate)^2
    local one_half     = (1-magic_hit_rate)
    local resist_roll  = math.random() + (self.base_resist or 0)
    local resist_index = 1

    if resist_roll <= one_eighth then
        resist_index = 1
    elseif resist_roll <= one_fourth then
        resist_index = 2
    elseif resist_roll <= one_half then
        resist_index = 3
    else
        resist_index = 4
    end

    return resist_index
end

function tpz.calculators.MagicResistCalc:getSpellMagicAcc(caster, target, element)
    local spell_mAcc = self:getCasterMagicAcc(caster, target, element) -- base mAcc

    -- mAcc from Merits
    spell_mAcc = spell_mAcc + self:getAccFromMerits(caster, element)

    -- mAcc from Abilities
    spell_mAcc = spell_mAcc + self:getAccFromStatus(caster)

    -- mAcc from Magic Burst
    spell_mAcc = spell_mAcc + self:getAccFromMagicBurst(target, element)

    -- mAcc from Weather
    spell_mAcc = spell_mAcc + self:getAccFromWeather(caster, element)

    -- mAcc from MACC Affinity
    spell_mAcc = spell_mAcc + self:getAccFromAffinity(caster, element)

    -- mAcc from Food
    spell_mAcc = spell_mAcc + self:getAccFromFood(caster, spell_mAcc)

    return spell_mAcc
end

function tpz.calculators.MagicResistCalc:getCasterMagicAcc(caster, target, element)
    --- This varies from spell to spell
    --- Elemental Magic? Ninjutsu? Blue Magic? Weaponskill? dStat? etc
    local mAcc = 0

    return mAcc
end

function tpz.calculators.MagicResistCalc:getMAccFromDStat(caster_stat, target_stat)
    -- As an example, this article from INT, but is same for MND (white magic), AGI(corsair),  etc
    -- https://www.bg-wiki.com/bg/Intelligence
    -- dInt test, ie, macc from INT
    local mAcc = 0

    if caster_stat - target_stat > 10 then
        -- + 1.0 mAcc per stat until dStat > 10
        -- That amount is targetInt + 10
        local amount = target_stat + 10
        mAcc = mAcc + amount

        -- + 0.5 mAcc per the remaining Int of the caster
        -- That amount is casterStat - amount
        mAcc = mAcc + math.floor((caster_stat - amount) / 2)
    else
        -- 1.0 mAcc per Stat
        mAcc = mAcc + caster_stat
    end

    return mAcc
end

function tpz.calculators.MagicResistCalc:getAccFromMerits(caster, element)
    local merit_mAcc = 0

    -- Deal with Red Mage Group 2 Magic Accuracy Merits
    --- https://www.bg-wiki.com/bg/Red_Mage#Merits
    merit_mAcc = merit_mAcc + caster:getMerit(tpz.merit.MAGIC_ACCURACY)

    -- Deal with REd Mage Group 1 Element Specific Accuracy Merits
    --- https://www.bg-wiki.com/bg/Red_Mage#Merits
    merit_mAcc = merit_mAcc + caster:getMerit(tpz.element.maps.to_rdm_acc_merits[element])

    return merit_mAcc
end

function tpz.calculators.MagicResistCalc:getAccFromAffinity(caster, element)
    -- No solid reference for this except for the dated post below ...
    --- https://ffxiclopedia.fandom.com/wiki/Magic_Accuracy
    -- It was 2011 when the parts we care about were last edited.
    local affinity_lvl  = caster:getMod(tpz.element.maps.to_affinity_acc[element])
    local affinity_mAcc = 0

    if affinity_lvl ~= 0 then
        affinity_mAcc = 10 + (affinity_lvl * 10)
    end

    return affinity_mAcc
end

function tpz.calculators.MagicResistCalc:getAccFromStatus(caster)
    local status_mAcc = 0

    --- https://www.bg-wiki.com/bg/Focalization
    if caster:hasStatusEffect(tpz.effect.FOCALIZATION) then
        status_mAcc = status_mAcc + caster:getMod(tpz.mod.FOCALIZATION_AMOUNT)
    end

    return status_mAcc
end

function tpz.calculators.MagicResistCalc:getAccFromWeather(caster, element)
    local weather_mAcc = 0

    --- https://www.bg-wiki.com/bg/Klimaform
    if element ~= tpz.element.NONE and caster:hasStatusEffect(tpz.effect.KLIMAFORM) then
        if element == tpz.weather.maps.to_element[caster:getWeather()] then
            weather_mAcc = 15
        end
    end

    return weather_mAcc
end

function tpz.calculators.MagicResistCalc:getAccFromMagicBurst(target, element)
    local burst_mAcc = 0

    local skillchainTier, _ = FormMagicBurst(element, target)
    if skillchainTier > 0 then
        -- Not sure where the +25 comes from? Currently taking from magic.lua
        burst_mAcc = 25
    end

    return burst_mAcc
end

function tpz.calculators.MagicResistCalc:getAccFromFood(caster, mAcc)
    local mAcc_from_food = utils.clamp(
        math.floor(mAcc * caster:getMod(tpz.mod.FOOD_MACCP) / 100), -- input value
        0,                                                          -- min value
        caster:getMod(tpz.mod.FOOD_MACC_CAP)                        -- max value
    )

    return mAcc_from_food
end

function tpz.calculators.MagicResistCalc:getTargetMagicEva(target, element)
    --- https://www.bg-wiki.com/bg/Magic_Evasion
    return target:getMod(tpz.mod.MEVA) + target:getMod(tpz.element.maps.to_mres[element])
end
