require("scripts/globals/spells/spells")
require("scripts/test_suite/test_libs/vanadiel")
local test      = require("scripts/test_suite/tests/base_test")
local entityObj = require("scripts/test_suite/test_libs/entity")
local spellObj  = require("scripts/test_suite/test_libs/spell")


------------------------------
--- Test Environment Setup ---
------------------------------
local magicTest = test:new("Magic Basics")

function magicTest:setup()
    -- Get us some fresh stuff!
    self.playerObj = entityObj:new()
    self.targetObj = entityObj:new()
    self.spellObj  = spellObj:new()

    self.blizThunk = self.blizThunk or function() return self.blizzardIV:castSpell(self.spellObj, self.playerObj, self.targetObj); end

    -- Configure out fresh stuff
    magicTest.playerObj.skill[tpz.skill.ELEMENTAL_MAGIC] = 279
    magicTest.spellObj.element                           = tpz.magic.element.ICE
end

-- Setup the Lua Spell
magicTest.blizzardIV  = tpz.magic.spells[tpz.magic.spellIDs.BLIZZARD_IV]
magicTest.blizzagaIII = tpz.magic.spells[tpz.magic.spellIDs.BLIZZAGA_III]
magicTest.freezeII    = tpz.magic.spells[tpz.magic.spellIDs.FREEZE_II]
magicTest.blizzaja    = tpz.magic.spells[tpz.magic.spellIDs.BLIZZAJA]
magicTest.cryohelix   = tpz.magic.spells[tpz.magic.spellIDs.CRYOHELIX]







--------------------
--- Test Helpers ---
--------------------

function magicTest:assertValidNukeDamage(damage, name)
    name = name or "unset"
    self:assert(type(damage) == "number", name .. " is not a number.")
    self:assert(damage >= 0, name .. " is negative.")
end


function magicTest:nukeAndValidate_unresisted(times, thunk, fail_name)
    local unresisted = -1

    for i = 1, times, 1 do
        local dmg = thunk()
        if dmg > unresisted then
            unresisted = dmg
        end
    end

    self:assertValidNukeDamage(unresisted, fail_name)
    return unresisted
end

function magicTest:nukeAndValidate_resisted(times, thunk, fail_name)
    local resisted = 99999999

    for i = 1, times, 1 do
        local dmg = thunk()
        if dmg < resisted then
            resisted = dmg
        end
    end

    self:assertValidNukeDamage(resisted, fail_name)
    return resisted
end

-- Define it out here because we will use it more than once
local element_to_nuke_wall_test_map = {
    [tpz.magic.element.FIRE]      = tpz.effect.NUKEWALL_FIRE,
    [tpz.magic.element.EARTH]     = tpz.effect.NUKEWALL_EARTH,
    [tpz.magic.element.WATER]     = tpz.effect.NUKEWALL_WATER,
    [tpz.magic.element.WIND]      = tpz.effect.NUKEWALL_WIND,
    [tpz.magic.element.ICE]       = tpz.effect.NUKEWALL_ICE,
    [tpz.magic.element.LIGHTNING] = tpz.effect.NUKEWALL_THUNDER,
    [tpz.magic.element.LIGHT]     = tpz.effect.NUKEWALL_LIGHT,
    [tpz.magic.element.DARK]      = tpz.effect.NUKEWALL_DARK,
}

-- We can't use the original map, or it will just validate errors that it might contain
local element_to_pot_test_map = {
    [tpz.magic.element.FIRE]      = tpz.mod.FIRE_MAGIC_POTENCY,
    [tpz.magic.element.EARTH]     = tpz.mod.EARTH_MAGIC_POTENCY,
    [tpz.magic.element.WATER]     = tpz.mod.WATER_MAGIC_POTENCY,
    [tpz.magic.element.WIND]      = tpz.mod.WIND_MAGIC_POTENCY,
    [tpz.magic.element.ICE]       = tpz.mod.ICE_MAGIC_POTENCY,
    [tpz.magic.element.LIGHTNING] = tpz.mod.THUNDER_MAGIC_POTENCY,
    [tpz.magic.element.LIGHT]     = tpz.mod.LIGHT_MAGIC_POTENCY,
    [tpz.magic.element.DARK]      = tpz.mod.DARK_MAGIC_POTENCY,
}

-- We can't use the original map, or it will just validate errors that it might contain
local element_to_affinity_dmg_test_map = {
    [tpz.magic.element.FIRE]      = tpz.mod.FIRE_AFFINITY_DMG,
    [tpz.magic.element.EARTH]     = tpz.mod.EARTH_AFFINITY_DMG,
    [tpz.magic.element.WATER]     = tpz.mod.WATER_AFFINITY_DMG,
    [tpz.magic.element.WIND]      = tpz.mod.WIND_AFFINITY_DMG,
    [tpz.magic.element.ICE]       = tpz.mod.ICE_AFFINITY_DMG,
    [tpz.magic.element.LIGHTNING] = tpz.mod.THUNDER_AFFINITY_DMG,
    [tpz.magic.element.LIGHT]     = tpz.mod.LIGHT_AFFINITY_DMG,
    [tpz.magic.element.DARK]      = tpz.mod.DARK_AFFINITY_DMG,
}

