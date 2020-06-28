---------------------------------------------------------------------------------------------------
-- func: changejob
-- desc: Changes the players current job.
---------------------------------------------------------------------------------------------------

require("scripts/globals/status")
require("scripts/globals/commands")

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function onTrigger(caller, entity, jobId, level)
    local usage = "!changejob <jobID> {level}"

    -- validate jobId
    if (jobId == nil) then
        tpz.commands.error(caller, entity, "You must enter a job short-name, e.g. WAR, or its equivalent numeric ID.", usage)
        return
    end
    jobId = tonumber(jobId) or tpz.job[string.upper(jobId)]
    if (jobId == nil or jobId <= 0 or jobId >= tpz.MAX_JOB_TYPE) then
        tpz.commands.error(caller, entity, "Invalid jobID.  Use job short name, e.g. WAR, or its equivalent numeric ID.", usage)
        return
    end

    -- validate level
    if (level ~= nil) then
        if (level < 1 or level > 99) then
            tpz.commands.error(caller, entity, "Invalid level. Level must be between 1 and 99!", usage)
            return
        end
    end

    -- change job and (optionally) level
    entity:changeJob(jobId)
    if (level ~= nil) then
        entity:setLevel(level)
    end

    -- invert tpz.job table
    local jobNameByNum={}
    for k,v in pairs(tpz.job) do
        jobNameByNum[v]=k
    end

    -- output new job to player
    tpz.commands.print(caller, entity, string.format("You are now a %s%i/%s%i.", jobNameByNum[entity:getMainJob()], entity:getMainLvl(), jobNameByNum[entity:getSubJob()], entity:getSubLvl()))
end
