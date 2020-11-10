------------------------------------
-- Login Campaign
------------------------------------
require("scripts/globals/status")

tpz = tpz or {}
tpz.logincampaign = tpz.logincampaign or {}

tpz.logincampaign.table =
{
    [2019] =
    {
        [11] =
        {
            [1] =
            {
                ["price"] = 10,
                ["items"] =
                {
                     1126,  -- Beastmen's Seal
                     1127,  -- Kindred's Seal
                     2955,  -- Kindred's Crest
                     2956,  -- High Kindred's Crest
                     2957,  -- Sacred Kindred's Crest
                     1857,  -- Cordial Invite
                     2306,  -- Martial Ball Invite
                     5364,  -- Training Grounds Key
                     2487,  -- Mercenary Camp Entry Slip
                     5741,  -- Flask Of Pest Repellent
                     3557,  -- Athena Orb
                     5113,  -- Cracked Nut
                     3541,  -- Seasoning Stone
                     3543,  -- Fossilized Fang
                     3542,  -- Fossilized Bone
                     5724,  -- Pungent Powder
                     6535,  -- Pungent Powder II
                     9890,  -- Tarazacum Orb
                },
            },

            [5] =
            {
                ["price"] = 100,
                ["items"] =
                {
                     8734,  -- Mog Kupon I-S1
                     8966,  -- Eudaemon Blade
                     8967,  -- Eudaemon Cape
                     8968,  -- Eudaemon Ring
                     8969,  -- Eudaemon Sash
                     8970,  -- Eudaemon Shield
                    17006,  -- Drill Calamary
                    17007,  -- Dwarf Pugil
                     6413,  -- Astral Cube
                     9891,  -- Zinnia Orb
                    10112,  -- Cipher: Zeid
                    10113,  -- Cipher: Lion
                    10118,  -- Cipher: Naja
                    10120,  -- Cipher: Lehko
                    10124,  -- Cipher: Luzaf
                    10125,  -- Cipher: Najelith
                    10129,  -- Cipher: Domina
                    10134,  -- Cipher: S. Sibyl
                    10142,  -- Cipher: Karaha
                    10149,  -- Cipher: Areuhat
                },
            },

            [9] =
            {
                ["price"] = 100,
                ["items"] =
                {
                    10136,  -- Cipher: Uka
                    10141,  -- Cipher: Kuyin
                    10144,  -- Cipher: Abenzio
                    10145,  -- Cipher: Rughadjeen
                    10150,  -- Cipher: Lhe
                    10151,  -- Cipher: Mayakov
                    10155,  -- Cipher: Brygid
                    10156,  -- Cipher: Mildaurion
                    10161,  -- Cipher: Rongelouts
                    10166,  -- Cipher: Robel-Akbel
                    10178,  -- Cipher: Ullegore
                    10179,  -- Cipher: Teodor
                    10183,  -- Cipher: Darrcuiln
                    20713,  -- Excalipoor
                     6008,  -- Copse Candy
                },
            },

            [13] =
            {
                ["price"] = 300,
                ["items"] =
                {
                    10187,  -- Cipher: Shantotto II
                    10069,  -- ♪Goobbue
                    10051,  -- ♪Crab
                    10058,  -- ♪Beetle
                    10384,  -- Cumulus Masque
                    20666,  -- Blizzard Brand
                    25658,  -- Wyrm. Masque +1
                    25757,  -- Wyrmking Suit +1
                     5854,  -- Frayed Pouch (B)
                     5855,  -- Frayed Pouch (A)
                     5856,  -- Frayed Pouch (G)
                     5857,  -- Frayed Pouch (D)
                     5858,  -- Frayed Pouch (R)
                     5946,  -- Frayed Sack (D)
                     5947,  -- Frayed Sack (L)
                     4064,  -- Rem's Tale Ch.1
                     4065,  -- Rem's Tale Ch.2
                     4066,  -- Rem's Tale Ch.3
                     4067,  -- Rem's Tale Ch.4
                     4068,  -- Rem's Tale Ch.5
                },
            },

            [17] =
            {
                ["price"] = 500,
                ["items"] =
                {
                    10073,  -- ♪Dhalmel
                },

            },

            [21] =
            {
                ["price"] = 750,
                ["items"] =
                {
                     9079,  -- Kitchen Brick
                     9080,  -- Kitchen StoveFacebook
                     9081,  -- Kitchen Plate
                     3339,  -- Honey Wine
                     3341,  -- Beastly Shank
                     3343,  -- Blue Pondweed
                     1873,  -- Brigand's Chart
                     1874,  -- Pirate's Chart
                     4069,  -- Copy Of Rem's Tale, Chapter 6
                     4070,  -- Copy Of Rem's Tale, Chapter 7
                     4071,  -- Copy Of Rem's Tale, Chapter 8
                     4072,  -- Copy Of Rem's Tale, Chapter 9
                     4073,  -- Copy Of Rem's Tale, Chapter 10
                },
            },

            [25] =
            {
                ["price"] = 1000,
                ["items"] =
                {
                     6499,  -- Patio Design Plans
                    26165,  -- Facility Ring
                    26164,  -- Caliber Ring
                     6486,  -- Frayed Sack (Pel)
                     6487,  -- Frayed Sack (Fer)
                     6488,  -- Frayed Sack (Tau)
                },
            },

            [29] =
            {
                ["price"] = 1500,
                ["items"] =
                {
                     3340,  -- Sweet Tea
                     3342,  -- Savory Shank
                     3344,  -- Red Pondweed
                     8720,  -- Maliya. Coral Orb
                     8722,  -- Hepatizon Ingot
                     8724,  -- Beryllium Ingot
                     8726,  -- Exalted Lumber
                     8728,  -- Sif's Macrame
                },
            },
        },
    },
}

