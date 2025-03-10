delimiter //

create function sprawdz_date_obserwacji(data_obserwacji date) returns boolean
begin
    if data_obserwacji > curdate() then
        return false;
    end if;
    return true;
end;
//

create function zapisz_zmiane_masy(id_czarnej_dziury int, stara_masa float, nowa_masa float) returns boolean
BEGIN
	if stara_masa != nowa_masa then
			insert into czarnedziury_masa_historia (Id_czarnej_dziury, stara_masa, nowa_masa, data_zmiany)
			values (id_czarnej_dziury, stara_masa, nowa_masa, now());
   		RETURN TRUE;
    end if;
    RETURN FALSE;
end;
//

create function sprawdz_obserwacje_badacza(id_badacza int) returns boolean
begin
    if exists (select 1 from badacze_obserwacje where Id_badacza = id_badacza) then
        return false;
    end if;
    return true;
end;
//

create trigger przed_wstawieniem_obserwacje
before insert on obserwacje
for each row
begin
    if not sprawdz_date_obserwacji(new.data_obserwacji) then
        signal sqlstate '45000' set message_text = 'Data obserwacji nie może być w przyszłości';
    end if;
end;
//

create trigger po_aktualizacji_czarnedziury
after update on czarnedziury
for each row
BEGIN
    if not zapisz_zmiane_masy(new.Id_czarnej_dziury, old.masa, new.masa) then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Masa musi różnić się od starej masy';
    END if;
end;
//

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

-- testy
-- tr no.1
INSERT INTO obserwacje (Id_czarnej_dziury, data_obserwacji, Id_teleskopu, zakres_promieniowania) VALUES (1, '2026-08-08', 5, 'gamma');
INSERT INTO obserwacje (Id_czarnej_dziury, data_obserwacji, Id_teleskopu, zakres_promieniowania) VALUES (1, '2024-08-08', 5, 'gamma');

-- tr no.2
UPDATE czarnedziury set masa = 367194.625 WHERE Id_czarnej_dziury = 1;
UPDATE czarnedziury set masa = 367594.625 WHERE Id_czarnej_dziury = 1;

-- tr no.3
delete from badacze where Id_badacza = 1;