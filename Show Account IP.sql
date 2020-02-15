SELECT 
    accounts.login 'Account', account_ip_record.client_ip
FROM
    dspdb.account_ip_record,
    accounts
WHERE
    accounts.id = account_ip_record.accid
ORDER BY client_ip;