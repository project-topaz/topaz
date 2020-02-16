-----------------------------------
--  Adventuring Fellow
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/quests")
require("scripts/globals/zone")
require("scripts/globals/msg")
-----------------------------------

local FELLOW_TYPE_NONE     = 0
local FELLOW_TYPE_SHIELD   = 1
local FELLOW_TYPE_ATTACKER = 2
local FELLOW_TYPE_HEALER   = 3
local FELLOW_TYPE_STALWART = 4
local FELLOW_TYPE_FIERCE   = 5
local FELLOW_TYPE_SOOTHING = 6

local FELLOWCHAT_GENERAL = 1

local FELLOWMESSAGEOFFSET_WS_READY         =   0
local FELLOWMESSAGEOFFSET_HP_LOW_NOTICE    =  15
local FELLOWMESSAGEOFFSET_MP_LOW_NOTICE    =  30
local FELLOWMESSAGEOFFSET_TIME_EXPIRED     =  75
local FELLOWMESSAGEOFFSET_LEAVE            =  90
local FELLOWMESSAGEOFFSET_PROVOKE          = 135
local FELLOWMESSAGEOFFSET_FIVE_MIN_WARNING = 165
local FELLOWMESSAGEOFFSET_WEAPONSKILL      = 211
local FELLOWMESSAGEOFFSET_WEAPONSKILL2     = 463

function onMobSpawn(mob)
    local master        = mob:getMaster()
    mob:setLocalVar("masterID", master:getID())
    mob:setLocalVar("castingCoolDown", os.time()+math.random(15,25))
    master:setLocalVar("chatCounter", 0)
    master:setFellowValue("spawnTime", os.time())

    if master:getLocalVar("FellowAttack") == 0 then
        master:addListener("ATTACK", "FELLOW_ENGAGE", function(player, target, action)
            local fellow = player:getFellow()
            if fellow ~= nil then
                if fellow:getTarget() == nil or target:getID() ~= fellow:getTarget():getID() then
                    player:fellowAttack(target)
                end
            end
        end)
    end

    if master:getLocalVar("FellowDisengage") == 0 then
        master:addListener("DISENGAGE", "FELLOW_DISENGAGE", function(player)
            local fellow = player:getFellow()
            if fellow ~= nil then
                player:fellowRetreat()
            end
        end)
    end
end

function onTrigger(player, mob)
    local ID            = require("scripts/zones/"..player:getZoneName().."/IDs")
    local personality   = checkPersonality(mob)
    if personality > 5 then personality = personality - 1 end

    if player:getQuestStatus(JEUNO,tpz.quest.id.jeuno.GIRL_IN_THE_LOOKING_GLASS) == QUEST_ACCEPTED and player:getCharVar("[Quest]Looking_Glass") == 3 then
        player:setLocalVar("triggerFellow", 0)
        player:setCharVar("[Quest]Looking_Glass", 4)
        player:showText(mob, ID.text.GIRL_BACK_TO_JEUNO + personality)
        player:timer(6000, function(player) player:despawnFellow() end)
    else
        player:triggerFellowChat(FELLOWCHAT_GENERAL)
    end
end

