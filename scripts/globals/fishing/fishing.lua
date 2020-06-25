-------------------------------------------------
--	Author: Setzor : setzor@gmail.com
--	Fishing functions
--  Info from:
--      Countless hours of fish testing on retail with tens of thousands of casts
--      http://wiki.ffxiclopedia.org/wiki/Fishing
-------------------------------------------------

require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/equipment")
require("scripts/globals/quests")

require("scripts/globals/fishing/fishing_types")
require("scripts/globals/fishing/fishing_accessories")

local MaxFishLevelDifferenceToHook = 100

local FishTablePoolWeight = 60

local FishDefaultPoolWeight = 110
local ItemDefaultPoolWeight = 20
local MobDefaultPoolWeight = 15
local NoCatchDefaultPoolWeight = 30

local MaxDiscernmentChance = 70

function coinFlip(a, b)
    local coinFlip = math.random(fishing.coinFlip.TAILS, fishing.coinFlip.HEADS)
    if coinFlip == fishing.coinFlip.Heads then
        return a
    end
    return b
end

function getFishingGear(player)
    local head = player:getEquipID(tpz.slot.HEAD)
    local neck = player:getEquipID(tpz.slot.NECK)
    local body = player:getEquipID(tpz.slot.BODY)
    local hands = player:getEquipID(tpz.slot.HANDS)
    local legs = player:getEquipID(tpz.slot.LEGS)
    local feet = player:getEquipID(tpz.slot.FEET)
    local ring1 = player:getEquipID(tpz.slot.RING1)
    local ring2 = player:getEquipID(tpz.slot.RING2)
    return head, neck, body, hands, legs, feet, ring1, ring2
end

function getMoonModifier()
    local phase = VanadielMoonPhase()
    local direction = VanadielMoonDirection()

    if phase <= 5 or (phase <= 10 and direction == 1) then      -- New Moon
        return 1.9
    elseif phase >= 7 and phase <= 38 and direction == 2 then   -- Waxing Crescent
        return 1.7
    elseif phase >= 40 and phase <= 55 and direction == 2 then  -- First Quarter
        return 1.5
    elseif phase >= 57 and phase <= 88 and direction == 2 then  -- Waxing Gibbous
        return 1.2
    elseif phase >= 95 or (phase >= 90 and direction == 2) then -- Full Moon
        return 1
    elseif phase >= 62 and phase <= 93 and direction == 1 then  -- Waning Gibbous
        return 1.2
    elseif phase >= 45 and phase <= 60 and direction == 1 then  -- Last Quarter
        return 1.5
    elseif phase >= 12 and phase < 43 and direction == 1 then   -- Waning Crescent
        return 1.7
    end

    return 2
end

function getLuckyMoonModifier()
    local phase = VanadielMoonPhase()
    local direction = VanadielMoonDirection()

    if phase <= 5 or (phase <= 10 and direction == 1) then      -- New Moon
        return 1
    elseif phase >= 7 and phase <= 38 and direction == 2 then   -- Waxing Crescent
        return 1
    elseif phase >= 40 and phase <= 55 and direction == 2 then  -- First Quarter
        return 3
    elseif phase >= 57 and phase <= 88 and direction == 2 then  -- Waxing Gibbous
        return 1
    elseif phase >= 95 or (phase >= 90 and direction == 2) then -- Full Moon
        return 4
    elseif phase >= 62 and phase <= 93 and direction == 1 then  -- Waning Gibbous
        return 1
    elseif phase >= 45 and phase <= 60 and direction == 1 then  -- Last Quarter
        return 3
    elseif phase >= 12 and phase < 43 and direction == 1 then   -- Waning Crescent
        return 1
    end

    return 0
end

function getHourModifier(tropical)
    local Hour = VanadielHour();
    -- for tides
    if tropical == true and (Hour == 5 or Hour == 17) then
        return 1.2
    end
    return 1
end

function getWeatherModifier(weather)
    if weather == tpz.weather.RAIN then
        return 1.1
    elseif weather == tpz.weather.SQUALL then
        return 1.2
    end
    return 1
end

function calcStamina(catchLevel)
    local StaminaRandomizer = math.random(95, 105)
    return StaminaRandomizer * (math.floor((catchLevel + 36) / 2))
end

function calcAttack(catchSize, fishAttack, legendaryFish, legendaryAttackBonus)
    local BonusAdd = 0
    if legendaryFish then
        BonusAdd = legendaryAttackBonus
    end
    return math.floor(catchSize + (catchSize * ((fishAttack+BonusAdd) / 100))) * 20
end

function calcHeal(catchSize, missRegen, legendaryFish, legendaryRegen)
    local RegenMod = missRegen
    if legendaryFish then
        RegenMod = legendaryRegen
    end
    return math.floor((catchSize + (catchSize * (RegenMod / 100))) / 2) * 10
end

