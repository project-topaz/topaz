------------------------------------------------------------------------------
-- !info
-- Notes: prints to player info about an entity that the player has targeted.
------------------------------------------------------------------------------
require("scripts/globals/status");

cmdprops =
{
    permission = 1,
    parameters = "s"
};

function onTrigger(player, idnumber)
    local targ
    local id = tonumber(idnumber)

    print(idnumber)
    if (id == nil) then
        -- player did not provide npcId.  Shift arguments by one.
        targ = player:getCursorTarget()
    else
        -- player provided npcId and animationId.
        if targ:isNpc() then
            targ = GetNPCByID(id)
        elseif targ:isMob() then
            targ = GetMobByID(id)
        else
            player:PrintToPlayer("cannot find any infomation about that target!")
        end
    end

    -- validate target
    if (targ == nil) then
        error(player,"You must either enter a valid mobID or target a MOB.")
        return
    end

    local zonename     = targ:getZoneName()
    local zoneid       = targ:getZone():getID()
    local name         = targ:getName()
    local family       = 0
    local modelid      = targ:getModelId()
    local status       = targ:getStatus()
    local animation    = targ:getAnimation()
    local animationsub = targ:AnimationSub()
    local pos          = targ:getPos()
    local ID           = targ:getID()

    if targ:isMob() then
        family = targ:getFamily()
    else
        family = "No family for this type of entity"
    end

    player:PrintToPlayer("Zone: " ..zonename.. "  Zone ID: " ..zoneid,29)
    player:PrintToPlayer(
        "Entity name: " ..name ..
        "\nID: " ..ID..
        "\nmodel id: " .. modelid..
        "\nanimation: " ..animation..
        "\nsub animation: " ..animationsub..
        "\nstatus: " ..status, 29)
    player:PrintToPlayer("Family: " ..family, 29)
    player:PrintToPlayer("pos: x: " ..pos.x.. " y: " ..pos.y.. " z: " ..pos.z.. " rot:" ..pos.rot, 29)
end