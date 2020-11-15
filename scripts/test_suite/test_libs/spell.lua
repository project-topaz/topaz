require("scripts/globals/data/element")

local spell = {}
spell.__index = spell

function spell:new()
    local s = {}
    setmetatable(s, self)

    s.numOfTargets = 1
    s.element      = tpz.magic.element.NONE

    return s
end

function spell:getTotalTargets()
    return self.numOfTargets
end

function spell:getElement()
    return self.element
end

return spell