function calcRegen(catchType, catchLevel, fishingSkill, sizeType, legendaryRodType, legendaryFish)
    local Regen = 128
    local DrainLevel = 13
    local RegenLevel = 25
    local RegenMod = 0.5
    local ActualFishingSkill = fishingSkill
    local ActualCatchLevel = catchLevel

    if legendaryRodType == fishing.rodLegendType.LUSHANG then
        ActualFishingSkill = ActualFishingSkill + 15
    elseif legendaryRodType == fishing.rodLegendType.EBISU then
        ActualFishingSkill = ActualFishingSkill + 20
    end

    if legendaryFish then
        ActualCatchLevel = ActualCatchLevel + 15
    end

    -- modify these based on specialty gear, etc
    if catchType <= fishing.catchType.ITEM and ActualCatchLevel < ActualFishingSkill and (ActualFishingSkill - ActualCatchLevel) >= DrainLevel then
        local divMod = 1.5
        if legendaryRodType == fishing.rodLegendType.LUSHANG then
            divMod = 1.3
        elseif legendaryRodType == fishing.rodLegendType.EBISU then
            divMod = 0.8
        end
        Regen = 127 - math.floor((ActualFishingSkill - ActualCatchLevel - DrainLevel) / divMod)
    end
    if catchType < fishing.catchType.ITEM and ActualCatchLevel > ActualFishingSkill and ActualCatchLevel - ActualFishingSkill >= RegenLevel then
        Regen = 128 + math.floor((ActualCatchLevel - ActualFishingSkill - RegenLevel) * RegenMod)
    end
    if sizeType > fishing.sizeType.SMALL and legendaryRodType < fishing.rodLegendType.EBISU then
        Regen = Regen + 1
    end
    if legendaryFish and legendaryRodType == fishing.rodLegendType.EBISU then -- ebisu
        Regen = Regen - 2
    end
    if catchType == fishing.catchType.MOB and legendaryRodType > fishing.rodLegendType.NONE then
        Regen = Regen - 3
    end
    return math.max(0, Regen)
end

function isLiveBait(lure)
    if lure.id == fishing.bait.DRILL_CALAMARY or lure.id == fishing.bait.DWARF_PUGIL then
        return true
    end
    return false
end

function calcHookTime(player, rod, fish, lure)
    local hookTime = rod.fishtime
    if fish.sizeType == fishing.sizeType.LARGE and bit.band(rod.flags, fishing.rodFlag.LARGE_PENALTY) > 0 then
        hookTime = hookTime - 10
    elseif fish.sizeType == fishing.sizeType.SMALL and bit.band(rod.flags, fishing.rodFlag.SMALL_PENALTY) > 0 then
        hookTime = hookTime - 10
    elseif fish.legendary == 1 and bit.band(rod.flags, fishing.rodFlag.LEGENDARY_BONUS) > 0 then
        hookTime = hookTime + 10
    end

    if player:hasKeyItem(tpz.keyItem.MOOCHING) and isLiveBait(lure) then
        hookTime = hookTime + 30
    end
    if player:getMod(tpz.mod.ALBATROSS_RING_EFFECT) > 0 then
        hookTime = hookTime + 30
    end
    return hookTime
end

-- Per SE : The likelihood of players receiving these golden opportunities depends on factors such as characters' fishing skills,
-- the skill differential between characters and their prey, the phase of the moon, time of day, the affinity of prey for
-- one's rod, moglification, and equipment.
function calcLuckyTiming(player, fishingSkill, fishLevel, fishSizeType, rodSizeType, legendaryFish, rodLegendaryType)
    local LuckyTiming = 10
    local Head, Neck, Body, Hands, Legs, Feet, Ring1, Ring2 = getFishingGear(player)
    local Hour = VanadielHour()
    local MoonModifier = getLuckyMoonModifier()

    -- Skill Mod
    local LevelMod = 0
    if fishLevel > fishingSkill + 10 then
        LevelMod = -math.floor((fishLevel - (fishingSkill+10)))
    else
        LevelMod = math.floor(((fishingSkill + 10) - fishLevel) / 20)
    end

    -- Moon Mod
    local MoonMod = math.floor(10 * MoonModifier)

    -- Hour Mod
    local HourMod = 0
    if (Hour >= 6 and Hour <= 7) or (Hour >= 16 and Hour <= 18) then
        -- Dawn/Dusk hours
        HourMod = 9
    elseif (Hour >= 8 and Hour <= 15) then
        -- Day Hours
        HourMod = 3
    else
        -- Night Hours
        HourMod = 6
    end

    -- Rod Mod
    local RodMod = 0
    if legendaryFish and rodSizeType == fishing.sizeType.LEGENDARY and rodLegendaryType == fishing.rodLegendType.EBISU then
        RodMod = 14
    elseif legendaryFish and rodSizeType == fishing.sizeType.LEGENDARY and rodLegendaryType == fishing.rodLegendType.LUSHANG then
        RodMod = 9
    elseif fishSizeType == rodSizeType then
        RodMod = 6
    elseif fishSizeType < rodSizeType then
        RodMod = 3
    end

    -- Gear Mod
    local GearMod = 0

    -- Body
    if Body == fishing.gear.FISHERMANS_TUNICA then
        GearMod = GearMod + 0.5
    elseif Body == fishing.gear.ANGLERS_TUNICA then
        GearMod = GearMod + 1
    elseif Body == fishing.gear.FISHERMANS_APRON then
        GearMod = GearMod + 2
    elseif Body == fishing.gear.FISHERMANS_SMOCK then
        GearMod = GearMod + 3
    end

    -- Hands
    if Hands == fishing.gear.FISHERMANS_GLOVES then
        GearMod = GearMod + 0.5
    elseif Hands == fishing.gear.ANGLERS_GLOVES then
        GearMod = GearMod + 1
    end

    -- Legs
    if Legs == fishing.gear.FISHERMANS_HOSE then
        GearMod = GearMod + 0.5
    elseif Legs == fishing.gear.ANGLERS_HOSE then
        GearMod = GearMod + 1
    end

    -- Feet
    if Feet == fishing.gear.FISHERMANS_BOOTS then
        GearMod = GearMod + 0.5
    elseif Feet == fishing.gear.ANGLERS_BOOTS then
        GearMod = GearMod + 1
    elseif Feet == fishing.gear.WADERS then
        GearMod = GearMod + 2
    end

    LuckyTiming = math.max(8, LuckyTiming + math.floor(LevelMod + MoonMod + HourMod + RodMod + GearMod))

    return LuckyTiming
end

