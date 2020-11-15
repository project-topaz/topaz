require("scripts/globals/status")

local status = {}
status.__index = status

function status:new()
    local s = {}
    setmetatable(s, self)

    s.id       = 0
    s.icon     = 0
    s.power    = 0
    s.tick     = 0
    s.duration = 0
    s.subid    = 0
    s.subPower = 0
    s.tier     = 0
    s.flags    = 0

    return s
end

function status:setPower(power)
    self.power = power
end

function status:getPower()
    return self.power
end

function status:setSubPower(power)
    self.subPower = power
end

function status:getSubPower()
    return self.subPower
end

function status:getType()
    return self.id
end

function status:getSubType()
    return self.subid
end

function status:getTier()
    return self.tier
end

return status