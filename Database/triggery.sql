delimiter //

-- Funkcja do sprawdzania, czy data obserwacji nie jest w przyszłości
create function sprawdz_date_obserwacji(data_obserwacji date) returns boolean
begin
    if data_obserwacji > curdate() then
        return false;
    end if;
    return true;
end;
//

-- Funkcja do logowania zmian masy czarnych dziur
create function zapisz_zmiane_masy(id_czarnej_dziury int, stara_masa float, nowa_masa float) returns boolean
begin
    insert into czarnedziury_masa_historia (Id_czarnej_dziury, stara_masa, nowa_masa, data_zmiany)
    values (id_czarnej_dziury, stara_masa, nowa_masa, now());
end;
//

-- Funkcja do sprawdzania, czy badacz ma przypisane obserwacje
create function sprawdz_obserwacje_badacza(id_badacza int) returns boolean
begin
    if exists (select 1 from badacze_obserwacje where Id_badacza = id_badacza) then
        return false;
    end if;
    return true;
end;
//

-- Trigger 1: Przed wstawieniem do obserwacje, aby sprawdzić, czy data obserwacji nie jest w przyszłości
create trigger przed_wstawieniem_obserwacje
before insert on obserwacje
for each row
begin
    if not sprawdz_date_obserwacji(new.data_obserwacji) then
        signal sqlstate '45000' set message_text = 'Data obserwacji nie może być w przyszłości';
    end if;
end;
//

-- Trigger 2: Po aktualizacji czarnedziury, aby logować zmiany masy
create trigger po_aktualizacji_czarnedziury
after update on czarnedziury
for each row
begin
    if old.masa != new.masa then
        call zapisz_zmiane_masy(new.Id_czarnej_dziury, old.masa, new.masa);
    end if;
end;
//

-- Trigger 3: Przed usunięciem z badacze, aby sprawdzić, czy badacz ma przypisane obserwacje
create trigger przed_usunieciem_badacze
before delete on badacze
for each row
begin
    if not sprawdz_obserwacje_badacza(old.Id_badacza) then
        signal sqlstate '45000' set message_text = 'Nie można usunąć badacza z przypisanymi obserwacjami';
    end if;
end;
//

delimiter ;