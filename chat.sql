SELECT
  datetime((m.ZMESSAGEDATE + 978307200), 'unixepoch') AS date,
  pn_from.ZPUSHNAME AS fromNICKNAME,
  pn_to.ZPUSHNAME AS toNICKNAME,
  REPLACE(REPLACE(m.ZFROMJID, '@s.whatsapp.net', ''), '@g.us', ' (Group)') AS fromNUMBER,
  REPLACE(REPLACE(m.ZTOJID, '@s.whatsapp.net', ''), '@g.us', ' (Group)') AS toNUMBER,
  m.ZTEXT AS message,
  CASE 
        WHEN m.ZFROMJID IS NULL THEN 'OUT'
        ELSE 'IN'
    END AS direction
FROM
  ZWAMESSAGE m
  LEFT JOIN
  ZWAPROFILEPUSHNAME pn_from ON pn_from.ZJID = m.ZFROMJID
  LEFT JOIN
  ZWAPROFILEPUSHNAME pn_to ON pn_to.ZJID = m.ZTOJID
WHERE
    datetime((m.ZMESSAGEDATE + 978307200), 'unixepoch') > '2014-05-27'
  AND datetime((m.ZMESSAGEDATE + 978307200), 'unixepoch') < '2014-12-31'
  AND (
        REPLACE(REPLACE(m.ZFROMJID, '@s.whatsapp.net', ''), '@g.us', ' (Group)') LIKE 'xxx%'
  OR REPLACE(REPLACE(m.ZTOJID, '@s.whatsapp.net', ''), '@g.us', ' (Group)') LIKE 'xxx%'
  OR REPLACE(REPLACE(m.ZFROMJID, '@s.whatsapp.net', ''), '@g.us', ' (Group)') = 'xxx'
  OR REPLACE(REPLACE(m.ZTOJID, '@s.whatsapp.net', ''), '@g.us', ' (Group)') = 'xxx'
    )
ORDER BY
    m.ZMESSAGEDATE ASC;