local element_to_day_test_map = {
    [tpz.magic.element.FIRE]      = tpz.day.FIRESDAY,
    [tpz.magic.element.EARTH]     = tpz.day.EARTHSDAY,
    [tpz.magic.element.WATER]     = tpz.day.WATERSDAY,
    [tpz.magic.element.WIND]      = tpz.day.WINDSDAY,
    [tpz.magic.element.ICE]       = tpz.day.ICEDAY,
    [tpz.magic.element.LIGHTNING] = tpz.day.LIGHTNINGDAY,
    [tpz.magic.element.LIGHT]     = tpz.day.LIGHTSDAY,
    [tpz.magic.element.DARK]      = tpz.day.DARKSDAY,
}

local element_to_weather_test_map = {
    [tpz.magic.element.FIRE]      = {tpz.weather.HOT_SPELL, tpz.weather.HEAT_WAVE},
    [tpz.magic.element.EARTH]     = {tpz.weather.DUST_STORM, tpz.weather.SAND_STORM},
    [tpz.magic.element.WATER]     = {tpz.weather.RAIN, tpz.weather.SQUALL},
    [tpz.magic.element.WIND]      = {tpz.weather.WIND, tpz.weather.GALES},
    [tpz.magic.element.ICE]       = {tpz.weather.SNOW, tpz.weather.BLIZZARDS},
    [tpz.magic.element.LIGHTNING] = {tpz.weather.THUNDER, tpz.weather.THUNDERSTORMS},
    [tpz.magic.element.LIGHT]     = {tpz.weather.AURORAS, tpz.weather.STELLAR_GLARE},
    [tpz.magic.element.DARK]      = {tpz.weather.GLOOM, tpz.weather.DARKNESS},
}

local element_to_sdt_test_map = {
    [tpz.magic.element.FIRE]      = tpz.mod.FIRESDT,
    [tpz.magic.element.EARTH]     = tpz.mod.EARTHSDT,
    [tpz.magic.element.WATER]     = tpz.mod.WATERSDT,
    [tpz.magic.element.WIND]      = tpz.mod.WINDSDT,
    [tpz.magic.element.ICE]       = tpz.mod.ICESDT,
    [tpz.magic.element.LIGHTNING] = tpz.mod.THUNDERSDT,
    [tpz.magic.element.LIGHT]     = tpz.mod.LIGHTSDT,
    [tpz.magic.element.DARK]      = tpz.mod.DARKSDT,
}

local element_to_dayweather_bonus_test_map = {
    [tpz.magic.element.FIRE]    = tpz.mod.FORCE_FIRE_DWBONUS,
    [tpz.magic.element.EARTH]   = tpz.mod.FORCE_EARTH_DWBONUS,
    [tpz.magic.element.WATER]   = tpz.mod.FORCE_WATER_DWBONUS,
    [tpz.magic.element.WIND]    = tpz.mod.FORCE_WIND_DWBONUS,
    [tpz.magic.element.ICE]     = tpz.mod.FORCE_ICE_DWBONUS,
    [tpz.magic.element.THUNDER] = tpz.mod.FORCE_LIGHTNING_DWBONUS,
    [tpz.magic.element.LIGHT]   = tpz.mod.FORCE_LIGHT_DWBONUS,
    [tpz.magic.element.DARK]    = tpz.mod.FORCE_DARK_DWBONUS,
}


local element_to_ascendant_element_test_map = {
    [tpz.magic.element.FIRE]      = tpz.magic.element.ICE,
    [tpz.magic.element.EARTH]     = tpz.magic.element.LIGHTNING,
    [tpz.magic.element.WATER]     = tpz.magic.element.FIRE,
    [tpz.magic.element.WIND]      = tpz.magic.element.EARTH,
    [tpz.magic.element.ICE]       = tpz.magic.element.WIND,
    [tpz.magic.element.LIGHTNING] = tpz.magic.element.WATER,
    [tpz.magic.element.LIGHT]     = tpz.magic.element.DARK,
    [tpz.magic.element.DARK]      = tpz.magic.element.LIGHT,
}

local element_to_descendant_element_test_map = {
    [tpz.magic.element.ICE]       = tpz.magic.element.FIRE,
    [tpz.magic.element.LIGHTNING] = tpz.magic.element.EARTH,
    [tpz.magic.element.FIRE]      = tpz.magic.element.WATER,
    [tpz.magic.element.EARTH]     = tpz.magic.element.WIND,
    [tpz.magic.element.WIND]      = tpz.magic.element.ICE,
    [tpz.magic.element.WATER]     = tpz.magic.element.LIGHTNING,
    [tpz.magic.element.LIGHT]     = tpz.magic.element.DARK,
    [tpz.magic.element.DARK]      = tpz.magic.element.LIGHT,
}

