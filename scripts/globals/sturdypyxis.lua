-----------------------------------------------------------
-- Abyssea Sturdy Pyxis
-- Spawn conditions type and size.
-- Loot set in scripts/zones/{name of zone}/pyxisloot.lua
-----------------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/zone")
require("scripts/globals/msg")

tpz = tpz or {}
tpz.pyxis = tpz.pyxis or {}

------------------------
-- ID by zone
-- abyssea Kon
------------------------
tpz.pyxis.data =
{
    abyssea_zones =
    {
        15, -- ABYSSEA_KONSCHTAT
        45, -- ABYSSEA_TAHRONGI
        132,-- ABYSSEA_LA_THEINE
        215,-- ABYSSEA_ATTOHWA
        216,-- ABYSSEA_MISAREAUX
        217,-- ABYSSEA_VUNKERL
        218,-- ABYSSEA_ALTEPA
        253,-- ABYSSEA_ULEGUERAND
        254 -- ABYSSEA_GRAUBERG
      --255 -- ABYSSEA_EMPYREAL_PARADOX
    },
    contentMessage =
    {
    ------------------------------------------------------
    -- | Key | Value |          Description            |--
    ------------------------------------------------------
        [1]  = 0x0010000, -- Feeble soothing light
        [2]  = 0x0020000, -- Miniscule curor
        [3]  = 0x0030000, -- Tiny exp
        [4]  = 0x0050000, -- Faint soothing light
        [5]  = 0x0060000, -- Small cruor
        [6]  = 0x0070000, -- little exp
        [7]  = 0x0090000, -- Mild soothing light
        [8]  = 0x00A0000, -- Moderate cruor
        [9]  = 0x00B0000, -- Some exp
        [10] = 0x00D0000, -- Strong soothing light
        [11] = 0x00E0000, -- Considerable cruor
        [12] = 0x00F0000, -- Considerable exp
        [13] = 0x0110000, -- Intense soothing light
        [14] = 0x0120000, -- Numerous temp items {Does NOT show items when peering into chest, just drops what ever into inventory like normal chests}
        [15] = 0x0130000, -- Princely crour
        [16] = 0x0140000, -- Tremendous exp
        [17] = 0x0150000, -- Stone fragment {Time Extension}
        [18] = 0x0160000, -- Faint Pearl light
        [19] = 0x0170000, -- Faint Azure light
        [20] = 0x0180000, -- Faint Ruby light
        [21] = 0x0190000, -- Faint Amber light
        [22] = 0x01A0000, -- Mild Pearl light
        [23] = 0x01B0000, -- Mild Azure light
        [24] = 0x01C0000, -- Mild Ruby light
        [25] = 0x01D0000, -- Mild Amber light
        [26] = 0x01E0000, -- Strong Pearl light
        [27] = 0x01F0000, -- Strong Azure light
        [28] = 0x0200000, -- Strong Ruby light
        [29] = 0x0210000, -- Strong Amber light
        [30] = 0x0220000, -- Faint Gold light
        [31] = 0x0230000, -- Faint Silver light
        [32] = 0x0240000, -- Faint Ebon light
        [33] = 0x0250000, -- Intense Azure light
        [34] = 0x0260000, -- Intense Ruby light
        [35] = 0x0270000, -- Intense Amber light
        [36] = 0x0280000, -- Mild Gold light
        [37] = 0x0290000, -- Mild Silver light
        [38] = 0x02A0000, -- Mild Ebon light
        [39] = 0x02B0000, -- Strong Gold light
        [40] = 0x02C0000, -- Strong Silver light
        [41] = 0x02D0000, -- Strong Ebon light
        [42] = 0x1000000, -- Temp items
        [43] = 0x2000000, -- Items
        [44] = 0x3000000, -- Poweful items
        [45] = 0x4000000  -- Key items
        -- Total 45
    },
    lightsmessage = 
    {
        pearl  = {18,18,22,22,26},
        azure  = {19,19,23,27,33},
        ruby   = {20,20,24,28,34},
        amber  = {21,21,25,29,35},
        gold   = {30,30,36,36,39},
        silver = {31,31,37,37,40},
        ebon   = {32,32,38,38,41},
    },
    expmessage = 
    {
        [1] = 3,
        [2] = 6,
        [3] = 9,
        [4] = 12,
        [5] = 16,
    },
    cruormessage = 
    {
        [1] = 2,
        [2] = 5,
        [3] = 8,
        [4] = 11,
        [5] = 15,
    },
    soothinglightmessage = 
    {
        [1] = 1,
        [2] = 4,
        [3] = 7,
        [4] = 10,
        [5] = 13,
    },
    ------------------------
    -- mID of type of chest
    ------------------------
    chestlook =
    {
      --960,    -- Basic Chest
        965,    -- Blue
      --966,    -- Casket
      --967,    -- Bronze
        968,    -- Red
        969,    -- Gold
      --1524,   -- Odd Chest
      --1932,   -- Black with Red chest
      --2425    -- Black with Red chest 2
    },
    droptypes =
    {
        [1]  = "tempitems",
        [2]  = "items",
        [3]  = "augments",
        [4]  = "keyitems",
        [5]  = "lights",
        [6]  = "restore",
        [7]  = "cruor",
        [8]  = "time",
        [9]  = "exp",
        [10] = "autotempitems",
    },
    ---------------------------------
    -- drop id's for temp items
    -- use zone id as the key
    ---------------------------------
    tempdrops =
    {
        [1] = {4206,4254,5394,5397,5433,5824,5827},
        [2] = {4206,4254,5394,5397,5433,5824,5827,5440,5835,5837,5839,5841,5843,5850,5849},
        [3] = {5395,5435,5439,5825,5828,5830,5832,5833,5834,5838,5844,5846,5852},
        [4] = {5395,5435,5439,5825,5828,5830,5832,5833,5834,5838,5844,5846,5852,4255,5322,5393,5434,5826,5829,5831,5836,5840,5842,5847,5848,5851},
        [5] = {5395,5435,5439,5825,5828,5830,5832,5833,5834,5838,5844,5846,5852,4255,5322,5393,5434,5826,5829,5831,5836,5840,5842,5847,5848,5851,4146,4202,5845},
    },
    ---------------------------------
    -- drop id's for augmented items
    -- uses zone id as the key
    ---------------------------------
    augdrops =
    {
        [15]  = {14644,12324,16128}, -- ABYSSEA_KONSCHTAT
        [45]  = {12420,13464,16265}, -- ABYSSEA_TAHRONGI
        [132] = {13087,13925,13212}, -- ABYSSEA_LA_THEINE
        [215] = {19309,11932,11880}, -- ABYSSEA_ATTOHWA
        [216] = {11424,18963,11684}, -- ABYSSEA_MISAREAUX
        [217] = {13450,11878,11428}, -- ABYSSEA_VUNKERL
        [218] = {17664,19310,19267}, -- ABYSSEA_ALTEPA
        [253] = {18964,18774,18875}, -- ABYSSEA_ULEGUERAND
        [254] = {16660,16485,16971}, -- ABYSSEA_GRAUBERG
    },
    ---------------------------------------------------------------------------------------------
    -- augs table holds potential augments with min/max values to be randomised for each item id
    -- example: Tarutaru sash [13212] would have 6 potentail augments, each with its own values
    ---------------------------------------------------------------------------------------------
    augs = 
    {
        [14644] = {augments = {{aug=42,  min=1, max=3 }, {aug=56,  min=1, max=6 }, {aug=33,  min=2, max=4 }, {aug=53,  min=1, max=5 }, {aug=55,  min=1, max=6 }, {aug=54,  min=1, max=6 }                                                                                                        }}, -- Dark Ring
        [12324] = {augments = {{aug=1,   min=2, max=17}, {aug=180, min=1, max=4 }, {aug=181, min=1, max=5 }, {aug=188, min=1, max=5 }, {aug=153, min=1, max=2 }, {aug=39,  min=1, max=2 }                                                                                                        }}, -- Tower Shield
        [16128] = {augments = {{aug=771, min=1, max=10}, {aug=773, min=1, max=10}, {aug=769, min=1, max=10}, {aug=775, min=1, max=10}, {aug=9,   min=10,max=16}, {aug=138, min=1, max=2 }                                                                                                        }}, -- Wivre Hairpin
        [12420] = {augments = {{aug=774, min=1, max=9 }, {aug=137, min=1, max=3 }, {aug=188, min=1, max=5 }, {aug=53,  min=1, max=3 }, {aug=329, min=2, max=5 }, {aug=137, min=1, max=1 }, {aug=1,   min=1, max=16}                                                                              }}, -- Adaman Barbuta
        [13464] = {augments = {{aug=791, min=7, max=9 }, {aug=185, min=1, max=3 }, {aug=179, min=1, max=3 }, {aug=183, min=1, max=3 }, {aug=516, min=1, max=3 }, {aug=335, min=1, max=3 }, {aug=133, min=1, max=3 }                                                                              }}, -- Demon's Ring
        [16265] = {augments = {{aug=1,   min=3, max=5 }, {aug=9,   min=2, max=5 }, {aug=513, min=1, max=3 }, {aug=195, min=2, max=5 }, {aug=772, min=3, max=4 }, {aug=41,  min=1, max=2 }                                                                                                        }}, -- Wivre Gorget
        [13087] = {augments = {{aug=1,   min=1, max=15}, {aug=9,   min=1, max=15}, {aug=518, min=1, max=4 }, {aug=517, min=1, max=4 }, {aug=516, min=1, max=4 }, {aug=51,  min=1, max=3 }, {aug=52,  min=1, max=3 }, {aug=140, min=1, max=3 }, {aug=141, min=1, max=3 }                          }}, -- Jeweled Collar
        [13925] = {augments = {{aug=768, min=1, max=4 }, {aug=182, min=1, max=5 }, {aug=183, min=2, max=4 }, {aug=198, min=1, max=5 }, {aug=31,  min=1, max=10}                                                                                                                                  }}, -- Rasetsu Jinpachi
        [13212] = {augments = {{aug=1,   min=1, max=15}, {aug=516, min=1, max=5 }, {aug=517, min=1, max=5 }, {aug=518, min=1, max=5 }, {aug=148, min=1, max=3 }, {aug=147, min=1, max=1 }                                                                                                        }}, -- Tarutaru Sash
        [19309] = {augments = {{aug=768, min=1, max=10}, {aug=772, min=1, max=10}, {aug=771, min=5, max=10}, {aug=1,   min=5, max=18}, {aug=514, min=1, max=5 }, {aug=187, min=3, max=5 }, {aug=23,  min=3, max=5 }, {aug=286, min=1, max=2 }, {aug=326, min=1, max=10}, {aug=327, min=1, max=5 }}}, -- Gleaming Spear
        [11932] = {augments = {{aug=774, min=1, max=10}, {aug=518, min=1, max=3 }, {aug=51,  min=1, max=3 }, {aug=323, min=1, max=6 }, {aug=289, min=1, max=5 }                                                                                                                                  }}, -- Lore Slops
        [11880] = {augments = {{aug=771, min=1, max=9 }, {aug=1,   min=1, max=15}, {aug=187, min=1, max=5 }, {aug=514, min=1, max=5 }, {aug=286, min=1, max=5 }, {aug=54,  min=1, max=1 }                                                                                                        }}, -- Versa Mufflers
        [11424] = {augments = {{aug=770, min=1, max=6 }, {aug=512, min=1, max=3 }, {aug=40,  min=1, max=3 }, {aug=145, min=1, max=3 }, {aug=195, min=1, max=5 }, {aug=116, min=1, max=3 }                                                                                                        }}, -- Gules Leggings
        [18963] = {augments = {{aug=775, min=1, max=10}, {aug=1,   min=1, max=20}, {aug=9,   min=1, max=20}, {aug=293, min=1, max=5 }, {aug=23,  min=1, max=10}                                                                                                                                  }}, -- Gleaming Zaghnal
        [11684] = {augments = {{aug=185, min=1, max=3 }, {aug=179, min=1, max=3 }, {aug=177, min=1, max=3 }, {aug=515, min=1, max=2 }, {aug=41,  min=1, max=1 }, {aug=184, min=1, max=3 }                                                                                                        }}, -- Light Earring
        [13450] = {augments = {{aug=769, min=1, max=5 }, {aug=180, min=1, max=3 }, {aug=516, min=1, max=3 }, {aug=517, min=1, max=3 }, {aug=53,  min=1, max=5 }                                                                                                                                  }}, -- Diamond Ring
        [11878] = {augments = {{aug=515, min=1, max=4 }, {aug=184, min=1, max=4 }, {aug=211, min=1, max=2 }, {aug=195, min=1, max=4 }, {aug=98,  min=1, max=4 }                                                                                                                                  }}, -- Gules Mittens
        [11428] = {augments = {{aug=1,   min=3, max=7 }, {aug=51,  min=1, max=3 }, {aug=52,  min=3, max=4 }, {aug=53,  min=2, max=10}, {aug=141, min=2, max=5 }                                                                                                                                  }}, -- Lore Sabots
        [17664] = {augments = {{aug=787, min=1, max=7 }, {aug=184, min=1, max=5 }, {aug=517, min=2, max=8 }, {aug=45,  min=2, max=9 }, {aug=1033,min=1, max=8 }                                                                                                                                  }}, -- Firmament
        [19310] = {augments = {{aug=788, min=2, max=7 }, {aug=177, min=2, max=6 }, {aug=29,  min=2, max=3 }, {aug=512, min=2, max=7 }, {aug=45,  min=6, max=15}, {aug=1052,min=2, max=8 }                                                                                                        }}, -- Guisarme
        [19267] = {augments = {{aug=784, min=2, max=7 }, {aug=178, min=2, max=6 }, {aug=25,  min=2, max=3 }, {aug=39,  min=2, max=7 }, {aug=45,  min=6, max=15}, {aug=1078,min=2, max=8 }                                                                                                        }}, -- Ribauldequin
        [18964] = {augments = {{aug=770, min=4, max=5 }, {aug=787, min=3, max=8 }, {aug=184, min=3, max=5 }, {aug=23,  min=1, max=3 }, {aug=198, min=2, max=7 }, {aug=512, min=3, max=3 }, {aug=45,  min=3, max=19}, {aug=1048,min=2, max=8 }                                                    }}, -- Dire Scythe
        [18774] = {augments = {{aug=786, min=1, max=7 }, {aug=181, min=1, max=6 }, {aug=41,  min=1, max=4 }, {aug=45,  min=2, max=5 }, {aug=1024,min=2, max=6 }                                                                                                                                  }}, -- Savate Fists
        [18875] = {augments = {{aug=789, min=3, max=7 }, {aug=182, min=3, max=6 }, {aug=512, min=3, max=8 }, {aug=45,  min=5, max=10}, {aug=1065,min=2, max=4 }, {aug=1064,min=2, max=4 }                                                                                                        }}, -- Vodun Mace
        [16660] = {augments = {{aug=786, min=2, max=5 }, {aug=187, min=1, max=6 }, {aug=512, min=3, max=8 }, {aug=45,  min=3, max=8 }, {aug=1040,min=2, max=4 }                                                                                                                                  }}, -- Doom Tabar
        [16485] = {augments = {{aug=787, min=2, max=8 }, {aug=184, min=1, max=5 }, {aug=25,  min=1, max=3 }, {aug=23,  min=1, max=2 }, {aug=45,  min=1, max=8 }, {aug=1028,min=2, max=4 }                                                                                                        }}, -- Yataghan
        [16971] = {augments = {{aug=788, min=2, max=5 }, {aug=177, min=3, max=6 }, {aug=1080,min=1, max=3 }, {aug=45,  min=5, max=8 }, {aug=1060,min=2, max=4 }                                                                                                                                  }}, -- Yukitsugu
    },
    -------------------------------------------------------------------------------
    -- This table reduces the total number of augments available by chest tier.
    -- removes total from right to left
    -- so {5,4,3,2,0},
    -- will decrease the total augments available for tier 1 chest by 5,
    -- tier 2 by 4, tier 3 by 3 and tier 4 by 2, leaving the full total for tier 5
    -------------------------------------------------------------------------------
    augTierDeduction =
    {
        [14644] = {3,3,3,2,0}, -- Dark Ring
        [12324] = {5,2,2,0,0}, -- Tower Shield
        [16128] = {3,3,3,2,0}, -- Wivre Hairpin
        [12420] = {6,6,6,4,0}, -- Adaman Barbuta
        [13464] = {4,4,4,3,0}, -- Demon's Ring
        [16265] = {3,3,3,0,0}, -- Wivre Gorget
        [13087] = {7,7,3,2,0}, -- Jeweled Collar
        [13925] = {2,2,2,0,0}, -- Rasetsu Jinpachi
        [13212] = {5,5,3,2,0}, -- Tarutaru Sash
        [19309] = {6,5,4,3,0}, -- Gleaming Spear
        [11932] = {3,3,2,0,0}, -- Lore Slops
        [11880] = {2,2,2,0,0}, -- Versa Mufflers
        [11424] = {4,4,3,0,0}, -- Gules Leggings
        [18963] = {4,4,2,0,0}, -- Gleaming Zaghnal
        [11684] = {3,3,3,0,0}, -- Light Earring
        [13450] = {4,4,2,0,0}, -- Diamond Ring
        [11878] = {3,3,2,0,0}, -- Gules Mittens
        [11428] = {2,2,2,1,0}, -- Lore Sabots
        [17664] = {4,4,3,2,0}, -- Firmament
        [19310] = {4,4,3,2,0}, -- Guisarme
        [19267] = {4,4,3,2,0}, -- Ribauldequin
        [18964] = {6,6,4,2,0}, -- Dire Scythe
        [18774] = {3,3,2,0,0}, -- Savate Fists
        [18875] = {4,4,3,2,0}, -- Vodun Mace
        [16660] = {3,3,2,0,0}, -- Doom Tabar
        [16485] = {4,4,3,2,0}, -- Yataghan
        [16971] = {3,3,2,0,0}, -- Yukitsugu
    },
    ---------------------------------
    -- drop id's for keyitems
    -- use zone id as the key
    ---------------------------------
    kidrops =
    {
        [15]  = {1461,1459,1465,1464,1462,1466,1463,1460}, -- ABYSSEA_KONSCHTAT
        [45]  = {1476,1471,1477,1470,1472,1473,1474,1475,1469,1468}, -- ABYSSEA_TAHRONGI
        [132] = {1478,1479,1480,1485,1486,1483,1484,1482,1481}, -- ABYSSEA_LA_THEINE
        [215] = {0,0,0}, -- ABYSSEA_ATTOHWA
        [216] = {0,0,0}, -- ABYSSEA_MISAREAUX
        [217] = {0,0,0}, -- ABYSSEA_VUNKERL
        [218] = {0,0,0}, -- ABYSSEA_ALTEPA
        [253] = {0,0,0}, -- ABYSSEA_ULEGUERAND
        [254] = {0,0,0}, -- ABYSSEA_GRAUBERG
    },
    ---------------------------------
    -- drop id's for items
    -- use zone id as the key
    ---------------------------------
    itemdrops =
    {
        [15]  = {1633,4781,4272,5152,2903,2824,2910,2189,781,1262,778,1740,685,1259,740,1469,836,4377,5001}, -- ABYSSEA_KONSCHTAT
        [45]  = {2408,2198,887,4691,4771,4781,4660,4614,4982,5001,4965,645,1633,812,804,756,794,1259,785,4272,2946,740,786,1312,942,2920,2948,2922,2949,2924,2950,2925,2923,2947}, -- ABYSSEA_TAHRONGI
        [132] = {1260,1415,2899,2901,2902,2895,2359,740,739,1446,685,1769,702,1258,756,4272,780,4377,5152,4781,4771,4655,5001,4982,4856,4991,4486,4965,2893,2900}, -- ABYSSEA_LA_THEINE
        [215] = {0,0,0}, -- ABYSSEA_ATTOHWA
        [216] = {0,0,0}, -- ABYSSEA_MISAREAUX
        [217] = {0,0,0}, -- ABYSSEA_VUNKERL
        [218] = {0,0,0}, -- ABYSSEA_ALTEPA
        [253] = {0,0,0}, -- ABYSSEA_ULEGUERAND
        [254] = {0,0,0}, -- ABYSSEA_GRAUBERG
    },
    itemTierDeductions = 
    {
        [15]  = {7,7,7,0,0}, -- ABYSSEA_KONSCHTAT
        [45]  = {14,14,14,9,0}, -- ABYSSEA_TAHRONGI
        [132] = {13,13,13,9,0}, -- ABYSSEA_LA_THEINE
        [215] = {0,0,0,0,0}, -- ABYSSEA_ATTOHWA
        [216] = {0,0,0,0,0}, -- ABYSSEA_MISAREAUX
        [217] = {0,0,0,0,0}, -- ABYSSEA_VUNKERL
        [218] = {0,0,0,0,0}, -- ABYSSEA_ALTEPA
        [253] = {0,0,0,0,0}, -- ABYSSEA_ULEGUERAND
        [254] = {0,0,0,0,0}, -- ABYSSEA_GRAUBERG
    },
}

