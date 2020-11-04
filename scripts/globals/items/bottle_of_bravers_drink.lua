-----------------------------------------
-- ID: 5390
-- Item: bottle_of_bravers_drink
-- Item Effect: all stats +15
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local power = 15
    local duration = 180

    local effects =
    {
        tpz.effect.STR_BOOST_II,
        tpz.effect.DEX_BOOST_II,
        tpz.effect.VIT_BOOST_II,
        tpz.effect.AGI_BOOST_II,
        tpz.effect.INT_BOOST_II,
        tpz.effect.MND_BOOST_II,
        tpz.effect.CHR_BOOST_II
    }

    for _, effect in ipairs(effects) do
        target:addStatusEffect(effect, power, 0, duration)
    end
end
