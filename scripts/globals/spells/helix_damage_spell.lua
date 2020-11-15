-----------------------------------------------------
---                                               ---
---  Helix Spell (extends Elemental Damage Spell) ---
---                                               ---
-----------------------------------------------------
require("scripts/globals/spells/elemental_damage_spell")

tpz.magic.HelixSpell = tpz.magic.HelixSpell or tpz.magic.ElementalDamageSpell:create()
tpz.magic.HelixSpell.__index = tpz.magic.HelixSpell

function tpz.magic.HelixSpell:castSpell(spell, caster, target)
    local damage, msg = tpz.magic.ElementalDamageSpell.castSpell(self, spell, caster, target)

    self:addDebuff(caster, target, damage)

    return damage, msg
end


function tpz.magic.HelixSpell:addDebuff(caster, target, damage)
    local duration = self:getHelixDuration(caster)
    local dot      = math.min(damage, 9999)

    if (dot > 0) then
        target:addStatusEffect(tpz.effect.HELIX,dot,3,duration)
    end

    return damage
end

-----------------------------------
--- Helix Duration Calculations ---
-----------------------------------------------------------------------------
--- This design defaults to retail settings, however if you want to roll  ---
--- some custom durations (ie, passing your own duration table), I would  ---
--- recommend passing a calculateHelixDurationIndex as well. And possibly ---
--- even recommend passing in a determineLvl function                     ---
-----------------------------------------------------------------------------
function tpz.magic.HelixSpell:getHelixDuration(caster)
    -- https://www.bg-wiki.com/bg/Category:Helix
    local lvl           = self:determineHelixLvl(caster)
    local durationIndex = self:calculateHelixDurationIndex(lvl)
    local durations     = self.durations or {30, 60, 90}

    return durations[durationIndex]
end

function tpz.magic.HelixSpell:determineHelixLvl(caster)
    local lvl = 1 -- incase somehow we casting helix without being a scholar???

    if caster:getMainJob() == tpz.job.SCH then
        lvl = caster:getMainLvl()
    elseif caster:getSubJob() == tpz.job.SCH then
        lvl = caster:getSubLvl()
    end

    return lvl
end

function tpz.magic.HelixSpell:calculateHelixDurationIndex(lvl)
    -- This is simply a helper function that allows for customizability
    return utils.clamp(lvl % 20, 1, 3)
end