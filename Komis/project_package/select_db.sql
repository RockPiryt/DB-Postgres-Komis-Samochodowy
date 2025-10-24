   /* • Obecność złączenia, zarówno w składni ze słowami INNER JOIN jak i bez niej.
    • Użycie grupowania i funkcji agregujących.
    • Wyświetlanie wyniku operacji np. operacji arytmetycznych na liczbach czy na datach.
    • Warunki odwołujące się do wzorców napisów (np. opisy wszystkich układanek, LIKE 'układanka%').
    • Użycie zagnieżdżenia w obu odmianach, nieskorelowane i skorelowane.
    • Sprawdzanie warunku NULL.
    • Zapytania negatywne, np. klienci bez złożonych zamówień. Co najmniej w dwu wersjach.*/


--------------WYMAGANIE-------------- Użycie zagnieżdżenia w obu odmianach, nieskorelowane 
-- Pokaż wszystkie samochody, które pochodzą z Polski
SELECT 
    dos.kraj_pochodzenia,
    s.*
FROM samochod as s 
JOIN dostawa as dos ON dos.id_samochod=s.id_samochod
WHERE s.id_samochod IN (SELECT d.id_samochod FROM dostawa AS d WHERE kraj_pochodzenia = 'Polska')


-- zagnieżdżona tabela użyta w warunku służy jako zbiór – możemy najpierw wykonać wewnętrzne zapytanie, a potem
-- z tabeli zewnętrznej – brak korelacji

--------------WYMAGANIE-------------- Użycie zagnieżdżenia w obu odmianach, skorelowane 
-- Pokaż klientow, którzy dokonali transakcji na placu nr 1
SELECT 
    kl.imie,
    kl.nazwisko
FROM klient AS kl
WHERE EXISTS (
    SELECT 1 
    FROM kartoteka_transakcji AS kt
    WHERE kt.id_klient = kl.id_klient
    AND kt.id_plac = 1
);
--------------WYMAGANIE-------------- Warunki odwołujące się do wzorców napisów (np. opisy wszystkich układanek, LIKE 'układanka%')
-- wyświetl samochody zarejestrowane w Poznania
SELECT * FROM samochod WHERE nr_rejestracyjny LIKE'PO%';
-- wyświetl samochody zarejestrowane, które mają napęd 4x4
SELECT 
    s.nr_vin,
    s.marka,
    s.model,
    s.rocznik
FROM samochod AS s WHERE model LIKE '%4x4%';

--------------WYMAGANIE-------------- Obecność złączenia bez składni INNER JOIN
-- Wyświetl wszystkie samochody wraz z informacją o rodzaju transakcji (sprzedaż/kupno) i dacie transakcji
SELECT 
    s.marka,
	s.model,
	kt.rodzaj,
	kt.data_transakcji
FROM samochod AS s, kartoteka_transakcji AS kt WHERE s.id_samochod=kt.id_samochod


--------------WYMAGANIE---------------INNER JOIN+grupowanie+funkcja aggregująca count 
-- Pokaż informacje o sprzedawcach, którzy sprzedali najwięcej samochodów
--możemy zsumować ilość sprzedanych samochodów dla każdego sprzedawcy i posortować wyniki malejąco.
SELECT s.id_sprzedawca, s.imie, s.nazwisko, COUNT(k.id_samochod) AS liczba_sprzedanych_samochodow
FROM sprzedawca AS s
JOIN kartoteka_transakcji AS  k ON s.id_sprzedawca = k.id_sprzedawca
GROUP BY s.id_sprzedawca, s.imie, s.nazwisko
ORDER BY liczba_sprzedanych_samochodow DESC
--LIMIT 1; -- wybór najlepszego sprzedawcy

--------------WYMAGANIE-----------------Sprawdzanie warunku NULL.
--pokaż samochody z opisami
SELECT 
    s.nr_vin,
    s.marka,
    s.model,
    s.rocznik,
    s.opis
FROM samochod AS s WHERE opis IS NOT NULL;


--------------------------Zapytania negatywne, np. klienci bez złożonych zamówień. Co najmniej w dwu wersjach
--pokaż klientów którzy nie dostali żadnego rabatu 
--WERSJA 1 -- WHERE NOT IN
SELECT 
    kl.imie,
    kl.nazwisko,
	kl.id_klient
FROM klient AS kl
WHERE kl.id_klient NOT IN (SELECT 
    k.id_klient
FROM klient AS k
JOIN kartoteka_transakcji as t ON t.id_klient=k.id_klient  
JOIN faktura AS f ON f.id_faktura=t.id_faktura
WHERE f.rabat IS NOT NULL)
ORDER BY kl.id_klient;

