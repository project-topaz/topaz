----------------------------
---                      ---
--- Day and Weather Data ---
---                      ---
----------------------------

tpz         = tpz or {}
tpz.weather = tpz.weather or {}
tpz.day     = tpz.day or {}

tpz.weather =
{
    NONE            =  0,
    SUNSHINE        =  1,
    CLOUDS          =  2,
    FOG             =  3,
    HOT_SPELL       =  4,
    HEAT_WAVE       =  5,
    RAIN            =  6,
    SQUALL          =  7,
    DUST_STORM      =  8,
    SAND_STORM      =  9,
    WIND            = 10,
    GALES           = 11,
    SNOW            = 12,
    BLIZZARDS       = 13,
    THUNDER         = 14,
    THUNDERSTORMS   = 15,
    AURORAS         = 16,
    STELLAR_GLARE   = 17,
    GLOOM           = 18,
    DARKNESS        = 19,
}

tpz.weather.maps = {
    to_element = {
        [tpz.weather.NONE]          = tpz.element.NONE,
        [tpz.weather.HOT_SPELL]     = tpz.element.FIRE,
        [tpz.weather.HEAT_WAVE]     = tpz.element.FIRE,
        [tpz.weather.DUST_STORM]    = tpz.element.EARTH,
        [tpz.weather.SAND_STORM]    = tpz.element.EARTH,
        [tpz.weather.RAIN]          = tpz.element.WATER,
        [tpz.weather.SQUALL]        = tpz.element.WATER,
        [tpz.weather.WIND]          = tpz.element.WIND,
        [tpz.weather.GALES]         = tpz.element.WIND,
        [tpz.weather.SNOW]          = tpz.element.ICE,
        [tpz.weather.BLIZZARDS]     = tpz.element.ICE,
        [tpz.weather.THUNDER]       = tpz.element.LIGHTNING,
        [tpz.weather.THUNDERSTORMS] = tpz.element.LIGHTNING,
        [tpz.weather.AURORAS]       = tpz.element.LIGHT,
        [tpz.weather.STELLAR_GLARE] = tpz.element.LIGHT,
        [tpz.weather.GLOOM]         = tpz.element.DARK,
        [tpz.weather.DARKNESS]      = tpz.element.DARK,
    },
}

tpz.day =
{
    FIRESDAY      = 0,
    EARTHSDAY     = 1,
    WATERSDAY     = 2,
    WINDSDAY      = 3,
    ICEDAY        = 4,
    LIGHTNINGDAY  = 5,
    LIGHTSDAY     = 6,
    DARKSDAY      = 7,
}

tpz.day.maps = {
    to_element = {
        [tpz.day.FIRESDAY]     = tpz.element.FIRE,
        [tpz.day.EARTHSDAY]    = tpz.element.EARTH,
        [tpz.day.WATERSDAY]    = tpz.element.WATER,
        [tpz.day.WINDSDAY]     = tpz.element.WIND,
        [tpz.day.ICEDAY]       = tpz.element.ICE,
        [tpz.day.LIGHTNINGDAY] = tpz.element.LIGHTNING,
        [tpz.day.LIGHTSDAY]    = tpz.element.LIGHT,
        [tpz.day.DARKSDAY]     = tpz.element.DARK,
    },
}