local function removeNukeWall(target, element)
    target:delStatusEffect(element_to_nuke_wall_test_map[element])
end












------------------------
--- Begin Tests List ---
------------------------
magicTest.tests = {

    ----------------------------------------------------
    --- Testing Increasing dINT and MAGIC_DAMAGE mod ---
    ----------------------------------------------------

    [1] = function(self)
        self.playerObj:resetStats({[tpz.mod.INT] = 10})
        local low_dINT   = self:nukeAndValidate_unresisted(6, self.blizThunk, "low_dINT")

        self.playerObj.stats[tpz.mod.INT] = 300
        local high_dINT = self:nukeAndValidate_unresisted(6, self.blizThunk, "high_dINT")

        self.playerObj.mods[tpz.mod.MAGIC_DAMAGE] = 50
        local high_dINT_DMG_MOD = self:nukeAndValidate_unresisted(6, self.blizThunk, "high_dINT_DMG_MOD")

        --- Test: low_dINT < high_dINT < high_dINT_DMG_MOD
        self:assert((low_dINT < high_dINT) and (high_dINT < high_dINT_DMG_MOD), "Base Damage not working properly.")
    end,

    --------------------------------------
    --- Testing Multi Target Reduction ---
    --------------------------------------

    [2] = function(self)
        local gaThunk = function() return self.blizzagaIII:castSpell(self.spellObj, self.playerObj, self.targetObj); end
        local non_aoe = self:nukeAndValidate_unresisted(6, gaThunk, "NON-AOE Nuke")

        self.spellObj.numOfTargets = 3
        local three_aoe = self:nukeAndValidate_unresisted(6, gaThunk, "3 AOE Nuke")

        self.spellObj.numOfTargets = 10
        local ten_aoe = self:nukeAndValidate_unresisted(6, gaThunk, "10 AOE Nuke")

        --- Test: ten_aoe < three_aoe < non_aoe
        self:assert((non_aoe > three_aoe) and (three_aoe >ten_aoe), "Multi Target Reduction is not working.")
    end,

    ------------------------------------
    --- Testing Staff / Potency Term ---
    ------------------------------------

    [3] = function(self)
        -- Step 1: Get and validate a baseline
        local no_staff_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "No Staff Damage")

        local strong_staff_dmg, weak_staff_dmg
        for element, magic_potency_id in pairs(element_to_pot_test_map) do
            -- Set the spellObj to be the element we want (ie, change blizzard to fire for fire_potency, etc)
            self.spellObj.element = element

            -- Do a strong staff nuke
            self.playerObj.mods[magic_potency_id] = 15
            strong_staff_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Strong Staff Damage " .. element)

            -- Do a weak staff nuke
            self.playerObj.mods[magic_potency_id] = -15
            weak_staff_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Weak Staff Damage " .. element)

            --- Test: weak_staff_dmg < no_staff_dmg < aquilo_staff_dmg
            self:assert(
                    (weak_staff_dmg < no_staff_dmg) and (no_staff_dmg < strong_staff_dmg), -- Test Condition
                    "Staff / Potency " .. element .. " is not working."                    -- Fail Message
            )
        end
    end,

    --------------------------
    --- Test Affinity Term ---
    --------------------------

    [4] = function(self)
        local no_affinity_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "No Affinity DMG")

        local affinity_dmg
        for element, affinity_mod in pairs(element_to_affinity_dmg_test_map) do
            -- Set the spellObj to be the element we want (ie, change blizzardIV to fire for fire_affinity, etc)
            self.spellObj.element = element

            -- Do a strong staff nuke
            self.playerObj.mods[affinity_mod] = 3
            affinity_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Affinity Damage " .. element)

            --- Test: no_affinity_dmg < affinity_dmg
            self:assert(no_affinity_dmg < affinity_dmg, "Affinity Damage " .. element .. " is not working.")

            -- Reset
            self.playerObj.mods[affinity_mod] = 0
        end
    end,

    -------------------------------------------
    --- Test the Specific Damage Taken Term ---
    -------------------------------------------

    [5] = function(self)
        local neutral_sdt_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Neutral Sdt Dmg")

        for element, sdt_id in pairs(element_to_sdt_test_map) do
            self.spellObj.element = element

            self.targetObj.mods[sdt_id] = 875
            local strong_vs_sdt_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Strong Vs Sdt DMG")

            self.targetObj.mods[sdt_id] = 1250
            local weak_vs_sdt_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Weak Vs Sdt DMG")

            --- Test: strong_vs_sdt_dmg < neutral_vs_sdt_dmg < weak_vs_sdt_dmg
            self:assert(
                    (strong_vs_sdt_dmg < neutral_sdt_dmg) and (neutral_sdt_dmg < weak_vs_sdt_dmg),
                    "Specific Damage Taken is not working."
            )

            -- Reset
            self.targetObj.mods[sdt_id] = 1000
        end
    end,

    ----------------------------
    --- Test the Resist Term ---
    --------------------------------------------------------------------
    --- General Test                                                 ---
    --- Following Tests are just making sure we do not produce zeros ---
    --- Test MACC sources                                            ---
    --- 1. MOD_MACC                                                  ---
    --- 2. MOD_ELEACC                                                ---
    --- 3. FOOD                                                      ---
    --- 4. Merits (BLM/RDM(x2))                                      ---
    --- 5. Affinity                                                  ---
    --- 6. Focalization                                              ---
    --- 7. Weather                                                   ---
    --- 8. Magic Burst                                               ---
    ---                                                              ---
    --- Test MEVA sources                                            ---
    --- 1. MOD_EVA                                                   ---
    --- 2. ELERES                                                    ---
    --------------------------------------------------------------------

    [6] = function(self)
        --- General Test
        -- Grab an unresisted nuke
        local unresisted_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Unresisted Dmg")

        -- Basically guarantee a resist
        self.targetObj.mods[tpz.mod.MEVA] = 2000

        -- Nuke!
        local resisted_dmg = self:nukeAndValidate_resisted(6, self.blizThunk, "Resisted Dmg")

        -- What about Magic Shield?
        self.targetObj:addStatusEffect(tpz.effect.MAGIC_SHIELD, 0, 0, 0)

        local magic_shield_dmg = self.blizzardIV:castSpell(self.spellObj, self.playerObj, self.targetObj)

        -- Validate
        self:assertValidNukeDamage(magic_shield_dmg, "Magic Shield Dmg")

        --- Test: magic_shield_dmg == 0
        --- Test: magic_shield_dmg < resisted_dmg < unresisted_dmg
        self:assert(magic_shield_dmg == 0, "Magic Shield damage is not working.")
        self:assert((magic_shield_dmg <= resisted_dmg) and (resisted_dmg < unresisted_dmg), "Resists are not working.")

        self.targetObj.mods[tpz.mod.MEVA] = 0
        self.targetObj:delStatusEffect(tpz.effect.MAGIC_SHIELD)


        --- MACC and MEVA Sources Test
        self.playerObj.mods[tpz.mod.MACC]                         = 20 -- Items
        self.playerObj.mods[tpz.mod.FOOD_MACCP]                   = 5  -- Food %
        self.playerObj.mods[tpz.mod.FOOD_MACC_CAP]                = 20 -- Food Cap
        self.playerObj.mods[tpz.mod.FIRE_AFFINITY_ACC]            = 3  -- Affinities
        self.playerObj.mods[tpz.mod.EARTH_AFFINITY_ACC]           = 3
        self.playerObj.mods[tpz.mod.WATER_AFFINITY_ACC]           = 3
        self.playerObj.mods[tpz.mod.WIND_AFFINITY_ACC]            = 3
        self.playerObj.mods[tpz.mod.ICE_AFFINITY_ACC]             = 3
        self.playerObj.mods[tpz.mod.THUNDER_AFFINITY_ACC]         = 3
        self.playerObj.mods[tpz.mod.FIREACC]                      = 10
        self.playerObj.mods[tpz.mod.EARTHACC]                     = 10
        self.playerObj.mods[tpz.mod.WATERACC]                     = 10
        self.playerObj.mods[tpz.mod.WINDACC]                      = 10
        self.playerObj.mods[tpz.mod.ICEACC]                       = 10
        self.playerObj.mods[tpz.mod.THUNDERACC]                   = 10
        self.playerObj.mods[tpz.mod.LIGHTACC]                     = 10
        self.playerObj.mods[tpz.mod.DARKACC]                      = 10
        self.playerObj.mods[tpz.mod.FOCALIZATION_AMOUNT]          = 20
        self.playerObj.merits[tpz.merit.MAGIC_ACCURACY]           = 25 -- RDM merit Group 2
        self.playerObj.merits[tpz.merit.FIRE_MAGIC_ACCURACY]      = 10 -- RDM merits Group 1
        self.playerObj.merits[tpz.merit.EARTH_MAGIC_ACCURACY]     = 10
        self.playerObj.merits[tpz.merit.WATER_MAGIC_ACCURACY]     = 10
        self.playerObj.merits[tpz.merit.WIND_MAGIC_ACCURACY]      = 10
        self.playerObj.merits[tpz.merit.LIGHTNING_MAGIC_ACCURACY] = 10
        self.playerObj.merits[tpz.merit.ICE_MAGIC_ACCURACY]       = 10
        self.playerObj.merits[tpz.merit.ELEMENTAL_MAGIC_ACCURACY] = 25 -- BLM Merit
        self.playerObj:addStatusEffect(tpz.effect.FOCALIZATION, 1, 0, 60)
        self.playerObj:addStatusEffect(tpz.effect.KLIMAFORM, 1, 0, 60)

        -- Evasion Sources
        self.targetObj.mods[tpz.mod.MEVA]       = 10
        self.targetObj.mods[tpz.mod.FIRERES]    = 20
        self.targetObj.mods[tpz.mod.EARTHRES]   = 20
        self.targetObj.mods[tpz.mod.WATERRES]   = 20
        self.targetObj.mods[tpz.mod.WINDRES]    = 20
        self.targetObj.mods[tpz.mod.THUNDERRES] = 20
        self.targetObj.mods[tpz.mod.ICERES]     = 20
        self.targetObj.mods[tpz.mod.LIGHTRES]   = 20
        self.targetObj.mods[tpz.mod.DARKRES]    = 20

        for element = tpz.magic.element.FIRE, tpz.magic.element.DARK, 1 do
            self.spellObj.element = element
            -- Setup for Magic Burst
            self.targetObj:addStatusEffect(tpz.effect.SKILLCHAIN, element, 0, 5, 0, 0, 3)
            vanadiel.day = element_to_day_test_map[element]

            for _, weather in pairs(element_to_weather_test_map[element]) do
                self.playerObj.weather = weather

                local successful_nuke = self.blizzardIV:castSpell(self.spellObj, self.playerObj, self.targetObj)

                -- Validate
                self:assertValidNukeDamage(successful_nuke, "MACCnMEVA (element/weather) " .. element .. "/" .. weather)

                --- Test: In general... this is a strong nuke and we have A LOT of macc, should do over 200...
                self:assert(successful_nuke > 200, "Successful Resist Nuke is not doing as much as it should.")
            end

            -- Remove the Magic Burst
            self.targetObj:delStatusEffect(tpz.effect.SKILLCHAIN)
        end
    end,
    [7] = function(self)
        -------------------------------------------------
        --- Test the Nuke Wall Term and addNukeWall() ---
        -------------------------------------------------
        -- Make the target an NM
        self.targetObj.NM = true
        local noWallBlizThunk  = function()
            removeNukeWall(self.targetObj, self.spellObj:getElement())
            return self.blizzardIV:castSpell(self.spellObj, self.playerObj, self.targetObj)
        end

        -- Test for each element
        for element, nukewall_effect_id in pairs(element_to_nuke_wall_test_map) do
            -- Set the spellObj to be the element we want (ie, change blizzard to fire for nukewall_fire, etc)
            self.spellObj.element = element
            local no_nuke_wall_dmg = self:nukeAndValidate_unresisted(6, noWallBlizThunk, "No Nuke Wall Damage " .. element)

            -- noWallBlizThunk removes the nukewall (if it is there) before nuking.
            -- ie, it should still leave a nukewall effect on the mob after it nukes
            self:assert(self.targetObj:hasStatusEffect(nukewall_effect_id), "Nuke Wall " .. element .. " is not being applied.")

            local nuke_wall_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Nuke Wall Damage " .. element)

            --- Test: nuke_wall_dmg < no_nuke_wall_dmg
            self:assert(nuke_wall_dmg < no_nuke_wall_dmg, "Nuke Wall is not working.")

            self.targetObj:delStatusEffect(nukewall_effect_id)
        end
    end,

    ------------------------------
    --- Day/Weather Bonus Term ---
    ------------------------------

    [8] = function(self)
        -- Eliminate these for the first phase of testing
        self.blizzardIV.spell_params.day_bonus_proc_rate     = 0
        self.blizzardIV.spell_params.weather_bonus_proc_rate = 0
        vanadiel.day                            = tpz.day.ICEDAY

        -- Test mod DAY_NUKE_BONUS

        local no_bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "No Bonus DMG")

        -- Add Sorcerer's Tonban (but a suped up 10% version!)
        self.playerObj.mods[tpz.mod.DAY_NUKE_BONUS] = 10

        local bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Day Bonus Mod")

        --- Test: no_bonus_dmg < bonus_dmg
        self:assert(no_bonus_dmg < bonus_dmg, "Day Nuke Bonus Mod is not working.")

        -- Remove the DAY_NUKE_BONUS mod for subsequent testing
        self.playerObj.mods[tpz.mod.DAY_NUKE_BONUS] = 0

        self.blizzardIV.spell_params.day_bonus_proc_rate = 1.0 -- guarantee we get a proc
        -- Day Testing (Proc Rate)
        for element, day in pairs(element_to_day_test_map) do
            -- Configure Environment
            self.spellObj.element = element
            vanadiel.day          = day

            local day_bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Day Proc Bonus DMG")

            -- ascendant element testing
            local ascendant_element = element_to_ascendant_element_test_map[element]
            vanadiel.day = element_to_day_test_map[ascendant_element]

            local day_penalty_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Day Proc Penalty DMG")

            --- Test: day_penalty_dmg < no_bonus_dmg < day_bonus_dmg
            self:assert(
                    (day_penalty_dmg < no_bonus_dmg) and (no_bonus_dmg < day_bonus_dmg),
                    "Day Proc Bonus DMG " .. vanadiel.day .. " is not working."
            )
        end

        -- Day Testing (Obi)
        self.blizzardIV.spell_params.day_bonus_proc_rate = 0.0 -- disable procs that would yield false positives
        for element, day in pairs(element_to_day_test_map) do
            -- Configure Environment
            self.playerObj.mods[element_to_dayweather_bonus_test_map[element]] = 1
            self.spellObj.element = element
            vanadiel.day          = day

            local forced_bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Forced Day Bonus DMG")

            -- ascendant element testing
            local ascendant_element = element_to_ascendant_element_test_map[element]
            vanadiel.day = element_to_day_test_map[ascendant_element]

            local day_penalty_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Forced Day Penalty DMG")

            --- Test: day_penalty_dmg < no_bonus_dmg < forced_bonus_dmg
            self:assert(
                    (day_penalty_dmg < no_bonus_dmg) and (no_bonus_dmg < forced_bonus_dmg),
                    "Obis " .. vanadiel.day .. " are not working for day procs."
            )
            self.playerObj.mods[element_to_dayweather_bonus_test_map[element]] = 0
        end

        -- Weather Testing (Proc Rate)
        self.blizzardIV.spell_params.weather_bonus_proc_rate = 1.0 -- guarantee a proc
        vanadiel.day = tpz.day.DARKSDAY+1 -- take day right out of the equation
        for element, weather_arr in pairs(element_to_weather_test_map) do
            self.spellObj.element = element
            -- Single Weather Proc
            self.playerObj.weather = weather_arr[1]

            -- Bonus Element
            local single_weather_bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Single Weather Bonus DMG")

            -- Penalty Element
            self.spellObj.element = element_to_ascendant_element_test_map[element]
            local single_weather_penalty_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Single Weather Penalty DMG")
            self.spellObj.element = element

            -- Double Weather Proc
            self.playerObj.weather = weather_arr[2]

            --Bonus Element and Iridescant
            local double_weather_bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Double Weather Bonus DMG")

            self.playerObj.mods[tpz.mod.IRIDESCENCE] = 1
            local double_with_iridescence_bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Double Weather with Iridescence Bonus DMG")
            self.playerObj.mods[tpz.mod.IRIDESCENCE] = 0

            -- Penalty Element
            self.spellObj.element = element_to_ascendant_element_test_map[element]
            local double_weather_penalty_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Double Weather Penalty DMG")

            --- Test: double_weather_penalty_dmg < single_weather_penalty_dmg < no_bonus_dmg < single_weather_bonus_dmg <
            ---       double_weather_bonus_dmg < double_with_iridescence_bonus_dmg
            self:assert(
                    (double_weather_penalty_dmg < single_weather_penalty_dmg) and (single_weather_penalty_dmg < no_bonus_dmg) and
                            (no_bonus_dmg < single_weather_bonus_dmg) and (single_weather_bonus_dmg < double_weather_bonus_dmg) and
                            (double_weather_bonus_dmg < double_with_iridescence_bonus_dmg),
                    "Weather PROC bonuses/penalties are not working."
            )
        end

        -- Weather Testing (Obis)
        self.blizzardIV.spell_params.weather_bonus_proc_rate = 0.0 -- disable weather procs
        --element_to_weather_test_map
        for element, weather_arr in pairs({[tpz.magic.element.LIGHT] = {tpz.weather.AURORAS, tpz.weather.STELLAR_GLARE}}) do
            self.spellObj.element = element
            self.playerObj.mods[element_to_dayweather_bonus_test_map[element]] = 1

            -- Single Weather Proc
            self.playerObj.weather = weather_arr[1]

            -- Bonus Element
            local single_weather_bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Forced Single Weather Bonus DMG")

            -- Penalty Element
            self.spellObj.element = element_to_ascendant_element_test_map[element]
            self.playerObj.mods[element_to_dayweather_bonus_test_map[self.spellObj.element]] = 1
            local single_weather_penalty_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Forced Single Weather Penalty DMG")
            self.playerObj.mods[element_to_dayweather_bonus_test_map[self.spellObj.element]] = 0
            self.spellObj.element = element

            -- Double Weather Proc
            self.playerObj.weather = weather_arr[2]

            --Bonus Element and Iridescant
            local double_weather_bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Forced Double Weather Bonus DMG")

            self.playerObj.mods[tpz.mod.IRIDESCENCE] = 1
            local double_with_iridescence_bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Forced Double Weather with Iridescence Bonus DMG")
            self.playerObj.mods[tpz.mod.IRIDESCENCE] = 0

            -- Penalty Element
            self.spellObj.element = element_to_ascendant_element_test_map[element]
            self.playerObj.mods[element_to_dayweather_bonus_test_map[self.spellObj.element]] = 1
            local double_weather_penalty_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Forced Double Weather Penalty DMG")


            --- Test: double_weather_penalty_dmg < single_weather_penalty_dmg < no_bonus_dmg < single_weather_bonus_dmg <
            ---       double_weather_bonus_dmg < double_with_iridescence_bonus_dmg
            self:assert(
                    (double_weather_penalty_dmg < single_weather_penalty_dmg) and (single_weather_penalty_dmg < no_bonus_dmg) and
                            (no_bonus_dmg < single_weather_bonus_dmg) and (single_weather_bonus_dmg < double_weather_bonus_dmg) and
                            (double_weather_bonus_dmg < double_with_iridescence_bonus_dmg),
                    "Weather Forced " .. element .. " bonuses/penalties are not working."
            )
            self.playerObj.mods[element_to_dayweather_bonus_test_map[element]] = 0
        end

        -- a little cleanup
        vanadiel.day = tpz.day.FIRESDAY
    end,

    ------------------------------------
    --- Test Magic Burst Damage Term ---
    ------------------------------------

    [9] = function(self)

        -- TODO: did not feel like looping through all the skillchains and elements, so we'll just do ice and darkness
        local baseline_burst_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Magic Burst Baseline DMG")

        -- Add a Two WS skillchain
        self.targetObj:addStatusEffectEx(tpz.effect.SKILLCHAIN, 0, SC_DARKNESS, 0, 5, 0, 2, 3)
        local two_ws_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Magic Burst Two WS DMG")

        -- Add a Three WS skillchain
        self.targetObj:addStatusEffectEx(tpz.effect.SKILLCHAIN, 0, SC_DARKNESS, 0, 5, 0, 3, 3)
        local three_ws_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Magic Burst Three WS DMG")

        --- Test: baseline_dmg < two_ws_dmg < three_ws_dmg
        self:assert((baseline_burst_dmg < two_ws_dmg) and (two_ws_dmg < three_ws_dmg), "Magic Burst Damage is not working.")

        ------------------------------------------------------
        --- Test Magic Burst Bonus Damage Term (continued) ---
        ------------------------------------------------------
        -- We will continue to use the two_ws_dmg from above

        -- Test for item bonuses
        self.playerObj.mods[tpz.mod.MAG_BURST_BONUS] = 40
        local item_burst_bonus_only_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Item Burst Bonus Only DMG")

        self.playerObj.mods[tpz.mod.MAG_BURST_BONUS] = 50 -- push over the limit, should not increase damage
        local item_burst_bonus_over_max_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Item Burst Over Bonus DMG")

        -- Test for trait
        self.playerObj.mods[tpz.mod.MAG_BURST_BONUS_TRAIT] = 13
        local item_and_trait_burst_bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Item and Trait DMG")


        --- Test: two_ws_dmg < (item_burst_bonus_only_dmg = item_burst_bonus_over_max_dmg) < item_and_trait_burst_bonus_dmg
        self:assert(
                (two_ws_dmg < item_burst_bonus_only_dmg) and (item_burst_bonus_only_dmg == item_burst_bonus_over_max_dmg) and
                        (item_burst_bonus_over_max_dmg < item_and_trait_burst_bonus_dmg),
                "Magic Burst Bonus Damage is not working."
        )
    end,

    -------------------------
    --- Test MAB/MDB Term ---
    -------------------------

    [10] = function(self)
        local mabmdb_baseline_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "MAB/MDB Baseline DMG")

        -- Add some MDB
        self.targetObj.mods[tpz.mod.MDEF] = 10
        local mdb_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "MDB DMG")

        -- Add some MAB
        self.playerObj.mods[tpz.mod.MATT] = 20
        local mab_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "MAB DMG")

        --- Test: mdb_dmg < mabmdb_baseline_dmg < mab_dmg
        self:assert((mdb_dmg < mabmdb_baseline_dmg) and (mabmdb_baseline_dmg < mab_dmg), "Magic Attack/Defense Bonus is not working.")
    end,

    -----------------------------------------------------------
    --- Skipping Magic DMG Taken as that's a C function.     ---
    --- I'd just be testing my fake magicdmgtaken function. ---
    -----------------------------------------------------------

    --------------------------------
    --- Test the Ebullience Term ---
    --------------------------------

    [11] = function(self)
        local eb_baseline_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Ebullience Baseline DMG")

        -- Add some Ebullience
        self.playerObj:addStatusEffect(tpz.effect.EBULLIENCE, 0, 0, 0)
        self.playerObj.mods[tpz.mod.EBULLIENCE_AMOUNT] = 30

        local eb_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Ebullience DMG")

        --- Test: eb_baseline_dmg < eb_dmg
        self:assert(eb_baseline_dmg < eb_dmg, "Ebullience is not working.")
    end,

    -----------------------------------
    --- Test Cumulative Damage Term ---
    -----------------------------------

    [12] = function(self)
        local clm_base_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Cumulative Base DMG")

        -- add some cumulative magic damage with our spells element
        self.targetObj:addStatusEffectEx(tpz.effect.CUMULATIVE_MAGIC_BONUS, 0, 2, 0, 60, self.spellObj.element )
        local clm_bonus_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Cumulative Bonus DMG")

        --- Test: clm_base_dmg < clm_bonus_dmg
        self:assert(clm_base_dmg < clm_bonus_dmg, "Cumulative Damage is not working.")
    end,

    ---------------------------
    --- Test Handle Phalanx ---
    ---------------------------

    [13] = function(self)
        local phalanx_base_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Phalanx Base DMG")

        -- Add some Phalanx to our target
        self.targetObj.mods[tpz.mod.PHALANX] = 20
        local phalanx_reduced_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Phalandx Reduced DMG")

        --- Test: phalanx_reduced_dmg < phalanx_base_dmg
        self:assert(phalanx_reduced_dmg < phalanx_base_dmg, "Phalanx is not working.")

    end,

    --------------------------------
    --- Test Stoneskin Reduction ---
    --------------------------------

    [14] = function(self)
        local stoneskin_base_dmg = self:nukeAndValidate_unresisted(6, self.blizThunk, "Stoneskin Base DMG")

        -- Add some Stoneskin to our target
        self.targetObj.mods[tpz.mod.STONESKIN] = 300

        -- Nuke and Validate separately
        local stoneskin_reduced_dmg = self.blizThunk() -- could get a resist but it -shouldn't- matter
        self:assertValidNukeDamage(stoneskin_reduced_dmg, "Stoneskin Reduced DMG")

        --- Test: stoneskin_reduced_dmg < stoneskin_base_dmg
        self:assert(stoneskin_reduced_dmg < stoneskin_base_dmg, "Stoneskin is not working.")
    end,

    ---------------------------
    --- Testing AMII Basics ---
    ---------------------------
    [15] = function(self)
        local freezeIIThunk = function() return self.freezeII:castSpell(self.spellObj, self.playerObj, self.targetObj); end

        for element, descendant_element in pairs(element_to_descendant_element_test_map) do
            self.spellObj.element = element
            self:nukeAndValidate_unresisted(1, freezeIIThunk, "AMII " .. element .. " DMG")

            --- Test: Target has NINJUTSU_ELE_DEBUFF (really think this should have its own...) with the descendant ele
            local effect = self.targetObj:getStatusEffect(tpz.effect.NINJUTSU_ELE_DEBUFF)

            self:assert( effect ~= nil, "AM Nukes not applying their Elemental Debuff.")
            self:assert( effect:getSubPower() == descendant_element, "AM Nuke adding the wrong Elemental Deuff.")
        end
    end,

    ------------------------
    --- Testing Blizzaja ---
    ------------------------
    [16] = function(self)
        local blizzajaThunk = function() return self.blizzaja:castSpell(self.spellObj, self.playerObj, self.targetObj); end
        self:nukeAndValidate_unresisted(1, blizzajaThunk, "First Blizzaja")

        --- Test if we got the buff and the strength is right
        local effect = self.targetObj:getStatusEffect(tpz.effect.CUMULATIVE_MAGIC_BONUS)

        self:assert(effect ~= nil, "Cumulative Bonus Damage is not being added.")
        self:assert(effect:getSubType() == self.spellObj.element, "Cumulative Bonus Damage bonus has the wrong element.")
        self:assert(effect:getPower() == 1, "Cumulative Bonus Damage has the wrong power.")


        -- Test accumulation
        self:nukeAndValidate_unresisted(1, blizzajaThunk, "Accumulating Blizzaja")
        effect = self.targetObj:getStatusEffect(tpz.effect.CUMULATIVE_MAGIC_BONUS)
        self:assert(effect:getPower() == 2, "Cumulative Bonus Damage not accumulating properly.")

        -- Test replacing with new element
        self.spellObj.element = tpz.magic.element.FIRE
        self:nukeAndValidate_unresisted(1, blizzajaThunk, "Replacing Blizzaja Nuke")
        effect = self.targetObj:getStatusEffect(tpz.effect.CUMULATIVE_MAGIC_BONUS)

        self:assert(effect ~= nil, "Cumulative Bonus Damage is not replacing properly.")
        self:assert(effect:getSubType() == self.spellObj.element, "Cumulative Bonus Damage bonus has the wrong element.")
        self:assert(effect:getPower() == 1, "Cumulative Bonus Damage has the wrong power.")
    end,

    -------------------------
    --- Test Helix Basics ---
    -------------------------
    [4] = function(self)
        local helixThunk = function() return self.cryohelix:castSpell(self.spellObj, self.playerObj, self.targetObj); end
        self:nukeAndValidate_unresisted(1, helixThunk)

        --- Did the Helix get added?
        self:assert(self.targetObj:hasStatusEffect(tpz.effect.HELIX), "Helix is not being added.")

    end,
}

return magicTest