function onMobRoam(mob)
    local master        = mob:getMaster()
    local ID            = require("scripts/zones/"..master:getZoneName().."/IDs")
    local personality   = checkPersonality(mob)
    local fellowType    = master:getFellowValue("job")
    local maxTime       = master:getFellowValue("maxTime")
    local spawnTime     = master:getFellowValue("spawnTime")
    local castCool      = mob:getLocalVar("castingCoolDown")
    local timeWarning   = mob:getLocalVar("timeWarning")
    local fellowLvl     = mob:getMainLvl()
    local mpNotice      = mob:getLocalVar("mpNotice")
    local mp            = mob:getMP()
    local mpp           = mp / mob:getMaxMP() * 100

    local members = 0
    local fellows = {}
    local party = master:getParty()
    if #party > 3 then
        for i, player in pairs(party) do
            if mob:getZone():getID() == player:getZone():getID() then
                if player:getFellow() ~= nil then
                    members = members + 2
                    fellows[player:getID()] = player:getFellowValue("spawnTime")
                else
                    members = members + 1
                end
            end
        end
        if members > 6 then
            local oldestTime = 0
            local oldestFellow = 0
            for i, fellow in pairs(fellows) do
                if oldestTime == 0 or fellow < oldestTime then
                    oldestTime = fellow
                    oldestFellow = i
                end
            end
            GetPlayerByID(oldestFellow):despawnFellow()
        end
    end

    if os.time() > spawnTime + maxTime - 300 and timeWarning == 0 then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_FIVE_MIN_WARNING + personality)
        mob:setLocalVar("timeWarning", 1)
    elseif os.time() > spawnTime + maxTime - 4 and timeWarning == 1 then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_TIME_EXPIRED + personality)
        mob:setLocalVar("timeWarning", 2)
    elseif os.time() > spawnTime + maxTime and timeWarning == 2 then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_LEAVE + personality)
        mob:setLocalVar("timeWarning", 3)
        master:despawnFellow()
    end

    if castCool <= os.time() then
        if (fellowType == FELLOW_TYPE_HEALER or fellowType == FELLOW_TYPE_SOOTHING) then
            if math.random(10) < fellowType+3 and checkCure(mob, master, fellowLvl, mp, fellowType) then
                mob:setLocalVar("castingCoolDown", os.time()+math.random(15,25))
            elseif math.random(10) < fellowType+1 and checkAilment(mob, master, fellowLvl, mp) then
                mob:setLocalVar("castingCoolDown", os.time()+math.random(15,25))
            elseif math.random(10) < fellowType-1 and checkBuff(mob, master, fellowLvl, mp, fellowType) then
                mob:setLocalVar("castingCoolDown", os.time()+math.random(15,25))
            end
        end
    end

    if mpp < 67 and mpNotice ~= 1 then
        mob:setLocalVar("mpNotice", 1)
    end
end

