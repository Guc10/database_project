create or replace view widok_obserwacje as
select
    o.Id_obserwacji,
    o.data_obserwacji,
    o.zakres_promieniowania,
    c.nazwa as nazwa_czarnej_dziury,
    c.masa,
    c.typ as typ_czarnej_dziury,
    t.nazwa as nazwa_teleskopu,
    t.typ as typ_teleskopu,
    b.imie,
    b.nazwisko,
    bo.`czy_udane(y/n)`
from
    obserwacje o
    join czarnedziury c on o.Id_czarnej_dziury = c.Id_czarnej_dziury
    join teleskopy t on o.Id_teleskopu = t.Id_teleskopu
    join badacze_obserwacje bo on o.Id_obserwacji = bo.Id_obserwacji
    join badacze b on bo.Id_badacza = b.Id_badacza;

create or replace view widok_zjawiska as
select
    z.Id_zjawiska,
    z.nazwa as nazwa_zjawiska,
    z.opis,
    cz.nazwa as nazwa_czarnej_dziury,
    cz.masa,
    cz.typ as typ_czarnej_dziury,
    cz.odleglosc_od_ziemi,
    cz_z.data_zjawiska
from
    zjawiska z
    join czarnedziury_zjawiska cz_z on z.Id_zjawiska = cz_z.Id_zjawiska
    join czarnedziury cz on cz_z.Id_czarnejdziury = cz.Id_czarnej_dziury;