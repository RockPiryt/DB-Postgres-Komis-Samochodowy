--------------------------------------------1. Funkcja obliczająca cenę po rabacie---------------------------------------
CREATE OR REPLACE FUNCTION oblicz_cene_po_rabacie(
    cena_brutto DECIMAL,
    rabat_procent INTEGER DEFAULT 0
) 
RETURNS DECIMAL AS $$
BEGIN
    RETURN cena_brutto - (cena_brutto * rabat_procent / 100);
END;
$$ LANGUAGE plpgsql;

-- Test
SELECT oblicz_cene_po_rabacie(100000, 10); -- Zwróci 90000

--------------------------------------------2. Funkcja zwracająca liczbę sprzedanych samochodów przez sprzedawcę---------------------------------------
CREATE OR REPLACE FUNCTION liczba_sprzedanych_samochodow(
    id_sprzedawcy INTEGER
) 
RETURNS INTEGER AS $$
DECLARE
    liczba INTEGER;
BEGIN
    SELECT COUNT(*) INTO liczba
    FROM kartoteka_transakcji
    WHERE id_sprzedawca = id_sprzedawcy;
    
    RETURN liczba;
END;
$$ LANGUAGE plpgsql;

-- Test
SELECT liczba_sprzedanych_samochodow(1);

--------------------------------------------3. Funkcja sprawdzająca dostępność samochodu---------------------------------------
CREATE OR REPLACE FUNCTION czy_samochod_dostepny(
    id_samochodu INTEGER
) 
RETURNS BOOLEAN AS $$
DECLARE
    dostepny BOOLEAN;
BEGIN
    SELECT gotowy_do_sprzedazy INTO dostepny
    FROM samochod
    WHERE id_samochod = id_samochodu;
    
    RETURN dostepny;
END;
$$ LANGUAGE plpgsql;

-- Test
SELECT czy_samochod_dostepny(5);


--------------------------------------------4. Funkcja zwracająca statystyki klienta---------------------------------------
CREATE OR REPLACE FUNCTION statystyki_klienta(
    id_klienta INTEGER
) 
RETURNS TABLE(
    liczba_transakcji INTEGER,
    suma_wydatkow DECIMAL,
    sredni_rabat DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COUNT(kt.id_transakcja),
        COALESCE(SUM(s.cena), 0),
        COALESCE(AVG(f.rabat), 0)
    FROM klient k
    LEFT JOIN kartoteka_transakcji kt ON k.id_klient = kt.id_klient
    LEFT JOIN samochod s ON kt.id_samochod = s.id_samochod
    LEFT JOIN faktura f ON kt.id_faktura = f.id_faktura
    WHERE k.id_klient = id_klienta
    GROUP BY k.id_klient;
END;
$$ LANGUAGE plpgsql;

-- Test
SELECT * FROM statystyki_klienta(1);

--------------------------------------------5. Funkcja automatycznie generująca numer faktury---------------------------------------
CREATE OR REPLACE FUNCTION generuj_numer_faktury()
RETURNS VARCHAR AS $$
DECLARE
    nowy_numer VARCHAR;
    ostatni_numer INTEGER;
BEGIN
    SELECT COALESCE(MAX(CAST(SUBSTRING(nr_faktury FROM 'FV/([0-9]+)') AS INTEGER)), 0)
    INTO ostatni_numer
    FROM faktura;
    
    nowy_numer := 'FV/' || LPAD((ostatni_numer + 1)::VARCHAR, 4, '0') || '/2024';
    
    RETURN nowy_numer;
END;
$$ LANGUAGE plpgsql;

-- Test
SELECT generuj_numer_faktury();

