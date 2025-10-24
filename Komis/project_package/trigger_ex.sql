-----------------------TRIGGER 1 -----------------------------------------

-- Sprawdź obecną cenę samochodu 1
SELECT id_samochod, cena FROM samochod WHERE id_samochod = 1;

-- Zmień cenę
UPDATE samochod
SET cena = cena + 5000
WHERE id_samochod = 1;

-- Sprawdź historię cen
SELECT * FROM historia_cen WHERE id_samochod = 1 ORDER BY data_zmiany DESC;


-----------------------TRIGGER 2 -----------------------------------------

-- Spróbuj dodać transakcję dla samochodu, który nie jest gotowy do sprzedaży
INSERT INTO kartoteka_transakcji 
(rodzaj, data_transakcji, samochod_w_rozliczeniu, uwagi, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES 
('sprzedaż', CURRENT_DATE, false, 'Test triggera', 3, 1, 1, 1, 1);

------------------------TRIGGER 3 -----------------------------------------
-- Dodanie nowej dostawy
INSERT INTO dostawa (data_dostawy, kraj_pochodzenia, czy_zarejestrowany, czy_uszkodzony, id_plac, id_samochod)
VALUES (CURRENT_DATE, 'Polska', true, false, 1, 11);

-- Sprawdź czy samochód został oznaczony jako gotowy
SELECT id_samochod, gotowy_do_sprzedaży FROM samochod WHERE id_samochod = 11;

------------------------TRIGGER 4----------------------------------
DELETE FROM samochod WHERE id_samochod = 2;

-------------------------TRIGGER 5---------------------------------
-- Dodanie nowego ubezpieczenia
INSERT INTO ubezpieczenie (id_samochod, firma_ubezpieczeniowa, nr_polisy, data_poczatku, data_konca, koszt)
VALUES (1, 'Allianz', 'POLISA123', CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', 1500);

-- Sprawdź wpis
SELECT * FROM ubezpieczenie WHERE id_samochod = 1 ORDER BY id_ubezpieczenie DESC;