function calcChanceToHook(fishingSkill, fish, rod, moonModifier, hourModifier)

    local ChanceToHook = FishTablePoolWeight

    -- Add Lure Bonus (max 50)
    ChanceToHook = ChanceToHook + (5 * fish.lurePower)

    -- Subtract Moon Penalty (max 10)
    ChanceToHook = ChanceToHook - math.min(10, math.floor(10 * (moonModifier - 1)))

    -- Add Hour Bonus (max 20)
    ChanceToHook = ChanceToHook + (5 * (2-hourModifier) * 10)

    -- Subtract Level Penalty (max 30)
    if fish.maxSkill > fishingSkill then
        ChanceToHook = ChanceToHook - math.min(30, math.floor(((fish.maxSkill - fishingSkill) / 3) * moonModifier))
    end

    -- Subtract Reverse Level Penalty (max 20)
    if fish.maxSkill < fishingSkill then
        ChanceToHook = ChanceToHook - math.min(20, math.floor(((fishingSkill - fish.maxSkill) / 5) * moonModifier))
    end

    -- Subtract Rod Penalty (max 10) | legendary rods have no penalty
    if fish.sizeType == fishing.sizeType.SMALL and rod.sizeType == fishing.sizeType.LARGE then
        ChanceToHook = ChanceToHook - math.min(10, math.floor(2 * moonModifier))  -- big rod catching small, less effect
    elseif fish.sizeType == fishing.sizeType.LARGE and rod.sizeType == fishing.sizeType.SMALL then
        ChanceToHook = ChanceToHook - math.min(10, math.floor(5 * moonModifier)) -- small rod catching big, more effect
    end

    return math.max(1, ChanceToHook)
end

function calcCriticalBiteChance(fishingSkill, fishSkill, moonModifier)
    local Chance = 0

    -- can only get discernment on fish 4 levels above your fishing skill and below
    if fishSkill - 4 > fishingSkill then
        return 0
    end

    local FishSkillCheck = math.max(0, fishSkill - 4)

    -- Base Chance
    Chance = 5 + (math.max(fishingSkill - FishSkillCheck, 0) * 2) -- ex. 5 + ((10-5) * 2) = 15, OR 5 + ((50-25) * 2) = 55

    -- Moon Modifier
    Chance = Chance + (10 * (2 - moonModifier))        -- max bonus 10, so 55 + (10 * 0.5) = 60

    return math.min(MaxDiscernmentChance, Chance)
end