tpz.logincampaign.check = function(player, npc)
    local loginPoints = 4200                   -- To be Changed for player:getLoginPoints()
    local cYear = CAMPAIGN_YEAR
    local cMonth = bit.lshift(CAMPAIGN_MONTH, 28)
    local cDate = bit.bor(cYear, cMonth)

    local price1 = tpz.logincampaign.table[cYear][cMonth][1]["price"]
    local price2 = bit.lshift(tpz.logincampaign.table[cYear][cMonth][5]["price"], 16)
    local price3 =  tpz.logincampaign.table[cYear][cMonth][9]["price"]
    local price4 = bit.lshift(tpz.logincampaign.table[cYear][cMonth][13]["price"], 16)
    local price5 = tpz.logincampaign.table[cYear][cMonth][17]["price"]
    local price6 = bit.lshift(tpz.logincampaign.table[cYear][cMonth][21]["price"], 16)
    local price7 = tpz.logincampaign.table[cYear][cMonth][25]["price"]
    local price8 = bit.lshift(tpz.logincampaign.table[cYear][cMonth][29]["price"], 16)

    local priceBit1 = bit.bor(price1, price2) -- set of 2 16bits
    local priceBit2 = bit.bor(price3, price4)
    local priceBit3 = bit.bor(price5, price6)
    local priceBit4 = bit.bor(price7, price8)

    player:startEvent(528, cDate, loginPoints, priceBit1, priceBit2, priceBit3, priceBit4)
end

tpz.logincampaign.eventupdate = function(player, csid, option)
    local showItems = bit.band(option, 31) -- first 32 bits are for showing correct item list
    local itemSelected = bit.band(bit.rshift(option, 5), 31)
    local itemQuantity = bit.band(bit.rshift(option, 11), 511)
    local cYear = CAMPAIGN_YEAR
    local cMonth = CAMPAIGN_MONTH

    if
        showItems == 1 or
        showItems == 5 or
        showItems == 9 or
        showItems == 13 or
        showItems == 17 or
        showItems == 21 or
        showItems == 25 or
        showItems == 29
    then
        local items = {}
        for i = 1, 20 do
            if tpz.logincampaign.table[cYear][cMonth][showItems]["items"][i] ~= nil then
                table.insert(items, tpz.logincampaign.table[cYear][cMonth][showItems]["items"][i])
            else
                table.insert(items, 0)
            end
        end

        player:updateEvent(
            bit.bor(items[1], bit.lshift(items[2], 16)),
            bit.bor(items[3], bit.lshift(items[4], 16)),
            bit.bor(items[5], bit.lshift(items[6], 16)),
            bit.bor(items[7], bit.lshift(items[8], 16)),
            bit.bor(items[9], bit.lshift(items[10], 16)),
            bit.bor(items[11], bit.lshift(items[12], 16)),
            bit.bor(items[13], bit.lshift(items[14], 16)),
            bit.bor(items[15], bit.lshift(items[16], 16))
        )

    elseif
        showItems == 2 or
        showItems == 6 or
        showItems == 10 or
        showItems == 14 or
        showItems == 18 or
        showItems == 22 or
        showItems == 26 or
        showItems == 30
    then
        local price = tpz.logincampaign.table[cYear][cMonth][showItems - 1]["price"]
        local loginPoints = 4200
        local totalItemsMask = (2 ^ 20 - 1) - (2 ^ #tpz.logincampaign.table[cYear][cMonth][showItems - 1]["items"] - 1)  -- Uses 20 bits and sets to 1 for items not used.
        local items = {}

        for i = 1, 20 do
            if tpz.logincampaign.table[cYear][cMonth][showItems - 1]["items"][i] ~= nil then
                table.insert(items, tpz.logincampaign.table[cYear][cMonth][showItems - 1]["items"][i])
            else
                table.insert(items, 0)
            end
        end

        player:updateEvent(
            bit.bor(items[17], bit.lshift(items[18], 16)),
            bit.bor(items[19], bit.lshift(items[20], 16)),
            totalItemsMask,
            price,
            loginPoints
        )

    else
        npcUtil.giveItem(player, { {tpz.logincampaign.table[cYear][cMonth][showItems - 2]["items"][itemSelected + 1], itemQuantity} })
    end

end