---------------------------------------------------------------------------------------------
-- Desc: Check for time elapsed since last spawned
-- NOTE: will NOT allow a spawn if time since last spanwed is under 5 mins.
---------------------------------------------------------------------------------------------
local function timeElapsedCheck(npc)
    local spawnTime = os.time() + 180000 -- defualt time in case no var set.
    local timeTable = {0, 0, 0}          -- HOURS,MINUTES,SECONDS.

    if npc == nil then
        return false
    end

    if npc:getLocalVar("[pyxis]SPAWNTIME") > 0 then
        spawnTime = npc:getLocalVar("[pyxis]SPAWNTIME")
    end

    if os.time() - spawnTime <= 0 then
        return true
    end
    return false
end

function GetPyxisID(player)
    local zoneId      = player:getZoneID()
    local ID          = zones[zoneId]
    local baseChestId = ID.npc.Sturdy_Pyxis_Base
    local chestId     = 0

    for i = baseChestId, baseChestId + 79 do
        if timeElapsedCheck(GetNPCByID(i)) then
            if GetNPCByID(i):getStatus() == tpz.status.DISAPPEAR then
                chestId = i
                break
            end
        end
    end

    if GetNPCByID(chestId) == nil then
        return 0
    end

    return chestId
end

local function CanSpawnPyxis(player)
    local pearl  = player:getCharVar("pearlLight")
    local dropchance = math.random(1 + pearl, 500) 

    if dropchance >= 250 then
        return true
    end

    return false
end

tpz.pyxis.spawnPyxis = function(player, x, y, z, r)
    local chestId = GetPyxisID(player)
    local npc     = GetNPCByID(chestId)
    
    --print(chestId)
    if chestId == 0 then
        return
    end

    if CanSpawnPyxis(player) then
        SetPyxisData(player, x, y, z, r, npc)
    end
end