function onMobFight(mob, target)
    local master        = mob:getMaster()
    local ID            = require("scripts/zones/"..master:getZoneName().."/IDs")
    local personality   = checkPersonality(mob)
    local fellowType    = master:getFellowValue("job")
    local maxTime       = master:getFellowValue("maxTime")
    local optionsMask   = master:getFellowValue("optionsMask")
    local spawnTime     = master:getFellowValue("spawnTime")
    local castCool      = mob:getLocalVar("castingCoolDown")
    local provoke       = mob:getLocalVar("provoke")
    local hpWarning     = mob:getLocalVar("hpWarning")
    local mpWarning     = mob:getLocalVar("mpWarning")
    local timeWarning   = mob:getLocalVar("timeWarning")
    local wsReady       = mob:getLocalVar("wsReady")
    local wsTime        = mob:getLocalVar("wsTime")
    local fellowLvl     = mob:getMainLvl()
    local mpNotice      = mob:getLocalVar("mpNotice")
    local mp            = mob:getMP()
    local mpp           = mp / mob:getMaxMP() * 100
    local hpSignals     = false
        if bit.band(optionsMask, bit.lshift(1,1)) == 2 then hpSignals = true end
    local mpSignals     = false
        if bit.band(optionsMask, bit.lshift(1,2)) == 4 then mpSignals = true end
    local wsSignals     = false
        if bit.band(optionsMask, bit.lshift(1,3)) == 8 then wsSignals = true end
    local otherSignals  = false
        if bit.band(optionsMask, bit.lshift(1,4)) == 16 then otherSignals = true end

    if os.time() > spawnTime + maxTime - 300 and timeWarning == 0 then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_FIVE_MIN_WARNING + personality)
        mob:setLocalVar("timeWarning", 1)
    elseif os.time() > spawnTime + maxTime - 4 and timeWarning == 1 then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_TIME_EXPIRED + personality)
        mob:setLocalVar("timeWarning", 2)
    elseif os.time() > spawnTime + maxTime and timeWarning == 2 then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_LEAVE + personality)
        mob:setLocalVar("timeWarning", 3)
        master:despawnFellow()
    end

    if provoke <= os.time() then
        if checkProvoke(mob, target, fellowType) and otherSignals == true then
            master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_PROVOKE + personality)
        end
    end
    if fellowType == FELLOW_TYPE_ATTACKER or fellowType == FELLOW_TYPE_FIERCE then
        if mob:getTP() == 3000 then
            if checkWeaponSkill(mob, target, fellowLvl) and otherSignals == true then
                master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_WEAPONSKILL + personality)
            end
        elseif mob:getTP() > 1000 then
            if wsSignals == true and wsReady == 0 and master:getTP() < 1000 and master:getTP() > 500 then
                master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_WS_READY + personality)
                mob:setLocalVar("wsReady", 1)
            elseif (fellowType == FELLOW_TYPE_ATTACKER and (master:getTP() > 1000 or master:getTP() < 500)) or
                (fellowType == FELLOW_TYPE_FIERCE and master:getTP() < 500) then
                    if checkWeaponSkill(mob, target, fellowLvl) and otherSignals == true then
                        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_WEAPONSKILL + personality)
                    end
            elseif fellowType == FELLOW_TYPE_FIERCE and master:getTP() > 1000 and wsReady == 0 and target:getHPP() > 15 then
                master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_WEAPONSKILL2 + personality)
                mob:setLocalVar("wsTime", os.time()+5)
                mob:setLocalVar("wsReady", 1)
            elseif fellowType == FELLOW_TYPE_FIERCE and master:getTP() > 1000 and wsTime <= os.time() then
                if checkWeaponSkill(mob, target, fellowLvl) and otherSignals == true then
                    master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_WEAPONSKILL + personality)
                end
            end
        end
    elseif mob:getTP() > 1000 then
        if checkWeaponSkill(mob, target, fellowLvl) and otherSignals == true then
            master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_WEAPONSKILL + personality)
        end
    end

    if castCool <= os.time() then
        if fellowType == FELLOW_TYPE_HEALER or fellowType == FELLOW_TYPE_SOOTHING then
            if math.random(10) < fellowType+4 and checkCure(mob, master, fellowLvl, mp, fellowType) then
                mob:setLocalVar("castingCoolDown", os.time()+math.random(15,25))
            elseif math.random(10) < fellowType+2 and checkAilment(mob, master, fellowLvl, mp) then
                mob:setLocalVar("castingCoolDown", os.time()+math.random(15,25))
            elseif math.random(10) < fellowType and checkDebuff(mob, target, master, fellowLvl, mp) then
                mob:setLocalVar("castingCoolDown", os.time()+math.random(15,25))
            elseif math.random(10) < fellowType-1 and checkBuff(mob, master, fellowLvl, mp, fellowType) then
                mob:setLocalVar("castingCoolDown", os.time()+math.random(15,25))
            end
        elseif fellowType == FELLOW_TYPE_STALWART then
            if checkCure(mob, master, fellowLvl, mp, fellowType) then
                mob:setLocalVar("castingCoolDown", os.time()+math.random(15,25))
            end
        end
    end

    if mob:getHPP() <= 25 and hpWarning == 0 and hpSignals == true then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_HP_LOW_NOTICE + personality)
        mob:setLocalVar("hpWarning", 1)
    elseif mob:getHPP() > 25 and hpWarning ~= 0 then
        mob:setLocalVar("hpWarning", 0)
    elseif mpp <= 25 and mpWarning == 0 and mpSignals == true then
        master:showText(mob, ID.text.FELLOW_MESSAGE_OFFSET + FELLOWMESSAGEOFFSET_MP_LOW_NOTICE + personality)
        mob:setLocalVar("mpWarning", 1)
    elseif mpp > 25 and mpWarning ~= 0 then
        mob:setLocalVar("mpWarning", 0)
    end

    if mpp < 67 and mpNotice ~= 1 then
        mob:setLocalVar("mpNotice", 1)
    end
end

