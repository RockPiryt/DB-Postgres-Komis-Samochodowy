--------------------------------------------1. Funkcja obliczająca wiek samochodu---------------------------------------
CREATE OR REPLACE FUNCTION wiek_samochodu(p_id_samochod INT)
RETURNS INT AS $$
DECLARE
    v_rocznik INT;
BEGIN
    SELECT rocznik INTO v_rocznik
    FROM samochod
    WHERE id_samochod = p_id_samochod;

    RETURN EXTRACT(YEAR FROM CURRENT_DATE) - v_rocznik;
END;
$$ LANGUAGE plpgsql;


-- Test
SELECT wiek_samochodu(1);

--------------------------------------------2. Funkcja obliczająca średnią cenę samochodów w danym komisie---------------------------------------
CREATE OR REPLACE FUNCTION srednia_cena_komisu(p_id_komis INT)
RETURNS NUMERIC AS $$
DECLARE
    v_srednia NUMERIC;
BEGIN
    SELECT AVG(cena) INTO v_srednia
    FROM samochod s
    JOIN plac p ON s.id_samochod = p.id_plac
    WHERE p.id_komis = p_id_komis;

    RETURN v_srednia;
END;
$$ LANGUAGE plpgsql;


-- Test
SELECT liczba_sprzedanych_samochodow(1);

--------------------------------------------3. Funkcja sprawdzająca dostępność samochodu---------------------------------------
CREATE OR REPLACE FUNCTION dostepny_do_sprzedazy(p_id_samochod INT)
RETURNS BOOLEAN AS $$
DECLARE
    v_gotowy BOOLEAN;
BEGIN
    SELECT gotowy_do_sprzedaży INTO v_gotowy
    FROM samochod
    WHERE id_samochod = p_id_samochod;

    RETURN v_gotowy;
END;
$$ LANGUAGE plpgsql;

-- Test
SELECT dostepny_do_sprzedazy(5);



--------------------------------------------4. Funkcja tworząca raport transakcji dla klienta---------------------------------------
CREATE OR REPLACE FUNCTION raport_klienta(p_id_klient INT)
RETURNS TABLE(
    liczba_transakcji INT,
    laczna_wartosc NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT COUNT(k.id_transakcja), COALESCE(SUM(s.cena), 0)
    FROM kartoteka_transakcji k
    JOIN samochod s ON k.id_samochod = s.id_samochod
    WHERE k.id_klient = p_id_klient;
END;
$$ LANGUAGE plpgsql;


-- Test
SELECT * FROM raport_klienta(2);

--------------------------------------------5. Funkcja aktualizująca cenę samochodu z zapisem historii---------------------------------------
CREATE OR REPLACE FUNCTION aktualizuj_cene(p_id_samochod INT, p_nowa_cena NUMERIC)
RETURNS VOID AS $$
BEGIN
    INSERT INTO historia_cen(id_samochod, stara_cena, nowa_cena)
    SELECT id_samochod, cena, p_nowa_cena
    FROM samochod
    WHERE id_samochod = p_id_samochod;

    UPDATE samochod
    SET cena = p_nowa_cena
    WHERE id_samochod = p_id_samochod;
END;
$$ LANGUAGE plpgsql;


-- Test
SELECT aktualizuj_cene(3, 50000.00);