function SetPyxisData(player, x, y, z, r, npc)
    local zoneId = player:getZoneID()
    local ID = zones[zoneId]
    ---------------------------------------------
    -- lights
    ---------------------------------------------
    local pearl  = player:getCharVar("pearlLight")
    local azure  = player:getCharVar("azureLight")
    local ruby   = player:getCharVar("rubyLight")
    local amber  = player:getCharVar("amberLight")
    local gold   = player:getCharVar("goldLight")
    local silver = player:getCharVar("silverLight")
    local ebon   = player:getCharVar("ebonLight")
    ---------------------------------------------
    -- type chance
    ---------------------------------------------
    local goldchance = math.random(amber)
    local redchance  = math.random(ruby)
    local bluechance = math.random(azure)
    local droptype   = 0
    local restore    = 0
    local partyid    = player:getLeaderID()
    local chestid    = npc:getID()
    local cheststyle = 0
    local locktype   = 1
    local tier       = 1
    local randnum    = 0
    local correctnum = 0
    local required   = math.random(1,6)
    local normalflag = 1155
    local goldflag   = {1155,1159}
    local sizeflag   = 3
    local message    = 0
    local light      = 1
    local gold       = 0
    local silver     = 0
    local ebon       = 0

    if (player:hasKeyItem(tpz.ki.IVORY_ABYSSITE_OF_ACUMEN)) then
        required = required - 2
        if (required < 1) then
            required = 1
        end
    end

    --printf("Gold Chance = %i", goldchance)
    --printf("Red Chance = %i", redchance)
    --printf("Blue Chance = %i", bluechance)

    math.randomseed(os.time())

    if (goldchance > redchance and goldchance > bluechance) then
        cheststyle = tpz.pyxis.data.chestlook[3] -- gold
    elseif (redchance > goldchance and redchance > bluechance) then
        cheststyle = tpz.pyxis.data.chestlook[2] -- red
    elseif (bluechance > goldchance and redchance < bluechance) then
        cheststyle = tpz.pyxis.data.chestlook[1] -- blue
    elseif (goldchance == redchance or goldchance == bluechance or redchance == bluechance) then
        cheststyle = tpz.pyxis.data.chestlook[math.random(#tpz.pyxis.data.chestlook)]
        tier = 1
    else
        cheststyle = tpz.pyxis.data.chestlook[math.random(#tpz.pyxis.datachestlook)]
        tier = 1
    end

    if (cheststyle == 965) then -- blue
        local bluedrops = 0
        local blueabyssitebonus = 0

        locktype = 1
        randnum = math.random(10,99)

        if (azure < 102) then
            tier = 1
        elseif (azure >= 102 and azure <= 153) then
            tier = 2
        elseif (azure > 153 and azure <= 204) then
            tier = 3
        elseif (azure > 204 and azure < 255) then
            tier = 4
        elseif (azure >= 255) then
            tier = 5
        end

        if (player:hasKeyItem(tpz.ki.SCARLET_ABYSSITE_OF_KISMET)) then
            blueabyssitebonus = blueabyssitebonus + 1
        end

        if (player:hasKeyItem(tpz.ki.IVORY_ABYSSITE_OF_KISMET)) then
            blueabyssitebonus = blueabyssitebonus + 1
        end

        if (player:hasKeyItem(tpz.ki.VERMILLION_ABYSSITE_OF_KISMET)) then
            blueabyssitebonus = blueabyssitebonus + 1
        end

        if (blueabyssitebonus > 0) then
            tier = tier + blueabyssitebonus  
        end
             
        if (tier > 5) then
            tier = 5
        end

        if (tier < 4) then
            bluedrops = math.random(1,4)
        else
            bluedrops = math.random(1,6)
        end
        --printf("blue drops = %s", tostring(bluedrops))

        if (bluedrops == 1) then
            message  = 14 -- Numerous temp items
            droptype = 10
        elseif (bluedrops == 2) then
            message  = tpz.pyxis.data.expmessage[tier]  -- exp
            droptype = 9
        elseif (bluedrops == 3) then
            message  = tpz.pyxis.data.soothinglightmessage[tier]  -- soothing light
            droptype = 6  -- tier 1 1 or 2, tier 2 1,2 or 3, tier 3 1,2,3 or 4, tier 4 3,4 or 5
            if tier == 1 then
                restore = math.random(1,2)
            elseif tier == 2 then
                restore = math.random(1,3)
            elseif tier == 3 then
                restore = math.random(1,4)
            elseif tier > 3 then
                restore = math.random(3,5)
            end
            --printf("RESTORE = %s", tostring(npc:getLocalVar("RESTORE")))
        elseif (bluedrops == 4) then
            message  = tpz.pyxis.data.cruormessage[tier]  -- curor
            droptype = 7
        elseif (bluedrops == 5) then
            message  = 42 -- temp items
            droptype = 1
        elseif (bluedrops == 6) then
            message  = 17 -- Time Extension
            droptype = 8
        end
    elseif (cheststyle == 968) then -- red
        light    = math.random(1,7)
        droptype = 5
        locktype = 2
        randnum  = math.random(25,75)

        if (ruby < 102) then
            tier = 1
        elseif (ruby >= 102 and ruby <= 153) then
            tier = 2
        elseif (ruby > 153 and ruby <= 204) then
            tier = 3
        elseif (ruby > 204 and ruby < 255) then
            tier = 4
        elseif (ruby >= 255) then
            tier = 5
        end

        if (light == 1) then
            message = tpz.pyxis.data.lightsmessage.pearl[tier]
            
        elseif (light == 2) then
            message = tpz.pyxis.data.lightsmessage.azure[tier]
            
        elseif (light == 3) then
            message = tpz.pyxis.data.lightsmessage.ruby[tier]
            
        elseif (light == 4) then
            message = tpz.pyxis.data.lightsmessage.amber[tier]
            
        elseif (light == 5) then
            message = tpz.pyxis.data.lightsmessage.gold[tier]

            if (tier == 1 or tier == 2) then
                gold = 5
            elseif (tier == 3 or tier == 4) then
                gold = 10
            elseif (tier == 5) then
                gold = 15
            end
        elseif (light == 6) then
            message = tpz.pyxis.data.lightsmessage.silver[tier]

            if (tier == 1 or tier == 2) then
                silver = 5
            elseif (tier == 3 or tier == 4) then
                silver = 10
            elseif (tier == 5) then
                silver = 15
            end
        elseif (light == 7) then
            message = tpz.pyxis.data.lightsmessage.ebon[tier]

            if (tier == 1 or tier == 2) then
                ebon = 5
            elseif (tier == 3 or tier == 4) then
                ebon = 10
            elseif (tier == 5) then
                ebon = 15
            end
        end
    elseif (cheststyle == 969) then -- gold
        local golddrops = 0

        locktype = 3

        if (amber < 80) then
            tier = 1
            randnum = math.random(11,33)
        elseif (amber >= 80 and amber <= 120) then
            tier = 2
            randnum = math.random(11,44)
        elseif (amber > 120 and amber <= 160) then
            tier = 3
            randnum = math.random(11,55)
        elseif (amber > 160 and amber < 200) then
            tier = 4
            randnum = math.random(11,90)
        elseif (amber >= 200) then
            tier = 5
            randnum = math.random(11,77)
        end

        if (tier < 3) then
            sizeflag = goldflag[1]
        elseif (tier > 3 and tier < 5) then
            if (math.random(100) > 25) then
                sizeflag = goldflag[2]
            else
                sizeflag = goldflag[1]
            end
        elseif (tier == 5) then
            if (math.random(100) > 40) then
                sizeflag = goldflag[2]
            else
                sizeflag = goldflag[1]
            end
        else
            sizeflag = normalflag
        end

        if (tier < 4) then
            golddrops = math.random(1,2)
        else
            golddrops = math.random(1,4)
        end

        if (golddrops == 1) then
            message  = 42  -- temp items
            droptype = 1
        elseif (golddrops == 2) then
            message  = 43  -- items
            droptype = 2
        elseif (golddrops == 3) then
            message  = 44  -- Poweful items (Augmented Items)
            droptype = 3
        elseif (golddrops == 4) then
            message  = 45  -- Key items
            droptype = 2
        end
    end

    if (randnum <= 50) then
        correctnum = math.random(50,99)
    elseif (randnum > 50) then
        correctnum = math.random(1,50)
    end

    --printf("locktype = %s", tostring(locktype))
    --printf("RAND_NUM = %s", tostring(randnum))

    if (npc ~= nil or npc:getStatus() == tpz.status.DISAPPEAR) then
        --printf("Spawning chest with Chest ID: [%s]", tostring(chestid))
        npc:resetLocalVars()
        --------------------------------------
        -- Change flags
        --------------------------------------
        npc:setNpcFlags(sizeflag, npc:getID())
        --printf("Setting flag to %s for chestid %s", tostring(sizeflag), tostring(chestid))
        -------------------------------------
        -- Chest data
        -------------------------------------
        --printf("Chest tier = %s", tostring(tier))
        npc:setLocalVar("KILLER",player:getID())
        npc:setLocalVar("TIER", tier)
        npc:setLocalVar("PARTYID", partyid)
        npc:setLocalVar("SIZE",sizeflag)
        npc:setLocalVar("LOCKTYPE", locktype)
        npc:setLocalVar("ITEMS_SET", 0)
        npc:setLocalVar("[pyxis]SPAWNTIME", os.time())
        npc:setLocalVar("RAND_NUM", randnum)
        npc:setLocalVar("REQUIREDGUESSES", required)
        npc:setLocalVar("CORRECT_NUM", correctnum)
        npc:setLocalVar("CORRECT_GUESSES", 0)
        npc:setLocalVar("FAILED_ATEMPTS", 0)
        npc:setLocalVar("PEEKMESSAGE", message)
        npc:setLocalVar("LOOT_TYPE", droptype)
        npc:setLocalVar("LIGHT",light)
        npc:setLocalVar("CRUOR",250 * tier)
        npc:setLocalVar("EXP",250 * tier)
        npc:setLocalVar("RESTORE",restore)
        npc:setLocalVar("PEARL_AMOUNT",8 * tier)
        npc:setLocalVar("AZURE_AMOUNT",8 * tier)
        npc:setLocalVar("RUBY_AMOUNT",8 * tier)
        npc:setLocalVar("AMBER_AMOUNT",8 * tier)
        npc:setLocalVar("GOLD_AMOUNT",gold)
        npc:setLocalVar("SILVER_AMOUNT",silver)
        npc:setLocalVar("EBON_AMOUNT",ebon)
        npc:setLocalVar("CHESTID", chestid)
        npc:setLocalVar("SPAWNSTATUS",1)
        npc:setPos(x, y, z, r)
        npc:setStatus(tpz.status.NORMAL)
        npc:entityAnimationPacket("deru")
        npc:AnimationSub(12)
        MessageChest(player,ID.text.MONSTER_CONCEALED_CHEST,0,0,0,0)
        npc:setModelId(cheststyle)        
        npc:timer(180000, function(npc)
            if npc:getStatus() == tpz.status.NORMAL then
                RemoveChest(player,npc,0,1)
            end
        end)
    else
        print("ERROR: Trying to spawn chest that is allready spawned!")
    end
end

local function GetDrops(npc,droptype,tier,zoneid)
    --printf("ITEMS_SET = %s", tostring(npc:getLocalVar("ITEMS_SET")))
    local chestid   = npc:getLocalVar("CHESTID")
    local chesttype = tpz.pyxis.data.droptypes[droptype]

    if (npc:getLocalVar("ITEMS_SET") == 1) then -- sets this to 1 so can get items once when triggered
        --print("Items allready set!")
        return
    end

    --printf("tier = %s", tostring(tier))
    --printf("chesttype = %s", tostring(chesttype))

    switch(chesttype): caseof
    { 
        ["tempitems"] = function(x) 
                        local  temps = {0,0,0,0,0,0,0,0}
                        local tempcount = math.random(1,tier + 3)

                        for i = 1, tempcount do
                            local temp = tpz.pyxis.data.tempdrops[tier][math.random(1, #tpz.pyxis.data.tempdrops[tier])]
                            temps[i] = temp
                        end

                        SetTempItems(npc, temps[1], temps[2], temps[3], temps[4], temps[5], temps[6], temps[7], temps[8])
                      end,
        ["keyitems"]  = function(x) 
                            local kis = {0,0}
                            local kicount = 1

                            if (math.random(100) > 75) then
                                kicount = 2
                            else
                                kicount = 1
                            end

                            for i = 1, kicount do
                                local ki = tpz.pyxis.data.kidrops[zoneid][math.random(1, #tpz.pyxis.data.kidrops[zoneid])]
                                kis[i] = ki
                            end

                            SetKIDrops(npc, kis[1], kis[2])
                      end,
        ["augments"]  = function(x) 
                            local item1
                            local item2

                            while (item1 == nil) do
                                item1 = tpz.pyxis.data.augdrops[zoneid][math.random(1,3)]
                                break
                            end

                            if (tier > 2) then
                                if (math.random(100) > 90 / tier) then
                                    while (item2 == nil) do
                                        item2 = tpz.pyxis.data.augdrops[zoneid][math.random(1,3)] 
                                        break
                                    end
                                else
                                    item2 = 0
                                end 
                            end

                            SetAugItem(GetNPCByID(npc:getID()),item1,item2)
                        end,
        ["items"]     = function(x)
                            local items = {0,0,0,0,0,0,0,0}
                            local itemcount = 1

                            if (tier < 3 or tier == 5) then
                                itemcount = math.random(1,3)
                            elseif (tier == 3 or tier == 4) then
                                itemcount = math.random(1,8)
                            end
                            --printf("itemcount = %i", itemcount)
                            for i = 1, itemcount do
                                local item = GetRandItem(zoneid, tier)
                                items[i] = item
                                --printf("setting item %i",i)
                            end

                            SetItems(npc, items[1], items[2], items[3], items[4], items[5], items[6], items[7], items[8]) 
                        end
    }
end

function DeletePyxisData(npc, chestid)
    --print("deleting chest data, is this right?")
    npc:resetLocalVars()
end

----------------------------------------------------------------------------------
-- Temp item functions
----------------------------------------------------------------------------------

function SetTempItems(npc, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8)
    npc:setLocalVar("TEMP1", temp1)
    npc:setLocalVar("TEMP2", temp2)
    npc:setLocalVar("TEMP3", temp3)
    npc:setLocalVar("TEMP4", temp4)
    npc:setLocalVar("TEMP5", temp5)
    npc:setLocalVar("TEMP6", temp6)
    npc:setLocalVar("TEMP7", temp7)
    npc:setLocalVar("TEMP8", temp8)
    npc:setLocalVar("ITEMS_SET",1)
end

function GetTempDrop(npc,tempnum)
    local query = string.format("TEMP" ..tempnum.. "")
    local var   = npc:getLocalVar(query)

    if (var == nil) then
        return 0
    else
        return var
    end
end

function GiveTempItem(player, npc, tempnum)
    local chest = npc
    local targ = player
    local temp1 = npc:getLocalVar("TEMP1")
    local temp2 = npc:getLocalVar("TEMP2")
    local temp3 = npc:getLocalVar("TEMP3")
    local temp4 = npc:getLocalVar("TEMP4")
    local temp5 = npc:getLocalVar("TEMP5")
    local temp6 = npc:getLocalVar("TEMP6")
    local temp7 = npc:getLocalVar("TEMP7")
    local temp8 = npc:getLocalVar("TEMP8")

    if (tempnum == 1) then
        if (temp1 == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.TEMP_ITEM_DISAPPEARED)
            return
        else
            if (player:hasItem(temp1,3)) then
                player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_TEMP_ITEM)
                return
            else
                player:addTempItem(temp1)
                MessageChest(targ,zones[player:getZoneID()].text.OBTAINS_TEMP_ITEM,temp1,0,0,0,chest)
                npc:setLocalVar("TEMP1",0)
            end
        end
    elseif (tempnum == 2) then
        if (temp2 == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.TEMP_ITEM_DISAPPEARED)
            return
        else
            if (player:hasItem(temp2,3)) then
                player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_TEMP_ITEM)
                return
            else
                player:addTempItem(temp2)
                MessageChest(targ,zones[player:getZoneID()].text.OBTAINS_TEMP_ITEM,temp2,0,0,0,chest)
                npc:setLocalVar("TEMP2",0)
            end
        end
    elseif (tempnum == 3) then
        if (temp3 == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.TEMP_ITEM_DISAPPEARED)
            return
        else
            if (player:hasItem(temp3,3)) then
                player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_TEMP_ITEM)
                return
            else
                player:addTempItem(temp3)
                MessageChest(targ,zones[player:getZoneID()].text.OBTAINS_TEMP_ITEM,temp3,0,0,0,chest)
                npc:setLocalVar("TEMP3",0)
            end
        end
    elseif (tempnum == 4) then
        if (temp4 == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.TEMP_ITEM_DISAPPEARED)
            return
        else
            if (player:hasItem(temp4,3)) then
                player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_TEMP_ITEM)
                return
            else
                player:addTempItem(temp4)
                MessageChest(targ,zones[player:getZoneID()].text.OBTAINS_TEMP_ITEM,temp4,0,0,0,chest)
                npc:setLocalVar("TEMP4",0)
            end
        end
    elseif (tempnum == 5) then
        if (temp5 == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.TEMP_ITEM_DISAPPEARED)
            return
        else
            if (player:hasItem(temp5,3)) then
                player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_TEMP_ITEM)
                return
            else
                player:addTempItem(temp5)
                MessageChest(targ,zones[player:getZoneID()].text.OBTAINS_TEMP_ITEM,temp5,0,0,0,chest)
                npc:setLocalVar("TEMP5",0)
            end
        end
    elseif (tempnum == 6) then
        if (temp6 == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.TEMP_ITEM_DISAPPEARED)
            return
        else
            if (player:hasItem(temp6,3)) then
                player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_TEMP_ITEM)
                return
            else
                player:addTempItem(temp6)
                MessageChest(targ,zones[player:getZoneID()].text.OBTAINS_TEMP_ITEM,temp6,0,0,0,chest)
                npc:setLocalVar("TEMP6",0)
            end
        end
    elseif (tempnum == 7) then
        if (temp7 == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.TEMP_ITEM_DISAPPEARED)
            return
        else
            if (player:hasItem(temp7,3)) then
                player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_TEMP_ITEM)
                return
            else
                player:addTempItem(temp7)
                MessageChest(targ,zones[player:getZoneID()].text.OBTAINS_TEMP_ITEM,temp7,0,0,0,chest)
                npc:setLocalVar("TEMP7",0)
            end
        end
    elseif (tempnum == 8) then
        if (temp8 == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.TEMP_ITEM_DISAPPEARED)
            return
        else
            if (player:hasItem(temp8,3)) then
                player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_TEMP_ITEM)
                return
            else
                player:addTempItem(temp8)
                MessageChest(targ,zones[player:getZoneID()].text.OBTAINS_TEMP_ITEM,temp8,0,0,0,chest)
                npc:setLocalVar("TEMP8",0)
            end
        end
    end

    if (npc:getLocalVar("TEMP1") == 0 and
        npc:getLocalVar("TEMP2") == 0 and
        npc:getLocalVar("TEMP3") == 0 and
        npc:getLocalVar("TEMP4") == 0 and
        npc:getLocalVar("TEMP5") == 0 and
        npc:getLocalVar("TEMP6") == 0 and
        npc:getLocalVar("TEMP7") == 0 and
        npc:getLocalVar("TEMP8") == 0) then

        RemoveChest(player,npc,0,3)
    end