-- returns rod/line break, percent
function calcChanceToBreak(fishingSkill, catchSkill, catchSize, catchType, catchSizeType, catchFlags, rod, lure, rodLegendary, legendaryFish)
    local ActualSkill = fishingSkill
    local ActualCatchSkill = catchSkill
    local ActualSize = catchSize
    local ActualDurability = rod.durability
    local ActualSizeType = catchSizeType

    local LoseChance = 0  -- lose catch chance
    local LoseChanceNoSkill = 0
    local LoseChanceTooBig = 0
    local LoseChanceTooSmall = 0

    local SnapChance = 0  -- line snap chance
    local SnapChanceNoSkill = 0
    local SnapChanceTooHeavy = 0

    local BreakChance = 0 -- rod break chance
    local BreakChanceTooBig = 0
    local BreakChanceTooHeavy = 0

    local LoseSense = 1
    local SnapSense = 1
    local BreakSense = 1

    local Sense = 1

    if rodLegendary == fishing.rodLegendType.LUSHANG then
        ActualSkill = ActualSkill + 40
    elseif rodLegendary == fishing.rodLegendType.EBISU then
        ActualSkill = ActualSkill + 50
    end


    if bit.band(catchFlags, fishing.fishFlag.HALF_SIZE) > 0 then
        ActualSize = math.floor(ActualSize / 2)
    elseif bit.band(catchFlags, fishing.fishFlag.DOUBLE_SIZE) > 0 then
        ActualSize = ActualSize * 2
    end

    if bit.band(catchFlags, fishing.fishFlag.RUSTY) > 0 then
        ActualSize = ActualSize + 5
    end

    if legendaryFish then
        ActualSizeType = 2
        ActualCatchSkill = ActualCatchSkill + 40
    end

    ActualSize = (ActualSize - math.random(0,3)) + (ActualSizeType * 5)

    local SkillDiffDurability = 0
    if ActualCatchSkill < ActualSkill then
        SkillDiffDurability = math.min(3, math.floor((ActualSkill - ActualCatchSkill)/5))
    end

    ActualDurability = ActualDurability + math.random(0, 3) + SkillDiffDurability

    if legendaryFish and rodLegendary > fishing.rodLegendType.NONE then
        ActualDurability = ActualDurability + 5
    end

    -- CALCULATE LOSE CHANCE
    local skillDiff = ActualCatchSkill - ActualSkill
    local sizeTypeDiff = ActualSizeType - rod.sizeType
    local durabilityDiff = ActualSize - ActualDurability

    if catchType == fishing.catchType.SMALLFISH or catchType == fishing.catchType.BIGFISH then
        if skillDiff > 10 then
            LoseChanceNoSkill = math.floor(skillDiff * 1.2)
        end
        if sizeTypeDiff >= 0 then
            local skillMod = 0
            if skillDiff > 10 then
                skillMod = skillDiff / 10
                if sizeTypeDiff > 0 then
                    LoseChanceTooBig = math.floor(25 * sizeTypeDiff)
                    BreakChanceTooBig = math.floor(skillMod * (10 + (10 * sizeTypeDiff)))
                end
                local skillDiffCheck = math.floor((catchSkill - ActualSkill)/10)
                if skillDiffCheck > 0 then
                    if skillDiffCheck == 1 then     -- 10-19 over
                        SnapChanceNoSkill = math.random(0,10)
                    elseif skillDiffCheck <= 3 then -- 20-39 over
                        SnapChanceNoSkill = math.random(10,25)
                    elseif skillDiffCheck <= 5 then -- 40-59 over
                        SnapChanceNoSkill = math.random(20,40)
                    elseif skillDiffCheck <= 7 then -- 60-79 over
                        SnapChanceNoSkill = math.random(50,70)
                    elseif skillDiffCheck <= 9 then -- 80-99 over
                        SnapChanceNoSkill = math.random(70,90)
                    else
                        SnapChanceNoSkill = 100
                    end
                end
            end
            if ActualDurability <= ActualSize then
                if durabilityDiff >= 0 then
                    if ActualSize >= ActualDurability then
                        local SizeDiffCheck = ActualSize - ActualDurability
                        if SizeDiffCheck >= 10 then
                            BreakChanceTooHeavy = 100
                            SnapChanceTooHeavy = 50
                        elseif SizeDiffCheck >= 8 then
                            BreakChanceTooHeavy = math.random(35,65)
                            SnapChanceTooHeavy = math.random(25,50)
                        elseif SizeDiffCheck >= 6 then
                            BreakChanceTooHeavy = math.random(20, 35)
                            SnapChanceTooHeavy = math.random(20, 40)
                        elseif SizeDiffCheck >= 4 then
                            BreakChanceTooHeavy = math.random(10, 20)
                            SnapChanceTooHeavy = math.random(15, 35)
                        elseif SizeDiffCheck >= 2 then
                            BreakChanceTooHeavy = math.random(5, 15)
                            SnapChanceTooHeavy = math.random(10, 25)
                        elseif SizeDiffCheck == 1 then
                            BreakChanceTooHeavy = math.random(1, 10)
                            SnapChanceTooHeavy = math.random(5, 15)
                        else
                            BreakChanceTooHeavy = math.random(1, 5)
                            SnapChanceTooHeavy = math.random(0, 10)
                        end
                    end
                end
            end
        elseif rod.sizeType < fishing.sizeType.LEGENDARY and sizeTypeDiff == -1 then
            LoseChanceTooSmall = 30
        end
    else
        if sizeTypeDiff > 0 then
            LoseChanceTooBig = math.random(30, 50)
            SnapChanceTooHeavy = math.random( 20,40)
            BreakChanceTooHeavy = math.random(10,30)
        end
    end

    BreakChance = math.max(BreakChanceTooBig, BreakChanceTooHeavy)
    LoseChance = math.max(LoseChanceTooSmall, LoseChanceTooBig, LoseChanceNoSkill)
    SnapChance = math.max(SnapChanceNoSkill, SnapChanceTooHeavy)

    if rodLegendary == fishing.rodLegendType.LUSHANG then
        BreakChance = math.floor(BreakChance / 4)
        SnapChance = math.floor(SnapChance / 2)
    end

    if rodLegendary == fishing.rodLegendType.EBISU then
        BreakChance = 0
        SnapChance = math.floor(SnapChance / 4)
    end

    if SnapChance > 0 then
        if SnapChanceNoSkill > SnapChanceTooHeavy then
            if SnapChance <= 10 then
                SnapSense = fishing.senseType.NOSKILL_FEELING
            elseif SnapChance <= 25 then
                SnapSense = fishing.senseType.NOSKILL_SURE_FEELING
            else
                SnapSense = fishing.senseType.NOSKILL_POSITIVEFEELING
            end
        else
            if SnapChance <= 50 then
                SnapSense = fishing.senseType.BAD
            else
                SnapSense = fishing.senseType.TERRIBLE
            end
        end
    end

    if BreakChance > 0 then
        if BreakChance <= 50 then
            BreakSense = fishing.senseType.BAD
        else
            BreakSense = fishing.senseType.TERRIBLE
        end
    end

    if LoseChance > 0 then
        if LoseChanceTooSmall > 0 and LoseChanceTooBig == 0 and LoseChanceNoSkill == 0 then
            LoseSense = fishing.senseType.GOOD
        elseif LoseChanceNoSkill > LoseChanceTooSmall and LoseChanceNoSkill > LoseChanceTooBig then
            LoseSense = fishing.senseType.NOSKILL_FEELING
        elseif LoseChanceTooBig > LoseChanceTooSmall and LoseChanceTooBig > LoseChanceNoSkill then
            LoseSense = fishing.senseType.BAD
        end
    end

    if BreakChance >= LoseChance and BreakChance >= SnapChance then
        Sense = BreakSense
    elseif SnapChance >= LoseChance and SnapChance >= BreakChance then
        Sense = SnapSense
    elseif LoseChance >= BreakChance and LoseChance >= SnapChance then
        Sense = LoseSense
    end
    return Sense, LoseChance, SnapChance, BreakChance
end

function calcSense(fishingSkill, catchSkill, catchType, catchSizeType, rodDurability, rodSizeType)
    local Sense = 1
    if catchSkill > fishingSkill - 5 then
        local SkillDiff = catchSkill - (fishingSkill - 5)
        if SkillDiff > rodDurability then
            if SkillDiff - rodDurability > 20 then
                Sense = 6
            elseif SkillDiff - rodDurability > 15 then
                Sense = 5
            elseif SkillDiff - rodDurability > 10 then
                Sense = 4
            elseif SkillDiff - rodDurability > 5 then
                Sense = 3
            else
                Sense = 2
            end
        end
    end
    return Sense
end

