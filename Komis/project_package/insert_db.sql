------------------------------------------------KOMIS INSERT--------------------------------------------ok


INSERT INTO komis (nip, nazwa, panstwo, miasto, ulica, nr_budynku, nr_lokalu, kod_pocztowy, telefon, e_mail)
VALUES (1234567890, 'AutoKomis XYZ', 'Polska', 'Warszawa', 'Marszałkowska', '123', '4A', '00-001', '123-456-789', 'kontakt@autokomisxyz.pl');
------------------------------------------------PLACE INSERTY--------------------------------------------ok

-- Do komisu należą 3 place
INSERT INTO plac (kraj, miejscowosc, ulica, nr_działki, id_komis)
VALUES ('Polska', 'Kraków', 'Floriańska', '10', 1);

INSERT INTO plac (kraj, miejscowosc, ulica, nr_działki, id_komis)
VALUES ('Polska', 'Gdańsk', 'Długa', '25', 1);

INSERT INTO plac (kraj, miejscowosc, ulica, nr_działki, id_komis)
VALUES ('Polska', 'Poznań', 'Święty Marcin', '8', 1);

-------------------------------------------------SAMOCHODY INSERTY ----------------------------------------ok

-- Samochody rozmieszczone na 3 placach
INSERT INTO samochod (nr_rejestracyjny, nr_vin, marka, model, rocznik, przebieg, silnik, paliwo, moc, kolor, rodzaj_pojazdu, ladownosc, gotowy_do_sprzedaży, cena, opis)
VALUES 
('ABC1234', '1HGCM82633A123456', 'Toyota', 'Corolla', 2015, 80000, 1.8, 'Benzyna', 140, 'Czarny', 'Sedan', 5.0, true, 15000.00, 'Polski salon'),
('DEF5678', '2HGCM82633A654321', 'Honda', 'Civic', 2018, 60000, 2.0, 'Benzyna', 158, 'Biały', 'Sedan', 4.5, false, 145999.00, 'Dodatkowy komplet opon'),
('GHI9101', '3HGCM82633A987654', 'Ford', 'Focus', 2020, 30000, 1.5, 'Diesel', 120, 'Niebieski', 'Hatchback', 4.0, true, 65000.00, 'Brak drugiego kluczyka'),
('POL2345', '4HGCM82633A456789', 'Volkswagen', 'Golf', 2016, 90000, 1.6, 'Benzyna', 110, 'Srebrny', 'Hatchback', 4.3, false, 90500.00, null),
('MNO6789', '5HGCM82633A112233', 'BMW', '3 Series 4x4', 2017, 70000, 2.0, 'Diesel', 190, 'Czerwony', 'Sedan', 4.8, true, 25000.00, null),
('PQR1122', '6HGCM82633A332211', 'Audi', 'A4', 2019, 50000, 2.0, 'Benzyna', 200, 'Czarny', 'Sedan', 4.7, false, 25000.00,'Dodatkowy komplet opon'),
('STU3344', '7HGCM82633A223344', 'Mercedes', 'C-Class', 2018, 65000, 2.0, 'Diesel', 180, 'Biały', 'Sedan', 4.6, true, 12000.00, null),
('VWX5566', '8HGCM82633A445566', 'Skoda', 'Octavia', 2021, 20000, 1.4, 'Benzyna', 150, 'Zielony', 'Hatchback', 4.2, false,15000.00, 'Dodatkowo CB radio'),
('YZA7788', '9HGCM82633A667788', 'Volvo', 'S60 4x4', 2016, 85000, 2.0, 'Diesel', 190, 'Srebrny', 'Sedan', 4.9, true,10000.00, null),
('POD9900', '0HGCM82633A889900', 'Mazda', '6 4x4', 2017, 75000, 2.2, 'Diesel', 175, 'Niebieski', 'Sedan', 4.5, false,115000.00, null),
('EFG1235', '1HGCM82633B112233', 'Opel', 'Astra', 2020, 25000, 1.6, 'Benzyna', 130, 'Czerwony', 'Hatchback', 4.1, true,17000.00, null),
('HIJ4567', '2HGCM82633B445566', 'Renault', 'Megane', 2019, 40000, 1.5, 'Diesel', 115, 'Biały', 'Hatchback', 4.0, false,20000.00, null),
('KLM7890', '3HGCM82633B778899', 'Peugeot', '308', 2018, 55000, 1.2, 'Benzyna', 130, 'Czarny', 'Hatchback', 4.2, true,15000.00, 'Brak drugiego kluczyka'),
('POP1123', '4HGCM82633C112233', 'Hyundai', 'Elantra', 2021, 15000, 1.8, 'Benzyna', 147, 'Srebrny', 'Sedan', 4.5, false,45000.00, 'Dodatkowy komplet opon'),
('QRC4456', '5HGCM82633C445566', 'Kia', 'Ceed', 2017, 70000, 1.6, 'Diesel', 136, 'Niebieski', 'Hatchback', 4.3, true,70000.00, 'Polski salon');