end

----------------------------------------------------------------------------------
-- Key item functions
----------------------------------------------------------------------------------

function GetKiDrop(npc,kinum)
    local query = string.format("KI" ..kinum.. "")
    local var   = npc:getLocalVar(query)

    if (var == nil) then
        return 0
    else
        return var
    end
end

function SetKIDrops(npc, ki1, ki2)
    if (ki1 ~= nil) then
        npc:setLocalVar("KI1",ki1)
        npc:setLocalVar("KI2",ki2)
        npc:setLocalVar("ITEMS_SET",1)
    end
end

function GivePlayerKi(npc, player, kinum)
    local ki1 = npc:getLocalVar("KI1")
    local ki2 = npc:getLocalVar("KI2")

    if (kinum == 1) then
        if (ki1 == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.KEY_ITEM_DISAPPEARED)
            return 0
        else
            if (player:hasKeyItem(ki1)) then
                player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_KEY_ITEM)
                return 0
            else
                player:addKeyItem(ki1)
                MessageChest(player,zones[player:getZoneID()].text.OBTAINS_THE_KEY_ITEM,ki1,0,0,0)
                npc:setLocalVar("KI1",0)
                if (npc:getLocalVar("KI2") == 0) then
                    RemoveChest(player,npc,0,3)
                end
            end
        end
    elseif (kinum == 2) then
        if (ki2 == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.KEY_ITEM_DISAPPEARED)
            return 0
        else
            if (player:hasKeyItem(ki2)) then
                player:messageSpecial(zones[player:getZoneID()].text.ALLREADY_POSSESS_KEY_ITEM)
                return 0
            else
                player:addKeyItem(ki2)
                MessageChest(player,zones[player:getZoneID()].text.OBTAINS_THE_KEY_ITEM,ki2,0,0,0)
                npc:setLocalVar("KI2",0)
                if (npc:getLocalVar("KI1") == 0) then
                    RemoveChest(player,npc,0,3)
                end
            end
        end
    end     
end

----------------------------------------------------------------------------------
-- Augmented item functions
----------------------------------------------------------------------------------

function GetAugItemID(npc, slot)
    local query   = string.format("ITEM" ..slot.. "ID")
    local var     = npc:getLocalVar(query)

    if (var == nil) then
        return 0
    else
        return var
    end
end

function GetAugID(npc, slot, augmentnumber)
    local query   = string.format("ITEM"..slot.."AU"..augmentnumber.."")
    local var     = npc:getLocalVar(query)

    if (var == nil) then
        return 0
    else
        return var
    end
end

function GetAug(npc, slot, augmentnumber)
    local query   = string.format("ITEM" ..slot.. "AUGMENT"..augmentnumber.."")
    local var     = npc:getLocalVar(query)

    if (var == nil) then
        return 0
    else
        return var
    end
end

function GetAugVal(npc, slot, augmentnumber)
    local query   = string.format("ITEM" ..slot.. "AUG"..augmentnumber.."VAL")
    local var     = npc:getLocalVar(query)

    if (var == nil) then
        return 0
    else
        return var
    end
end

function SetAugItemID(npc, itemnum, augmentnumber, augment)
    --print("Setting Augment varible")
    local aug       = 0 -- set to 0 as defualt in case of nil error
    local query     = string.format("ITEM"..itemnum.."AU"..augmentnumber.."")

    aug = augment

    npc:setLocalVar(query, aug)
end

function SetAugItem(npc, item1, item2)
    --print("setting aug item")
    local chestid = npc:getLocalVar("CHESTID")
    local chest   = GetNPCByID(chestid)
    local tier    = npc:getLocalVar("TIER")

    if (item1 == nil or item1 == 0) then
        GetDrops(chest,npc:getLocalVar("LOOT_TYPE"),tier,npc:getZoneID())
    else
        npc:setLocalVar("ITEM1ID",item1)
        GetAugment(chest,item1,1)
        if (item2 ~= nil and item2 > 0) then
            npc:setLocalVar("ITEM1ID",item1)
            GetAugment(chest,item1,1)
            npc:setLocalVar("ITEM2ID",item2)
            GetAugment(chest,item2,2)
        end
        chest:setLocalVar("ITEMS_SET",1)
    end
end

