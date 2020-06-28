------------------------------------
--
-- NPC PATH WALKING
--
------------------------------------
tpz = tpz or {}

tpz.path =
{
    flag =
    {
        NONE     = 0,
        RUN      = 1,
        WALLHACK = 2,
        REVERSE  = 4,
    },

    -- returns the point at the given index
    get = function(points, index)
        local pos = {}

        if index < 0 then
            index = (#points + index - 2) / 3
        end

        pos[1] = points[index*3-2]
        pos[2] = points[index*3-1]
        pos[3] = points[index*3]

        return pos
    end,

    -- returns number of points in given path
    length = function(points)
        return #points / 3
    end,

    -- returns first point in given path
    first = function(points)
        return tpz.path.get(points, 1)
    end,

    -- are two points the same?
    equal = function(point1, point2)
        return point1[1] == point2[1] and point1[2] == point2[2] and point1[3] == point2[3]
    end,

    -- returns last point in given path
    last = function(points)
        local length = tpz.path.length(points)
        return tpz.path.get(points, length)
    end,

    -- returns random point from given path
    random = function(points)
        local length = tpz.path.length(points)
        return tpz.path.get(points, math.random(length))
    end,

    -- returns the start path without the first element
    fromStart = function(points, start)
        start = start or 1
        local t2 = {}
        local maxLength = 50
        local length = tpz.path.length(points)
        local count = 1
        local pos = start + 1
        local index = 1

        while pos <= length and count <= maxLength do
            local pt = tpz.path.get(points, pos)

            t2[index] = pt[1]
            t2[index+1] = pt[2]
            t2[index+2] = pt[3]

            pos = pos + 1
            count = count + 1
            index = index + 3
        end

        return t2
    end,

    -- reverses the array and removes the first element
    fromEnd = function(points, start)
        start = start or 1
        local t2 = {}
        local length = tpz.path.length(points)
        start = length - start
        local index = 1

        for i = start, 1, -1 do
            local pt = tpz.path.get(points, i)

            t2[index] = pt[1]
            t2[index+1] = pt[2]
            t2[index+2] = pt[3]

            index = index + 3

            if i > 50 then
                break
            end
        end

        return t2
    end,

    -- continusly run the path
    patrol = function(npc, points, flags)
        if npc:atPoint(tpz.path.first(points)) or npc:atPoint(tpz.path.last(points)) then
            npc:pathThrough(tpz.path.fromStart(points), flags)
        else
            local length = tpz.path.length(points)
            local currentLength = 0
            local i = 51

            while(i <= length) do
                if npc:atPoint(tpz.path.get(points, i)) then
                    npc:pathThrough(tpz.path.fromStart(points, i), flags)
                    break
                end

                i = i + 50
            end
        end
    end,

    -- run a basic path from start to end and repeat, the path will need to be linked back to start to loop correctly.
    -- takes a point that is {x,y,z} extra option can be added: {x,y,z {delay = 4}} or {x,y,z{rot = 230}} or both {x,y,z{rot = 90, delay = 7}}
    -- if a rotation is added "{x,y,z {rot = 35}}" then a delay will be added to allow for the rotation to execute.
    general = function(entity, points, flags)
        local path = points or {}
        local point = entity:getPathPoint()
        local pos = entity:getPos()
        local pathFlags = tpz.path.flag.NONE
        local canPath = false
        local delay = 0
        local rotation = 0

        if flags ~= tpz.path.flag.NONE and flags ~= nil then
            pathFlags = flags
        end

        local dx = path[point][1] - pos.x
        local dz = path[point][3] - pos.z

        local distToPoint = math.sqrt( dx * dx + dz * dz )

        if distToPoint < 0.1 then
            if path[point][4] then
                local options = path[point][4] or {}
                ----------------------------------
                -- Set delay if found
                ----------------------------------
                if options.delay then
                    if options.delay > 0 then
                        delay = options.delay
                    end
                end
                --------------------------------------------
                -- Auto delay if rotation and no delay found
                --------------------------------------------
                if options.rot then
                    if options.rot > 0 and delay == 0 then
                        delay = 3
                    end
                end
            end
                
            if delay > 0 then
                entity:setLocalVar("[PATHDELAY]", os.time() + delay)
            else
                if entity:getLocalVar("[PATHDELAY]") ~= 0 then
                    entity:setLocalVar("[PATHDELAY]", 0)
                end
            end
            ----------------------------------
            -- Set next point
            ----------------------------------
            if point == #path then
                entity:setPathPoint(1)
            else
                entity:setPathPoint(point +1)
            end
        end

        local lastPoint = point

        if point > 1 and point < #path then
            lastPoint = point -1
        end

        ----------------------------------
         -- Set rotation if one found
        ----------------------------------
        if path[lastPoint][4] then
            local rotateOptions = path[lastPoint][4] or {}
            if rotateOptions.rot then
                if rotateOptions.rot > 0 then
                    rotation = rotateOptions.rot
                end
            end
        end

        ----------------------------------
        -- Move if time is > delay
        ----------------------------------
        if os.time() >= entity:getLocalVar("[PATHDELAY]") then
            entity:pathTo(path[point][1], path[point][2], path[point][3], pos.rot, pathFlags)
        else
            if rotation > 0 then
                entity:rotateToAngle(rotation)
            end
        end
    end,

    -- entity will move to last point then set the last position in the path
    toPoint = function(entity, points, run)
        local path = points or {}
        local point = entity:getPathPoint()
        local pos = entity:getPos()
        local canPath = true

        if path == {} then
            return
        end

        if entity:atPoint(path[point]) then
            if point == #path then
                canPath = false
            else
                entity:setPathPoint(point +1)
                canPath = true   
            end
        end

        if canPath then
            entity:stepTo(path[point][1], path[point][2], path[point][3], run)
        end
    end,

    -- entity will move between two points 
    pingPong = function(entity, points, flags)
        local path = points or {}
        local point = entity:getPathPoint()
        local pos = entity:getPos()

        if entity:atPoint(path[1]) then
            entity:setPathPoint(2)
        elseif entity:atPoint(path[2]) then
            entity:setPathPoint(1)
        end

        entity:pathTo(path[point][1], path[point][2], path[point][3], 0, flags)
    end,

    -- pick a random point in the path and set random delay.
    randomPoint = function(entity, points, run)
        local path = points or {}
        local point = entity:getPathPoint()
        local pos = entity:getPos()
        local dx = path[point][1] - pos.x
        local dz = path[point][3] - pos.z

        local distToPoint = math.sqrt( dx * dx + dz * dz )

        if distToPoint < 0.1 then
            entity:setLocalVar("[PATHDELAY]", os.time() + math.random(4, 8))
            entity:setPathPoint(math.random(1, #path))
        end

        if os.time() >= entity:getLocalVar("[PATHDELAY]") then
            entity:stepTo(path[point][1], path[point][2], path[point][3], run)
        end
    end
}
