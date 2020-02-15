SELECT 
    chars.charname 'Character',
    craft_names.name 'Skill',
    char_skills.value / 10 'Value',
    char_skills.rank 'Rank Number'
FROM
    char_skills,
    chars,
    craft_names
WHERE
    char_skills.skillid = craft_names.skillid
        AND chars.charid = char_skills.charid
ORDER BY chars.charname;