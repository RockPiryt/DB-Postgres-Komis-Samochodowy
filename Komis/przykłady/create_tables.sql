CREATE TABLE towar (
id_towaru INTEGER PRIMARY KEY,
nazwa VARCHAR(100)
);

CREATE TABLE spedytor (
id_spedytora INTEGER PRIMARY KEY,
imie VARCHAR(30),
nazwisko VARCHAR(30),
nr_telefonu INTEGER,
e_mail VARCHAR(50)
);

CREATE TABLE operacja_log (
skrot CHAR(1) PRIMARY KEY,
nazwa VARCHAR(15)
);

CREATE TABLE typ_taboru (
id_typu INTEGER PRIMARY KEY,
nazwa VARCHAR(30)
);

CREATE TABLE kierowca (
id_kierowcy INTEGER PRIMARY KEY,
imie VARCHAR(30),
nazwisko VARCHAR(30),
nr_dok_toz VARCHAR(30),
nr_telefonu INTEGER,
wtrasie BOOL
);

CREATE TABLE klient (
id_klienta INTEGER PRIMARY KEY,
nazwa_klienta VARCHAR(200),
ulica VARCHAR(100),
miasto VARCHAR(50),
kod VARCHAR(10),
panstwo VARCHAR(30),
nip VARCHAR(20),
os_kontaktowa VARCHAR(60),
nr_telefonu INTEGER,
e_mail VARCHAR VARCHAR(50)
);

CREATE TABLE miejsce (
id_miejsca INTEGER PRIMARY KEY,
nazawa_firmy VARCHAR(200),
ulica VARCHAR(100),
miasto VARCHAR(50),
kod VARCHAR(10),
panstwo VARCHAR(30),
dodatkowy_opis VARCHAR(200),
godziny_pracy VARCHAR(20)
);

CREATE TABLE tabor (
nr_rejestracyjny VARCHAR(10) PRIMARY KEY,
id_typu, INTEGER NOT NULL,
data_przegladu DATE,
zajety_wolny BOOL,
CONSTRAINT fk_tabor FOREIGN KEY id_typu REFERENCES typ_taboru(id_typu)
);

CREATE TABLE zlecenie (
id_zlecenia INTEGER PRIMARY KEY,
id_klienta INTEGER NOT NULL,
nr_rejestracyjny VARCHAR(10) NOT NULL,
id_spedytora INTEGER NOT NULL,
naczepa_nr_rejestracyjny VARCHAR(10) NOT NULL,
data_zlecenia DATE,
rozliczone BOOL,
cena NUMERIC(10,2),
waluta VARCHAR(3),
temperatura_trans VARCHAR(10),
dodatkowe_inf VARCHAR(200),
CONSTRAINT fk_klient FOREIGN KEY id_klienta REFERENCES klient(id_klienta),
CONSTRAINT fk_spedytor FOREIGN KEY id_spedytora REFERENCES spedytor(id_spedytora),
CONSTRAINT fk_ciagnik FOREIGN KEY nr_rejestracyjny REFERENCES tabor(nr_rejestracyjny),
CONSTRAINT fk_naczepa FOREIGN KEY naczepa_nr_rejestracyjny REFERENCES tabor(nr_rejestracyjny)
);

CREATE TABLE kierowcy_do_zlecenia (
id_kier_zlecenie INTEGER PRIMARY KEY,
id_kierowcy INTEGER NOT NULL,
id_zlecenia INTEGER NOT NULL,
CONSTRAINT fk_kierowca FOREIGN KEY id_kierowcy REFERENCES kierowca(id_kierowcy),
CONSTRAINT fk_zlecenia FOREIGN KEY id_zlecenia_kierowca REFERENCES zlecenie(id_zlecenia)
);

CREATE TABLE m_zal_roz_zlecenia (
id m_zal_roz INTEGER PRIMARY KEY,
id_zlecenia INTEGER NOT NULL,
id_miejsca INTEGER NOT NULL,
id_towaru INTEGER,
operacja_log CHAR(1),
data_operacji DATETIME,
ilosc_towaru VARCHAR(20),
dodatkowy_opis VARCHAR(200),
CONSTRAINT fk_zlecenie_miejsce FOREIGN KEY id_zlecenia REFERENCES zlecenie(id_zlecenia),
CONSTRAINT fk_miejsce_zlecenie FOREIGN KEY id_miejsca REFERENCES miejsce(id_miejsca),
CONSTRAINT fk_towar_miejsce FOREIGN KEY id_towaru REFERENCES towar(id_towaru),
CONSTRAINT fk_operacja FOREIGN KEY operacja_log REFERENCES operacja_log(skrot)
);