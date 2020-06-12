-----------------------------------
-- Area: Fei'Yin
--  NPC: Seed Afterglow
-- !pos -94.342 -15.656 -85.889 204     Red
-- !pos -52.019 -16.525 38.848 204      Orange
-- !pos 36.000 -15.000 -35.000 204      Green
-- !pos 74.611 -16.123 134.570 204      Yellow
-- !pos -6.710  0.462 210.245 204       Cerulean
-- !pos -200.000 -15.425 120.000 204    Blue
-- !pos -168.000 0.114 130.000 204      Golden
-- !pos -130.000 0.113 8.000 204        Silver
-- !pos -50.000 0.114 32.000 204        White
-- Todo: NPC moving. In retail these move around with 3-5+ pos EACH
-----------------------------------
local ID = require("scripts/zones/Upper_Delkfutts_Tower/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------

function onTrade(player,npc,trade)
    if  player:hasKeyItem(tpz.ki.WHISPER_OF_TIDES)    and
        player:hasKeyItem(tpz.ki.WHISPER_OF_GALES)    and
        player:hasKeyItem(tpz.ki.WHISPER_OF_FLAMES)   and
        player:hasKeyItem(tpz.ki.WHISPER_OF_STORMS)   and
        player:hasKeyItem(tpz.ki.WHISPER_OF_FROST)    and
        player:hasKeyItem(tpz.ki.WHISPER_OF_TREMORS)  and
        player:hasKeyItem(tpz.ki.WHISPER_OF_THE_MOON) and
        npcUtil.tradeHas(trade, {17545, 17547, 17549, 17551, 17553, 17555, 17557, 17559})
    then
        player:addItem(18632); -- Iridial Staff
        player:messageSpecial(ID.text.ITEM_OBTAINED,18632); -- Iridial Staff
        player:addExp(4000*EXP_RATE);
        player:confirmTrade();
        player:delKeyItem(tpz.ki.WHISPER_OF_TIDES)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED + 1, WHISPER_OF_TIDES)
        player:delKeyItem(tpz.ki.WHISPER_OF_GALES)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED + 1, WHISPER_OF_GALES)
        player:delKeyItem(tpz.ki.WHISPER_OF_FLAMES)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED + 1, WHISPER_OF_FLAMES)
        player:delKeyItem(tpz.ki.WHISPER_OF_STORMS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED + 1, WHISPER_OF_STORMS)
        player:delKeyItem(tpz.ki.WHISPER_OF_FROST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED + 1, WHISPER_OF_FROST)
        player:delKeyItem(tpz.ki.WHISPER_OF_TREMORS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED + 1, WHISPER_OF_TREMORS)
        player:delKeyItem(tpz.ki.WHISPER_OF_THE_MOON)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED + 1, WHISPER_OF_THE_MOON)
    end
end

function onTrigger(player,npc)
    player:PrintToPlayer("Seed Fragment: The elements whisper a story. Tell their whispers to me and your weapons will be collapsed into one great weapon of iridescence.", tpz.msg.channel.NS_SAY)
--[[    local offset        = npc:getID() - ID.npc.AFTERGLOW_OFFSET
    local ACP           = player:getCurrentMission(ACP)
    local progressMask  = player:getCharVar("SEED_AFTERGLOW_MASK")
    local intensity     = player:getCharVar("SEED_AFTERGLOW_INTENSITY")

    if (
        player:hasKeyItem(tpz.ki.MARK_OF_SEED) or
        player:hasKeyItem(tpz.ki.AZURE_KEY) or
        player:hasKeyItem(tpz.ki.IVORY_KEY) or
        CurrentDay == player:getCharVar("LastAzureKey") or
        CurrentDay == player:getCharVar("LastIvoryKey") or
        ACP < tpz.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II
    ) then
        player:messageSpecial(ID.text.SOFTLY_SHIMMERING_LIGHT)

    elseif (needToZone and not player:hasStatusEffect(tpz.effect.MARK_OF_SEED)) then
        player:messageSpecial(ID.text.YOU_REACH_FOR_THE_LIGHT)
    elseif (ACP >= tpz.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II and not player:getMaskBit(progressMask, offset)) then
        player:setMaskBit(progressMask, "SEED_AFTERGLOW_MASK", offset, true)
        intensity = intensity + 1
        if (intensity == 9) then
            player:startEvent(28)
        elseif (not needToZone and not player:hasStatusEffect(tpz.effect.MARK_OF_SEED)) then
            player:setCharVar("SEED_AFTERGLOW_INTENSITY", intensity)
            player:messageSpecial(ID.text.YOU_REACH_OUT_TO_THE_LIGHT, 0)
            player:addStatusEffectEx(tpz.effect.MARK_OF_SEED, 0, 0, 30, 1800)
            player:needToZone(true)
            player:messageSpecial(ID.text.THE_LIGHT_DWINDLES, 0)
        else
            player:setCharVar("SEED_AFTERGLOW_INTENSITY", intensity)
            player:messageSpecial(ID.text.EVEN_GREATER_INTENSITY, offset)
        end

    else
        player:messageSpecial(ID.text.SOFTLY_SHIMMERING_LIGHT)
    --end]]
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)

end
