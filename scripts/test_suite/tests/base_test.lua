local test = {}

function test:new(name)
    local t = {}
    setmetatable(t, self)

    self.__index = self
    self.tests   = {}
    self.name    = name
    self.success = false
    return t
end

function test:setup()
end

function test:tearDown()
end

test.__call = function(self)
    local successes = 0
    local failures  = 0

    for _, current_test in ipairs(self.tests) do
        self:setup()
        -- use a latching mechanic, default to true and set and stay false if we fail an assert within a test
        self.success = true
        current_test(self)
        if self.success == true then
            successes = successes + 1
        else
            failures = failures + 1
        end
        self:tearDown()
    end
    print(self.name .. ": " .. successes .. " Test(s) Passed and " .. failures .. " Test(s) Failed")
    return successes, failures
end

function test:assert(condition, failMsg)
    if condition == false then
        self.success = false
        print(failMsg)
    end
end

return test