--------------------------------------------DOSTAWA INSERTY---------------------------------------ok
INSERT INTO dostawa (data_dostawy, kraj_pochodzenia, czy_zarejestrowany, czy_uszkodzony, id_plac, id_samochod)
VALUES 
('2022-01-05', 'Polska', true, false, 1, 1),
('2022-02-12', 'Niemcy', false, true, 2, 2),
('2022-03-20', 'Polska', true, false, 3, 3),
('2022-04-15', 'Francja', false, true, 1, 4),
('2022-05-10', 'Polska', true, false, 2, 5),
('2022-06-25', 'Włochy', false, true, 3, 6),
('2022-07-08', 'Polska', true, false, 1, 7),
('2022-08-19', 'Hiszpania', false, true, 2, 8),
('2022-09-21', 'Polska', true, false, 3, 9),
('2022-10-03', 'Holandia', false, true, 1, 10),
('2022-11-14', 'Polska', true, false, 2, 11),
('2022-12-30', 'Belgia', false, true, 3, 12),
('2023-01-08', 'Polska', true, false, 1, 13),
('2023-02-17', 'Austria', false, true, 2, 14),
('2023-03-22', 'Polska', true, false, 3, 15);


--------------------------------------------SPRZEDAWCA INSERTY---------------------------------------
--Po 4 sprzedawców na każdy z 3 placów komisu 

-- Sprzedawcy dla pierwszego placu (id_plac = 1)
INSERT INTO sprzedawca (imie, nazwisko, nr_telefonu, e_mail, id_komis, id_plac)
VALUES 
('Jan', 'Kowalski', '123-456-789', 'jan.kowalski@example.com', 1, 1),
('Anna', 'Nowak', '234-567-890', 'anna.nowak@example.com', 1, 1),
('Piotr', 'Wiśniewski', '345-678-901', 'piotr.wisniewski@example.com', 1, 1),
('Katarzyna', 'Wójcik', '456-789-012', 'katarzyna.wojcik@example.com', 1, 1);

-- Sprzedawcy dla drugiego placu (id_plac = 2)
INSERT INTO sprzedawca (imie, nazwisko, nr_telefonu, e_mail, id_komis, id_plac)
VALUES 
('Marek', 'Kowalczyk', '567-890-123', 'marek.kowalczyk@example.com', 1, 2),
('Ewa', 'Kamińska', '678-901-234', 'ewa.kaminska@example.com', 1, 2),
('Tomasz', 'Lewandowski', '789-012-345', 'tomasz.lewandowski@example.com', 1, 2),
('Magdalena', 'Dąbrowska', '890-123-456', 'magdalena.dabrowska@example.com', 1, 2);

-- Sprzedawcy dla trzeciego placu (id_plac = 3)
INSERT INTO sprzedawca (imie, nazwisko, nr_telefonu, e_mail, id_komis, id_plac)
VALUES 
('Robert', 'Zieliński', '901-234-567', 'robert.zielinski@example.com', 1, 3),
('Agnieszka', 'Szymańska', '012-345-678', 'agnieszka.szymanska@example.com', 1, 3),
('Paweł', 'Woźniak', '123-456-789', 'pawel.wozniak@example.com', 1, 3),
('Zofia', 'Kozłowska', '234-567-890', 'zofia.kozlowska@example.com', 1, 3);

---------------------------------FAKTURA INSERTY---------------------------------------------ok
INSERT INTO faktura (nr_faktury, rabat, sposob_zaplaty, czy_zaplacono) 
VALUES 
('F/2024/001', 5, 'Przelew', true),
('F/2024/002', null, 'Gotówka', true),
('F/2024/003', 10, 'Karta kredytowa', true),
('F/2024/004', 5,'Przelew', false),
('F/2024/005', 4, 'Gotówka', true),
('F/2024/006', null, 'Przelew', false),
('F/2024/007', 9, 'Przelew', true),
('F/2024/008', 3, 'Karta kredytowa', true),
('F/2024/009', 4, 'Przelew', true),
('F/2024/010', 7, 'Gotówka', true);

---------------------------------KLIENT INSERTY---------------------------------------------ok

