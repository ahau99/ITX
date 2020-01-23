-- 2018-07-18 : "Name" in Datum gewandelt um Abfrage eingebaut, so dass nur Daten ab dem April 2018 angezeigt werden
use DWH;
SELECT distinct
 CAST(LEFT(rmc.FACT_OFFENE_POSTEN_HIST.DueDate, 4) AS INT) AS Jahr
FROM rmc.FACT_OFFENE_POSTEN_HIST
WHERE (IstFreigegeben = 'Ja')

ORDER BY 
jahr desc