function checkPersonality(mob)
    local master = mob:getMaster()
    local personality   = master:getFellowValue("personality")
    switch (personality) : caseof
    {
        [4]  = function (x) personality = 0  end,
        [8]  = function (x) personality = 1  end,
        [12] = function (x) personality = 2  end,
        [16] = function (x) personality = 3  end,
        [40] = function (x) personality = 4  end,
        [44] = function (x) personality = 5  end,
        [20] = function (x) personality = 7  end,
        [24] = function (x) personality = 8  end,
        [28] = function (x) personality = 9  end,
        [32] = function (x) personality = 10 end,
        [36] = function (x) personality = 11 end,
        [48] = function (x) personality = 12 end,
    }

    return personality
end

function checkProvoke(mob, target, fellowType)
    local master = mob:getMaster()

    if fellowType == FELLOW_TYPE_SHIELD or fellowType == FELLOW_TYPE_STALWART or master:getHPP() < 25 then
        if mob:actionQueueEmpty() and (mob:getHPP() > 25 or master:getHPP() < 10) then
            if target:isEngaged() then
                if target:getTarget():getID() ~= mob:getID() then
                    mob:useJobAbility(19, target)
                    mob:setLocalVar("provoke", os.time()+30)
                    return true
                end
            else -- edge case for independent fellow attacking (quest bcnms)
                mob:useJobAbility(19, target)
                mob:setLocalVar("provoke", os.time()+30)
                return true
            end
        end
    end

    return false
end

