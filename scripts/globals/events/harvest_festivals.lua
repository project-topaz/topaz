------------------------------------
-- Harvest Festivals
------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
------------------------------------
events = events or {}

events.harvest =
{
    skins =
    {
        orc = 1,
        quadav = 2,
        yagudo = 3,
        shade = 4,
        ghost = 5,
        hound = 6,
        skeleton = 7,
        goblin = 8,
    },
    decorations =
    {
        [tpz.zone.SOUTHERN_SAN_DORIA] = { 17719828, 17719829, 17719830 },
        [tpz.zone.NORTHERN_SAN_DORIA] = { 17723774, 17723775, 17723776, 17723777, 17723812, 17723809 },
        [tpz.zone.BASTOK_MINES] = { 17735939, 17735940, 17735941, 17735962, 17735959 },
        [tpz.zone.BASTOK_MARKETS] = { 17740139, 17740140, 17740141, 17740142, 17740143 },
        [tpz.zone.WINDURST_WATERS] = { 17752504, 17752505, 17752506, 17752507, 17752548, 17752545 },
        [tpz.zone.WINDURST_WOODS] = { 17764742, 17764743, 17764744 },
    },
    paths =
    {
        bastok =
        {
			-341.947, -10.004, -161.233,
			-342.947, -10.000, -161.233,
			-293.236, -10.004, -113.025,
			-269.164, -10.000, -112.511,
			-252.357, -9.035, -120.792,
			-235.528, -7.307, -121.165,
			-220.101, -6.000, -112.457,
			-204.516, -6.000, -96.995,
			-183.274, -6.000, -92.812,
			-176.764, -4.496, -92.719,
			-128.829, -4.000, -116.708,
			-88.801, -4.000, -117.891,
			-87.382, -4.000, -95.879,
			-128.365, -4.000, -96.421,
			-174.522, -4.000, -76.303,
			-197.885, -6.000, -74.354,
			-202.041, -6.000, -71.868,
			-211.158, -6.000, -71.600,
			-242.170, -6.000, -73.933,
			-242.259, -12.000, -58.803,
			-247.025, -12.000, -58.045,
			-247.423, -12.000, -48.479,
			-233.237, -12.000, -33.047,
			-176.753, -8.000, -32.376,
			-177.835, -8.000, -28.725,
			-233.225, -12.000, -29.166,
			-268.216, -12.000, -39.695,
			-302.634, -12.000, -40.728,
			-305.552, -12.000, -77.681,
			-282.239, -12.000, -97.816,
			-283.032, -10.000, -103.797,
			-293.000, -10.000, -111.000
        },
        sandoria =
        {
            -137.374, 12.000, 212.743,
            -135.374, 12.000, 212.743,
            -167.785, 4.000, 209.809,
            -168.421, 0.000, 188.252,
            -175.333, 0.000, 176.733,
            -176.500, 0.000, 145.882,
            -152.745, 0.000, 120.791,
            -150.122, 0.000, 95.297,
            -114.348, 0.000, 59.962,
            -29.079, 0.000, 59.055,
            -20.919, 0.000, 51.736,
            -24.859, 0.000, 33.944,
            -15.757, 0.000, 20.051,
            12.735, 0.000, 18.732,
            22.612, 0.000, 35.347,
            52.339, 0.000, 33.471,
            52.704, 0.000, 45.022,
            23.446, 0.000, 46.562,
            4.500, 0.000, 63.700,
            -21.390, 0.000, 55.290,
            -29.438, 0.000, 61.563,
            -52.363, 0.000, 62.577,
            -110.723, 0.000, 60.871,
            -133.042, 0.000, 80.892,
            -151.257, 0.000, 110.707,
            -150.350, 0.000, 122.660,
            -123.971, 0.000, 135.001,
            -122.497, 0.000, 171.776,
            -126.629, 0.000, 185.903,
            -115.159, 6.000, 198.638,
            -128.129, 12.000, 210.372,
            -138.000, 12.000, 210.000,
        },
        windurst =
        {
            {
                148.130, -2.500, 207.123,
                149.130, -2.500, 207.123,
                147.786, -2.500, 134.164,
                124.204, -2.500, 111.512,
                123.452, -2.144, 96.057,
                111.027, -2.000, 84.118,
                106.145, -2.000, 71.278,
                119.384, -1.965, 47.941,
                77.013, -2.101, 27.110,
                45.473, -2.000, 45.489,
                33.554, -2.000, 49.778,
                33.554, -2.000, 49.778,
                -2.460, -1.000, 50.451,
                -2.944, -1.000, 71.288,
                -10.710, -5.000, 86.862,
                -37.590, -5.000, 88.158,
                -40.078, -5.000, 123.984,
                -44.125, -5.000, 85.544,
                -81.171, -5.000, 86.720,
                -78.780, -3.500, 63.466,
                -104.828, -2.000, 52.330,
                -105.515, -2.000, 39.306,
                -99.201, -3.500, 23.543,
                -43.688, -2.000, 1.276,
                -31.915, -2.000, 6.077,
                -30.372, -3.500, 37.840,
                -6.074, -1.000, 37.294,
                3.247, -1.000, 50.296,
                33.971, -2.000, 49.355,
                59.718, -2.109, 38.167,
                73.141, -2.116, 26.886,
                85.250, -2.500, 29.840,
                118.528, -1.979, 49.170,
                107.773, -2.166, 69.715,
                111.054, -2.000, 84.144,
                123.245, -2.112, 94.284,
                125.542, -2.500, 113.878,
                148.683, -2.500, 136.279,
                148.662, 0.000, 183.685,
                118.668, 0.000, 184.553,
                116.580, 0.000, 169.693,
                98.244, -2.500, 171.419,
                98.426, -2.500, 202.653,
                145, 0, 211
            },
            {
                8.888, -1.000, 22.891,
                8.788, -1.000, 22.691,
                -7.035, -1.000, 21.795,
                -8.821, -2.000, -24.073,
                -45.499, -2.632, -65.225,
                -43.493, -3.401, -75.936,
                -36.120, -2.500, -90.229,
                -36.084, -2.500, -102.374,
                -4.649, -2.500, -135.233,
                -4.321, -4.000, -181.148,
                -42.469, -1.000, -180.298,
                -76.639, -1.000, -163.456,
                -112.138, -1.000, -162.446,
                -155.553, -2.166, -180.748,
                -176.367, -1.492, -180.721,
                -189.488, -0.054, -170.694,
                -203.669, -1.640, -173.720,
                -205.304, -1.808, -184.690,
                -225.577, -1.907, -224.560,
                -242.360, -3.104, -231.883,
                -245.484, -3.000, -254.458,
                -242.231, -3.060, -268.685,
                -243.057, -3.000, -295.611,
                -236.585, -3.000, -295.444,
                -239.779, -2.766, -266.985,
                -220.064, -1.610, -224.771,
                -218.331, -0.475, -212.793,
                -201.731, -1.943, -179.814,
                -222.445, -1.274, -139.862,
                -220.428, -3.132, -120.915,
                -205.092, -3.250, -111.478,
                -210.662, -2.302, -134.882,
                -219.147, -0.633, -145.515,
                -205.863, -1.681, -172.294,
                -185.662, -0.296, -173.420,
                -142.489, -1.805, -179.430,
                -108.894, -1.000, -159.810,
                -84.731, -1.000, -160.901,
                -53.749, -1.000, -169.109,
                -50.925, -2.500, -118.561,
                -35.840, -2.500, -100.982,
                -36.630, -2.500, -86.128,
                -40.215, -3.000, -56.350,
                -7.831, -2.000, -23.366,
                -9.264, -1.000, 31.940,
                9.922, -1.000, 34.360,
                9, 0, 23
            },
        },
    },
}

