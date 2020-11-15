-----------------------
---                 ---
--- Spell Interface ---
---                 ---
-----------------------
tpz = tpz or {}
tpz.interfaces = tpz.interfaces or {}

------------------------------------------
--- Defining the Basic Spell Interface ---
------------------------------------------

tpz.interfaces.Spell = tpz.interfaces.Spell or {}
tpz.interfaces.Spell.__index = tpz.interfaces.Spell

function tpz.interfaces.Spell:create(args)
    local object = args or {}
    setmetatable(object, self)

    return object
end

function tpz.interfaces.Spell:canCastSpell()
    local msg = 0 -- message ID to send if they can't cast the spell, zero indicates they can

    return msg
end

function tpz.interfaces.Spell:castSpell(spell, caster, target)
    local param = 0 -- Absolutely ridiculous that this param has multiple meanings... should be refactored
    local msg   = 0 -- no more weird setMsg non-sense, just return the message id here

    return param, msg
end


