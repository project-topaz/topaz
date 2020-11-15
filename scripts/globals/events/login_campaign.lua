------------------------------------
-- Login Campaign
------------------------------------
require("scripts/globals/npc_util")
------------------------------------

tpz = tpz or {}
tpz.events = tpz.events or {}
tpz.events.loginCampaign = tpz.events.loginCampaign or {}

loginCampaignYear = 2019
loginCampaignMonth = 11
loginCampaignDay = 2
loginCampaignDuration = 28 -- Duration is set in Earth days

tpz.events.loginCampaign.isCampaignActive = function()
    if ENABLE_LOGIN_CAMPAIGN == 1 then
        local currentLocalTime = os.time(os.date('*t'))
        local currentUTCTime = os.time(os.date('!*t'))
        local jstOffset = currentUTCTime - currentLocalTime + 32400
        local campaignStartDate = os.time({
            year = loginCampaignYear,
            month = loginCampaignMonth,
            day = loginCampaignDay,
            hour = 0,
            min = 0,
            sec = 0
        }) + jstOffset  -- JST time
        local campaignEndDate = campaignStartDate + loginCampaignDuration * 24 * 60 * 60

        if os.time() < campaignEndDate then
            return true
        end
    end
end

-- Gives Login Points once a day.
tpz.events.loginCampaign.onGameIn = function(player)
    local zoneId      = player:getZoneID()
    local ID          = zones[zoneId]
    local loginPoints = player:getCurrency("login_points")
    local playercMonth = player:getCharVar("LoginCampaignMonth")
    local playercYear = player:getCharVar("LoginCampaignYear")
    local nextMidnight = player:getCharVar("LoginCampaignNextMidnight")
    local loginCount = player:getCharVar("LoginCampaignLoginNumber")

    -- Carry last months points if there's any
    if playercMonth ~= loginCampaignMonth and playercYear ~= loginCampaignYear then
        if loginPoints > 1500 then
            player:setCurrency("login_points", 1500)
            player:messageSpecial(ID.text.CARRIED_OVER_POINTS, 0, 1500)
        elseif loginPoints ~= 0 then
            player:messageSpecial(ID.text.CARRIED_OVER_POINTS, 0, loginPoints)
        end
        player:setCharVar("LoginCampaignMonth", loginCampaignMonth)
        player:setCharVar("LoginCampaignYear", loginCampaignYear)
    end

    -- Show Info about campaign (month, year, login time) and add points
    if nextMidnight ~= getMidnight() then
        player:messageSpecial(ID.text.LOGIN_CAMPAIGN_UNDERWAY, loginCampaignYear, loginCampaignMonth)

        if loginCount == 0 then
            loginCount = 1
        else
            loginCount = loginCount + 1
        end

        player:setCharVar("LoginCampaignNextMidnight", getMidnight())

        -- show total points
        if loginCount == 1 then
            player:addCurrency("login_points", 500)
            player:messageSpecial(ID.text.LOGIN_NUMBER, 0, loginCount, 500, player:getCurrency("login_points"))
        else
            player:addCurrency("login_points", 100)
            player:messageSpecial(ID.text.LOGIN_NUMBER, 0, loginCount, 100, player:getCurrency("login_points"))
        end
        player:PrintToPlayer("next midnight is"..getMidnight())
        player:setCharVar("LoginCampaignLoginNumber", loginCount)
    end

end

-- Load Login Campaign Data
package.loaded["scripts/globals/events/login_campaign_data"] = nil
require("scripts/globals/events/login_campaign_data")

--
tpz.events.loginCampaign.onTrigger = function(player)
    local loginPoints = player:getCurrency("login_points")
    local cYear = loginCampaignYear
    local cMonth = loginCampaignMonth
    local cDate = bit.bor(cYear, bit.lshift(loginCampaignMonth, 28))
    local currentLoginCampaign = tpz.events.loginCampaign.prizes[cYear][cMonth]

    local price1 = currentLoginCampaign[1]["price"]
    local price2 = bit.lshift(currentLoginCampaign[5]["price"], 16)
    local price3 = currentLoginCampaign[9]["price"]
    local price4 = bit.lshift(currentLoginCampaign[13]["price"], 16)
    local price5 = currentLoginCampaign[17]["price"]
    local price6 = bit.lshift(currentLoginCampaign[21]["price"], 16)
    local price7 = currentLoginCampaign[25]["price"]
    local price8 = bit.lshift(currentLoginCampaign[29]["price"], 16)

    local priceBit1 = bit.bor(price1, price2) -- set of 2 16bits
    local priceBit2 = bit.bor(price3, price4)
    local priceBit3 = bit.bor(price5, price6)
    local priceBit4 = bit.bor(price7, price8)

    player:startEvent(528, cDate, loginPoints, priceBit1, priceBit2, priceBit3, priceBit4)
end

tpz.events.loginCampaign.onEventUpdate = function(player, csid, option)
    local showItems = bit.band(option, 31) -- first 32 bits are for showing correct item list
    local itemSelected = bit.band(bit.rshift(option, 5), 31)
    local itemQuantity = bit.band(bit.rshift(option, 11), 511)
    local cYear = loginCampaignYear
    local cMonth = loginCampaignMonth
    local currentLoginCampaign = tpz.events.loginCampaign.prizes[cYear][cMonth]

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
            if currentLoginCampaign[showItems]["items"][i] ~= nil then
                table.insert(items, currentLoginCampaign[showItems]["items"][i])
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
        local price = currentLoginCampaign[showItems - 1]["price"]
        local loginPoints = player:getCurrency(login_points)
        local totalItemsMask = (2 ^ 20 - 1) - (2 ^ #currentLoginCampaign[showItems - 1]["items"] - 1)  -- Uses 20 bits and sets to 1 for items not used.
        local items = {}

        for i = 1, 20 do
            if currentLoginCampaign[showItems - 1]["items"][i] ~= nil then
                table.insert(items, currentLoginCampaign[showItems - 1]["items"][i])
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
        if npcUtil.giveItem(player, { {currentLoginCampaign[showItems - 2]["items"][itemSelected + 1], itemQuantity} }) then
            player:delCurrency("login_points", currentLoginCampaign[showItems - 2]["price"] * itemQuantity)
        end
    end
end
