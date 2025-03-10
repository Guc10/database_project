-- 1
WITH MasyCzarnychDziur AS (
    SELECT 
        g.nazwa AS nazwa_galaktyki,
        AVG(cd.masa) AS srednia_masa
    FROM 
        czarnedziury cd
    JOIN 
        lokalizacje l ON cd.Id_czarnej_dziury = l.Id_czarnej_dziury
    JOIN 
        galaktyki g ON l.Id_galaktyki = g.Id_galaktyki
    GROUP BY 
        g.nazwa
)
SELECT 
    nazwa_galaktyki, 
    srednia_masa
FROM 
    MasyCzarnychDziur;

-- 2
SELECT CONCAT(b.imie, ' ', b.nazwisko) AS pelne_imie, SUM(cd.masa) AS suma_mas
FROM badacze b
JOIN badacze_obserwacje bo ON b.Id_badacza = bo.Id_badacza
JOIN obserwacje o ON bo.Id_obserwacji = o.Id_obserwacji
JOIN (SELECT * FROM czarnedziury WHERE masa > 600000) cd ON o.Id_czarnej_dziury = cd.Id_czarnej_dziury
GROUP BY b.Id_badacza
HAVING SUM(cd.masa) > 1000000
ORDER BY SUM(cd.masa) DESC
LIMIT 10;

-- 3
SELECT SUBSTRING(cd.nazwa, 1, 3) AS skrot_nazwy, cd.masa AS masa,
       (SELECT COUNT(*) FROM obserwacje o WHERE o.Id_czarnej_dziury = cd.Id_czarnej_dziury) AS liczba_obserwacji
FROM czarnedziury cd
GROUP BY SUBSTRING(cd.nazwa, 1, 3)
ORDER BY masa DESC
LIMIT 50;

-- 4
SELECT LENGTH(cd.nazwa) AS dlugosc_nazwy, COUNT(*) AS liczba_czarnych_dziur
FROM (SELECT * FROM czarnedziury WHERE typ IN ('pierwotne', 'gwiazdowe')) cd
GROUP BY LENGTH(cd.nazwa)
LIMIT 5;

-- 5
SELECT LOWER(b.instytucja) AS instytucja_male_litery, COUNT(*) AS liczba_badaczy
FROM badacze b
WHERE b.Id_badacza IN (SELECT Id_badacza FROM badacze_obserwacje WHERE Id_obserwacji IN (SELECT Id_obserwacji FROM obserwacje))
GROUP BY LOWER(b.instytucja);

--6
SELECT UPPER(cd.nazwa) AS nazwa_wielkie_litery, cd.masa AS masa
FROM (SELECT * FROM czarnedziury WHERE odleglosc_od_ziemi < 1000) cd
ORDER BY cd.masa ASC
LIMIT 10;

--7
WITH WielkosciCzarnychDziur AS (
    SELECT 
        cd.Id_czarnej_dziury,
        cd.nazwa,
        cd.masa,
        (CAST(SUBSTRING(cd.nazwa, 4) AS UNSIGNED) * cd.masa) AS wielkosc
    FROM 
        czarnedziury cd
)
(SELECT 
    'Największa czarna dziura' AS typ,
    nazwa,
    wielkosc
FROM 
    WielkosciCzarnychDziur
ORDER BY 
    wielkosc DESC
LIMIT 1)
UNION ALL
(SELECT 
    'Najmniejsza czarna dziura' AS typ,
    nazwa,
    wielkosc
FROM 
    WielkosciCzarnychDziur
ORDER BY 
    wielkosc ASC
LIMIT 1);

-- 8
SELECT SUBSTRING(cd.nazwa, 1, 3) AS skrot_nazwy, cd.masa AS masa
FROM czarnedziury cd
WHERE cd.masa > (SELECT AVG(masa) FROM czarnedziury)
GROUP BY SUBSTRING(cd.nazwa, 1, 3)
ORDER BY AVG(cd.masa)
LIMIT 15;

-- 9
WITH SredniaOdleglosc AS (
    SELECT 
        cd.odleglosc_od_ziemi AS odleglosc
    FROM 
        czarnedziury cd
   	WHERE
   	cd.masa > 500000
)
SELECT 
    AVG(odleglosc) AS srednia_odleglosc
FROM 
    SredniaOdleglosc

-- 10
SELECT CONCAT(b.imie, ' ', b.nazwisko) AS pelne_imie, 
       (SELECT COUNT(*) FROM badacze_obserwacje bo WHERE bo.Id_badacza = b.Id_badacza) AS liczba_obserwacji
FROM badacze b;