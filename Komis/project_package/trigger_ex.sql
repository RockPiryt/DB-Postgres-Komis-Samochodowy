-----------------------TRIGGER 1 - PRZYKŁAD (historia zmian ceny samochodu )
--Dodanie nowego samochodu do bazy danych:
INSERT INTO samochod (nr_rejestracyjny, nr_vin, marka, model, rocznik, przebieg, silnik, paliwo, moc, kolor, rodzaj_pojazdu, ladownosc, gotowy_do_sprzedaży, cena, opis, id_plac)
VALUES ('ABC1234', '1HGBH41JXMN109186', 'Toyota', 'Camry', 2020, 15000.00, 2.5, 'Benzyna', 178, 'Biały', 'Sedan', 1.50, TRUE, 85000.00, 'Samochód w bardzo dobrym stanie', 1);

--Aktualizacja ceny samochodu:
UPDATE samochod
SET cena = 80000.00
WHERE id_samochod = 16;

--Weryfikacja zmian cen w tabeli historia_cen
SELECT * FROM historia_cen
WHERE id_samochod = 16;



-----------------------TRIGGER 2 - PRZYKŁAD -----zablokowanie wstawienia rekordu -----------------------------------------------


--Wstawienie nowej transakcji, które uruchomi trigger before_insert_kartoteka_transakcji. 
--Zakładamy, że mamy samochód o id_samochod = 1, który nie jest gotowy do sprzedaży:

-- Ustawienie statusu gotowości samochodu na false
UPDATE samochod SET gotowy_do_sprzedaży = FALSE WHERE id_samochod = 1;

-- Próba wstawienia transakcji dla samochodu, który nie jest gotowy do sprzedaży
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES ('Sprzedaż', '2024-05-01', FALSE, 1, 1, 1, 1, 1);

-- Sprawdzenie, czy transakcja została wstawiona
SELECT * FROM kartoteka_transakcji WHERE id_samochod = 1;

--Ponieważ samochód o id_samochod = 1 nie jest gotowy do sprzedaży, 
--trigger before_insert_kartoteka_transakcji zablokuje wstawienie rekordu 
--i zwróci błąd: Samochód nie jest gotowy do sprzedaży.

--------------------------------------wstawienie nowego rekordu transakcji do tabeli kartoteka_transakcji-----------------------------------

--Teraz ustawimy samochód jako gotowy do sprzedaży i spróbujemy ponownie:

-- Ustawienie statusu gotowości samochodu na true
UPDATE samochod SET gotowy_do_sprzedaży = TRUE WHERE id_samochod = 1;

-- Ponowna próba wstawienia transakcji dla samochodu, który jest gotowy do sprzedaży
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES ('Sprzedaż', '2024-05-01', FALSE, 1, 1, 1, 1, 1);

-- Sprawdzenie, czy transakcja została wstawiona
SELECT * FROM kartoteka_transakcji WHERE id_samochod = 1;

--Po ustawieniu statusu samochodu na gotowy do sprzedaży, 
--trigger pozwoli na wstawienie nowego rekordu transakcji do tabeli kartoteka_transakcji.


