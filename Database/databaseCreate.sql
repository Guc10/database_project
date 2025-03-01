create or replace schema czarnedziurydb1 collate utf8mb4_uca1400_ai_ci;
use czarnedziurydb1;

create or replace table badacze
(
    Id_badacza int auto_increment
        primary key,
    imie       text collate utf8mb4_uca1400_ai_ci                                not null,
    nazwisko   text collate utf8mb4_uca1400_ai_ci                                not null,
    instytucja enum ('NASA', 'ESA', 'ISRO', 'CSA') collate utf8mb4_uca1400_ai_ci not null
)
    collate = utf8mb4_uca1400_ai_ci;

create or replace table czarnedziury
(
    Id_czarnej_dziury  int auto_increment
        primary key,
    nazwa              varchar(30)                                     not null,
    masa               float(15, 3)                                    not null,
    typ                enum ('gwiazdowe', 'supermasywne', 'pierwotne') not null,
    odleglosc_od_ziemi double(20, 3)                                   not null
)
    collate = utf8mb4_uca1400_ai_ci;

create or replace table galaktyki
(
    Id_galaktyki         int auto_increment
        primary key,
    nazwa                varchar(30)       not null,
    numer_katalogowy_ngc int(15) default 0 not null
)
    collate = utf8mb4_uca1400_ai_ci;

create or replace table lokalizacje
(
    Id_lokalizacji    int auto_increment
        primary key,
    Id_czarnej_dziury int          not null,
    Id_galaktyki      int          not null,
    wspolrzedne_RA    float(15, 3) not null,
    wspolrzedne_DEC   float(15, 3) not null,
    constraint Id_czarnej_dziury
        unique (Id_czarnej_dziury),
    constraint Id_czarnej_dziury
        foreign key (Id_czarnej_dziury) references czarnedziury (Id_czarnej_dziury),
    constraint Id_galaktyki
        foreign key (Id_galaktyki) references galaktyki (Id_galaktyki)
)
    collate = utf8mb4_uca1400_ai_ci;

create or replace table teleskopy
(
    Id_teleskopu int auto_increment
        primary key,
    nazwa        varchar(30)                    not null,
    typ          enum ('naziemny', 'kosmiczny') not null,
    czy_w_uzyciu tinyint(1)                     not null
)
    collate = utf8mb4_uca1400_ai_ci;

create or replace table obserwacje
(
    Id_obserwacji         int auto_increment
        primary key,
    Id_czarnej_dziury     int                                                    not null,
    data_obserwacji       date                                                   not null,
    Id_teleskopu          int                                                    not null,
    zakres_promieniowania enum ('rentgenowskie', 'radiowe', 'hawkinga', 'gamma') not null,
    constraint Obserwacje_czarnedziury_FK
        foreign key (Id_czarnej_dziury) references czarnedziury (Id_czarnej_dziury),
    constraint Obserwacje_teleskopy_FK
        foreign key (Id_teleskopu) references teleskopy (Id_teleskopu)
)
    collate = utf8mb4_uca1400_ai_ci;

create or replace table badacze_obserwacje
(
    Id               int auto_increment
        primary key,
    Id_badacza       int              not null,
    Id_obserwacji    int              not null,
    `czy_udane(y/n)` char default 'n' not null,
    constraint Badacze_obserwacje_badacze_FK
        foreign key (Id_badacza) references badacze (Id_badacza),
    constraint badacze_obserwacje_obserwacje_FK
        foreign key (Id_obserwacji) references obserwacje (Id_obserwacji)
)
    collate = utf8mb4_uca1400_ai_ci;

create or replace table zjawiska
(
    Id_zjawiska int auto_increment
        primary key,
    nazwa       varchar(100) not null,
    opis        varchar(200) not null
)
    collate = utf8mb4_uca1400_ai_ci;

create or replace table czarnedziury_zjawiska
(
    Id_zjawiska      int       not null,
    Id_czarnejdziury int       not null,
    data_zjawiska    timestamp not null,
    constraint Id_czarnejdziury
        foreign key (Id_czarnejdziury) references czarnedziury (Id_czarnej_dziury),
    constraint Id_zjawiska
        foreign key (Id_zjawiska) references zjawiska (Id_zjawiska)
)
    collate = utf8mb4_uca1400_ai_ci;

insert into zjawiska (Id_zjawiska, nazwa, opis)
values  (1, 'Akrecja materii', 'Czarna dziura pochłania otaczający gaz i tworzy dysk który świeci'),
        (2, 'Promieniowanie Hawkinga', 'powolne wyparowanie'),
        (3, 'Kolizja i połączenie z inną czarną dziurą', 'wielkie bum'),
        (4, 'Tidal Disruption Event', 'rozerwanie gwiazdy'),
        (5, 'Rozpad osobliwości', 'hipotetyczna teoria kwantowa'),
        (6, 'Wielki wybuch', 'wielkie wielkie bum');