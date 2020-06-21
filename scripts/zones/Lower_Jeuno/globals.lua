-- Zone: Lower Jeuno (245)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs");
require("scripts/globals/status");
-----------------------------------

LOWER_JEUNO = {
    --[[..............................................................................................
        Community Service Quest: player clicks a streetlamp
        ..............................................................................................]]
    lampTrigger = function(player, npc)
        local lampId = npc:getID();
        local lampNum = lampId - ID.npc.STREETLAMP_OFFSET;
        local lampCs = 120 + lampNum;

        if (GetServerVariable("[JEUNO]CommService") == player:getID()) then
            local hour = VanadielHour();
            if (hour >= 20 and hour < 21) then
                player:startEvent(lampCs, 4); -- It is too early to light it.  You must wait until nine o'clock.
            elseif (hour >= 21 or hour < 1) then
                if (npc:getAnimation() == tpz.anim.OPEN_DOOR) then
                    player:startEvent(lampCs, 2); -- The lamp is already lit.
                else
                    player:startEvent(lampCs, 1, lampNum); -- Light the lamp? Yes/No
                end
            else
                player:startEvent(lampCs, 3); -- You have failed to light the lamps in time.
            end

        else
            if (npc:getAnimation() == tpz.anim.OPEN_DOOR) then
                player:startEvent(lampCs, 5); -- The lamp is lit.
            else
                player:startEvent(lampCs, 6); -- You examine the lamp. It seems that it must be lit manually.
            end

        end
    end,

    --[[..............................................................................................
        Community Service Quest: end of event triggered by lamp click
        ..............................................................................................]]
    lampEventFinish = function(player, csid, option, lampNum)
        local lampId = ID.npc.STREETLAMP_OFFSET + lampNum;
        local lampCs = 120 + lampNum;

        if (csid == lampCs and option == 1) then
            GetNPCByID(lampId):setAnimation(tpz.anim.OPEN_DOOR);

            local lampsRemaining = 12;
            for i = 0, 11 do
                local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + i);
                if (lamp:getAnimation() == tpz.anim.OPEN_DOOR) then
                    lampsRemaining = lampsRemaining - 1;
                end
            end

            if (lampsRemaining == 0) then
                player:messageSpecial(ID.text.LAMP_MSG_OFFSET);
            else
                player:messageSpecial(ID.text.LAMP_MSG_OFFSET + 1, lampsRemaining);
            end
        end
    end,

    --[[..............................................................................................
        the path that Vhana Ehgaklywha will walk to light the lamps
        ..............................................................................................]]
    lampPath =
    {
        {   1.531,  0.000,   34.090, 0, 0, 0}, -- start
        {   6.080,  0.000,   31.542, 0, 0, 0},
        {   6.470,  0.000,   25.144, 0, 0, 0},
        {  -4.600,  0.000,   15.493, 0, 0, 0},
        {  -8.833,  0.000,   13.122, 0, 4, ID.npc.STREETLAMP_OFFSET +11},      -- lamp 1
        { -10.526,  0.000,    2.396, 0, 0, 0},
        { -18.941,  0.000,   -4.309, 0, 4, ID.npc.STREETLAMP_OFFSET +10},   -- lamp 2
        { -19.931,  0.000,   -8.269, 0, 0, 0},
        { -30.713,  0.000,  -27.756, 0, 0, 0},
        { -32.974,  0.000,  -28.554, 0, 4, ID.npc.STREETLAMP_OFFSET +9},   -- lamp 3
        { -32.252,  0.000,  -38.309, 0, 0, 0},
        { -36.578,  0.000,  -45.455, 0, 0, 0},
        { -45.047,  0.000,  -47.151, 0, 4, ID.npc.STREETLAMP_OFFSET +8},   -- lamp 4
        { -45.731,  0.000,  -52.497, 0, 0, 0},
        { -52.494,  0.000,  -60.238, 0, 4, ID.npc.STREETLAMP_OFFSET +7},   -- lamp 5
        { -41.209,  0.000,  -47.596, 0, 0, 0},
        { -37.514,  0.000,  -51.935, 0, 0, 0},
        { -43.825,  6.000,  -62.458, 0, 0, 0},
        { -55.446,  6.000,  -75.588, 0, 0, 0},
        { -60.904,  6.000,  -74.785, 0, 4, ID.npc.STREETLAMP_OFFSET + 6},  -- lamp 6
        { -61.146,  6.000,  -83.961, 0, 0, 0},
        { -67.435,  6.000,  -94.883, 0, 0, 0},
        { -73.020,  6.000,  -95.701, 0, 4, ID.npc.STREETLAMP_OFFSET + 5},  -- lamp 7
        { -75.648,  6.000, -112.960, 0, 0, 0},
        { -76.083,  6.000, -116.388, 0, 0, 0},
        { -78.459,  3.750, -120.090, 0, 0, 0},
        { -83.408,  0.000, -126.294, 0, 0, 0},
        { -86.027,  0.000, -126.946, 0, 0, 0},
        { -81.627,  0.000, -110.110, 0, 4, ID.npc.STREETLAMP_OFFSET + 4},  -- lamp 8
        { -86.615,  0.000, -118.916, 0, 0, 0},
        { -89.185,  0.000, -123.232, 0, 4, ID.npc.STREETLAMP_OFFSET + 3},  -- lamp 9
        { -88.330,  0.000, -135.539, 0, 0, 0},
        { -94.206,  0.000, -145.839, 0, 0, 0},
        {-101.215,  0.000, -144.035, 0, 4, ID.npc.STREETLAMP_OFFSET + 2}, -- lamp 10
        {-109.137,  0.000, -158.031, 0, 4, ID.npc.STREETLAMP_OFFSET + 1}, -- lamp 11
        {-117.165,  0.000, -171.811, 0, 4, ID.npc.STREETLAMP_OFFSET}, -- lamp 12
        {-114.751,  0.000, -182.867, 0, 0, 0},
        {-119.651,  0.000, -191.165, 0, 0, 0},
        {-120.659,  0.000, -199.247, 0, 0, 0},
        {-200.000,  0.000, -250.000, 0, 0, 0}, -- end
    },

    --[[..............................................................................................
        indices within lampPath that contain lamps
        ..............................................................................................]]
    lampPoints = {6, 8, 11, 14, 16, 21, 24, 30, 32, 35, 36, 37}
}

return LOWER_JEUNO;
