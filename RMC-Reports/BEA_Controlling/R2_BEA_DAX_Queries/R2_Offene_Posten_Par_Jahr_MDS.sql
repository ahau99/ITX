-- 2018-07-18 : "Name" in Datum gewandelt um Abfrage eingebaut, so dass nur Daten ab dem April 2018 angezeigt werden

SELECT distinct
CAST(LEFT(Name, 4) AS INT) AS Jahr
--,CAST(RIGHT(Name, 2) AS INT) AS MonatNo,Name
--,DATEfromParts(
--				CAST(LEFT (Name, 4) AS INT),	--Jahr
--				CAST(RIGHT(Name, 2) AS INT),	-- Monat
--				1								-- Tag
--			   ) as Calendar_Date
FROM mdm.Freigabe_Finanzdaten
WHERE (Freigegeben_Name = N'Ja')
AND	   DATEfromParts(
				CAST(LEFT (Name, 4) AS INT),	--Jahr
				CAST(RIGHT(Name, 2) AS INT),	-- Monat
				1								-- Tag
			   ) >= DateFromParts(2018,04,01)   -- erst am dem Datum gibt es historie, davor noch nicht
Order by 1 desc