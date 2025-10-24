-- ============================================
-- 1. Historia zmian ceny samochodu
-- AFTER UPDATE OF cena ON samochod
-- ============================================
CREATE OR REPLACE FUNCTION log_cena_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO historia_cen (id_samochod, stara_cena, nowa_cena)
    VALUES (OLD.id_samochod, OLD.cena, NEW.cena);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS log_cena_update ON samochod;
CREATE TRIGGER log_cena_update
AFTER UPDATE OF cena ON samochod
FOR EACH ROW
WHEN (OLD.cena IS DISTINCT FROM NEW.cena)
EXECUTE FUNCTION log_cena_changes();


-- ============================================
-- 2. Sprawdzenie gotowości samochodu do sprzedaży
-- BEFORE INSERT ON kartoteka_transakcji
-- ============================================
CREATE OR REPLACE FUNCTION check_car_ready_for_sale()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT gotowy_do_sprzedaży FROM samochod WHERE id_samochod = NEW.id_samochod) = FALSE THEN
        RAISE EXCEPTION 'Samochód nie jest gotowy do sprzedaży';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS before_insert_kartoteka_transakcji ON kartoteka_transakcji;
CREATE TRIGGER before_insert_kartoteka_transakcji
BEFORE INSERT ON kartoteka_transakcji
FOR EACH ROW
EXECUTE FUNCTION check_car_ready_for_sale();


-- ============================================
-- 3. Automatyczne ustawienie samochodu jako gotowego po dostawie
-- AFTER INSERT ON dostawa
-- ============================================
CREATE OR REPLACE FUNCTION mark_car_ready_after_delivery()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE samochod
    SET gotowy_do_sprzedaży = TRUE
    WHERE id_samochod = NEW.id_samochod;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS after_insert_dostawa ON dostawa;
CREATE TRIGGER after_insert_dostawa
AFTER INSERT ON dostawa
FOR EACH ROW
EXECUTE FUNCTION mark_car_ready_after_delivery();


-- ============================================
-- 4. Blokowanie usunięcia samochodu powiązanego z transakcją
-- BEFORE DELETE ON samochod
-- ============================================
CREATE OR REPLACE FUNCTION prevent_delete_car_in_transaction()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS(SELECT 1 FROM kartoteka_transakcji WHERE id_samochod = OLD.id_samochod) THEN
        RAISE EXCEPTION 'Nie można usunąć samochodu powiązanego z transakcją';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS before_delete_samochod ON samochod;
CREATE TRIGGER before_delete_samochod
BEFORE DELETE ON samochod
FOR EACH ROW
EXECUTE FUNCTION prevent_delete_car_in_transaction();


-- ============================================
-- 5. Automatyczne ustawienie daty końca polisy ubezpieczeniowej
-- BEFORE INSERT ON ubezpieczenie
-- ============================================
CREATE OR REPLACE FUNCTION set_default_end_date()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.data_konca IS NULL THEN
        NEW.data_konca := NEW.data_poczatku + INTERVAL '1 year';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS before_insert_ubezpieczenie ON ubezpieczenie;
CREATE TRIGGER before_insert_ubezpieczenie
BEFORE INSERT ON ubezpieczenie
FOR EACH ROW
EXECUTE FUNCTION set_default_end_date();
