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
    basicPath = function(entity, points, run)
        local path = points or {}
        local point = entity:getPathPoint()
        local pos = entity:getPos()

        if entity:atPoint(path[point]) then
            if path[point][4] ~= 0 then
                entity:setLocalVar("[PATHDELAY]", os.time() + path[point][4])
            else
                if entity:getLocalVar("[PATHDELAY]") ~= 0 then
                    entity:setLocalVar("[PATHDELAY]", 0)
                end
            end

            if point == #path then
                entity:setPathPoint(1)
            else
                entity:setPathPoint(point +1)
            end
        end

        local np = 
        {
            path[point][1],
            path[point][2], 
            path[point][3]
        }

        if os.time() >= entity:getLocalVar("[PATHDELAY]") then
            entity:stepTo(np[1], np[2], np[3], run)
        end
    end,

    -- run an advanced path from start to end and repeat, the path will need to be linked back to start to loop correctly.
    -- can be delayed with a wait at a point and have the entity use a showText at a point also.
    -- entity will look at a target if one is added to the 6th column in the table, but must be an npc.
    -- example path point {x, y, z, text id, delay in seconds, npc id}
    advancedPath = function(entity, points, run)
        local path = points or {}
        local point = entity:getPathPoint()
        local pos = entity:getPos()
        local debugPath = false -- change to true to show debug info

        if entity:atPoint(path[point]) then
            if path[point][4] ~= 0 then -- speak at this point if available (only use showText as the speaker needs to not be a player)
                entity:showText(entity, path[point][4])
            end

            if path[point][5] ~= 0 then
                entity:setLocalVar("[PATHDELAY]", os.time() + path[point][5])
            else
                if entity:getLocalVar("[PATHDELAY]") ~= 0 then
                    entity:setLocalVar("[PATHDELAY]", 0)
                end
            end

            if point == #path then
                entity:setPathPoint(1)
            else
                entity:setPathPoint(point +1)
            end
        end

        if os.time() >= entity:getLocalVar("[PATHDELAY]") then
            entity:stepTo(path[point][1], path[point][2], path[point][3], run)
        else
            local lastPoint = point -1
            if lastPoint > 1 and lastPoint < #path and path[lastPoint][6] ~= 0 then
                if GetNPCByID(path[lastPoint][6]) ~= nil then
                    entity:lookAt(GetNPCByID(path[lastPoint][6]):getPos())
                    if debugPath then
                        printf("looking at an npc: %u", tonumber(path[lastPoint][6])) -- un comment to debug
                        printf("lastPoint was %u, and this point is %u", lastPoint, point)
                    end
                end
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
    randomPoint = function(entity, points, flags)
        local path = points or {}
        local point = entity:getPathPoint()
        local pos = entity:getPos()

        if entity:atPoint(path[point]) then
            if path[point][5] ~= 0 then
                entity:setLocalVar("[PATHDELAY]", os.time() + path[point][5])
            else
                entity:setLocalVar("[PATHDELAY]", os.time() + math.random(4, 8))
            end
            entity:setPathPoint(math.random(1, #path))
        end

        local np = 
        {
            path[point][1],
            path[point][2], 
            path[point][3], 
            path[point][4]
        }

        local rotation = 0

        if np[4] == 0 then
            rotation = pos.rot
        end

        if os.time() >= entity:getLocalVar("[PATHDELAY]") then
            entity:pathTo(np[1], np[2], np[3], rotation, flags)
            if path[point][4] == 0 then
                entity:lookAt(np[1], np[2], np[3])
            end
        end
    end,

    -- basic move to a position, uses a run bool, default is false
    moveToPosition = function(entity, newPos, run)
        local point = newPos or {0,0,0}

        entity:stepTo(point[1], point[2], point[3], run)
    end,

    -- move or keep entity behind a target.
    behindTarget = function(entity, target)
        local pos = entity:getPos()
        local tPos = target:getPos()
        local offset = target:getModelSize() +5

        local rotation = (tPos.rot/256) * 2 * math.pi

        rotation = rotation + math.pi

        local newX = tPos.x + math.cos((2 * math.pi - rotation)) * offset
        local newZ = tPos.z + math.sin((2 * math.pi - rotation)) * offset

        entity:pathTo(newX, tPos.y, newZ, 0, 8, true)
        entity:lookAt(tPos)
    end,

    -- move or keep entity infront of a target.
    infrontTarget = function(entity, target)
        local pos = entity:getPos()
        local tPos = target:getPos()
        local offset = target:getModelSize() +5

        local rotation = (tPos.rot/256) * 2 * math.pi 

        local newX = tPos.x + math.cos((2 * math.pi - rotation)) * offset
        local newZ = tPos.z + math.sin((2 * math.pi - rotation)) * offset

        entity:pathTo(newX, tPos.y, newZ, 0, 8, true)
        entity:lookAt(tPos)
    end,

    --- move or keep entity out of incomming casting range from target.
    safeDistance = function(entity, target)
        local pos = entity:getPos()
        local tPos = target:getPos()
        local offset = target:getModelSize() + 22

        local newX = tPos.x + math.cos((2 * math.pi)) * offset
        local newZ = tPos.z + math.sin((2 * math.pi)) * offset

        entity:pathTo(newX, tPos.y, newZ, 0, 8, true)
        entity:lookAt(tPos)
    end,

    -- move or keep entity in meele range of target.
    meeleRange = function(entity, target)
        local pos = entity:getPos()
        local tPos = target:getPos()
        local offset = target:getModelSize() + 3

        local newX = tPos.x + math.cos((2 * math.pi)) * offset
        local newZ = tPos.z + math.sin((2 * math.pi)) * offset

        entity:pathTo(newX, tPos.y, newZ, 0, 8, true)
        entity:lookAt(tPos)
    end,

    -- move or keep entity in casting range of target.
    castingRange = function(enity, target)
        local pos = entity:getPos()
        local tPos = target:getPos()
        local offset = target:getModelSize() + 18

        local newX = tPos.x + math.cos((2 * math.pi)) * offset
        local newZ = tPos.z + math.sin((2 * math.pi)) * offset

        entity:pathTo(newX, tPos.y, newZ, 0, 8, true)
        entity:lookAt(tPos)
    end,

    -- move or keep entity in range of target to use a song or cor roll.
    songRollRange = function(entity, target)
        local pos = entity:getPos()
        local tPos = target:getPos()
        local offset = target:getModelSize() + 2

        local newX = tPos.x + math.cos((2 * math.pi)) * offset
        local newZ = tPos.z + math.sin((2 * math.pi)) * offset

        entity:pathTo(newX, tPos.y, newZ, 0, 8, true)
        entity:lookAt(tPos)
    end,

    -- move or keep entity in ranged attack range.
    rangedRange = function(entity, target)
        local pos = entity:getPos()
        local tPos = target:getPos()
        local offset = target:getModelSize() + 15

        local newX = tPos.x + math.cos((2 * math.pi)) * offset
        local newZ = tPos.z + math.sin((2 * math.pi)) * offset

        entity:pathTo(newX, tPos.y, newZ, 0, 8, true)
        entity:lookAt(tPos)
    end,

    -- move or keep entity at a certain distance using a range passed to function.
    wantedRange = function(entity, target, range)
        local pos = entity:getPos()
        local tPos = target:getPos()
        local offset = target:getModelSize() + range

        local newX = tPos.x + math.cos((2 * math.pi)) * offset
        local newZ = tPos.z + math.sin((2 * math.pi)) * offset

        entity:pathTo(newX, tPos.y, newZ, 0, 8, true)
        entity:lookAt(tPos)
    end,


    -- move or keep entity between cover target and cover target, needs both passed to function. 
    coverTarget = function(entity, coverTarget, target)
        local pos = entity:getPos()
        local tPos = target:getPos()
        local cTPos = coverTarget:getPos()

        local rotation = (tPos.rot/256) * 2 * math.pi

        local dx = tPos.x - cTPos.x
        local dz = tPos.z - cTPos.z

        local midpoint = math.sqrt( dx * dx + dz * dz )/2

        local newX = tPos.x + math.cos((2 * math.pi - rotation)) * midpoint
        local newZ = tPos.z + math.sin((2 * math.pi - rotation)) * midpoint

        entity:pathTo(newX, tPos.y, newZ, 0, 8, true)
        entity:lookAt(tPos)
    end
}
