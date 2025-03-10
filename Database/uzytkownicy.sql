CREATE USER 'galaktyczny_admin'@'%' IDENTIFIED BY 'SuperTajneHaslo1';
GRANT ALL PRIVILEGES ON czarnedziurydb1.* TO 'galaktyczny_admin'@'%' WITH GRANT OPTION;

CREATE USER 'obserwator'@'%' IDENTIFIED BY 'BezpieczneHaslo2';
GRANT SELECT, SHOW VIEW ON czarnedziurydb1.* TO 'obserwator'@'%';
GRANT SELECT ON czarnedziurydb1.widok_obserwacje TO 'obserwator'@'%';
GRANT SELECT ON czarnedziurydb1.widok_zjawiska TO 'obserwator'@'%';

CREATE USER 'eksperymentator'@'%' IDENTIFIED BY 'MocneHaslo3';
GRANT INSERT, UPDATE, DELETE ON czarnedziurydb1.* TO 'eksperymentator'@'%';

CREATE USER 'analityk'@'%' IDENTIFIED BY 'SilneHaslo4';
GRANT SELECT, EXECUTE, SHOW VIEW, CREATE TEMPORARY TABLES ON czarnedziurydb1.* TO 'analityk'@'%';
GRANT SELECT ON czarnedziurydb1.widok_obserwacje TO 'analityk'@'%';
GRANT SELECT ON czarnedziurydb1.widok_zjawiska TO 'analityk'@'%';

CREATE USER 'archiwista'@'%' IDENTIFIED BY 'TrudneHaslo5';
GRANT SELECT, CREATE VIEW, SHOW VIEW, LOCK TABLES ON czarnedziurydb1.* TO 'archiwista'@'%';
GRANT SELECT ON czarnedziurydb1.widok_obserwacje TO 'archiwista'@'%';
GRANT SELECT ON czarnedziurydb1.widok_zjawiska TO 'archiwista'@'%';

FLUSH PRIVILEGES;