--WERSJA 2 - LEFT JOIN
SELECT 
    kl.imie,
    kl.nazwisko,
	kl.id_klient
FROM klient AS kl
LEFT JOIN kartoteka_transakcji as t ON t.id_klient=kl.id_klient  
LEFT JOIN faktura AS f ON f.id_faktura=t.id_faktura
WHERE f.rabat IS NULL
ORDER BY kl.id_klient;


--------------WYMAGANIE-----------------Użycie grupowania i funkcji agregujących.
-- Pokaż średnią wartość rabatu udzielanego klientom w procentach i kwotowo
SELECT 
    ROUND(AVG(rabat),2) AS sredni_rabat_procent
FROM faktura;

--------------WYMAGANIE-----------------Wyświetlanie wyniku operacji na datach.
-- pokaż transakcje z kartoteki zleceń z miesiąca marca
SELECT * FROM public.kartoteka_transakcji
	 WHERE data_transakcji BETWEEN '2024-03-01' AND '2024-03-31'
ORDER BY id_transakcja ASC 

--------------WYMAGANIE----------------- Obecność złączenia, zarówno w składni ze słowami INNER JOIN jak i bez niej.
--wyświetlenie pozycji samochodów na konkretnej fakturze wraz z cenami
SELECT 
	kt.id_samochod,
	s.cena,
	f.*
	FROM faktura AS f
JOIN kartoteka_transakcji AS kt ON kt.id_faktura=f.id_faktura
JOIN samochod AS s ON s.id_samochod=kt.id_samochod
WHERE f.id_faktura=1


-------------------------Zagnieżdzenie w klauzuli FROM
-- pokaż sumę wszytskich pozycji na fakturze nr 1 (z uwzględnieniem rabatów)
SELECT 
    SUM(sub.cena_po_rabacie) AS suma_cen
FROM 
    (SELECT 
        s.cena - (s.cena * ROUND((CAST(COALESCE(f.rabat, 0) AS decimal) / 100), 2)) AS cena_po_rabacie
     FROM faktura AS f
     JOIN  kartoteka_transakcji AS kt ON kt.id_faktura = f.id_faktura
     JOIN samochod AS s ON s.id_samochod = kt.id_samochod
     WHERE f.id_faktura = 1
     ) AS sub;

--------------WYMAGANIE----------------Użycie widoku (perspektywy, VIEW) + Wyświetlanie wyniku  operacji arytmetycznych 
--wyświetl tabele faktura z ostatecznymi kwotami po rabacie

CREATE VIEW kwota_po_rabacie
AS
SELECT 	
        kt.id_samochod,
	    s.cena AS cena_samochodu,
        f.id_faktura,f.nr_faktury,
		COALESCE(f.rabat, 0) AS rabat_procenty,
		ROUND((CAST(COALESCE(f.rabat, 0) AS decimal)/100),2) AS rabat_decimal,
        s.cena * ROUND((CAST(COALESCE(f.rabat, 0) AS decimal)/100),2) AS kwota_rabatu,
		s.cena -(s.cena * ROUND((CAST(COALESCE(f.rabat, 0) AS decimal)/100),2)) AS kwota_po_rabacie,
        f.sposob_zaplaty,f.czy_zaplacono
FROM faktura AS f
JOIN kartoteka_transakcji AS kt ON kt.id_faktura=f.id_faktura
JOIN samochod AS s ON s.id_samochod=kt.id_samochod;

------------------------Użycie grupowania i funkcji agregujących.+Użycie widoku (perspektywy, VIEW) 
--pokazuje ceny po rabacie dla faktury nr 1

CREATE VIEW zestawienie_faktura_1
AS
SELECT 	
        f.id_faktura,
		f.nr_faktury,
        s.id_samochod,
        SUM(s.cena -(s.cena * ROUND((CAST(COALESCE(f.rabat, 0) AS decimal)/100),2))) AS cena_auta_po_rabacie
FROM faktura AS f
JOIN kartoteka_transakcji AS kt ON kt.id_faktura=f.id_faktura
JOIN samochod AS s ON s.id_samochod=kt.id_samochod
WHERE f.id_faktura=1
GROUP BY f.id_faktura,f.nr_faktury,s.cena, s.id_samochod


--------------------UPDATE
--Zmiana atrybutu gotowy_do_sprzedaży dla samochodu o id=4
UPDATE samochod SET gotowy_do_sprzedaży = TRUE WHERE id_samochod = 4;

-- aktualizacja ceny (obniżenie pierwotnej) dla samochodu o id=15
UPDATE samochod SET cena=65000.00 WHERE id_samochod = 15;

--------------------DELETE
--Zwolnienie pracownika z id=15 (Zofia Kozłowska)
DELETE FROM sprzedawca WHERE id_sprzedawca = 12;




