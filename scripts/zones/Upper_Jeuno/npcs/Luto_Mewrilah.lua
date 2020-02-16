-----------------------------------
-- Area: Upper Jeuno
--  NPC: Luto Mewrilah
-- !pos -53 0 45 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/pets/fellow")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/pets")
-----------------------------------

function onTrade(player,npc,trade)
    if npcUtil.tradeHas(trade, 14810) and player:getLocalVar("StartOver") == 1 then
    local fellowParam = getFellowParam(player)
        player:startEvent(10049,244,0,0,0,0,0,0,fellowParam)
    end
end

function onTrigger(player,npc)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")
    local UnlistedQualities = player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.UNLISTED_QUALITIES)
    local UnlistedQualitiesProgress = player:getCharVar("[Quest]Unlisted_Qualities")
    local LookingGlass = player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
    local LookingGlassProgress = player:getCharVar("[Quest]Looking_Glass")
    local MirrorMirror = player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.MIRROR_MIRROR)
    local MirrorMirrorProgress = player:getCharVar("[Quest]Mirror_Mirror")
    local needToZone = player:needToZone()
    local fellowParam = 0
    if UnlistedQualities == QUEST_COMPLETED then
        fellowParam = getFellowParam(player)
    end

    if player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatJeuno,7) == false then
        player:startEvent(10085)
    elseif UnlistedQualities == QUEST_AVAILABLE then -- and player:getRank() >= 4 then  -- Rank 4 no longer required
        player:startEvent(10031)
    elseif UnlistedQualities == QUEST_ACCEPTED and UnlistedQualitiesProgress < 15 then
        player:startEvent(10033)
    elseif UnlistedQualities == QUEST_ACCEPTED and UnlistedQualitiesProgress == 15 then
        player:startEvent(10032)
    elseif UnlistedQualities == QUEST_COMPLETED and LookingGlass < QUEST_ACCEPTED and needToZone == true then
        player:startEvent(10034)
    elseif UnlistedQualities == QUEST_COMPLETED and LookingGlass == QUEST_AVAILABLE then
        player:startEvent(10039)
    elseif LookingGlass == QUEST_ACCEPTED and LookingGlassProgress < 4 then
        player:startEvent(10042)
    elseif LookingGlass == QUEST_ACCEPTED and LookingGlassProgress == 4 then
        player:startEvent(10043,244,0,0,0,0,0,0,fellowParam)
    elseif LookingGlass == QUEST_COMPLETED and MirrorMirror < QUEST_ACCEPTED and needToZone == true then
        player:startEvent(10048)
    elseif LookingGlass == QUEST_COMPLETED and MirrorMirror == QUEST_AVAILABLE then
        player:startEvent(10044,244,0,0,0,0,0,0,fellowParam)
    elseif MirrorMirror == QUEST_ACCEPTED and MirrorMirrorProgress < 3 then
        player:startEvent(10045)
    elseif MirrorMirror == QUEST_ACCEPTED and MirrorMirrorProgress == 3 then
        player:startEvent(10046,244,14810,0,0,0,0,0,fellowParam)
    elseif MirrorMirror == QUEST_COMPLETED and player:getLocalVar("StartOver") == 1 then
        player:startEvent(10053,244,14810,0,0,0,0,0,fellowParam)
    elseif MirrorMirror == QUEST_COMPLETED then
        player:startEvent(10047,244,14810,0,0,0,0,0,fellowParam)
    else
        player:startEvent(10041)
    end
end

-- 10041  10071  10050  10051  10068  10069  10070  10076  10077  10052  10055  10056  10057  10058
-- 10060  10059  10061  10062  10063  10064  10067  10065  10066  10072  10073  10074  10075  10078
-- 10079  10080  10081  10082  10174  10175

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
    if csid == 10085 then
        player:setMaskBit(player:getCharVar("WildcatJeuno"),"WildcatJeuno",7,true)
    elseif csid == 10031 then
        player:addQuest(JEUNO,tpz.quest.id.jeuno.UNLISTED_QUALITIES)
        player:setFellowValue("fellowid",option)
