--------------------------------------------------
---                                            ---
--- Core Interface Functions                   ---
---                                            ---
--- This is a collection of functions the core ---
--- will use to interface with lua.            ---
---                                            ---
--------------------------------------------------
require('scripts/globals/spells/spells')

tpz                 = tpz or {}
tpz.interfaces      = tpz.interfaces or {}
tpz.interfaces.core = tpz.interfaces.core or {}

function tpz.interfaces.core.castSpell(spellId, spellObj, casterObj, targetObj)
    local spell = tpz.magic.spells[spellId]
    local param, msg

    if spell ~= nil then
        param, msg = spell:castSpell(spellObj, casterObj, targetObj)
    else
        msg = "[Lua] Warning: Attempt to cast a spell that does not exist: SpellId(" .. spellId .. ")"
    end

    return param, msg
end