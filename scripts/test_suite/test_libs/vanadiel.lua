require("scripts/globals/data/day_weather")
require("scripts/globals/data/element")

vanadiel = vanadiel or {}

vanadiel.day = tpz.day.FIRESDAY

function VanadielDayElement()
    return tpz.day.maps.to_element[vanadiel.day]
end