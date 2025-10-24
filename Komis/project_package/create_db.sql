--CREATE DATABASE komis_projekt;
-----------------------------------------------------------------------------
CREATE TABLE komis 
(
    id_komis                serial               PRIMARY KEY,
    nip                     int                  not null,
    nazwa                   varchar(30)          not null,
    panstwo                 varchar(30)          not null,
    miasto                  varchar(30)          not null,
    ulica                   varchar(30)          not null,
    nr_budynku              int                  not null,
    nr_lokalu               varchar(10),
    kod_pocztowy            char(6)              not null,
    telefon                 varchar(15),
    e_mail                  varchar(30),
    UNIQUE(nip)
);
-------------------------------------------------------------------------------
CREATE TABLE plac 
(
    id_plac                 serial          PRIMARY KEY,
    kraj                    varchar(30)     not null        DEFAULT 'Polska',
    miejscowosc             varchar(30)     not null,
    ulica                   varchar(30)     not null,
    nr_działki              varchar(20)     not null,
    id_komis                int,
    -- klucz obcy - powiazanie placu z komisem
    CONSTRAINT              fk_komis_plac FOREIGN KEY(id_komis)
                            REFERENCES komis(id_komis)
                            ON UPDATE CASCADE ON DELETE CASCADE
);
--------------------------------------------------------------------------------
CREATE TABLE samochod 
(
    id_samochod             serial          PRIMARY KEY,
    nr_rejestracyjny        varchar(7),
    nr_vin                  char(17)        not null,
    marka                   varchar(30)     not null,
    model                   varchar(30)     not null,
    rocznik                 int             not null,
    przebieg                decimal(12,2)   not null,
    silnik                  decimal(4,2)    not null,
    paliwo                  varchar(30)     not null,
    moc                     int             not null,
    kolor                   varchar(30)     not null,
    rodzaj_pojazdu          varchar(30)     not null,
    ladownosc               decimal(4,2),
    gotowy_do_sprzedaży     bool            not null,
    cena                    decimal(20,2)   not null,
    opis                    text,
    UNIQUE(nr_rejestracyjny, nr_vin)
);

------------------------------------------------------------------
CREATE TABLE dostawa
(
    id_dostawa            serial                PRIMARY KEY,
    data_dostawy          date                  not null,
    kraj_pochodzenia      varchar(50)           not null, 
    czy_zarejestrowany    bool                  not null,
    czy_uszkodzony        bool                  not null,
    id_plac               int,
    id_samochod           int,
    -- klucz obcy - powiazanie dostawy z samochodem
    CONSTRAINT              fk_samochod_dostawa FOREIGN KEY(id_samochod)
                            REFERENCES samochod(id_samochod)
                            ON UPDATE CASCADE ON DELETE CASCADE,
    -- klucz obcy - powiazanie dostawy z placem
    CONSTRAINT              fk_plac_dostawa FOREIGN KEY(id_plac)
                            REFERENCES plac(id_plac)
                            ON UPDATE CASCADE ON DELETE CASCADE
);

