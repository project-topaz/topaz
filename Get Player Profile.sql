SELECT 
    chars.charname,
    chars.nation,
    char_profile.rank_sandoria,
    char_profile.rank_bastok,
    char_profile.rank_windurst,
    job_list.jobcode,
    char_stats.mlvl,
    job2_list.jobcode,
    char_stats.slvl
FROM
    chars,
    char_profile,
    zone_settings,
    char_stats,
    job_list,
    job2_list,
    discord,
    char_jobs
WHERE
        chars.charid = char_profile.charid
        AND char_stats.charid = chars.charid
        AND char_stats.mjob = job_list.jobid
        AND char_stats.sjob = job2_list.jobid
        AND chars.charid = discord.charid
        AND char_jobs.charid = chars.charid;