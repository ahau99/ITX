-- 2018-07-18 : "Name" in Datum gewandelt um Abfrage eingebaut, so dass nur Daten ab dem April 2018 angezeigt werden
use DWH;
SELECT distinct
 CAST(LEFT(rmc.FACT_OFFENE_POSTEN_HIST.DueDate, 4) AS INT) AS Jahr
,CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) AS MonatNo
,CASE
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  1 THEN 'Januar'
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  2 THEN 'Februar'
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  3 THEN 'März'
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  4 THEN 'April'
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  5 THEN 'Mai'
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  6 THEN 'Juni'
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  7 THEN 'Juli'
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  8 THEN 'August'
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  9 THEN 'September'
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) = 10 THEN 'Oktober'
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) = 11 THEN 'November'
    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) = 12 THEN 'Dezember'
    ELSE Concat('Unbekannte Monatsnummer =>', ' "', CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT), '"')
 END AS MonatTxtLong
--,	   [dssDateTime]  as StichtagTimestamp
--,Year ([LastChgDateTime]) as StichtagJahr
--,Month([LastChgDateTime]) as StichtagMonat
--,Day  ([LastChgDateTime]) as StichtagTag
FROM rmc.FACT_OFFENE_POSTEN_HIST
WHERE (IstFreigegeben = 'Ja')

ORDER BY jahr desc, MonatNo DESC


-- 2018-07-18 : "Name" in Datum gewandelt um Abfrage eingebaut, so dass nur Daten ab dem April 2018 angezeigt werden
--use MDS;
--SELECT
--CAST(LEFT(Name, 4) AS INT) AS Jahr
--,CAST(RIGHT(Name, 2) AS INT) AS MonatNo
--,CASE
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  1 THEN 'Januar'
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  2 THEN 'Februar'
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  3 THEN 'März'
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  4 THEN 'April'
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  5 THEN 'Mai'
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  6 THEN 'Juni'
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  7 THEN 'Juli'
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  8 THEN 'August'
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) =  9 THEN 'September'
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) = 10 THEN 'Oktober'
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) = 11 THEN 'November'
--    WHEN CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT) = 12 THEN 'Dezember'
--    ELSE Concat('Unbekannte Monatsnummer =>', ' "', CAST(SUBSTRING(rmc.FACT_OFFENE_POSTEN_HIST.DueDate,5,2) AS INT), '"')
-- END AS MonatTxtLong
--,	   [LastChgDateTime]  as StichtagTimestamp
--,Year ([LastChgDateTime]) as StichtagJahr
--,Month([LastChgDateTime]) as StichtagMonat
--,Day  ([LastChgDateTime]) as StichtagTag
--FROM mdm.Freigabe_Finanzdaten
--WHERE (Freigegeben_Name = N'Ja')
--AND (CAST(LEFT(Name, 4) AS int) = 2018)
--AND	   DATEfromParts(
--				CAST(LEFT (Name, 4) AS INT),	--Jahr
--				CAST(RIGHT(Name, 2) AS INT),	-- Monat
--				1								-- Tag
--			   ) >= DateFromParts(2018,04,01)   -- erst am dem Datum gibt es historie, davor noch nicht
--ORDER BY jahr desc, MonatNo DESC