function createFishItemPool(player, fishingSkill, fishlist, rod, moonModifier)
    local FishPool = {}
    local ItemPool = {}
    local FishPoolWeight = 0
    local ItemWeightQuestBonus = 0
    for k, fish in pairs(fishlist) do
        local randomizer = math.random(1, 1000)
        if fish.rarity == 0 or (fish.rarity > 0 and randomizer >= 1000 - fish.rarity) then
            if (fish.maxSkill <= fishingSkill or (fish.maxSkill - fishingSkill) <= MaxFishLevelDifferenceToHook) then
                local FishItem = {}
                FishItem["id"] = k
                FishItem["legendary"] = fish.legendary
                FishItem["legendary_flags"] = fish.legendaryFlags
                if fish.item == 0 then
                    local TropicalFish = bit.band(fish.flags, fishing.fishFlag.TROPICAL) > 0
                    local HourModifier = getHourModifier(TropicalFish)

                    if fish.reqKeyItem == 0 or fish.reqKeyItem > 0 and player:hasKeyItem(fish.reqKeyItem) then
                        local ChanceToHook = calcChanceToHook(fishingSkill, fish, rod, moonModifier, HourModifier)
                        FishItem["weight"] = ChanceToHook
                        FishPoolWeight = FishPoolWeight + ChanceToHook
                        table.insert(FishPool, FishItem)
                    end
                elseif fish.item == 1 then
                    if fish.quest < 255 and fish.log < 255 then
                        if player:getQuestStatus(fish.log, fish.quest) == QUEST_ACCEPTED then
                            table.insert(ItemPool, FishItem)
                            ItemWeightQuestBonus = 50
                        end
                    else
                        table.insert(ItemPool, FishItem)
                    end
                end
            end
        end
    end
    return FishPool, ItemPool, FishPoolWeight, ItemWeightQuestBonus
end

function createMobPool(player, moblist, moonModifier, areaId, lure)
    local MobPool = {}
    local MobWeightQuestBonus = 0
    for l, mob in pairs(moblist) do
        local testMob = GetMobByID(mob.id)
        if testMob and not testMob:isSpawned() and (testMob:getLocalVar('hooked') == 0 or testMob:getLocalVar('hookedTime') - os.time() > 100) then
            local MobItem = {}
            MobItem["id"] = l
            MobItem["mobid"] = testMob:getID()
            if mob.nm and mob.areaId == areaId and (mob.reqLure == 0 or mob.reqLure == lure.id) then
                if mob.quest < 255 and mob.log < 255 then
                    if player:getQuestStatus(mob.log, mob.quest) == QUEST_ACCEPTED then
                        table.insert(MobPool, MobItem)
                        MobWeightQuestBonus = 500
                    end
                elseif mob.rarity > 0 then
                    local mobChecker = math.random(1, 1000)
                    mobChecker = mobChecker - math.floor((2 - moonModifier) * 10)
                    if mobChecker < mob.rarity then
                        table.insert(MobPool, MobItem)
                    end
                elseif mob.minRespawn > 0 then
                    local lastTOD = testMob:getLocalVar('lastTOD')
                    local respawnTime = lastTOD + mob.minRespawn
                    local difference = respawnTime - os.time()
                    if difference <= 0 then
                        table.insert(MobPool, MobItem)
                    end
                else
                    table.insert(MobPool, MobItem)
                end
            elseif not mob.nm then
                table.insert(MobPool, MobItem)
            end
        end
    end
    return MobPool, MobWeightQuestBonus
end

function calcBigFishStats(minLength, maxLength)
    local Lm = 0
    local Pz = 0
    local EpicCatch = false
    if maxLength > 1 then
        local WeightRandomizer = math.random(1, 50)
        Lm = math.random(minLength, maxLength)
        Pz = math.floor(Lm * ((WeightRandomizer+465) / 100))
        -- if randomizer is at least 80% of max then it's considered epic
        if Lm > (minLength + maxLength) / 2 and WeightRandomizer > 40 then
            EpicCatch = true
        end
    end
    return Lm, Pz, EpicCatch
end