INSERT INTO klient (imie, nazwisko, pesel, rodzaj_dokumentu, nr_dokumentu, panstwo, miasto, ulica, nr_domu, nr_mieszkania, kod, telefon)
VALUES 
('Jan', 'Kowalski', '12345678901', 'Dowód osobisty', 'ABC123456', 'Polska', 'Warszawa', 'Krakowska', 10, 2, '00-001', '123456789'),
('Anna', 'Nowak', '98765432101', 'Dowód osobisty', 'DEF987654', 'Polska', 'Kraków', 'Piotrkowska', 5, NULL, '30-002', '987654321'),
('Piotr', 'Wiśniewski', '34567890101', 'Paszport', 'GHI654321', 'Polska', 'Gdańsk', 'Słoneczna', 15, 4, '80-003', '654321987'),
('Maria', 'Dąbrowska', '67890123402', 'Dowód osobisty', 'JKL321654', 'Polska', 'Poznań', 'Leszczyńska', 20, NULL, '60-004', '456789012'),
('Adam', 'Lis', '01234567891', 'Paszport', 'MNO987654', 'Polska', 'Łódź', 'Wschodnia', 30, 7, '90-005', '789012345'),
('Ewa', 'Kamińska', '11223344556', 'Dowód osobisty', 'PQR456789', 'Polska', 'Wrocław', 'Polna', 25, 1, '50-006', '321654987'),
('Tomasz', 'Zieliński', '12345678909', 'Paszport', 'STU654321', 'Polska', 'Szczecin', 'Rybacka', 8, NULL, '70-007', '654987321'),
('Magdalena', 'Woźniak', '21314151617', 'Dowód osobisty', 'VWX123456', 'Polska', 'Katowice', 'Ogrodowa', 12, NULL, '40-008', '987321654'),
('Katarzyna', 'Jaworska', '56789012342', 'Dowód osobisty', 'YZA987654', 'Polska', 'Gdynia', 'Moraska', 18, 3, '20-009', '741852963'),
('Grzegorz', 'Kaczmarek', '67890123456', 'Dowód osobisty', 'BCD654321', 'Polska', 'Kraków', 'Długa', 7, NULL, '30-010', '852963741');


--------------------------------------------KARTOTEKA ZLECEŃ INSERTY----------------------------------------

-- Sprzedaż na placu 1 przez sprzedawcę 1
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, uwagi, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES 
('sprzedaż', '2023-01-10', false, 'Dodać opony ziomowe', 1, 7, 1, 1, 1);

-- Sprzedaż na placu 1 przez sprzedawcę 2
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, uwagi, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES 
('sprzedaż', '2023-01-15', true, 'Samochód kupiony z rabatem', 2, 10, 9, 1, 1);

-- Sprzedaż na placu 1 przez sprzedawcę 3
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, uwagi, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES 
('sprzedaż', '2023-02-05', false, 'Polerka przed wydaniem', 3, 3, 3, 1, 2);

-- Kupno na placu 2 przez sprzedawcę 4
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, uwagi, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES 
('kupno', '2024-02-20', false, 'Samochód kupiony z rabatem', 4, 6, 4, 2, 2);

-- Sprzedaż na placu 2 przez sprzedawcę 5
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, uwagi, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES 
('sprzedaż', '2024-03-01', true, 'Brak uwag', 5, 2, 5, 2, 5);

-- Sprzedaż na placu 2 przez sprzedawcę 6
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, uwagi, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES 
('sprzedaż', '2024-03-15', false, 'Brak uwag', 6, 8, 9, 2, 6);

-- Kupno na placu 3 przez sprzedawcę 7
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, uwagi, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES 
('kupno', '2024-04-01', true, 'Samochód w rozliczeniu', 7, 9, 5, 3, 7);

-- Sprzedaż na placu 3 przez sprzedawcę 8
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, uwagi, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES 
('sprzedaż', '2024-04-10', false, 'Brak uwag', 8, 5, 8, 3, 8);

-- Sprzedaż na placu 3 przez sprzedawcę 9
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, uwagi, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES 
('sprzedaż', '2024-04-20', false, 'Dodać opony letnie', 9, 4, 9, 3, 9);

-- Kupno na placu 1 przez sprzedawcę 10
INSERT INTO kartoteka_transakcji (rodzaj, data_transakcji, samochod_w_rozliczeniu, uwagi, id_samochod, id_klient, id_sprzedawca, id_plac, id_faktura)
VALUES 
('kupno', '2024-05-01', true, 'Samochód w rozliczeniu', 10, 1, 10, 1, 9);