function checkWeaponSkill(mob, target, fellowLvl)
    local weaponskills =
        { --[[
            [tpz.skill.HAND_TO_HAND] =
                {
                     [1] = { 1, false}, -- combo
                     [2] = {13, false}, -- shoulder tackle
                     [3] = {24, false}, -- one inch punch
                     [4] = {33, false}, -- backhand blow
                     [5] = {41, false}, -- raging fists
                     [6] = {49,  true}, -- spinning attack
                     [7] = {60, false}, -- howling fist
                     [8] = {65, false}, -- dragon kick
                },
            [tpz.skill.DAGGER] =
                {
                     [ ] = { 1, false}, -- wasp sting
                     [ ] = {13, false}, -- gust slash
                     [ ] = {23, false}, -- shadowstitch
                     [ ] = {33, false}, -- viper bite
                     [ ] = {41,  true}, -- cyclone
                     [ ] = {49, false}, -- energy steal
                     [ ] = {55, false}, -- energy drain
                     [ ] = {60, false}, -- dancing edge
                     [ ] = {66, false}, -- shark bite
                }, --]]
            [tpz.skill.SWORD] =
                {
                    [32] = { 1, false}, -- fast blade
                    [33] = { 9, false}, -- burning blade
                    [34] = {16, false}, -- red lotus blade
                    [35] = {24, false}, -- flat blade
                    [36] = {33, false}, -- shining blade
                    [37] = {41, false}, -- seraph blade
                    [38] = {49,  true}, -- circle blade
                    [39] = {55, false}, -- spirits within
                    [40] = {60, false}, -- vorpal blade
                    [41] = {65, false}, -- swift blade
                }, --[[
            [tpz.skill.GREAT_SWORD] =
                {
                    [ ] = { 1, false}, -- hard slash
                    [ ] = { 9, false}, -- power slash
                    [ ] = {23, false}, -- frostbite
                    [ ] = {33, false}, -- freezebite
                    [ ] = {49,  true}, -- shockwave
                    [ ] = {55, false}, -- crescent moon
                    [ ] = {60, false}, -- sickle moon
                    [ ] = {65, false}, -- spinning slash
                },
            [tpz.skill.AXE] =
                {
                    [ ] = { 1, false}, -- raging axe
                    [ ] = {13, false}, -- smash axe
                    [ ] = {23, false}, -- gale axe
                    [ ] = {33, false}, -- avalanche axe
                    [ ] = {49, false}, -- spinning axe
                    [ ] = {55, false}, -- rampage
                    [ ] = {60, false}, -- calamity
                    [ ] = {66, false}, -- mistral axe
                },
            [tpz.skill.GREAT_AXE] =
                {
                    [ ] = { 1, false}, -- shield break
                    [ ] = {13, false}, -- iron tempest
                    [ ] = {23, false}, -- sturmwind
                    [ ] = {33, false}, -- armor break
                    [ ] = {49, false}, -- keen edge
                    [ ] = {55, false}, -- weapon break
                    [ ] = {60, false}, -- raging rush
                    [ ] = {65, false}, -- full break
                },
            [tpz.skill.SCYTHE] =
                {
                    [ ] = { 1, false}, -- slice
                    [ ] = { 9, false}, -- dark harvest
                    [ ] = {23, false}, -- shadow of death
                    [ ] = {33, false}, -- nightmare scythe
                    [ ] = {41,  true}, -- spinning scythe
                    [ ] = {49, false}, -- vorpal scythe
                    [ ] = {60, false}, -- guillotine
                    [ ] = {65, false}, -- cross reaper
                },
            [tpz.skill.POLEARM] =
                {
                    [ ] = { 1, false}, -- double thrust
                    [ ] = { 9, false}, -- thunder thrust
                    [ ] = {23, false}, -- raiden thrust
                    [ ] = {33, false}, -- leg sweep
                    [ ] = {49, false}, -- penta thrust
                    [ ] = {55, false}, -- vorpal thrust
                    [ ] = {60, false}, -- skewer
                    [ ] = {65, false}, -- wheeling thrust
                },
            [tpz.skill.KATANA] =
                {
                    [ ] = { 1, false}, -- blade: rin
                    [ ] = { 9, false}, -- blade: retsu
                    [ ] = {23, false}, -- blade: teki
                    [ ] = {33, false}, -- blade: to
                    [ ] = {49, false}, -- blade: chi
                    [ ] = {55, false}, -- blade: ei
                    [ ] = {60, false}, -- blade: jin
                    [ ] = {66, false}, -- blade: ten
                },
            [tpz.skill.GREAT_KATANA] =
                {
                    [ ] = { 1, false}, -- tachi: enpi
                    [ ] = { 9, false}, -- tachi: hobaku
                    [ ] = {23, false}, -- tachi: goten
                    [ ] = {33, false}, -- tachi: kagero
                    [ ] = {49, false}, -- tachi: jinpu
                    [ ] = {55, false}, -- tachi: koki
                    [ ] = {60, false}, -- tachi: yukikaze
                    [ ] = {65, false}, -- tachi: gekko
                },
            [tpz.skill.CLUB] =
                {
                    [ ] = { 1, false}, -- shining strike
                    [ ] = {13, false}, -- seraph strike
                    [ ] = {23, false}, -- brainshaker
                    [ ] = {33, false}, -- starlight
                    [ ] = {41, false}, -- moonlight
                    [ ] = {49, false}, -- skullbreaker
                    [ ] = {55, false}, -- true strike
                    [ ] = {60, false}, -- judgment
                    [ ] = {67, false}, -- hexa strike
                },
            [tpz.skill.STAFF] =
                {
                    [ ] = { 1, false}, -- heavy swing
                    [ ] = {13, false}, -- rock crusher
                    [ ] = {23,  true}, -- earth crusher
                    [ ] = {33, false}, -- starburst
                    [ ] = {49, false}, -- sunburst
                    [ ] = {55, false}, -- shell crusher
                    [ ] = {60, false}, -- full swing
                    [ ] = {63, false}, -- spirit taker
                }, --]]
        }

    local master        = mob:getMaster()
    local skill         = mob:getWeaponSkillType(tpz.slot.MAIN)
    local optionsMask   = master:getFellowValue("optionsMask")
    local randomWS      = {}
    local aoeEnabled    = false
        if bit.band(optionsMask, bit.lshift(1,0)) == 1 then aoeEnabled = true end

    for i, ws in pairs(weaponskills[skill]) do
        if fellowLvl >= ws[1] and (aoeEnabled == ws[2] or not ws[2]) then
            table.insert(randomWS, i)
        end
    end

    if mob:actionQueueEmpty() then
        mob:useMobAbility(randomWS[math.random(#randomWS)], target)
        mob:setLocalVar("wsReady", 0)
        return true
    end

    return false
end

function checkCure(mob, master, fellowLvl, mp, fellowType)
    local cureSpell = 0
    local cures =
    { -- spellid, lvl, mpcost
        [1] = {5, 61, 135}, -- cure V
        [2] = {4, 41,  88}, -- cure IV
        [3] = {3, 21,  46}, -- cure III
        [4] = {2, 11,  24}, -- cure II
        [5] = {1,  1,   8}, -- cure I
    }
    local accuracy =
    { -- hpp, fellowType, accuracy(chance to use full pwr), validity(does this type cast at this hpp)
        [1] = {hpp = 30, job = {[3] = {95,  true}, [4] = {100, true}, [6] = {100, true}}},
        [2] = {hpp = 50, job = {[3] = {70,  true}, [4] = {100, true}, [6] = { 90, true}}},
        [3] = {hpp = 60, job = {[3] = {50,  true}, [4] = {100, true}, [6] = { 80, true}}},
        [4] = {hpp = 70, job = {[3] = { 0, false}, [4] = {  0, true}, [6] = { 10, true}}},
        [4] = {hpp = 80, job = {[3] = { 0, false}, [4] = {  0, true}, [6] = {  0, true}}},
    }

    for i, cure in ipairs(cures) do
        if fellowLvl >= cure[2] and mp >= cure[3] then
            cureSpell = cure[1]
            break
        end
    end

    function doFellowCure (mob)
        for i, v in ipairs(accuracy) do
            if mob:getHPP() <= v.hpp and v.job[fellowType][2] then
                if cureSpell > 1 and math.random(100) > v.job[fellowType][1] then
                    mob:castSpell(cureSpell -1, mob)
                    return true
                else
                    mob:castSpell(cureSpell, mob)
                    return true
                end
            end
        end
    end

    function doMasterCure(mob, master)
        for i, v in ipairs(accuracy) do
            if master:getHPP() <= v.hpp and v.job[fellowType][2] then
                if cureSpell > 1 and math.random(100) > v.job[fellowType][1] then
                    mob:castSpell(cureSpell -1, master)
                    return true
                else
                    mob:castSpell(cureSpell, master)
                    return true
                end
            end
        end
    end

    if cureSpell > 0 then
        if fellowType == 3 then
            if doFellowCure(mob) or doMasterCure(mob, master) then
                return true
            end
        elseif fellowType == 4 then
            if doFellowCure(mob) then
                return true
            end
        elseif fellowType == 6 then
            if doMasterCure(mob, master) or doFellowCure(mob) then
                return true
            end
        end
    end

    return false
end

function checkBuff(mob, master, fellowLvl, mp, fellowType)
    local mpp = mob:getMP() / mob:getMaxMP() * 100
    local pS = {}
    local sS = {}
    local protects =
    { -- spellid, lvl, mpcost
        [1] = {46, 63, 65}, -- protect IV
        [2] = {45, 47, 46}, -- protect III
        [3] = {44, 27, 28}, -- protect II
        [4] = {43,  7,  9}, -- protect I
    }
    for i, protect in ipairs(protects) do
        if fellowLvl >= protect[2] then
            pS = protects[i]
            break
        end
    end
    local shells =
    { -- spellid, lvl, mpcost
        [1] = {51, 68, 75}, -- shell IV
        [2] = {50, 57, 56}, -- shell III
        [3] = {49, 37, 37}, -- shell II
        [4] = {48, 17, 18}, -- shell I
    }
    for i, shell in ipairs(shells) do
        if fellowLvl >= shell[2] then
            sS = shells[i]
            break
        end
    end
    local buffs =
    {                        -- spellid, lvl, mpcost, canTarget, job, priority, cutoff
        [tpz.effect.STONESKIN] = {   54,    28,    29, false, job = {[3] = {10, 0}, [6] = {20, 60}}},
        [tpz.effect.PROTECT]   = {pS[1], pS[2], pS[3],  true, job = {[3] = {50, 0}, [6] = {50,  0}}},
        [tpz.effect.SHELL]     = {sS[1], sS[2], sS[3],  true, job = {[3] = {50, 0}, [6] = {50,  0}}},
        [tpz.effect.BLINK]     = {   53,    19,    20, false, job = {[3] = {10, 0}, [6] = {20, 60}}},
        [tpz.effect.HASTE]     = {   57,    40,    40,  true, job = {[3] = {65, 0}, [6] = {65, 30}}},
    }

    if master:getFellowValue("job") == FELLOW_TYPE_SOOTHING then
        switch (master:getMainJob()) : caseof
        {
            [tpz.job.WHM] = function (x) buffs[tpz.effect.HASTE].job[6][2] = 80 end,
            [tpz.job.BLM] = function (x) buffs[tpz.effect.HASTE].job[6][2] = 80 end,
            [tpz.job.RDM] = function (x) buffs[tpz.effect.HASTE].job[6][2] = 80 end,
            [tpz.job.BRD] = function (x) buffs[tpz.effect.HASTE].job[6][2] = 80 end,
            [tpz.job.RNG] = function (x) buffs[tpz.effect.HASTE].job[6][2] = 80 end,
            [tpz.job.SMN] = function (x) buffs[tpz.effect.HASTE].job[6][2] = 80 end,
            [tpz.job.COR] = function (x) buffs[tpz.effect.HASTE].job[6][2] = 80 end,
            [tpz.job.SCH] = function (x) buffs[tpz.effect.HASTE].job[6][2] = 80 end,
        }
    end

    for status, spell in pairs(buffs) do
        if math.random(100) < spell.job[fellowType][1] and mpp > spell.job[fellowType][2] then
            if not mob:hasStatusEffect(status) and fellowLvl >= spell[2] and mp >= spell[3] then
                mob:castSpell(spell[1], mob)
                return true
            end
        elseif math.random(100) < spell.job[fellowType][1] and mpp > spell.job[fellowType][2] and spell[4] then
            if not master:hasStatusEffect(status) and fellowLvl >= spell[2] and mp >= spell[3] then
                mob:castSpell(spell[1], master)
                return true
            end
        end
    end

    return false
end

function checkDebuff(mob, target, master, fellowLvl, mp)
    local dS = {}
    local dias =
    { -- spellid, lvl, mpcost
        [1] = {24, 36, 30}, -- dia II
        [2] = {23,  3,  7}, -- dia I
    }
    for i, dia in ipairs(dias) do
        if fellowLvl >= dia[2] then
            dS = dias[i]
            break
        end
    end
    local debuffs =
    {                       -- spellid, lvl, mpcost, priority, immunity
        [tpz.effect.PARALYSIS] = {   58,     4,     6, 25,  32},
        [tpz.effect.SILENCE]   = {   59,    15,    16, 60,  16},
        [tpz.effect.SLOW]      = {   56,    13,    15, 25, 128},
        [tpz.effect.DIA]       = {dS[1], dS[2], dS[3], 75,   0},
    }

    if not target:hasSpellList() then
        debuffs[tpz.effect.SILENCE] = nil
    end

    for status, spell in pairs(debuffs) do
        if math.random(100) < spell[4] and not target:hasImmunity(spell[5]) then
            if not target:hasStatusEffect(status) and fellowLvl >= spell[2] and mp >= spell[3] then
                    mob:castSpell(spell[1], target)
                    return true
            end
        end
    end
    return false
end

function checkAilment(mob, master, fellowLvl, mp)
    local ailments =
    {                        -- spellid, lvl, mpcost, selfcast
        [tpz.effect.PETRIFICATION] = {18, 40, 12, false},
        [tpz.effect.BLINDNESS]     = {16, 14, 16,  true},
        [tpz.effect.PARALYSIS]     = {15,  9, 12,  true},
        [tpz.effect.CURSE_II]      = {20, 29, 30,  true},
        [tpz.effect.CURSE_I]       = {20, 29, 30,  true},
        [tpz.effect.DISEASE]       = {19, 34, 48,  true},
        [tpz.effect.SILENCE]       = {17, 19, 24, false},
        [tpz.effect.POISON]        = {14,  6,  8,  true},
    }

    for status, spell in pairs(ailments) do
        if mob:hasStatusEffect(status) and fellowLvl >= spell[2] and mp >= spell[3] and spell[4] then
            mob:castSpell(spell[1], mob)
            return true
        elseif master:hasStatusEffect(status) and fellowLvl >= spell[2] and mp >= spell[3] then
            mob:castSpell(spell[1], master)
            return true
        end
    end

    return false
end

function onMobDeath(mob)
    local master = GetPlayerByID(mob:getLocalVar("masterID"))
    if master ~= nil then
        local ID = require("scripts/zones/"..master:getZoneName().."/IDs")
        local bf = master:getBattlefield()
        if bf ~= nil then
            if bf:getID() == 37 then -- mirror mirror
                local players = bf:getPlayers()
                bf:lose()
                for i, player in pairs(players) do
                    if player:getFellow() ~= nil then
                        player:despawnFellow()
                    end
                    player:messageSpecial(ID.text.UNABLE_TO_PROTECT)
                end
            end
        end
        master:removeListener("FELLOW_ENGAGE")
        master:removeListener("FELLOW_DISENGAGE")
    end
end

function onMobDespawn(mob)
    local master = GetPlayerByID(mob:getLocalVar("masterID"))
    local zone = mob:getZoneID()
    if master ~= nil and mob:getCurrentRegion() < 19 then
        if zone ~= 16 and zone ~= 18 and zone ~= 20 then -- no gear adjust in promys
            local maxKills      = mob:getLocalVar("maxKills")
            local zoneKills     = mob:getLocalVar("zoneKills")
            local kills         = master:getFellowValue("kills")
            print("master: "..mob:getLocalVar("masterID").." zoneKills: "..zoneKills.." total kills: "..kills)
            local armorLock     = master:getFellowValue("armorLock")
            local region        = GetRegionOwner(mob:getCurrentRegion())
            local unlocked      = {}
            local armorTable    =
            {
                [1] = { "body"},
                [2] = {"hands"},
                [3] = { "legs"},
                [4] = { "feet"},
            }
            for i, v in ipairs(armorTable) do
                if (bit.band(armorLock, bit.lshift(1,i)) == 0) then
                    table.insert(unlocked, v[1])
                end
            end
            local randomArmor   = unlocked[math.random(#unlocked)]
            local armor         =  master:getFellowValue(randomArmor)
            if zoneKills >= 15 then
                if maxKills == kills and kills ~= 0 then
                    if region == math.floor(armor/100) then
                        armor = armor + 1
                    else
                        armor = 0 + (region * 100)
                    end
                    if armor % 100 == 12 then armor = 0 + (region * 100) end
                else
                    if region == math.floor(armor/100) then
                        armor = (armor % 100) - 1
                        if armor < 0 then armor = 0 end
                        armor = armor + (region * 100)
                    else
                        armor = 0 + (region * 100)
                    end
                end
            end
            master:setFellowValue(randomArmor, armor)
        end
    master:removeListener("FELLOW_ENGAGE")
    master:removeListener("FELLOW_DISENGAGE")
    end
end

function getStyleParam(player)
    local body          = player:getFellowValue("body")
    local hands         = player:getFellowValue("hands")
    local legs          = player:getFellowValue("legs")
    local feet          = player:getFellowValue("feet")
    local styleParam    = bit.lshift(math.floor(feet/100),12) +
                          bit.lshift(math.floor(legs/100)*4,8) +
                          bit.lshift(math.floor(hands/100),8) +
                          bit.lshift(math.floor(body/100)*4,4)
    return styleParam
end

function getLookParam(player)
    local body          = player:getFellowValue("body")
    local hands         = player:getFellowValue("hands")
    local legs          = player:getFellowValue("legs")
    local feet          = player:getFellowValue("feet")
    local lookParam     = bit.lshift(feet % 100,16) +
                          bit.lshift(legs % 100,12) +
                          bit.lshift(hands % 100,8) +
                          bit.lshift(body % 100,4) + player:getFellowValue("head")
    return lookParam
end

function getFellowParam(player)
    local fellowParam   = bit.lshift(player:getFellowValue("face"),20) +
                          bit.lshift(player:getFellowValue("size"),16) +
                          bit.lshift(player:getFellowValue("personality"),8) +
                          player:getFellowValue("fellowid")
    return fellowParam
end