function GetAugment(npc, itemid, itemslot)
    local secondAugment = false
    local chestid       = npc:getLocalVar("CHESTID")
    local chest         = GetNPCByID(chestid)
    local tier          = npc:getLocalVar("TIER")
    local slot          = itemslot
    local randaugment1  = 0
    local randaugment2  = 0
    local augment1      = 0
    local augment2      = 0
    local aug1          = 0
    local aug2          = 0

    math.randomseed(os.time())

    if (tier < 3) then
        if (math.random(100) > 98) then
            secondAugment = true
        else
            secondAugment = false
        end  
    elseif (tier >= 3 and tier < 5) then
        if (math.random(100) > 80) then
            secondAugment = true
        else
            secondAugment = false
        end
    elseif (tier == 5) then
        if (math.random(100) > 65) then
            secondAugment = true
        else
            secondAugment = false
        end
    end

    --printf("secondAugment = %s",tostring(secondAugment))
    --printf("tier = %u", tier)

    randaugment1 = math.random(1,#tpz.pyxis.data.augs[itemid].augments - tpz.pyxis.data.augTierDeduction[itemid][tier])
    aug1 = tpz.pyxis.data.augs[itemid].augments[randaugment1]

    if (aug1.min == aug1.max) then
        multival1 = aug1.min
    else
        multival1 = math.random(aug1.min, aug1.max)
    end

    if (aug1 == nil) then
        augment1 = 0
    else
        if (multival1 > 1 and multival1 ~= nil) then
            augment1 = bit.bor(aug1.aug,bit.lshift(multival1 -1 ,11))
        else
            augment1 = aug1.aug
        end
        SetAugItemID(npc, slot, 1, augment1)
        --printf("Aug1 for slot %i = %s", slot, tostring(aug1.aug))
        --printf("multival1 for slot %i = %s", slot, tostring(multival1))

        if (slot == 1) then
            npc:setLocalVar("ITEM1AUGMENT1",aug1.aug)
            npc:setLocalVar("ITEM1AUG1VAL",multival1 -1)
        elseif (slot == 2) then
            npc:setLocalVar("ITEM2AUGMENT1",aug1.aug)
            npc:setLocalVar("ITEM2AUG1VAL",multival1 -1)
        end
    end


    if (secondAugment) then
        randaugment2 = math.random(1,#tpz.pyxis.data.augs[itemid].augments - tpz.pyxis.data.augTierDeduction[itemid][tier])

        if (randaugment2 == randaugment1) then
            randaugment2 = 0
        end
        
        if (randaugment2 ~= 0 and randaugment2 ~= nil) then
            aug2 = tpz.pyxis.data.augs[itemid].augments[randaugment2]

            if (aug2.min == aug2.max) then
                multival2 = aug2.min
            else
                multival2 = math.random(aug2.min, aug2.max)
            end
           
            if (aug2 == nil) then
                augment2 = 0
            else
                if (multival2 > 1 and multival2 ~= nil) then
                    augment2 = bit.bor(aug2.aug,bit.lshift(multival2 -1 ,11))
                else
                    augment2 = aug2
                end
                SetAugItemID(npc, slot, 2, augment2)
                --printf("Aug2 for slot %i = %s", slot, tostring(aug2.aug))
                --printf("multival2 for slot %i = %s", slot, tostring(multival2))

                if (slot == 1) then
                    npc:setLocalVar("ITEM1AUGMENT2",aug2.aug)
                    npc:setLocalVar("ITEM1AUG2VAL",multival2 -1)
                elseif (slot == 2) then
                    npc:setLocalVar("ITEM2AUGMENT2",aug2.aug)
                    npc:setLocalVar("ITEM2AUG2VAL",multival2 -1)
                end
            end
        end
    end
end

function GiveAugItem(npc, player, slot)
    local chestid      = npc:getLocalVar("CHESTID")
    local chest        = GetNPCByID(chestid)
    local item1        = GetAugItemID(npc,1)
    local item2        = GetAugItemID(npc,2)
    local item1aug1    = GetAug(npc, 1, 1)
    local item1aug1val = GetAugVal(npc, 1, 1)
    local item1aug2    = GetAug(npc, 1, 2)
    local item1aug2val = GetAugVal(npc, 1, 2)
    local item2aug1    = GetAug(npc, 2, 1)
    local item2aug1val = GetAugVal(npc, 2, 1)
    local item2aug2    = GetAug(npc, 2, 2)
    local item2aug2val = GetAugVal(npc, 2, 2)
    
    if (slot == 1) then
        if (chest:getLocalVar("ITEM1ID") == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, item1)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (GetAugItemID(npc,1) ~= 0) then
                    player:addItem(item1,1,item1aug1,item1aug1val,item1aug2,item1aug2val)
                    MessageChest(player,zones[player:getZoneID()].text.OBTIANS_THE_ITEM,item1,0,0,0)
                    chest:setLocalVar("ITEM1ID",0)
                end
            end
        end
    elseif (slot == 2) then
        if (chest:getLocalVar("ITEM2ID") == 0) then
            player:messageSpecial(zones[player:getZoneID()].text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(zones[player:getZoneID()].text.ITEM_CANNOT_BE_OBTAINED, item2)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (GetAugItemID(npc,2) ~= 0) then
                    player:addItem(item2,1,item2aug1,item2aug1val,item2aug2,item2aug2val)
                    MessageChest(player,zones[player:getZoneID()].text.OBTIANS_THE_ITEM,item2,0,0,0)
                    chest:setLocalVar("ITEM2ID",0)
                end
            end
        end
    end

    if (npc:getLocalVar("ITEM1ID") == 0 and npc:getLocalVar("ITEM2ID") == 0) then
        RemoveChest(player,npc,0,3)
    end      
end

----------------------------------------------------------------------------------
-- Basic item functions
----------------------------------------------------------------------------------
function GetRandItem(zoneid, tier)
    local rand = 1
    local item = 0
    rand = math.random(1,#tpz.pyxis.data.itemdrops[zoneid] - tpz.pyxis.data.itemTierDeductions[zoneid][tier])

    item = tpz.pyxis.data.itemdrops[zoneid][rand]
    --printf("randitem = %s", tostring(item))

    if (item == 0 or item == nil) then
        return 0
    else
        return item
    end
end

function GetChestItem(npc, slot)
    local query   = string.format("ITEM" ..slot.. "")
    local var     = npc:getLocalVar(query)

    if (var == nil) then
        return 0
    else
        return var
    end
end

function GetLootTable(player, npc)
    local loot = {}

    for i = 1, 8 do
        table.insert(loot, npc:getLocalVar("ITEM" ..i))
    end
    return loot
end

function SetItems(npc, item1, item2, item3, item4, item5, item6, item7, item8)
    npc:setLocalVar("ITEM1",item1)
    npc:setLocalVar("ITEM2",item2)
    npc:setLocalVar("ITEM3",item3)
    npc:setLocalVar("ITEM4",item4)
    npc:setLocalVar("ITEM5",item5)
    npc:setLocalVar("ITEM6",item6)
    npc:setLocalVar("ITEM7",item7)
    npc:setLocalVar("ITEM8",item8)
    npc:setLocalVar("ITEMS_SET",1)
end

function GiveItem(player, npc, itemnum)
    local zoneId  = player:getZoneID()
    local ID      = zones[zoneId]
    local chestid = npc:getLocalVar("CHESTID")
    local chest   = GetNPCByID(chestid)
    local item1   = npc:getLocalVar("ITEM1")
    local item2   = npc:getLocalVar("ITEM2")
    local item3   = npc:getLocalVar("ITEM3")
    local item4   = npc:getLocalVar("ITEM4")
    local item5   = npc:getLocalVar("ITEM5")
    local item6   = npc:getLocalVar("ITEM6")
    local item7   = npc:getLocalVar("ITEM7")
    local item8   = npc:getLocalVar("ITEM8")
    
    if (itemnum == 1) then
        if (chest:getLocalVar("ITEM1") == 0) then
            player:messageSpecial(ID.text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item1)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (item1 ~= 0) then
                    player:addItem(item1,1,0,0,0,0)
                    MessageChest(player,ID.text.OBTIANS_THE_ITEM,item1,0,0,0,npc)
                    chest:setLocalVar("ITEM1",0)
                end
            end
        end
    elseif (itemnum == 2) then
        if (chest:getLocalVar("ITEM2") == 0) then
            player:messageSpecial(ID.text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item2)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (item2 ~= 0) then
                    player:addItem(item2,1,0,0,0,0)
                    MessageChest(player,ID.text.OBTIANS_THE_ITEM,item2,0,0,0,npc)
                    chest:setLocalVar("ITEM2",0)
                end
            end
        end
    elseif (itemnum == 3) then
        if (chest:getLocalVar("ITEM3") == 0) then
            player:messageSpecial(ID.text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item3)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (item3 ~= 0) then
                    player:addItem(item3,1,0,0,0,0)
                    MessageChest(player,ID.text.OBTIANS_THE_ITEM,item3,0,0,0,npc)
                    chest:setLocalVar("ITEM3",0)
                end
            end
        end
    elseif (itemnum == 4) then
        if (chest:getLocalVar("ITEM4") == 0) then
            player:messageSpecial(ID.text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item4)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (item4 ~= 0) then
                    player:addItem(item4,1,0,0,0,0)
                    MessageChest(player,ID.text.OBTIANS_THE_ITEM,item4,0,0,0,npc)
                    chest:setLocalVar("ITEM4",0)
                end
            end
        end
    elseif (itemnum == 5) then
        if (chest:getLocalVar("ITEM5") == 0) then
            player:messageSpecial(ID.text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item5)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (item5 ~= 0) then
                    player:addItem(item5,1,0,0,0,0)
                    MessageChest(player,ID.text.OBTIANS_THE_ITEM,item5,0,0,0,npc)
                    chest:setLocalVar("ITEM5",0)
                end
            end
        end
    elseif (itemnum == 6) then
        if (chest:getLocalVar("ITEM6") == 0) then
            player:messageSpecial(ID.text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item6)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (item6 ~= 0) then
                    player:addItem(item6,1,0,0,0,0)
                    MessageChest(player,ID.text.OBTIANS_THE_ITEM,item6,0,0,0,npc)
                    chest:setLocalVar("ITEM6",0)
                end
            end
        end
    elseif (itemnum == 7) then
        if (chest:getLocalVar("ITEM7") == 0) then
            player:messageSpecial(ID.text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item7)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (item7 ~= 0) then
                    player:addItem(item7,1,0,0,0,0)
                    MessageChest(player,ID.text.OBTIANS_THE_ITEM,item7,0,0,0,npc)
                    chest:setLocalVar("ITEM7",0)
                end
            end
        end
    elseif (itemnum == 8) then
        if (chest:getLocalVar("ITEM8") == 0) then
            player:messageSpecial(ID.text.ITEM_DISAPPEARED)
            return 0
        else
            if (player:getFreeSlotsCount() == 0) then -- NOTE: check a var or somthing for the item
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item8)
                return 0
            elseif (player:getFreeSlotsCount() > 0) then
                 if (item8 ~= 0) then
                    player:addItem(item8,1,0,0,0,0)
                    MessageChest(player,ID.text.OBTIANS_THE_ITEM,item8,0,0,0,npc)
                    chest:setLocalVar("ITEM8",0)
                end
            end
        end
    end

    if (npc:getLocalVar("ITEM1") == 0 and
        npc:getLocalVar("ITEM2") == 0 and
        npc:getLocalVar("ITEM3") == 0 and
        npc:getLocalVar("ITEM4") == 0 and
        npc:getLocalVar("ITEM5") == 0 and
        npc:getLocalVar("ITEM6") == 0 and
        npc:getLocalVar("ITEM7") == 0 and
        npc:getLocalVar("ITEM8") == 0) then

        RemoveChest(player,npc,0,3)
    end     
end

----------------------------------------------------------------------
-- 
----------------------------------------------------------------------
tpz.pyxis.onPyxisTrade = function(player,npc,trade)
    local zoneId     = player:getZoneID()
    local ID         = zones[zoneId]
    local chestid    = npc:getID()
    local tier       = npc:getLocalVar("TIER")
    local loottype   = npc:getLocalVar("LOOT_TYPE")
    local chestowner = npc:getLocalVar("PARTYID")
    local party      = {}

    party = player:getAlliance()

    if not player:getLeaderID() == chestowner then
        if player:getPartySize() < 2 then
            return ID.text.CANNOT_OPEN_CHEST
        else
            return ID.text.PARTY_NOT_OWN_CHEST
        end
    end

    if npc:AnimationSub() == 12 then
        if trade:hasItemQty(2490,1) and trade:getItemCount() == 1 then
            player:tradeComplete() -- NOTE: Uncomment once test it complete!
            GetDrops(npc,loottype,tier,player:getZoneID())
            MessageChest(player,ID.text.TRADE_KEY_OPEN,2490,0,0,0,npc)
            OpenChest(player,npc)
        end 
    end
end
tpz.pyxis.onPyxisTrigger = function(player,npc)
    ------------------------------------------------------------------
    -- Basic chest var's
    ------------------------------------------------------------------
    local zoneId          = player:getZoneID()
    local ID              = zones[zoneId]
    local killer          = GetPlayerByID(npc:getLocalVar("KILLER"))
    local chestid         = npc:getID()
    local tier            = npc:getLocalVar("TIER")
    local size            = npc:getLocalVar("SIZE")
    local timeleft        = os.time() - npc:getLocalVar("[pyxis]SPAWNTIME")
    local itemtype        = npc:getLocalVar("LOOT_TYPE")        -- Type: 1 Temps, 2 Items, 3 aug items, 4 keyitems
    local locktype        = npc:getLocalVar("LOCKTYPE")         -- 1:Blue "twist dial" || 2:Red "pressure" || 3:Gold "enter two-digit combination (10~99)". 
    local chestowner      = npc:getLocalVar("PARTYID")          -- the id of the party that has rights to the chest.
    local playerpartyid   = player:getLeaderID()
    local messagetype     = npc:getLocalVar("PEEKMESSAGE")
    local keytype         = tpz.pyxis.data.contentMessage[messagetype] + locktype
    local aumentflag      = 0x0202                              -- this only seems to work as a hex value
    local cs_base         = 2004                                -- base id of all cs's this should not change, but if it does, can adjust here
    local eventbase       = ID.npc.Sturdy_Pyxis_Base
    local lockedEvent     = chestid - eventbase + cs_base
    local unlockedEvent   = chestid - eventbase + cs_base + 64
    local required        = npc:getLocalVar("REQUIREDGUESSES")
    local attemptsallowed = 5
    local failedatempts   = npc:getLocalVar("FAILED_ATEMPTS")

    if playerpartyid ~= chestowner then
        if player:getLeaderID() ~= player:getID() then
            player:messageSpecial(ID.text.PARTY_NOT_OWN_CHEST)
        else
            player:messageSpecial(ID.text.CANNOT_OPEN_CHEST)
        end
        return
    end

    timeleft = timeleft * 60

    ------------------------------------------------------------------
    -- Blue chest var's
    ------------------------------------------------------------------
    
    local currentatempts  = npc:getLocalVar("CURRENT_ATEMPTS") -- Current Progress/Successful atempts made
    local targetnumber    = npc:getLocalVar("RAND_NUM")
    
    ------------------------------------------------------------------
    -- Red chest var's
    ------------------------------------------------------------------

    local targetpressure  = targetnumber
    local currentpressure = npc:getLocalVar("CURRENTPRESSURE")
    local pressurerange   = 10
    local targetlow       = 0
    local targethigh      = 0

    local lockwearmessage  = npc:getLocalVar("LOCKWEARMESSAGE") -- 0-3 good -> bad 
    
    if (lockwearmessage == 0 or lockwearmessage == nil) then
        lockwearmessage = math.random(1,4)
    end

    local lockwear    = {[1] = {max = 5},[2] = {max = 10},[3] = {max = 15},[4] = {max = 30}}
    local lockwearmax = lockwear[lockwearmessage].max

    if (currentpressure <= 0) then
        if (targetnumber < 50) then
            currentpressure = math.random(targetnumber + 10,150)
        elseif (targetnumber > 50) then
            currentpressure = math.random(1,targetnumber - 10)
        end
        npc:setLocalVar("CURRENTPRESSURE", currentpressure)
    end

    targetlow  = targetpressure - pressurerange
    targethigh = targetpressure + pressurerange

    npc:setLocalVar("LOCKWEARADD",math.random(0,lockwearmax))
    --printf("lockwearmessage = %s", tostring(lockwearmessage))
    --printf("RAND_NUM = %s", tostring(targetnumber))
    ------------------------------------------------------------------
    -- Gold chest var's
    ------------------------------------------------------------------

    local highnumber = 0

    if (tier == 1) then
        highnumber = 33
    elseif (tier == 2) then
        highnumber = 44
    elseif (tier == 3) then
        highnumber = 55
    elseif(tier >= 4) then
        if (size == 1155) then
            highnumber = 90
        else
            highnumber = 77
        end
    end

    GetDrops(npc,itemtype,tier,player:getZoneID())

    if (lockedEvent > 2067) then
        lockedEvent = lockedEvent + 80     -- added because there is a jump in npc id's
    end

    if (unlockedEvent > 2131) then
        unlockedEvent = unlockedEvent + 80 -- added because there is a jump in npc id's
    end

    --printf("lockedEvent onTrigger = %i", lockedEvent)
    --printf("UnlockedEvent onTrigger = %i", unlockedEvent)

    --------------------------------------------------
    -- Chest Locked
    -------------------------------------------------
    if (npc:AnimationSub() == 12) then
        if (locktype == 1) then
            player:startEvent(lockedEvent, keytype, targetnumber, currentatempts, required, failedatempts, attemptsallowed, 3, timeleft) -- Blue
        elseif (locktype == 2) then
            player:startEvent(lockedEvent, keytype, currentpressure, bit.bor(targetlow,bit.lshift(targethigh,16)), lockwearmessage -1, attemptsallowed, currentatempts, 3, timeleft) -- Red
        elseif (locktype == 3) then
            player:startEvent(lockedEvent, keytype, 11, highnumber, attemptsallowed, currentatempts, targetnumber, 3, timeleft) -- Gold
        end
    --------------------------------------------------
    -- Chest Unlocked
    -------------------------------------------------
    elseif (npc:AnimationSub() == 13) then -- NOTE: Maybe change this incase players can alter npc animations
        if (itemtype == 10) then
            itemtype = 1
        end

        player:startEvent(unlockedEvent, 1, 1, 1, itemtype, 1, timeleft, 1, 1) -- Gold
    end
end

tpz.pyxis.onPyxisEventUpdate = function(player,csid,option,input)
    local zoneId         = player:getZoneID()
    local ID             = zones[zoneId]
    local npc            = player:getEventTarget()
    local chestid        = npc:getID()
    local aumentflag     = 0x0202
    local locktype       = npc:getLocalVar("LOCKTYPE")
    local itemtype       = npc:getLocalVar("LOOT_TYPE")
    local cs_base        = 2004
    local eventbase      = ID.npc.Sturdy_Pyxis_Base
    local lockedEvent    = chestid - eventbase + cs_base
    local unlockedEvent  = chestid - eventbase + cs_base + 64

    if lockedEvent > 2067 then
        lockedEvent = lockedEvent + 80
    end

    if unlockedEvent > 2131 then
        unlockedEvent = unlockedEvent + 80
    end
 
    --printf("lockedEvent onEventUpdate = %i", lockedEvent)
    --printf("unlockedEvent onEventUpdate = %i", unlockedEvent)
    if csid == lockedEvent and option ~= nil then
        --printf("option = %u", option)
        player:updateEvent(lockedEvent)
    end

    if itemtype == 1 then -- temps
        if csid == lockedEvent then
            player:updateEvent(GetTempDrop(npc,1), GetTempDrop(npc,2), GetTempDrop(npc,3), GetTempDrop(npc,4), GetTempDrop(npc,5), GetTempDrop(npc,6), GetTempDrop(npc,7), GetTempDrop(npc,8))
        elseif csid == unlockedEvent then 
            player:updateEvent(GetTempDrop(npc,1), GetTempDrop(npc,2), GetTempDrop(npc,3), GetTempDrop(npc,4), GetTempDrop(npc,5), GetTempDrop(npc,6), GetTempDrop(npc,7), GetTempDrop(npc,8))
        end
    elseif itemtype == 2 then -- basic items
        if csid == lockedEvent then
            player:updateEvent(GetChestItem(npc,1), GetChestItem(npc,2), GetChestItem(npc,3), GetChestItem(npc,4), GetChestItem(npc,5), GetChestItem(npc,6), GetChestItem(npc,7), GetChestItem(npc,8))
        elseif csid == unlockedEvent then 
            player:updateEvent(GetChestItem(npc,1), GetChestItem(npc,2), GetChestItem(npc,3), GetChestItem(npc,4), GetChestItem(npc,5), GetChestItem(npc,6), GetChestItem(npc,7), GetChestItem(npc,8))
        end  
    elseif itemtype == 3 then -- aug items
        if csid == lockedEvent then
            player:updateEvent(GetAugItemID(npc,1), aumentflag, GetAugID(npc,1,1), GetAugID(npc,1,2), GetAugItemID(npc,2), aumentflag, GetAugID(npc,2,1), GetAugID(npc,2,2))
        elseif csid == unlockedEvent then 
            player:updateEvent(GetAugItemID(npc,1), aumentflag, GetAugID(npc,1,1), GetAugID(npc,1,2), GetAugItemID(npc,2), aumentflag, GetAugID(npc,2,1), GetAugID(npc,2,2)) 
        end
    elseif itemtype == 4 then -- ki's
        if csid == lockedEvent then
            player:updateEvent(GetKiDrop(npc,1), GetKiDrop(npc,2), 0, 0, 0, 0, 0, 0)
        elseif csid == unlockedEvent then 
            player:updateEvent(GetKiDrop(npc,1), GetKiDrop(npc,2), 0, 0, 0, 0, 0, 0)
        end
    end

    --printf("UPDATE CSID: %u",csid)
    --printf("UPDATE OPTION: %u",option)
end

tpz.pyxis.onPyxisEventFinish = function(player,csid,option,npc)
    local zoneId           = player:getZoneID()
    local ID               = zones[zoneId]
    local playerid         = player:getID()
    local npc              = player:getEventTarget()
    local chestid          = npc:getID()
    local spawnstatus      = npc:getLocalVar("SPAWNSTATUS")
    local locktype         = npc:getLocalVar("LOCKTYPE")
    local loottype         = npc:getLocalVar("LOOT_TYPE")
    local correctnumber    = npc:getLocalVar("CORRECT_NUM")
    local currentatempts   = npc:getLocalVar("CURRENT_ATEMPTS")
    local failedatempts    = npc:getLocalVar("FAILED_ATEMPTS")
    local attemptsallowed  = 5
    local lastrand         = npc:getLocalVar("RAND_NUM")
    local newrand          = 0
    local requiredguesses  = npc:getLocalVar("REQUIREDGUESSES")
    local P_correctguesses = npc:getLocalVar("CORRECT_GUESSES")

    local targetpressure   = lastrand
    local currentpressure  = npc:getLocalVar("CURRENTPRESSURE")
    local pressurerange    = 10
    local pressurechange   = 0
    local targetlow        = targetpressure - pressurerange
    local targethigh       = targetpressure + pressurerange
    local lockwearmessage  = npc:getLocalVar("LOCKWEARMESSAGE") 
    local lockwearadd      = npc:getLocalVar("LOCKWEARADD")
    local targetnumber     = lastrand
    local itemremoved      = 0
    local cs_base          = 2004
    local eventbase        = ID.npc.Sturdy_Pyxis_Base
    local lockedEvent      = chestid - eventbase + cs_base
    local unlockedEvent    = chestid - eventbase + cs_base + 64
    local lockedchoice     = bit.lshift(1, option -1)
    local openchoice       = bit.lshift(1, option -65)
    local inputnumber      = bit.band(option, 0xFF) --bit.rshift(option, 16)
    local mask             = option
    
    if lockedEvent > 2067 then
        lockedEvent = lockedEvent + 80
    end

    if unlockedEvent > 2131 then
        unlockedEvent = unlockedEvent + 80
    end
    -- 11: 2048, 20: 1048576
    ----------------------------------------------------------------------
    -- Chest Locked Events
    ----------------------------------------------------------------------
    ------------------------------------
    -- Minigame 
    ------------------------------------
    if csid == lockedEvent then
        if option > 0 and spawnstatus ~= 1 then
            player:messageSpecial(ID.text.CHEST_DESPAWNED)
            return
        end

        if locktype == 1 then
            if lockedchoice == 1 then 
                newrand = math.random(10,99)
                npc:setLocalVar("RAND_NUM", newrand)

                if newrand > lastrand then -- check guesses
                    MessageChest(player,ID.text.RANDOM_SUCCESS_FAIL_GUESS,newrand,0,0,0,npc)

                    if P_correctguesses == nil or P_correctguesses == 0 then
                        npc:setLocalVar("CORRECT_GUESSES",1)
                    else
                        P_correctguesses = P_correctguesses + 1
                        npc:setLocalVar("CORRECT_GUESSES", P_correctguesses)
                    end

                    if P_correctguesses >= requiredguesses then
                        MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
                        OpenChest(player,player:getEventTarget())
                    elseif P_correctguesses < requiredguesses then
                        if (currentatempts == nil) then
                            npc:setLocalVar("CURRENT_ATEMPTS",1)
                        else
                            currentatempts = currentatempts + 1
                            npc:setLocalVar("CURRENT_ATEMPTS", currentatempts)
                        end
                    end
                else
                    MessageChest(player,ID.text.RANDOM_SUCCESS_FAIL_GUESS,newrand,1,0,0,npc)

                    if failedatempts == nil or failedatempts == 0 then
                        npc:setLocalVar("FAILED_ATEMPTS",1)
                    else
                        failedatempts = failedatempts + 1
                        npc:setLocalVar("FAILED_ATEMPTS", failedatempts)
                    end

                    if failedatempts >= attemptsallowed then
                        RemoveChest(player,npc,0,1)
                        MessageChest(player,ID.text.PLAYER_FAILED_LOCK,0,0,0,0,npc)
                        player:messageSpecial(ID.text.CHEST_DISAPPEARED)
                    end    
                end
            elseif lockedchoice == 2 then
                newrand = math.random(10,99)
                npc:setLocalVar("RAND_NUM", newrand)

                if newrand < lastrand then -- check guesses
                    MessageChest(player,ID.text.RANDOM_SUCCESS_FAIL_GUESS,newrand,0,0,0,npc)

                    if P_correctguesses == nil or P_correctguesses == 0 then
                        npc:setLocalVar("CORRECT_GUESSES",1)
                    else
                        P_correctguesses = P_correctguesses + 1
                        npc:setLocalVar("CORRECT_GUESSES", P_correctguesses)
                    end

                    if P_correctguesses >= requiredguesses then
                        MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
                        OpenChest(player,player:getEventTarget())
                    elseif P_correctguesses < requiredguesses then
                        if currentatempts == nil then
                            npc:setLocalVar("CURRENT_ATEMPTS",1)
                        else
                            currentatempts = currentatempts + 1
                            npc:setLocalVar("CURRENT_ATEMPTS", currentatempts)
                       end
                    end
                else
                    MessageChest(player,ID.text.RANDOM_SUCCESS_FAIL_GUESS,newrand,1,0,0,npc)

                    if failedatempts == nil then
                        npc:setLocalVar("FAILED_ATEMPTS",1)
                    else
                        failedatempts = failedatempts + 1
                        npc:setLocalVar("FAILED_ATEMPTS", failedatempts)
                    end

                    if failedatempts >= attemptsallowed then
                        RemoveChest(player,npc,0,1)
                        MessageChest(player,ID.text.PLAYER_FAILED_LOCK,0,0,0,0,npc)
                        player:messageSpecial(ID.text.CHEST_DISAPPEARED)
                    end    
                end
            end
        elseif locktype == 2 then
            if lockedchoice == 1 then
                pressurechange = 10 + lockwearadd
                --printf("pressurechange = %s", tostring(-pressurechange))
                if currentpressure - pressurechange >= targetlow and currentpressure - pressurechange <= targethigh then
                    MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
                    OpenChest(player,npc)
                else
                    npc:setLocalVar("LOCKWEARMESSAGE",math.random(1,4))

                    if currentpressure - pressurechange > 0 then
                        npc:setLocalVar("CURRENTPRESSURE", currentpressure - pressurechange)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,0,nil,currentpressure - pressurechange,npc)
                    else
                        npc:setLocalVar("CURRENTPRESSURE", 0)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,0,nil,0,npc)
                    end
                    
                    if currentatempts == nil or currentatempts == 0 then
                        npc:setLocalVar("CURRENT_ATEMPTS",1)
                    else
                        if currentatempts < 5 then
                            currentatempts = currentatempts + 1
                            npc:setLocalVar("CURRENT_ATEMPTS", currentatempts)
                        else
                            RemoveChest(player,npc,0,1)
                            MessageChest(player,ID.text.PLAYER_FAILED_LOCK,0,0,0,0,npc)
                            player:messageSpecial(ID.text.CHEST_DISAPPEARED)
                        end
                    end
                end
            elseif lockedchoice == 2 then
                pressurechange = 20 + lockwearadd
                --printf("pressurechange = %s", tostring(-pressurechange))
                if currentpressure - pressurechange >= targetlow and currentpressure - pressurechange <= targethigh then
                    MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
                    OpenChest(player,player:getEventTarget())
                else
                    npc:setLocalVar("LOCKWEARMESSAGE",math.random(1,4))

                    if currentpressure - pressurechange > 0 then
                        npc:setLocalVar("CURRENTPRESSURE", currentpressure - pressurechange)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,0,nil,currentpressure - pressurechange,npc)
                    else
                        npc:setLocalVar("CURRENTPRESSURE", 0)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,0,nil,0,npc)
                    end

                    if currentatempts == nil or currentatempts == 0 then
                        npc:setLocalVar("CURRENT_ATEMPTS",1)
                    else
                        if currentatempts < 4 then
                            currentatempts = currentatempts + 1
                            npc:setLocalVar("CURRENT_ATEMPTS", currentatempts)
                        else
                            RemoveChest(player,npc,0,1)
                            MessageChest(player,ID.text.PLAYER_FAILED_LOCK,0,0,0,0,npc)
                            player:messageSpecial(ID.text.CHEST_DISAPPEARED)
                        end
                    end
                end
            elseif lockedchoice == 4 then
                pressurechange = 30 + lockwearadd
                --printf("pressurechange = %s", tostring(-pressurechange))
                if currentpressure - pressurechange >= targetlow and currentpressure - pressurechange <= targethigh then
                    MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
                    OpenChest(player,npc)
                else
                    npc:setLocalVar("LOCKWEARMESSAGE",math.random(1,4))

                    if currentpressure - pressurechange > 0 then
                        npc:setLocalVar("CURRENTPRESSURE", currentpressure - pressurechange)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,0,nil,currentpressure - pressurechange,npc)
                    else
                        npc:setLocalVar("CURRENTPRESSURE", 0)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,1,nil,0,npc)
                    end

                    if currentatempts == nil or currentatempts == 0 then
                        npc:setLocalVar("CURRENT_ATEMPTS",1)
                    else
                        if currentatempts < 4 then
                            currentatempts = currentatempts + 1
                            npc:setLocalVar("CURRENT_ATEMPTS", currentatempts) 
                        else
                            RemoveChest(player,npc,0,1)
                            MessageChest(player,ID.text.PLAYER_FAILED_LOCK,0,0,0,0,npc)
                            player:messageSpecial(ID.text.CHEST_DISAPPEARED)
                        end
                    end
                end
            elseif lockedchoice == 8 then
                pressurechange = 10 + lockwearadd
                --printf("pressurechange = %s", tostring(pressurechange))
                if currentpressure + pressurechange >= targetlow and currentpressure + pressurechange <= targethigh then
                    MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
                    OpenChest(player,npc)
                else
                    npc:setLocalVar("LOCKWEARMESSAGE",math.random(1,4))

                    if currentpressure + pressurechange < 150 then
                        npc:setLocalVar("CURRENTPRESSURE", currentpressure + pressurechange)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,1,nil,currentpressure + pressurechange,npc)
                    else
                        npc:setLocalVar("CURRENTPRESSURE", 150)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,1,nil,150,npc)
                    end
                    
                    if currentatempts == nil or currentatempts == 0 then
                        npc:setLocalVar("CURRENT_ATEMPTS",1)
                    else
                        if currentatempts < 4 then
                            currentatempts = currentatempts + 1
                            npc:setLocalVar("CURRENT_ATEMPTS", currentatempts)
                        else
                            RemoveChest(player,npc,0,1)
                            MessageChest(player,ID.text.PLAYER_FAILED_LOCK,0,0,0,0,npc)
                            player:messageSpecial(ID.text.CHEST_DISAPPEARED)
                        end
                    end
                end
            elseif lockedchoice == 16 then
                pressurechange = 20 + lockwearadd
                --printf("pressurechange = %s", tostring(pressurechange))
                if currentpressure + pressurechange >= targetlow and currentpressure + pressurechange <= targethigh then
                    MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
                    OpenChest(player,npc)
                else  
                    npc:setLocalVar("LOCKWEARMESSAGE",math.random(1,4))

                    if currentpressure + pressurechange < 150 then
                        npc:setLocalVar("CURRENTPRESSURE", currentpressure + pressurechange)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,1,nil,currentpressure + pressurechange,npc)
                    else
                        npc:setLocalVar("CURRENTPRESSURE", 150)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,1,nil,150,npc)
                    end

                    if currentatempts == nil or currentatempts == 0 then
                        npc:setLocalVar("CURRENT_ATEMPTS",1)
                    else
                        if currentatempts < 4 then
                            currentatempts = currentatempts + 1
                            npc:setLocalVar("CURRENT_ATEMPTS", currentatempts)
                        else
                            RemoveChest(player,npc,0,1)
                            MessageChest(player,ID.text.PLAYER_FAILED_LOCK,0,0,0,0,npc)
                            player:messageSpecial(ID.text.CHEST_DISAPPEARED)
                        end
                    end
                end
            elseif lockedchoice == 32 then
                pressurechange = 30 + lockwearadd
                --printf("pressurechange = %s", tostring(pressurechange))
                if currentpressure + pressurechange >= targetlow and currentpressure + pressurechange <= targethigh then
                    MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
                    OpenChest(player,npc)
                else
                    npc:setLocalVar("LOCKWEARMESSAGE",math.random(1,4))

                    if currentpressure + pressurechange < 150 then
                        npc:setLocalVar("CURRENTPRESSURE", currentpressure + pressurechange)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,1,nil,currentpressure + pressurechange,npc)
                    else
                        npc:setLocalVar("CURRENTPRESSURE", 150)
                        MessageChest(player,ID.text.AIR_PRESSURE_CHANGE,pressurechange,1,nil,150,npc)
                    end

                    if currentatempts == nil or currentatempts == 0 then
                        npc:setLocalVar("CURRENT_ATEMPTS",1)
                    else
                        if currentatempts < 4 then
                            currentatempts = currentatempts + 1
                            npc:setLocalVar("CURRENT_ATEMPTS", currentatempts) 
                        else
                            RemoveChest(player,npc,0,1)
                            MessageChest(player,ID.text.PLAYER_FAILED_LOCK,0,0,0,0,npc)
                            player:messageSpecial(ID.text.CHEST_DISAPPEARED)
                        end
                    end
                end
            end
        elseif locktype == 3 then
            if inputnumber > 10 and inputnumber < 100 then
                local splitnumbers = {}

                for digit in string.gmatch(tostring(targetnumber), "%d") do
                    table.insert(splitnumbers,digit)
                end

                if inputnumber == targetnumber then
                    MessageChest(player,ID.text.INPUT_SUCCESS_FAIL_GUESS,inputnumber,1,0,0,npc) -- unlocking chest
                    MessageChest(player,ID.text.PLAYER_OPENED_LOCK,0,0,0,0,npc)
                    OpenChest(player,npc)
                else
                    MessageChest(player,ID.text.INPUT_SUCCESS_FAIL_GUESS,inputnumber,0,0,0,npc) -- nothing happens

                    if inputnumber > targetnumber then
                        player:messageSpecial(ID.text.GREATER_OR_LESS_THAN,inputnumber,1,0,0) -- greater
                        npc:setLocalVar("CURRENT_ATEMPTS",currentatempts + 1)
                    elseif inputnumber < targetnumber then
                        player:messageSpecial(ID.text.GREATER_OR_LESS_THAN,inputnumber,0,0,0) -- less
                        npc:setLocalVar("CURRENT_ATEMPTS",currentatempts + 1)
                    end

                    local randtext = math.random(1,5)
                    local firstsecond = math.random(1,100)

                    if randtext == 1 then
                        if firstsecond <= 50 then
                            player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_EVEN_ODD,0,isEven(splitnumbers[1]),0,0)
                        else
                            player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_EVEN_ODD,1,isEven(splitnumbers[2]),0,0)
                        end
                    elseif randtext == 2 then
                        if firstsecond <= 50 then
                            player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS,0,splitnumbers[1],0,0)
                        else
                            player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS,1,splitnumbers[2],0,0)
                        end
                    elseif randtext == 3 then
                        if firstsecond <= 50 then
                            if tonumber(splitnumbers[1]) < 4 then
                                player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS_OR,0,1,2,3)
                            elseif tonumber(splitnumbers[1]) > 3 and splitnumbers[1] < 6 then
                                player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS_OR,0,3,4,5)
                            elseif tonumber(splitnumbers[1]) > 7 then
                                player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS_OR,0,7,8,9)
                            end
                        else
                            if tonumber(splitnumbers[2]) < 4 then
                                player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS_OR,1,1,2,3)
                            elseif tonumber(splitnumbers[2]) > 3 and splitnumbers[2] < 6 then
                                player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS_OR,1,3,4,5)
                            elseif tonumber(splitnumbers[2]) > 7 then
                                player:messageSpecial(ID.text.HUNCH_SECOND_FIRST_IS_OR,1,7,8,9)
                            end
                        end
                    elseif randtext == 4 then
                        if firstsecond <= 50 then
                            player:messageSpecial(ID.text.HUNCH_ONE_DIGIT_IS,splitnumbers[1],0,0,0)
                        else
                            player:messageSpecial(ID.text.HUNCH_ONE_DIGIT_IS,splitnumbers[2],0,0,0)
                        end
                    elseif randtext == 5 then
                        local sum = tonumber(splitnumbers[1]) + tonumber(splitnumbers[2])
                        player:messageSpecial(ID.text.HUNCH_SUM_EQUALS,sum)
                    end
                end
            end
        end
    ----------------------------------------------------------------------
    -- Chest Open Events
    ----------------------------------------------------------------------
    
    elseif csid == unlockedEvent then
    ------------------------------------
    -- Grab items out of the chest
    ------------------------------------
        if option > 0 and spawnstatus ~= 1 then
            player:messageSpecial(ID.text.CHEST_DESPAWNED)
            return 0 
        end

        if openchoice == 1 then
            local selection  = bit.lshift(1, option -1)
            --printf("selection = %i",selection)

            if selection == 1 or selection == 2 then
                ----------------------------------
                -- Temps
                ----------------------------------
                if loottype == 1 then
                    if option == 65537 then
                        GiveTempItem(player, npc, 1)
                    elseif option == 131073 then
                        GiveTempItem(player, npc, 2)
                    elseif option == 196609 then
                        GiveTempItem(player, npc, 3)
                    elseif option == 262145 then
                        GiveTempItem(player, npc, 4)
                    elseif option == 327681 then
                        GiveTempItem(player, npc, 5)
                    elseif option == 393217 then
                        GiveTempItem(player, npc, 6)
                    elseif option == 458753 then
                        GiveTempItem(player, npc, 7)
                    elseif option == 524289 then
                        GiveTempItem(player, npc, 8)
                    end
                ----------------------------------
                -- Items
                ----------------------------------
                elseif loottype == 2 then
                    local loottable = {}
                    local obtaineditem = 0

                    loottable = GetLootTable(player,npc)

                    if option == 65537 then
                        --print("Item 1 selected")
                        GiveItem(player, npc, 1)
                    elseif option == 131073 then
                        --print("Item 2 selected")
                        GiveItem(player, npc, 2)
                    elseif option == 196609 then
                        --print("Item 3 selected")
                        GiveItem(player, npc, 3)
                    elseif option == 262145 then
                        --print("Item 4 selected")
                        GiveItem(player, npc, 4)
                    elseif option == 327681 then
                        --print("Item 5 selected")
                        GiveItem(player, npc, 5)
                    elseif option == 393217 then
                        --print("Item 6 selected")
                        GiveItem(player, npc, 6)
                    elseif option == 458753 then
                        --print("Item 7 selected")
                        GiveItem(player, npc, 7)
                    elseif option == 524289 then
                        --print("Item 8 selected")
                        GiveItem(player, npc, 8)
                    ------------------------------------
                    -- Add spoils to treasure
                    ------------------------------------
                    elseif option == 589825 then
                        for k,v in ipairs(loottable) do
                            AddItemToTresurePool(player,v)
                            --print(v)
                        end
                        
                        MessageChest(player,ID.text.ADD_SPOILS_TO_TREASURE,0,0,0,0,npc)
                        RemoveChest(player, npc, 0, 1)
                        ---- NOTE: NEED A CHECK HERE TO MAKE SURE ITS UPDATED AND CANT REMOVE THE SAME ITEM AGAIN
                    end
                    ----------------------------------
                    -- Augmented Items
                    ----------------------------------
                elseif loottype == 3 then
                    if option == 65537 then
                        GiveAugItem(npc, player, 1)
                    elseif option == 131073 then
                        GiveAugItem(npc, player, 2)
                    end
                    ----------------------------------
                    -- Key Items
                    ----------------------------------
                elseif loottype == 4 then
                    if option == 65537 then
                        GivePlayerKi(npc, player, 1)
                    elseif option == 131073 then
                        GivePlayerKi(npc, player, 2)
                    end
                end
            end
    ------------------------------------
    -- Destroying chest 
    ------------------------------------
        elseif openchoice == 2 then
            RemoveChest(player, npc, 1, 1)
        end
    end

    if option == 999 then
        RemoveChest(player, npc, 1, 1)   
    end

    --printf("FINNISH CSID: %u",csid)
    --printf("FINNISH OPTION: %u",option)
