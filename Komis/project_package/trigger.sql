--------------------------------------------- TRIGGER 1
--Ten trigger będzie zapisywać historię zmian ceny samochodu 
--w osobnej tabeli historia_cen, za każdym razem, gdy cena samochodu zostanie zaktualizowana. 
CREATE TABLE historia_cen (
    id_historia serial PRIMARY KEY,
    id_samochod int NOT NULL,
    stara_cena decimal(20,2),
    nowa_cena decimal(20,2),
    data_zmiany timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_samochod_historia FOREIGN KEY (id_samochod)
        REFERENCES samochod(id_samochod)
        ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION log_cena_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO historia_cen (id_samochod, stara_cena, nowa_cena)
    VALUES (OLD.id_samochod, OLD.cena, NEW.cena);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_cena_update
AFTER UPDATE OF cena ON samochod
FOR EACH ROW
WHEN (OLD.cena IS DISTINCT FROM NEW.cena)
EXECUTE FUNCTION log_cena_changes();

--------------------------------------------- TRIGGER 2

--Trigger przed wstawieniem nowego rekordu do tabeli kartoteka_transakcji, 
--który sprawdza, czy samochód jest gotowy do sprzedaży. Jeśli nie, wstawienie rekordu zostanie zablokowane.

CREATE OR REPLACE FUNCTION check_car_ready_for_sale()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT gotowy_do_sprzedaży FROM samochod WHERE id_samochod = NEW.id_samochod) = FALSE THEN
        RAISE EXCEPTION 'Samochód nie jest gotowy do sprzedaży';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_kartoteka_transakcji
BEFORE INSERT ON kartoteka_transakcji
FOR EACH ROW
EXECUTE FUNCTION check_car_ready_for_sale();


