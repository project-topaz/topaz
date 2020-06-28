require("scripts/globals/status")
require("scripts/globals/common")
require("scripts/globals/data/day_weather")

local statusObj = require("scripts/test_suite/test_libs/status")
local entity = {}
entity.__index = entity

function entity:new()
    local p = {}
    setmetatable(p, self)

    p.stats          = {
        [tpz.mod.STR] = 50,
        [tpz.mod.DEX] = 50,
        [tpz.mod.AGI] = 50,
        [tpz.mod.VIT] = 50,
        [tpz.mod.INT] = 50,
        [tpz.mod.MND] = 50,
        [tpz.mod.CHR] = 50,
        [tpz.mod.ATT] = 300,
        [tpz.mod.DEF] = 300,
        [tpz.mod.EVA] = 300,
    }
    p.mods           = {
        [tpz.mod.FIRESDT] = 1000,
        [tpz.mod.EARTHSDT] = 1000,
        [tpz.mod.WATERSDT] = 1000,
        [tpz.mod.WINDSDT] = 1000,
        [tpz.mod.ICESDT] = 1000,
        [tpz.mod.THUNDERSDT] = 1000,
        [tpz.mod.LIGHTSDT] = 1000,
        [tpz.mod.DARKSDT] = 1000,
    }
    p.equip          = {}
    p.skill          = {}
    p.status_effects = {}
    p.merits         = {}
    p.weather        = tpz.weather.NONE
    p.NM             = false
    p.objType        = tpz.objType.PC
    p.job            = tpz.job.WAR
    p.sjob           = tpz.job.NIN
    p.joblvl         = 75
    p.sjoblvl        = 37

    return p
end

function entity:resetStats(stats)
    self.stats = {
        [tpz.mod.STR] = 50,
        [tpz.mod.DEX] = 50,
        [tpz.mod.AGI] = 50,
        [tpz.mod.VIT] = 50,
        [tpz.mod.INT] = 50,
        [tpz.mod.MND] = 50,
        [tpz.mod.CHR] = 50,
        [tpz.mod.ATT] = 300,
        [tpz.mod.DEF] = 300,
        [tpz.mod.EVA] = 300,
    }

    if stats ~= nil then
        for k, v in pairs(stats) do
            self.stats[k] = v
        end
    end
end

function entity:resetMods(mods)
    self.mods = {}

    if mods ~= nil then
        for k, v in pairs(mods) do
            self.stats[k] = v
        end
    end
end

function entity:getStat(statID)
    local  stat = self.stats[statID] or 0
    local  mod  = self.mods[statID]  or 0
    return stat + mod
end

function entity:getMod(modID)
    local  mod = self.mods[modID] or 0
    return mod
end

function entity:getEquipID(slotID)
    local  ID = self.equip[slotID] or 0
    return ID
end

function entity:getSkillLevel(skillID)
    local  skill_level = self.skill[skillID] or 0
    return skill_level
end

function entity:hasStatusEffect(statusID, subID)
    local has_effect = false

    if subID == nil then
        for _, status in pairs(self.status_effects) do
            if status.id == statusID then
                has_effect = true
                break
            end
        end
    else
        for _, status in pairs(self.status_effects) do
            if status.id == statusID and status.subid == subID then
                has_effect = true
                break
            end
        end
    end

    return has_effect
end

function entity:getStatusEffect(statusID, subID)
    local status_effect

    if subID == nil then
        for _, status in pairs(self.status_effects) do
            if status.id == statusID then
                status_effect = status
                break
            end
        end
    else
        for _, status in pairs(self.status_effects) do
            if status.id == statusID and status.subid == subID then
                status_effect = status
                break
            end
        end
    end

    return status_effect
end

function entity:delStatusEffect(statusID)
    if self.status_effects[statusID] ~= nil then
        self.status_effects[statusID] = nil
    end
end

