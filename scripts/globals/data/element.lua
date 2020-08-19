---------------------------------
---                           ---
--- Element Data and Mappings ---
---                           ---
---------------------------------
require("scripts/globals/status")

tpz = tpz or {}

tpz.element = tpz.element or {
    NONE      = 0,
    FIRE      = 1,
    EARTH     = 2,
    WATER     = 3,
    WIND      = 4,
    ICE       = 5,
    LIGHTNING = 6,
    THUNDER   = 6,
    LIGHT     = 7,
    DARK      = 8,
}

tpz.element.maps = {
    to_potency = {
        [tpz.element.FIRE]    = tpz.mod.FIRE_MAGIC_POTENCY,
        [tpz.element.EARTH]   = tpz.mod.EARTH_MAGIC_POTENCY,
        [tpz.element.WATER]   = tpz.mod.WATER_MAGIC_POTENCY,
        [tpz.element.WIND]    = tpz.mod.WIND_MAGIC_POTENCY,
        [tpz.element.ICE]     = tpz.mod.ICE_MAGIC_POTENCY,
        [tpz.element.THUNDER] = tpz.mod.THUNDER_MAGIC_POTENCY,
        [tpz.element.LIGHT]   = tpz.mod.LIGHT_MAGIC_POTENCY,
        [tpz.element.DARK]    = tpz.mod.DARK_MAGIC_POTENCY,
    },

    to_ascendant_element = {
        [tpz.element.FIRE]      = tpz.element.ICE,
        [tpz.element.EARTH]     = tpz.element.LIGHTNING,
        [tpz.element.WATER]     = tpz.element.FIRE,
        [tpz.element.WIND]      = tpz.element.EARTH,
        [tpz.element.ICE]       = tpz.element.WIND,
        [tpz.element.LIGHTNING] = tpz.element.WATER,
        [tpz.element.LIGHT]     = tpz.element.DARK,
        [tpz.element.DARK]      = tpz.element.LIGHT,
    },

    to_descendant_element = {
        [tpz.element.ICE]       = tpz.element.FIRE,
        [tpz.element.LIGHTNING] = tpz.element.EARTH,
        [tpz.element.FIRE]      = tpz.element.WATER,
        [tpz.element.EARTH]     = tpz.element.WIND,
        [tpz.element.WIND]      = tpz.element.ICE,
        [tpz.element.WATER]     = tpz.element.LIGHTNING,
        [tpz.element.LIGHT]     = tpz.element.DARK,
        [tpz.element.DARK]      = tpz.element.LIGHT,
    },

    to_affinity_dmg = {
        [tpz.element.FIRE]    = tpz.mod.FIRE_AFFINITY_DMG,
        [tpz.element.EARTH]   = tpz.mod.EARTH_AFFINITY_DMG,
        [tpz.element.WATER]   = tpz.mod.WATER_AFFINITY_DMG,
        [tpz.element.WIND]    = tpz.mod.WIND_AFFINITY_DMG,
        [tpz.element.ICE]     = tpz.mod.ICE_AFFINITY_DMG,
        [tpz.element.THUNDER] = tpz.mod.THUNDER_AFFINITY_DMG,
        [tpz.element.LIGHT]   = tpz.mod.LIGHT_AFFINITY_DMG,
        [tpz.element.DARK]    = tpz.mod.DARK_AFFINITY_DMG,
    },

    to_affinity_acc = {
        [tpz.element.FIRE]    = tpz.mod.FIRE_AFFINITY_ACC,
        [tpz.element.EARTH]   = tpz.mod.EARTH_AFFINITY_ACC,
        [tpz.element.WATER]   = tpz.mod.WATER_AFFINITY_ACC,
        [tpz.element.WIND]    = tpz.mod.WIND_AFFINITY_ACC,
        [tpz.element.ICE]     = tpz.mod.ICE_AFFINITY_ACC,
        [tpz.element.THUNDER] = tpz.mod.THUNDER_AFFINITY_ACC,
        [tpz.element.LIGHT]   = tpz.mod.LIGHT_AFFINITY_ACC,
        [tpz.element.DARK]    = tpz.mod.DARK_AFFINITY_ACC,
    },

    to_sdt = {
        [tpz.element.FIRE]    = tpz.mod.FIRESDT,
        [tpz.element.EARTH]   = tpz.mod.EARTHSDT,
        [tpz.element.WATER]   = tpz.mod.WATERSDT,
        [tpz.element.WIND]    = tpz.mod.WINDSDT,
        [tpz.element.ICE]     = tpz.mod.ICESDT,
        [tpz.element.THUNDER] = tpz.mod.THUNDERSDT,
        [tpz.element.LIGHT]   = tpz.mod.LIGHTSDT,
        [tpz.element.DARK]    = tpz.mod.DARKSDT,
    },

    to_mres = {
        [tpz.element.FIRE]    = tpz.mod.FIRERES,
        [tpz.element.EARTH]   = tpz.mod.EARTHRES,
        [tpz.element.WATER]   = tpz.mod.WATERRES,
        [tpz.element.WIND]    = tpz.mod.WINDRES,
        [tpz.element.ICE]     = tpz.mod.ICERES,
        [tpz.element.THUNDER] = tpz.mod.THUNDERRES,
        [tpz.element.LIGHT]   = tpz.mod.LIGHTRES,
        [tpz.element.DARK]    = tpz.mod.DARKRES,
    },

    to_macc = {
        [tpz.element.FIRE]    = tpz.mod.FIREACC,
        [tpz.element.EARTH]   = tpz.mod.EARTHACC,
        [tpz.element.WATER]   = tpz.mod.WATERACC,
        [tpz.element.WIND]    = tpz.mod.WINDACC,
        [tpz.element.ICE]     = tpz.mod.ICEACC,
        [tpz.element.THUNDER] = tpz.mod.THUNDERACC,
        [tpz.element.LIGHT]   = tpz.mod.LIGHTACC,
        [tpz.element.DARK]    = tpz.mod.DARKACC,
    },

    to_matk = {
        [tpz.element.FIRE]    = tpz.mod.FIREATT,
        [tpz.element.EARTH]   = tpz.mod.EARTHATT,
        [tpz.element.WATER]   = tpz.mod.WATERATT,
        [tpz.element.WIND]    = tpz.mod.WINDATT,
        [tpz.element.ICE]     = tpz.mod.ICEATT,
        [tpz.element.THUNDER] = tpz.mod.THUNDERATT,
        [tpz.element.LIGHT]   = tpz.mod.LIGHTATT,
        [tpz.element.DARK]    = tpz.mod.DARKATT,
    },

    to_rdm_acc_merits = {
        [tpz.element.FIRE]    = tpz.merit.FIRE_MAGIC_ACCURACY,
        [tpz.element.EARTH]   = tpz.merit.EARTH_MAGIC_ACCURACY,
        [tpz.element.WATER]   = tpz.merit.WATER_MAGIC_ACCURACY,
        [tpz.element.WIND]    = tpz.merit.WIND_MAGIC_ACCURACY,
        [tpz.element.ICE]     = tpz.merit.ICE_MAGIC_ACCURACY,
        [tpz.element.THUNDER] = tpz.merit.LIGHTNING_MAGIC_ACCURACY
    },

    to_blm_mab_merits = {
        [tpz.element.FIRE]    = tpz.merit.FIRE_MAGIC_POTENCY,
        [tpz.element.EARTH]   = tpz.merit.EARTH_MAGIC_POTENCY,
        [tpz.element.WATER]   = tpz.merit.WATER_MAGIC_POTENCY,
        [tpz.element.WIND]    = tpz.merit.WIND_MAGIC_POTENCY,
        [tpz.element.ICE]     = tpz.merit.ICE_MAGIC_POTENCY,
        [tpz.element.THUNDER] = tpz.merit.LIGHTNING_MAGIC_POTENCY
    },

    to_nukewall_effect = {
        [tpz.element.FIRE]    = tpz.effect.NUKEWALL_FIRE,
        [tpz.element.EARTH]   = tpz.effect.NUKEWALL_EARTH,
        [tpz.element.WATER]   = tpz.effect.NUKEWALL_WATER,
        [tpz.element.WIND]    = tpz.effect.NUKEWALL_WIND,
        [tpz.element.ICE]     = tpz.effect.NUKEWALL_ICE,
        [tpz.element.THUNDER] = tpz.effect.NUKEWALL_LIGHTNING,
        [tpz.element.LIGHT]   = tpz.effect.NUKEWALL_LIGHT,
        [tpz.element.DARK]    = tpz.effect.NUKEWALL_DARK,
    },

    to_dayweather_bonus = {
        [tpz.element.FIRE]    = tpz.mod.FORCE_FIRE_DWBONUS,
        [tpz.element.EARTH]   = tpz.mod.FORCE_EARTH_DWBONUS,
        [tpz.element.WATER]   = tpz.mod.FORCE_WATER_DWBONUS,
        [tpz.element.WIND]    = tpz.mod.FORCE_WIND_DWBONUS,
        [tpz.element.ICE]     = tpz.mod.FORCE_ICE_DWBONUS,
        [tpz.element.THUNDER] = tpz.mod.FORCE_LIGHTNING_DWBONUS,
        [tpz.element.LIGHT]   = tpz.mod.FORCE_LIGHT_DWBONUS,
        [tpz.element.DARK]    = tpz.mod.FORCE_DARK_DWBONUS,
    },

    to_absorb = {
        [tpz.element.FIRE]    = tpz.mod.FIRE_ABSORB,
        [tpz.element.EARTH]   = tpz.mod.EARTH_ABSORB,
        [tpz.element.WATER]   = tpz.mod.WATER_ABSORB,
        [tpz.element.WIND]    = tpz.mod.WIND_ABSORB,
        [tpz.element.ICE]     = tpz.mod.ICE_ABSORB,
        [tpz.element.THUNDER] = tpz.mod.LIGHTNING_ABSORB,
        [tpz.element.LIGHT]   = tpz.mod.LIGHT_ABSORB,
        [tpz.element.DARK]    = tpz.mod.DARK_ABSORB,
    },

    to_null = {
        [tpz.element.FIRE]    = tpz.mod.FIRE_NULL,
        [tpz.element.EARTH]   = tpz.mod.EARTH_NULL,
        [tpz.element.WATER]   = tpz.mod.WATER_NULL,
        [tpz.element.WIND]    = tpz.mod.WIND_NULL,
        [tpz.element.ICE]     = tpz.mod.ICE_NULL,
        [tpz.element.THUNDER] = tpz.mod.LIGHTNING_NULL,
        [tpz.element.LIGHT]   = tpz.mod.LIGHT_NULL,
        [tpz.element.DARK]    = tpz.mod.DARK_NULL,
    }
}
