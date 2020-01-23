SELECT distinct
max(CAST(LEFT(Name, 4) AS INT)) AS Jahr

FROM mdm.Freigabe_Finanzdaten
WHERE (Freigegeben_Name = N'Ja')
Order by 1 desc