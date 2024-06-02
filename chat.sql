SELECT
	*
FROM (
	SELECT
		datetime ((ZMESSAGEDATE + 978307200),
			'unixepoch') AS date,
		(
			SELECT
				ZPUSHNAME
			FROM
				ZWAPROFILEPUSHNAME
			WHERE
				ZJID = ZFROMJID) AS `fromNICKNAME`, (
				SELECT
					ZPUSHNAME
				FROM
					ZWAPROFILEPUSHNAME
				WHERE
					ZJID = ZTOJID) AS `toNICKNAME`, REPLACE(REPLACE(ZFROMJID, '@s.whatsapp.net', ''), '@g.us', ' (Group)') AS `fromNUMBER`, REPLACE(REPLACE(ZTOJID, '@s.whatsapp.net', ''), '@g.us', ' (Group)') AS `toNUMBER`, ZTEXT AS `message`, CASE WHEN ZFROMJID IS NULL THEN
					'OUT'
				ELSE
					'IN'
				END AS `direction`
			FROM
				ZWAMESSAGE
			ORDER BY
				ZMESSAGEDATE ASC)
		WHERE
			`date` > '2014-05-27'
			AND `date` < '2014-12-31'
			AND(fromNumber LIKE 'xxx%'
				OR toNUMBER LIKE 'xxx'
				OR fromNUMBER = 'xxx'
				OR toNUMBER = 'xxx')