end
    ----------------------------------------------------------------------
    -- Desc: Messages sent to all players in a party in the zone
    ----------------------------------------------------------------------
function MessageChest(player,messageid,param1,param2,param3,param4)
    local zoneId = player:getZoneID()
    local ID = zones[zoneId]
    local party = player:getAlliance()

    for index,member in ipairs(party) do
        if member:getZoneID() == player:getZoneID() and member:isPC() then    
            member:messageName(messageid, player, param1, param2, param3, param4, nil)
        end
    end
end
    ----------------------------------------------------------------------
    -- Desc: Despawn a chest and reset its local var's
    ----------------------------------------------------------------------
function RemoveChest(player, npc, addcruor, delay)
    local zoneId = player:getZoneID()
    local ID = zones[zoneId]
    local chestid = npc:getID()
    local chest   = GetNPCByID(chestid)
    local tier    = npc:getLocalVar("TIER")
    local amount  = 10 * tier

    --print("Removing chest")

    if addcruor ~= 0 then
        player:addCurrency("cruor",amount)
        player:messageSpecial(ID.text.CRUOR_OBTAINED, amount,0,0,0)
    end
 
    npc:timer(delay * 1000, function(npc)
        npc:AnimationSub(12)
        npc:entityAnimationPacket("kesu")
        npc:setNpcFlags(3203, npc:getID())
        npc:setLocalVar("SPAWNSTATUS",0)
        npc:setStatus(tpz.status.DISAPPEAR)
        end)
