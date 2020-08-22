require("scripts/globals/spell_data")
require("scripts/globals/factories/spell_factory")

tpz = tpz or {}
tpz.magic = tpz.magic or {}

tpz.magic.spells = {
    [tpz.magic.spellIDs.BLIZZARD_IV] = tpz.factories.basicEleNuke{
        V = {560, 755, 935, 1210}, M = {3.9, 3.6, 28, 2}, hasMultipleTargetReduction = false,
    },
    [tpz.magic.spellIDs.BLIZZAGA_III] = tpz.factories.basicEleNuke{
        V = {660, 855, 1035, 1310}, M = {3.9, 3.6, 2.8, 2}, hasMultipleTargetReduction = true
    },
    [tpz.magic.spellIDs.FREEZE_II] = tpz.factories.am2Nuke{
        V = {800, 900, 1000, 1200}, M = {2, 2, 2, 2}, hasMultipleTargetReduction = false,
    },
    --[tpz.spellIDs.BLIZZAJA] = tpz.jaNuke:create{
    --    V = {950, 1170, 1370, 1750}, M = {4.4, 4, 3.8, 3}, hasMultipleTargetReduction = true
    --},
    --[tpz.spellIDs.CRYOHELIX] = tpz.helixNuke:create{
    --    V = {25, 103, 181}, M = {1, 0.5, 0}, hasMultipleTargetReduction = false
    --},
}