function entity:addStatusEffect(id, power, tick, duration, subid, subPower, tier)
    subid    = subid    or 0
    subPower = subPower or 0
    tier     = tier     or 0

    local status    = statusObj:new()
    status.id       = id
    status.icon     = id
    status.power    = power
    status.tick     = tick
    status.duration = duration
    status.subid    = subid
    status.subPower = subPower
    status.tier     = tier

    self.status_effects[id] = status
end

function entity:addStatusEffectEx(id, icon, power, tick, duration, subid, subPower, tier)
    subid    = subid    or 0
    subPower = subPower or 0
    tier     = tier     or 0

    local status    = statusObj:new()
    status.id       = id
    status.icon     = icon
    status.power    = power
    status.tick     = tick
    status.duration = duration
    status.subid    = subid
    status.subPower = subPower
    status.tier     = tier

    self.status_effects[id] = status
end

function entity:getMerit(meritID)
    local  merit_bonus = self.merits[meritID] or 0
    return merit_bonus
end

function entity:getWeather()
    return self.weather
end

function entity:getILvlMacc()
    return 0
end

function entity:isNM()
    return self.NM
end

function entity:magicDmgTaken(damage, element)

    -- handled UDMGMAGIC (which I think is uncapped?)
    local resist          = math.max(1.0 + self:getMod(tpz.mod.UDMGMAGIC) / 100, 0.00)
    local adjusted_damage = math.floor(damage * resist)

    -- Magic Damage I caps at 50% reduction
    resist = math.max(1.0 + (self:getMod(tpz.mod.DMGMAGIC) / 100) + (self:getMod(tpz.mod.DMG) / 100), 0.5)

    -- Account for Magic Damage II
    resist = resist + (self:getMod(tpz.mod.DMGMAGIC_II) /100)

    -- Total non-UDMG stuff caps at 87.5%
    resist = math.max(resist, 0.125)

    adjusted_damage = math.floor(adjusted_damage * resist)

    -----------------------------------------------------------------------------------------------
    --- the remaining is really outside of the scope of this testing rig, at this moment anyway ---
    ---  as a side note, this function should really be addressed, it's a mess and does like,   ---
    ---  4 different things which is bad design                                                 ---
    -----------------------------------------------------------------------------------------------
    --if (damage > 0 && PDefender->objtype == TYPE_PET && PDefender->getMod(Mod::AUTO_STEAM_JACKET) > 1)
    --damage = HandleSteamJacket(PDefender, damage, 5);
    --
    --if (tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::ABSORB_DMG_CHANCE) ||
    --(element && tpzrand::GetRandomNumber(100) < PDefender->getMod(absorb[element - 1])) ||
    --tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::MAGIC_ABSORB))
    --damage = -damage;
    --else if ((element && tpzrand::GetRandomNumber(100) < PDefender->getMod(nullarray[element - 1])) ||
    --tpzrand::GetRandomNumber(100) < PDefender->getMod(Mod::MAGIC_NULL))
    --damage = 0;
    --else
    --{
    --damage = HandleSevereDamage(PDefender, damage, false);
    --int16 absorbedMP = (int16)(damage * PDefender->getMod(Mod::ABSORB_DMG_TO_MP) / 100);
    --if (absorbedMP > 0)
    --PDefender->addMP(absorbedMP);
    --}
    --
    --//ShowDebug(CL_CYAN"MagicDmgTaken: Element = %d\n" CL_RESET, element);
    return adjusted_damage;
end

-- Dummy functions because we currently do not care about what they do for our testing, we just need them to not error
function entity:takeSpellDamage()
    return
end

function entity:handleAffalatusMiseryDamage()
    return
end

function entity:updateEnmityFromDamage()
    return
end

function entity:addTP()
    return
end

function entity:getObjType()
    return self.objType
end

function entity:getMainJob()
    return self.job
end

function entity:getSubJob()
    return self.sjob
end

function entity:getMainLvl()
    return self.joblvl
end

function entity:getSubLvl()
    return self.sjoblvl
end


function entity:setMod(mod_id, amount)
    self.mods[mod_id] = amount
end

return entity