function events.harvest.initZone(zone)
    if isHalloweenEnabled() ~= 0 then
        applyHalloweenNpcCostumes(zone:getID(),true)
        applyHalloweenDecorations(zone:getID(),true)
    end
    events.harvest.registerRegions(zone)
end

function events.harvest.registerRegions(zone)
    switch (zone:getID()): caseof
    {
        [tpz.zone.SOUTHERN_SAN_DORIA] = zone:registerRegion( 7,  122.602,  0.0,   72.500,  125.000,  0.0,   75.625 ), -- Pitchfork
        [tpz.zone.NORTHERN_SAN_DORIA] = function ()
                zone:registerRegion( 7, -172.253,  0.0,  129.389, -170.047,  0.0,  134.279 ) -- Pitchfork
                zone:registerRegion( 8, -235.279,  8.0,   15.879, -233.569,  8.0,   19.925 ) -- Pitchfork +1
                end,
        [tpz.zone.BASTOK_MINES] = zone:registerRegion( 1,  -32.442,  0.0,  -29.566,  -30.090,  0.0,  -26.070 ), -- Pitchfork
        [tpz.zone.BASTOK_MARKETS] = function ()
                zone:registerRegion( 1, -123.230, -4.0, -134.556, -119.557, -4.0, -130.665 ) -- Pitchfork
                zone:registerRegion( 2, -255.105,  0.0,   81.564, -253.085,  0.0,   85.509 ) -- Pitchfork +1
                end,
        [tpz.zone.WINDURST_WATERS] = function ()
                zone:registerRegion( 2, -113.177, -2.0,   39.484, -110.866, -2.0,   41.984 ) -- Pitchfork
                zone:registerRegion( 3,  141.731,  0.0,  152.559,  143.153,  0.0,  154.663 ) -- Pitchfork +1
                end,
        [tpz.zone.WINDURST_WOODS] = zone:registerRegion( 1,  -30.427, -3.5,    1.833,  -27.999,  3.5,    3.965 ), -- Pitchfork
    }