function onFishingCheck(player, fishskilllevel, rod, fishlist, moblist, lure, areaid, areaname, zoneType, zoneDifficulty, fishingToken)
    local Caught = 0
    local CatchID = 0
    local CatchType = 0
    local CatchLevel = 0
    local CatchSize = 0
    local CatchSizeType = 0
    local CatchSelect = 0
    local CatchFlags = 0
    local Count = 0
    local Stamina = 0
    local Delay = 0
    local Regen = 128
    local RegenAdd = 0
    local Movement = 0
    local AttackDmg = 0
    local AttackPenalty = 0
    local Heal = 240
    local HealAdd = 0
    local TimeLimit = 0
    local Sense = 1
    local HookSense = 0
    local LuckyTiming = 20
    local Lm = 0
    local Pz = 0
    local EpicCatch = false
    local CriticalBite = false
    local FishingSkill = math.floor(fishskilllevel / 10) + player:getMod(tpz.mod.FISH)
    local RodSizeType = rod.sizeType
    local RodLegendaryType = fishing.rodLegendType.NONE
    local LoseChance = 0
    local SnapChance = 0
    local BreakChance = 0
    local LegendaryFish = false
    local LegendaryFlags = fishing.legendaryFlag.NORMAL
    local NM = false
    local NMFlags = 0
    local MaxHook = lure.maxhook

    -- Set Rod Legendary Type
    if rod.sizeType == fishing.sizeType.LEGENDARY then
        RodLegendaryType = fishing.rodLegendType.LUSHANG
        if rod.material == fishing.rodMaterial.SYNTHETIC then
            RodLegendaryType = fishing.rodLegendType.EBISU
        end
    end

    --------------------------------------------
    -- Create catch pool
    --------------------------------------------
    local FishWeight = 0
    local ItemWeight = 0
    local MobWeight = 0
    local FishWeightAdd = 0
    local ItemWeightAdd = 0
    local MobWeightAdd = 0
    local ItemWeightQuestBonus = 0
    local MobWeightQuestBonus = 0
    local NoCatchWeight = 0
    local NoCatchWeightAdd = 0
    local TotalPoolWeight = 0

    local FishPool = {}
    local ItemPool = {}
    local MobPool = {}

    local FishPoolWeight = 0

    local MoonModifier = getMoonModifier()
    local WeatherModifier = getWeatherModifier(player:getWeather())


    -- Get Fish and Item Lists

    if fishlist ~= nil and #fishlist > 0 then
        FishPool, ItemPool, FishPoolWeight, ItemWeightQuestBonus = createFishItemPool(player, FishingSkill, fishlist, rod, MoonModifier)
    end

    -- Get Mob List
    if moblist ~= nil and #moblist > 0 then
        MobPool, MobWeightQuestBonus = createMobPool(player, moblist, MoonModifier, areaid, lure)
    end

    -- Area Type Pool Weight Bonus/Penalties
    if zoneType == 1 then               -- city
        ItemWeightAdd = 20
        NoCatchWeightAdd = 20
    elseif zoneType == 2 then           -- outdoors
        FishWeightAdd = 20
        ItemWeightAdd = 10
        MobWeightAdd = 10
    elseif zoneType == 3 then           -- dungeon
        MobWeightAdd = 40
    end

    -- Calculate Pool Weight modifiers
    if #FishPool > 0 then
        FishWeight = FishDefaultPoolWeight
        FishWeight = FishWeight * WeatherModifier
        FishWeight = math.floor(FishWeight + (FishWeight * (MoonModifier - 1))) + FishWeightAdd
    end

    if #ItemPool > 0 then
        ItemWeight = ItemDefaultPoolWeight + math.floor(MoonModifier * 20) + ItemWeightQuestBonus + ItemWeightAdd
    end

    if #MobPool > 0 then
        MobWeight = MobDefaultPoolWeight + math.floor(MoonModifier * 20) + MobWeightQuestBonus + MobWeightAdd
    end

    NoCatchWeight = NoCatchDefaultPoolWeight + math.floor(math.random(40, 60) * (MoonModifier - 1))
    NoCatchWeight = NoCatchWeight + (zoneDifficulty * math.random(40,60)) + NoCatchWeightAdd

    if #FishPool == 0 then
        NoCatchWeight = NoCatchWeight + FishDefaultPoolWeight
    end
    if #ItemPool == 0 then
        NoCatchWeight = NoCatchWeight + ItemDefaultPoolWeight
    end
    if #MobPool == 0 and zoneType > 1 then
        NoCatchWeight = NoCatchWeight + MobDefaultPoolWeight
    end

    -- Handle fisherman's apron item chance reduction, adds to "no catch" pool
    if ItemWeight > 0 and player:getEquipID(tpz.slot.BODY) == fishing.gear.FISHERMANS_APRON then
        local reductionAmount = math.floor(ItemWeight * 0.5)
        ItemWeight = math.max(0, ItemWeight - reductionAmount)
        NoCatchWeight = NoCatchWeight + reductionAmount
    end

    TotalPoolWeight = FishWeight + ItemWeight + MobWeight + NoCatchWeight

    local PoolSelect = math.random(1, TotalPoolWeight)
    local PoolWeight = 0
    local HookType = fishing.hookType.NONE

    -- Selection time
    if #FishPool > 0 and PoolSelect < FishWeight then
        local FishSelect = math.random(1, FishPoolWeight)
        for k, fish in pairs(FishPool) do
            PoolWeight = PoolWeight + fish["weight"]
            if FishSelect < PoolWeight then
                HookType = fishing.hookType.FISH
                CatchSelect = fish["id"]
                if fish["legendary"] == 1 then
                    LegendaryFish = true
                    LegendaryFlags = fish["legendary_flags"]
                end
                break
            end
        end
    elseif #ItemPool > 0 and PoolSelect < FishWeight + ItemWeight then
        local HookSelect = ItemPool[math.random(1, #ItemPool)]
        HookType = fishing.hookType.ITEM
        CatchSelect = HookSelect["id"]
    elseif #MobPool > 0 and PoolSelect < FishWeight + ItemWeight + MobWeight then
        local HookSelect = MobPool[math.random(1, #MobPool)]
        HookType = fishing.hookType.MOB
        CatchSelect = HookSelect["id"]
    end

    if HookType > fishing.hookType.NONE then
        local BaseTimeLimit = rod.fishtime
        Caught = true
        -- if hooking fish or item
        if HookType == fishing.hookType.FISH or HookType == fishing.hookType.ITEM then
            TimeLimit = calcHookTime(player, rod, fishlist[CatchSelect], lure)
            CatchSizeType = fishlist[CatchSelect].sizeType
            -- CATCH ID
            CatchID = fishlist[CatchSelect].id

            -- DELAY/MOVE TYPE
            Delay = fishlist[CatchSelect].baseDelay
            Movement = fishlist[CatchSelect].baseMove

            if player:getMod(tpz.mod.PENGUIN_RING_EFFECT) > 0 then
                Delay = Delay + 2
                Movement = Movement + 2
            end

            -- CATCH LEVEL
            CatchLevel = fishlist[CatchSelect].maxSkill

            -- CATCH SIZE
            CatchSize = fishlist[CatchSelect].size

            -- CATCH COUNT
            Count = 1

            -- CATCH TYPE
            if HookType == fishing.hookType.FISH then
                CatchFlags = fishlist[CatchSelect].flags
                if CatchSizeType == fishing.sizeType.SMALL then
                    -- Small Fish
                    Delay = Delay + rod.smdelaybonus
                    Movement = Movement + rod.smmovebonus
                    CatchType = fishing.catchType.SMALLFISH
                    HookSense = fishing.hookSenseType.SMALL
                    if MaxHook > 1 and fishlist[CatchSelect].maxhook > 1 then
                        Count = math.random(1, MaxHook)
                    end
                elseif CatchSizeType == fishing.sizeType.LARGE then
                    -- Large Fish
                    Delay = Delay + rod.lgdelaybonus
                    Movement = Movement + rod.lgmovebonus
                    CatchType = fishing.catchType.BIGFISH
                    HookSense = fishing.hookSenseType.LARGE
                    if fishlist[CatchSelect].maxLength > 1 then
                        Lm, Pz, EpicCatch = calcBigFishStats(fishlist[CatchSelect].minLength, fishlist[CatchSelect].maxLength)
                    end
                    -- legendary Fish
                    if LegendaryFish then
                        if  bit.band(LegendaryFlags, fishing.legendaryFlag.NO_ROD_TIME_BONUS) == 0 or
                            (bit.band(LegendaryFlags, fishing.legendaryFlag.EBISU_TIME_BONUS_ONLY) > 0 and
                            RodLegendaryType == fishing.rodLegendType.EBISU) then
                            TimeLimit = TimeLimit + rod.lgdbonustime
                        end
                        if bit.band(LegendaryFlags, fishing.legendaryFlag.HALF_TIME) > 0 then
                            TimeLimit = TimeLimit - math.floor(BaseTimeLimit / 2)
                        end
                        if bit.band(LegendaryFlags, fishing.legendaryFlag.ADD_TIME_MULTIPLIER) > 0 then
                            TimeLimit = TimeLimit + (rod.multiplier * 10)
                        end
                    end
                end

                -- calculate anglers sense
                if not EpicCatch then
                    local CriticalBiteChance = calcCriticalBiteChance(FishingSkill, fishlist[CatchSelect].maxSkill, MoonModifier)
                    if math.random(1, 100) < CriticalBiteChance then
                        CriticalBite = true
                    end
                end
            else
                -- Item
                CatchType = 3
                if CatchSizeType == fishing.sizeType.SMALL then
                    -- Small Item
                    HookSense = fishing.hookSenseType.SMALL
                else
                    -- Large Large Item
                    HookSense = fishing.hookSenseType.LARGE
                end
                if CatchID == 65535 then
                    Count = 1
                    HookSense = 0
                    CatchSizeType = 0
                    if (math.random(1, 5) == 1) then
                        Count = 100
                    end
                end

            end
            -- else hooking a mob
        elseif HookType == fishing.hookType.MOB then
            TimeLimit = BaseTimeLimit
            CatchType = fishing.catchType.MOB
            CatchID = moblist[CatchSelect].id
            CatchLevel = moblist[CatchSelect].level
            CatchSize = moblist[CatchSelect].size
            Delay = moblist[CatchSelect].baseDelay
            Movement = moblist[CatchSelect].baseMove
            GetMobByID(CatchID):setLocalVar("hooked", 1)
            GetMobByID(CatchID):setLocalVar("hookedTime", os.time())

            Delay = Delay + rod.lgdelaybonus
            Movement = Movement + rod.lgmovebonus
            Count = 1
            HookSense = fishing.hookSenseType.LARGE
            CatchSizeType = fishing.sizeType.LARGE
            if moblist[CatchSelect].nm then
                if moblist[CatchSelect].log < 255 and moblist[CatchSelect].quest < 255 then
                    CatchSizeType = fishing.sizeType.SMALL
                end
                NM = true
                NMFlags = moblist[CatchSelect].nmFlags
                if bit.band(NMFlags, fishing.nmFlag.RANDOM_REGEN_EASY) > 0 then
                    RegenAdd = math.random(1,2)
                end
                if bit.band(NMFlags, fishing.nmFlag.RANDOM_REGEN_DIFFICULT) > 0 then
                    RegenAdd = math.random(3,4)
                end
                if bit.band(NMFlags, fishing.nmFlag.RANDOM_ATTACK_EASY) > 0 then
                    AttackPenalty = math.random(0,20)
                end
                if bit.band(NMFlags, fishing.nmFlag.RANDOM_ATTACK_DIFFICULT) > 0 then
                    AttackPenalty = math.random(25,50)
                end
                if bit.band(NMFlags, fishing.nmFlag.RANDOM_HEAL_EASY) > 0 then
                    HealAdd = math.random(0,20)
                end
                if bit.band(NMFlags, fishing.nmFlag.RANDOM_HEAL_DIFFICULT) > 0 then
                    HealAdd = math.random(25,50)
                end
            end
        end

        -- CATCH STAMINA
        Stamina = calcStamina(CatchLevel)

        -- CATCH ATTACK
        AttackDmg = math.max(20, calcAttack(CatchSize, rod.fishattack, LegendaryFish, rod.lgdbonusatk) - AttackPenalty)

        -- CATCH HEAL
        Heal = calcHeal(CatchSize, rod.missregen, LegendaryFish, rod.lgdmissregen) + HealAdd

        -- CATCH REGEN
        Regen = calcRegen(CatchType, CatchLevel, FishingSkill, CatchSizeType, RodLegendaryType, LegendaryFish) + RegenAdd

        -- LUCKY TIMING
        LuckyTiming = calcLuckyTiming(player, FishingSkill, CatchLevel, CatchSizeType, RodSizeType, LegendaryFish, RodLegendaryType)

        -- CATCH BREAK/LOSE CHANCE
        Sense, LoseChance, SnapChance, BreakChance = calcChanceToBreak(FishingSkill, CatchLevel, CatchSize, CatchType, CatchSizeType, CatchFlags, rod, lure, RodLegendaryType, LegendaryFish)


        -- HANDLE CRITICAL BITE
        if CriticalBite then
            LuckyTiming = LuckyTiming + 50
            Regen = Regen - math.floor(Regen * 0.03)
            HookSense = HookSense + 2
            Sense = fishing.senseType.KEEN_ANGLERS_SENSE
        end

        -- EPIC CATCH!
        if EpicCatch then
            Sense = fishing.senseType.EPIC_CATCH
        end

    else
        CatchType = fishing.catchType.NONE
    end

    return fishingToken, Caught, CatchID, CatchType, CatchLevel, CatchSize, Count, Stamina, Delay, Regen, Movement, AttackDmg, Heal, TimeLimit, Sense, HookSense, LuckyTiming, Lm, Pz, LoseChance, BreakChance, SnapChance, CatchSizeType, LegendaryFish, NM, NMFlags
end

function onFishingReelIn(player, catchType, fishingSkillLevel, fishLevel, loseChance, breakChance, snapChance, rodSizeType, fishSizeType, legendary, rodBreakable, durability, fishSize, nm, nmId, nmFlags, fishingToken)
    local Caught = true
    local Broke = false
    local Snap = false
    local Reason = fishing.failType.NONE
    local FishingSkill = math.floor(fishingSkillLevel / 10) + player:getMod(tpz.mod.FISH)

    if loseChance > 0 or snapChance > 0 or breakChance > 0 then
        -- if we didn't even get 1 more than 0 on lose, snap or break, then don't bother calculating

        local LowSkill = false
        local FishBigger = false
        local FishSmaller = false
        local FishHeavier = false

        local MaxBreak = 0
        local MaxSnap = 0

        local MoonPhaseMultiplier = getMoonModifier()


        if (legendary == 1) then
            fishSizeType = fishing.sizeType.LEGENDARY
        end

        -- Size Bonuses
        if rodSizeType == fishing.sizeType.SMALL and fishSizeType == fishing.sizeType.SMALL then
            -- small rod vs small fish
            MaxBreak = 105
            MaxSnap = 95
        elseif rodSizeType == fishing.sizeType.SMALL and fishSizeType == fishing.sizeType.LARGE then
            -- small rod vs large fish
            MaxBreak = 95
            MaxSnap = 85
            FishBigger = true
        elseif rodSizeType == fishing.sizeType.SMALL and fishSizeType == fishing.sizeType.LEGENDARY then
            -- small rod vs legendary
            MaxBreak = 75
            MaxSnap = 65
            FishBigger = true
        elseif rodSizeType == fishing.sizeType.LARGE and fishSizeType == fishing.sizeType.SMALL then
            -- large rod vs small fish
            MaxBreak = 130
            MaxSnap = 120
        elseif rodSizeType == fishing.sizeType.LARGE and fishSizeType == fishing.sizeType.LARGE then
            -- large rod vs large fish
            MaxBreak = 120
            MaxSnap = 110
        elseif rodSizeType == fishing.sizeType.LARGE and fishSizeType == fishing.sizeType.LEGENDARY then
            -- large rod vs legendary fish
            MaxBreak = 90
            MaxSnap = 80
            FishBigger = true
        elseif rodSizeType == fishing.sizeType.LEGENDARY and fishSizeType == fishing.sizeType.SMALL then
            -- legendary rod vs small fish
            MaxBreak = 160
            MaxSnap = 135
        elseif rodSizeType == fishing.sizeType.LEGENDARY and fishSizeType == fishing.sizeType.LARGE then
            -- legendary rod vs large fish
            MaxBreak = 150
            MaxSnap = 125
        elseif rodSizeType == fishing.sizeType.LEGENDARY and fishSizeType == fishing.sizeType.LEGENDARY then
            -- legendary rod vs legendary fish
            MaxBreak = 140
            MaxSnap = 115
        end

        -- Skill Difference
        if fishLevel - 10 > FishingSkill then
            LowSkill = true
        end

        -- Size Difference
        if rodSizeType > fishSizeType then
            FishSmaller = true
        elseif fishSizeType > rodSizeType then
            FishBigger = true
        end

        -- MoonPhase Mod
        MaxBreak = MaxBreak + (math.floor((1.9 - MoonPhaseMultiplier) * 10)) -- roughly 0 to 10 bonus

        -- if using Ebisu, take breaking off the table
        if rodBreakable == 0 then
            breakChance = 0
            snapChance = snapChance + math.min(20, math.floor(breakChance / 4))
        end

        local SnapRandomizer = math.random(0, MaxSnap)
        local BreakRandomizer = math.random(0, MaxBreak)

        -- Lose Catch Chance
        local MaxLoseCatch = 100 -- this is lessened by break and snap chances being higher

        local LoseRandomizer = math.random(1, MaxLoseCatch)
        if loseChance > 0 and LoseRandomizer < loseChance then
            Caught = false
            if LowSkill then
                Reason = fishing.failType.LOST_LOWSKILL
            elseif FishSmaller then
                Reason = fishing.failType.LOST_TOOSMALL
            elseif FishBigger then
                Reason = fishing.failType.LOST_TOOBIG
            else
                Reason = fishing.failType.LOST
            end
        end
        if Caught then
            if SnapRandomizer < snapChance then
                Caught = false
                Snap = true
                Reason = fishing.failType.LINESNAP
            elseif rodBreakable == 1 and BreakRandomizer < breakChance then
                Caught = false
                Broke = true
                if FishBigger then
                    Reason = fishing.failType.RODBREAK_TOOBIG
                elseif FishHeavier then
                    Reason = fishing.failType.RODBREAK_TOOHEAVY
                else
                    Reason = fishing.failType.RODBREAK
                end
            end
        end
    end
    if nm and Caught == false then
        if bit.band(nmFlags, fishing.nmFlag.RESET_RESPAWN_ON_FAIL) > 0 then
            GetMobByID(nmId):setLocalVar('lastTOD', os.time())
        end
    end
    return fishingToken, Caught, Broke, Snap, Reason
end

function onFishingStart(player)
end

function onFishingAction(player)
end

function onFishingFinish(player, catchdata, stamina, special)
end

function onFishingCatch(player)
end

function onFishingEnd(player)
end