-----------------------------------------------------------------------
CREATE TABLE sprzedawca 
(
    id_sprzedawca           serial              PRIMARY KEY,
    imie                    varchar(30)         not null,
    nazwisko                varchar(30)         not null,
    nr_telefonu             varchar(30),
    e_mail                  varchar(50),
    id_komis                int,
    id_plac                 int,
    -- klucz obcy - powiazanie sprzedawcy z komisem
    CONSTRAINT              fk_komis_sprzedawca FOREIGN KEY(id_komis)
                            REFERENCES komis(id_komis)
                            ON UPDATE CASCADE ON DELETE CASCADE,
    -- klucz obcy - powiazanie sprzedawcy z placem(są 3 place)
    CONSTRAINT              fk_plac_sprzedawca FOREIGN KEY(id_plac)
                            REFERENCES plac(id_plac)
                            ON UPDATE CASCADE ON DELETE CASCADE
);
------------------------------------------------------------------
CREATE TABLE faktura
(
    id_faktura              serial                  PRIMARY KEY,
    nr_faktury              varchar(10)             not null, 
    rabat                   smallint,
    sposob_zaplaty          varchar(30)             not null,
    czy_zaplacono           bool                    not null,
    UNIQUE(nr_faktury)
);
------------------------------------------------------------------------
CREATE TABLE klient 
(
    id_klient               serial               PRIMARY KEY,
    imie                    varchar(30)          not null,
    nazwisko                varchar(30)          not null,
    pesel                   varchar(11)          not null,
    rodzaj_dokumentu        varchar(50)          not null,
    nr_dokumentu            varchar(30)          not null,
    panstwo                 varchar(30),
    miasto                  varchar(50),
    ulica                   varchar(50),
    nr_domu                 int,
    nr_mieszkania           varchar(10),
    kod                     varchar(10),
    telefon                 varchar(30),
    UNIQUE(pesel)
);
-----------------------------------------------------------------------
CREATE TABLE kartoteka_transakcji
(
    id_transakcja           serial                 PRIMARY KEY,
    rodzaj                  varchar(15)            not null,
    data_transakcji         date                   not null,
    samochod_w_rozliczeniu  bool                   not null,
    uwagi                   text,
    id_samochod             int,
    id_klient               int,
    id_sprzedawca           int,
    id_plac					int,
    id_faktura              int,
    -- klucz obcy - powiazanie transakcji z zakupionym/sprzedanym samochodem
    CONSTRAINT              fk_samochod_transakcja FOREIGN KEY(id_samochod)
                            REFERENCES samochod(id_samochod)
                            ON UPDATE CASCADE ON DELETE CASCADE,
    -- klucz obcy - powiazanie transakcji z klientem
    CONSTRAINT              fk_klient_transakcja FOREIGN KEY(id_klient)
                            REFERENCES klient(id_klient)
                            ON UPDATE CASCADE ON DELETE CASCADE,
    -- klucz obcy - powiazanie transakcji z placem
    CONSTRAINT              fk_plac_transakcja FOREIGN KEY(id_plac)
                            REFERENCES plac(id_plac)
                            ON UPDATE CASCADE ON DELETE CASCADE,
    -- klucz obcy - powiazanie transakcji ze sprzedajacym
    CONSTRAINT              fk_sprzedawca_transakcja FOREIGN KEY(id_sprzedawca)
                            REFERENCES sprzedawca(id_sprzedawca)
                            ON UPDATE CASCADE ON DELETE CASCADE,
    -- klucz obcy - powiazanie transakcji z faktura
    CONSTRAINT              fk_faktura_transakcja FOREIGN KEY(id_faktura)
                            REFERENCES faktura(id_faktura)
                            ON UPDATE CASCADE ON DELETE CASCADE
    
);



CREATE TABLE historia_cen 
(
    id_historia             serial                  PRIMARY KEY,
    id_samochod             int                     not null,
    stara_cena              decimal(20,2),
    nowa_cena               decimal(20,2),
    data_zmiany timestamp                           not null DEFAULT CURRENT_TIMESTAMP,
    -- klucz obcy - powiazanie historia_cen z samochodem
    CONSTRAINT fk_samochod_historia FOREIGN KEY (id_samochod)
        REFERENCES samochod(id_samochod)
        ON DELETE CASCADE
);


CREATE TABLE ubezpieczenie (
    id_ubezpieczenie     serial PRIMARY KEY,
    id_samochod          int NOT NULL,
    firma_ubezpieczeniowa varchar(50) NOT NULL,
    nr_polisy            varchar(30) NOT NULL UNIQUE,
    data_poczatku        date NOT NULL,
    data_konca           date NOT NULL,
    koszt                decimal(10,2),
    CONSTRAINT fk_samochod_ubezpieczenie FOREIGN KEY (id_samochod)
        REFERENCES samochod(id_samochod)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