end

function OpenChest(player, npc)
    local zoneId   = player:getZoneID()
    local ID       = zones[zoneId]
    local chestid  = npc:getLocalVar("CHESTID")
    local chest    = GetNPCByID(chestid)
    local party    = player:getPartyWithTrusts()
    local loottype = npc:getLocalVar("LOOT_TYPE")
    local tier     = npc:getLocalVar("TIER")

    --printf("OpenChest loottype = %s", tostring(loottype))
    --printf("OpenChest tier = %s", tostring(tier))
    --printf("OpenChest npc = %s", tostring(chest))
    -----------------------------------------------
    -- cruor
    -----------------------------------------------
    local cruoramout = npc:getLocalVar("CRUOR")
    -----------------------------------------------
    -- exp
    -----------------------------------------------
    local exp = npc:getLocalVar("EXP")
    -----------------------------------------------
    -- lights
    -----------------------------------------------
    local light  = npc:getLocalVar("LIGHT")
    -------------------------------------------------
    -- restore
    -------------------------------------------------
    local restoretype = chest:getLocalVar("RESTORE")
    -----------------------------------------------
    -- current amounts
    -----------------------------------------------
    local pearl  = player:getCharVar("pearlLight")
    local azure  = player:getCharVar("azureLight")
    local ruby   = player:getCharVar("rubyLight")
    local amber  = player:getCharVar("amberLight")
    local gold   = player:getCharVar("goldLight")
    local silver = player:getCharVar("silverLight")
    local ebon   = player:getCharVar("ebonLight")
    -------------------------------------------------
    -- set amounts
    -------------------------------------------------
    local pearlset  = npc:getLocalVar("PEARL_AMOUNT")
    local azureset  = npc:getLocalVar("AZURE_AMOUNT")
    local rubyset   = npc:getLocalVar("RUBY_AMOUNT")
    local amberset  = npc:getLocalVar("AMBER_AMOUNT")
    local goldset   = npc:getLocalVar("GOLD_AMOUNT")
    local silverset = npc:getLocalVar("SILVER_AMOUNT")
    local ebonset   = npc:getLocalVar("EBON_AMOUNT")
    
    npc:AnimationSub(13)

    if loottype == 9 then
        for p,member in ipairs(party) do
            if member:getZoneID() == player:getZoneID() then
                member:addExp(exp)
                --printf("giving exp to %s for %s", member:getName(), exp)
            end
        end
        RemoveChest(player, npc, 0, 3)
    elseif loottype == 7 then       
        for p,member in ipairs(party) do
            if member:getZoneID() == player:getZoneID() then
                if member:isPC() then
                    member:addCurrency("cruor",cruoramout)
                --printf("giving cruor to %s", member:getName())
                    member:messageSpecial(ID.text.CRUOR_OBTAINED,cruoramout)
                end
            end
        end
        RemoveChest(player, npc, 0, 3)
    elseif loottype == 8 then
        for p,member in ipairs(party) do
            if member:getZoneID() == player:getZoneID() and member:isPC() then
            -- TODO: add the time to visitent status effect
                member:messageSpecial(ID.text.VISITANT_EXTENDED,10,1)
                --printf("adding time to %s", member:getName())
            end
        end
        RemoveChest(player, npc, 0, 3)
    elseif loottype == 10 then
        local tempcount = 1
        tempcount = math.random(1,5)

        for i = 1, #tpz.pyxis.data.tempdrops[tier] do
            local item = tpz.pyxis.data.tempdrops[tier][math.random(1,#tpz.pyxis.data.tempdrops[tier])]
            for p,member in ipairs(party) do
                if member:isPC() and not member:hasItem(item,3) and member:getZoneID() == player:getZoneID() then
                    member:addTempItem(item, 1, 0, 0, 0, 0, 0, 0, 0, 0) 
                end
            end
        end

        for p,member in ipairs(party) do
            if member:isPC() then
                member:messageSpecial(ID.text.OBTAINES_SEVERAL_TEMPS,0,0,0,0)
            end
        end
        RemoveChest(player, npc, 0, 3)
    elseif loottype == 5 then
        --printf("light type = %s", tostring(light))
        for p,member in ipairs(party) do
            if member:getZoneID() == player:getZoneID() and member:isPC() then
                if light == 1 then
                    AddPlayerLights(member, 1, pearlset)
                elseif light == 2 then
                    AddPlayerLights(member, 2, azureset)
                elseif light == 3 then
                    AddPlayerLights(member, 3, rubyset)
                elseif light == 4 then
                    AddPlayerLights(member, 4, amberset)
                elseif light == 5 then
                    AddPlayerLights(member, 5, goldset)
                elseif light == 6 then
                    AddPlayerLights(member, 6, silverset)
                elseif light == 7 then
                    AddPlayerLights(member, 7, ebonset)
                end
            end
        end
        RemoveChest(player, npc, 0, 3)
    elseif loottype == 6 then
        if restoretype == 1 then
            player:restoreFromChest(npc,1)

            for p,member in ipairs(party) do
                if member:getZoneID() == player:getZoneID() then
                    local hp = member:getMaxHP() - member:getHP()
                    member:addHP(hp)
                    if member:isPC() then
                        member:messageBasic(tpz.msg.basic.RECOVERS_HP,0,hp)
                    end
                end
            end
            RemoveChest(player, npc, 0, 4)
        elseif restoretype == 2 then
            player:restoreFromChest(npc,2)
            for p,member in ipairs(party) do
                if member:getZoneID() == player:getZoneID() then
                    local mp = member:getMaxMP() - member:getMP()
                    member:addMP(mp)
                    if member:isPC() then
                        member:messageBasic(tpz.msg.basic.RECOVERS_MP,0,mp)
                    end
                end
            end
            RemoveChest(player, npc, 0, 4)
        elseif restoretype == 3 then
            player:restoreFromChest(npc,1)
            for p,member in ipairs(party) do
                if member:getZoneID() == player:getZoneID() then
                    member:addTP(1000)
                    if member:isPC() then
                        member:PrintToPlayer("TP increased by 1000", 29)
                    end
                end
            end
            RemoveChest(player, npc, 0, 4)
        elseif restoretype == 4 then
            player:restoreFromChest(npc,1)
            for p,member in ipairs(party) do
                if member:getZoneID() == player:getZoneID() then
                    local mp = member:getMaxMP() - member:getMP()
                    local hp = member:getMaxHP() - member:getHP()
                    member:addHP(hp)
                    member:addMP(mp)
                    member:addTP(3000)
                    if member:isPC() then
                        member:messageBasic(tpz.msg.basic.RECOVERS_HP_AND_MP)
                    end
                end
            end
            RemoveChest(player, npc, 0, 4)
        elseif restoretype == 5 then
            player:restoreFromChest(npc,1)
            for p,member in ipairs(party) do
                if member:getZoneID() == player:getZoneID() then
                    local mp = member:getMaxMP() - member:getMP()
                    local hp = member:getMaxHP() - member:getHP()
                    member:addHP(hp)
                    member:addMP(mp)
                    member:addTP(3000)
                    member:resetRecasts()
                    if member:isPC() then
                        member:messageBasic(tpz.msg.basic.RECOVERS_HP_AND_MP)
                        member:messageBasic(tpz.msg.basic.ALL_ABILITIES_RECHARGED)
                    end
                end
            end
            RemoveChest(player, npc, 0, 4)
        end
    end
end
----------------------------------------------------------------------------------
-- Note: Adds an item or all items to the party's treasure pool
-- Example: AddItemToTresurePool(player, 13212)
----------------------------------------------------------------------------------

function AddItemToTresurePool(player, item)
    if (item > 0) then
        player:addTreasure(item, nil);
    end
end

function distance( x1, y1, x2, y2 )
    return math.sqrt( (x2-x1)^2 + (y2-y1)^2 )
end

function isEven(number)
    if (number % 2 == 0) then
        return 0
    else
        return 1
    end
end