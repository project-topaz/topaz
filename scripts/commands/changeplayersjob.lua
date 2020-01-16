---------------------------------------------------------------------------------------------------
-- func: changesjob
-- desc: Changes the players current subjob.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status");

cmdprops =
{
    permission = 4,
    parameters = "sis"
};

function error(player, msg)
    player:PrintToPlayer(msg);
    player:PrintToPlayer("!changesjob <jobID> {level} <player>");
end;

function onTrigger(player, jobId, level, target)
    -- validate jobId
    if (jobId == nil) then
        error(player, "You must enter a job short-name, e.g. WAR, or its equivalent numeric ID.");
        return;
    end
    jobId = tonumber(jobId) or dsp.job[string.upper(jobId)];
    if (jobId == nil or jobId <= 0 or jobId >= dsp.MAX_JOB_TYPE) then
        error(player, "Invalid jobID.  Use job short name, e.g. WAR, or its equivalent numeric ID.");
        return;
    end

    -- validate level
    if (level ~= nil) then
        if (level < 1 or level > 99) then
            error(player, "Invalid level. Level must be between 1 and 99!");
            return;
        end
    end


    -- invert dsp.job table
    local jobNameByNum={};
    for k,v in pairs(dsp.job) do
        jobNameByNum[v]=k;
    end

    -- validate target
    local targ;
    if (target == nil) then
        error(player, "You must provide a player name.");
        return;
    else
        targ = GetPlayerByName( target );
        if (targ == nil) then
            error(player, string.format( "Player named '%s' not found!", target ) );
            return;
        end
    end
    
    -- change job and (optionally) level
    targ:changesJob(jobId);
    if (level ~= nil) then
        targ:setsLevel(level);
    end

    -- output new job to player
    targ:PrintToPlayer(string.format("You are now a %s%i/%s%i.", jobNameByNum[targ:getMainJob()], targ:getMainLvl(), jobNameByNum[targ:getSubJob()], targ:getSubLvl()));
end