end

function isHalloweenEnabled()
    local option = 0
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))
    if (month == 10 and day >= 20 or month == 11 and day == 1 or HALLOWEEN_YEAR_ROUND ~= 0) then -- According to wiki Harvest Fest is Oct 20 - Nov 1.
        if (HALLOWEEN_2005 == 1) then
            option = 1
        elseif (HALLOWEEN_2008 == 1) then
            option = 2
        elseif (HALLOWEEN_2009 == 1) then
            option = 3
        elseif (HALLOWEEN_2010 == 1) then
            option = 4
        end
    end
    return option
end

function halloweenItemsCheck(player)
    local headSlot = player:getEquipID(tpz.slot.HEAD)
    local mainHand = player:getEquipID(tpz.slot.MAIN)
    local reward = 0

    -- Normal Quality Rewards
    local pumpkinHead = 13916
    local pumpkinHead2 = 15176
    local trickStaff = 17565
    local trickStaff2 = 17587

    reward_list = {pumpkinHead, pumpkinHead2, trickStaff, trickStaff2}

    -- Checks for HQ Upgrade
    if (headSlot == pumpkinHead and player:hasItem(13917) == false) then
        reward = 13917 -- Horror Head
    elseif (headSlot == pumpkinHead2 and player:hasItem(15177) == false) then
        reward = 15177 -- Horror Head II
    elseif (mainHand == trickStaff and player:hasItem(17566) == false) then
        reward =  17566 -- Treat Staff
    elseif (mainHand == trickStaff2 and player:hasItem(17588) == false) then
        reward = 17588 -- Treat Staff II
    end
    if reward ~= 0 then
        return reward
    end

    -- Checks the possible item rewards to ensure player doesnt already have the item we are about to give them
    local cnt = #reward_list
    while cnt ~= 0 do
        local picked = reward_list[math.random(1, #reward_list)]
        if (player:hasItem(picked) == false) then
            reward = picked
            cnt = 0
        else
            table.remove(reward_list, picked)
            cnt = cnt - 1
        end
    return reward
    end
end

function onHalloweenTrade(player, trade, npc)
    local zone = player:getZoneID()
    local ID = zones[player:getZoneID()]
    local contentEnabled = isHalloweenEnabled()
    local item = trade:getItemId()
    -------------------
    -- 2005 edition ---
    -------------------
    if (contentEnabled == 1) then
        -----------------------------------
        -- Treats allowed
        -----------------------------------
        local treats_table =
        {
            4510, -- Acorn Cookie
            5646, -- Bloody Chocolate
            4496, -- Bubble Chocolate
            4397, -- Cinna-cookie
            4394, -- Ginger Cookie
            4495, -- Goblin Chocolate
            4413, -- Apple Pie
            4488, -- Jack-o'-Pie
            4421, -- Melon Pie
            4563, -- Pamama Tart
            4446, -- Pumpkin Pie
            4414, -- Rolanberry Pie
            4406, -- Baked Apple
            5729, -- Bavarois
            5745, -- Cherry Bavarois
            5653, -- Cherry Muffin
            5655, -- Coffee Muffin
            5718, -- Cream Puff
            5144, -- Crimson Jelly
            5681, -- Cupid Chocolate
            5672, -- Dried Berry
            5567, -- Dried Date
            4556, -- Icecap Rolanberry
            5614, -- Konigskuchen
            5230, -- Love Chocolate
            4502, -- Marron Glace
            4393, -- Orange Kuchen
            5147, -- Snoll Gelato
            4270, -- Sweet Rice Cake
            5645, -- Witch Nougat
            5552, -- Black Pudding  --safe
            5550, -- Buche au Chocolat -- safe @ 43 items
            5616, -- Lebkuchen House --breaks
            5633, -- Chocolate Cake
            5542, -- Gateau aux Fraises
            5572, -- Irmik Helvasi
            5625, -- Maple Cake
            5559, -- Mille Feuille
            5557, -- Mont Blanc
            5629, -- Orange Cake
            5631, -- Pumpkin Cake
            5577, -- Sutlac
            5627, -- Yogurt Cake
        }
        for itemInList = 1, #treats_table  do
            if (item == treats_table[itemInList]) then
                local itemReward = halloweenItemsCheck(player)
                local varName = "harvestFestTreats"
                if (itemInList >= 32) then -- The size of the list is too big for int 32 used that stores the bit mask, as such there are two lists
                    varName = "harvestFestTreats2"
                    itemInList = itemInList - 32
                end
                local harvestFestTreats = player:getCharVar(varName)
                local AlreadyTradedChk = utils.mask.getBit(harvestFestTreats, itemInList)
                if (itemReward ~= 0 and player:getFreeSlotsCount() >= 1 and math.random(1, 3) < 2) then -- Math.random added so you have 33% chance on getting item
                    if npcUtil.giveItem(player,itemReward) then
                        player:messageSpecial(ID.text.HERE_TAKE_THIS)
                    end
                elseif player:canUseMisc(tpz.zoneMisc.COSTUME) and not AlreadyTradedChk then
                    local Orc = math.random(612, 639)
                    local Quadav = math.random(644, 671)
                    local Yagudo = math.random(580, 607)
                    local Shade = 533  -- Fomor
                    local Ghost = 368
                    local Hound = 365
                    local Skeleton = 564
                    local Goblin = 488

                    local halloween_costume_list = { Orc, Quadav, Yagudo, Shade, Ghost, Hound, Skeleton, Goblin }
                    local costumePicked = halloween_costume_list[math.random(1, #halloween_costume_list)] -- will randomly pick one of the costumes in the list

                    if ID.npc.HALLOWEEN_SKINS[npc:getID()] then -- Check what costume the npc should give
                        costumePicked = halloween_costume_list[ID.npc.HALLOWEEN_SKINS[npc:getID()][3]]
                    end
                    local goblinhelper = { Orc, Quadav, Yagudo }
                    if player:getEquipID(tpz.slot.MAIN) == 18102 and goblinhelper[player:getNation()+1] == costumePicked then -- Check for goblin costume reward
                        costumePicked = player:getCharVar("harvestFestPitchForkZone") == zone and goblinhelper[player:getNation()+1] or Goblin
                    end
                    player:addStatusEffect(tpz.effect.COSTUME, costumePicked, 0, 3600)
                    player:setCharVar(varName, utils.mask.setBit(harvestFestTreats, itemInList, true))
                    -- pitchForkCostumeList defines the special costumes per zone that can trigger the pitch fork requirement
                    -- zone, costumeID
                    local pitchForkCostumeList =
                    {
                        [tpz.zone.SOUTHERN_SAN_DORIA] = { Ghost, Skeleton },
                        [tpz.zone.NORTHERN_SAN_DORIA] = { Hound, Skeleton },
                        [tpz.zone.BASTOK_MINES] = {  Shade, Skeleton },
                        [tpz.zone.BASTOK_MARKETS] = { Hound, Ghost },
                        [tpz.zone.WINDURST_WATERS] = { Shade, Hound },
                        [tpz.zone.WINDURST_WOODS] = { Ghost, Shade },
                    }
                    if costumePicked == pitchForkCostumeList[zone][1] or costumePicked == pitchForkCostumeList[zone][2] or costumePicked == Goblin then -- Gives special hint for pitch fork costume
                        player:messageSpecial(ID.text.IF_YOU_WEAR_THIS)
                    else
                        player:messageSpecial(ID.text.THANK_YOU_TREAT)
                    end
                else
                    player:messageSpecial(ID.text.THANK_YOU)
                end
                player:tradeComplete()
                break
            end
        end
    end
end

function checkHalloweenRegion(player,region)
    if not isHalloweenEnabled() then
        return 0
    end
    local ID = zones[player:getZoneID()]
    local pitchZone = player:getCharVar("harvestFestPitchForkZone")
    local zone = player:getZoneID()
    player:setCharVar("harvestFestPitchRegion",zone + (region * 1000) )
    local correctCostumes = 0
    local noFreeJacks = 0
    local rewards = {18102,18103}
    -- Region 1 nq pitchfork, 2 HQ pitchfork
    if player:getPartySize(0) == 2 then
        if region == 1 then -- Pitchfork Check
            local pitchForkCostumeList =
            {
                234, 533, 564, -- Bastok mines
                235, 365, 368, -- Bastok Markets
                230, 368, 564, -- Southern Sandoria
                231, 365, 564, -- Northern Sandoria
                241, 368, 533, -- Windurst Woods
                238, 533, 365  -- Windurst Waters
            }
            for _, member in pairs(player:getParty()) do
                local costume = member:hasStatusEffect(tpz.effect.COSTUME) and member:getStatusEffect(tpz.effect.COSTUME):getPower() or 0
                for zi = 1, #pitchForkCostumeList, 3 do
                    if
                    (zone == pitchForkCostumeList[zi] and costume == pitchForkCostumeList[zi + 1]) or
                    (zone == pitchForkCostumeList[zi] and costume == pitchForkCostumeList[zi + 2]) and
                    (member:getCharVar("harvestFestPitchRegion") - (region * 1000)) == pitchForkCostumeList[zi] -- Compare zone and region match
                    then
                        correctCostumes = correctCostumes + 1
                        pitchForkCostumeList[costume == pitchForkCostumeList[zi + 1] and zi + 1 or zi + 2] = 0
                    end

                    if not member:hasItem(rewards[region]) then
                        noFreeJacks = 1
                    end
                end
            end
        elseif region == 2 then -- Pitchfork+1 check
            for _, member in pairs(player:getParty()) do
                local costume = member:hasStatusEffect(tpz.effect.COSTUME) and member:getStatusEffect(tpz.effect.COSTUME):getPower() or 0
                if costume == 488 and (member:getCharVar("harvestFestPitchRegion") - (region * 1000)) == player:getZoneID() then
                    correctCostumes = correctCostumes + 1
                end

                if not member:hasItem(rewards[region]) then
                    noFreeJacks = 1
                end
           end
        end

        if correctCostumes == 2 and noFreeJacks == 1 then -- Two players with correct costume
            for _, member in pairs(player:getParty()) do
                if not member:hasItem(rewards[region]) then
                    if npcUtil.giveItem(member,rewards[region]) then
                        member:messageSpecial(ID.text.HERE_TAKE_THIS)
                        if region == 1 then
                            member:setCharVar("harvestFestPitchForkZone",zone)
                        end
                    end
                else
                    if npcUtil.giveItem(member, 4488) then
                        member:messageSpecial(ID.text.HERE_TAKE_THIS)
                    end
                end
            end
        end
    end
end

function clearHalloweenRegion(player)
    player:setCharVar("harvestFestPitchRegion",0)
end

function applyHalloweenDecorations(zone,enable)
    local decorationlist = events.harvest.decorations[zone]
    if decorationlist then
        for _, id in pairs(decorationlist) do
            local npc = GetNPCByID(id)
            if npc then
                npc:setStatus(enable and 0 or 2)
            end
        end
    end
end

function applyHalloweenNpcCostumes(zoneid,enable)
    local skinList = zones[zoneid].npc.HALLOWEEN_SKINS
    if skinList then
        for id, skinTable in pairs(skinList) do
            local npc = GetNPCByID(id)
            if npc then
                local index = enable and 1 or 2
                if skinTable[index] > 0 then
                    npc:setModelId(skinTable[index])
                else
                    npc:setStatus(enable and 0 or 2)
                end
                npc:setLookSize(index - 1)
            end
        end
    end
end

