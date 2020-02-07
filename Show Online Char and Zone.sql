SELECT 
    chars.charname 'Character',
    zone_settings.name 'Zone',
    job_list.jobcode 'Job',
    char_stats.mlvl 'Level',
    job2_list.jobcode 'Subjob',
    char_stats.slvl 'Level',
    chars.gmlevel 'GM Level',
    accounts_parties.partyid,
    accounts_parties.partyflag,
    accounts_parties.allianceid
FROM
    accounts_sessions,
    chars,
    zone_settings,
    char_stats,
    job_list,
    job2_list,
    accounts_parties
WHERE
    accounts_sessions.charid = chars.charid
        AND zone_settings.zoneid = chars.pos_zone
        AND char_stats.charid = chars.charid
        AND char_stats.mjob = job_list.jobid
        AND char_stats.sjob = job2_list.jobid
        AND chars.charid = accounts_parties.charid
ORDER BY chars.charname;