--[[
Adventuring Fellow Name Options:
    Male Hume:
        0   Feliz
        1   Ferdinand
        2   Gunnar
        3   Massimo
        4   Oldrich
        5   Siegward
        6   Theobald
        7   Zenji
    Female Hume:
        16  Amerita
        17  Beatrice
        18  Henrietta
        19  Jesimae
        20  Karyn
        21  Nanako
        22  Sharlene
        23  Sieghilde
    Male Elvaan:
        32  Chanandit
        33  Deulmaeux
        34  Demresinaux
        35  Ephealgaux
        36  Gauldeval
        37  Grauffemart
        38  Migaifongut
        39  Romidiant
    Female Elvaan:
        48  Armittie
        49  Cadepure
        50  Clearite
        51  Epilleve
        52  Liabelle
        53  Nauthima
        54  Radille
        55  Vimechue
    Male Taru:
        64  Balu-Falu
        65  Burg-Ladarg
        66  Ehgo-Ryuhgo
        67  Kolui-Pelui
        68  Nokum-Akkum
        69  Savul-Kivul
        70  Vinja-Kanja
        71  Yarga-Umiga
    Female Taru:
        80  Cupapa
        81  Jajuju
        82  Kalokoko
        83  Mahoyaya
        84  Pakurara
        85  Ripokeke
        86  Yawawa
        87  Yufafa
    Mithra:
        96  Fhig Lahrv
        97  Khuma Tagyawhan
        98  Pimy Kettihl
        99  Raka Maimhov
        100 Sahyu Banjyao
        101 Sufhi Uchnouma
        102 Tsuim Nhomango
        103 Yoli Kohlpaka
    Galka:
        112 Durib
        113 Dzapiwa
        114 Jugowa
        115 Mugido
        116 Voldai
        117 Wagwei
        118 Zayag
        119 Zoldof
--]]
    elseif csid == 10032 then
        if npcUtil.giveItem(player, 744) then
            player:completeQuest(JEUNO,tpz.quest.id.jeuno.UNLISTED_QUALITIES)
            player:setCharVar("[Quest]Unlisted_Qualities", 0)
            player:needToZone(true)
        end
    elseif csid == 10039 then
        player:addQuest(JEUNO,tpz.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
        player:setCharVar("[Quest]Looking_Glass", 1)
    elseif csid == 10043 then
        player:completeQuest(JEUNO,tpz.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
        player:setCharVar("[Quest]Looking_Glass", 0)
        player:needToZone(true)
    elseif csid == 10044 then
        player:addQuest(JEUNO,tpz.quest.id.jeuno.MIRROR_MIRROR)
        player:setCharVar("[Quest]Mirror_Mirror", 1)
    elseif csid == 10046 then
        if npcUtil.giveItem(player, 14810) then
            player:completeQuest(JEUNO,tpz.quest.id.jeuno.MIRROR_MIRROR)
            player:setCharVar("[Quest]Mirror_Mirror", 0)
        end
    elseif csid == 10047 and option == 100 then
        player:setLocalVar("StartOver", 1)
    elseif csid == 10053 and option == 101 then
        player:setLocalVar("StartOver", 0)
    elseif csid == 10049 then
        player:delQuest(JEUNO,tpz.quest.id.jeuno.CLASH_OF_THE_COMRADES)
        player:delQuest(JEUNO,tpz.quest.id.jeuno.MIXED_SIGNALS)
        player:delQuest(JEUNO,tpz.quest.id.jeuno.REGAINING_TRUST)
        player:delQuest(JEUNO,tpz.quest.id.jeuno.CHAMELEON_CAPERS)
        player:delQuest(JEUNO,tpz.quest.id.jeuno.MIRROR_IMAGES)
        player:delQuest(JEUNO,tpz.quest.id.jeuno.BLESSED_RADIANCE)
        player:delQuest(JEUNO,tpz.quest.id.jeuno.BLIGHTED_GLOOM)
        player:delQuest(JEUNO,tpz.quest.id.jeuno.PAST_REFLECTIONS)
        player:delQuest(JEUNO,tpz.quest.id.jeuno.MIRROR_MIRROR)
        player:delQuest(JEUNO,tpz.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS)
        player:delQuest(JEUNO,tpz.quest.id.jeuno.UNLISTED_QUALITIES)
        player:delFellowValue()
        player:setLocalVar("StartOver", 0)
        player:confirmTrade()
    end
end