USE czarnedziurydb1;
CREATE OR REPLACE SEQUENCE sekwencja
  START WITH 1  
  INCREMENT BY 1
  MAXVALUE 100;

CREATE OR REPLACE TABLE tabela_testowa (
  id INT,
  name VARCHAR(50),
  age INT,
  PRIMARY KEY (id, name)
) collate = utf8mb4_uca1400_ai_ci;

INSERT INTO tabela_testowa (id, name, age) VALUES 
(NEXTVAL(sekwencja), 'Marek', 15),
(NEXTVAL(sekwencja), 'Łukasz', 54),
(NEXTVAL(sekwencja), 'Oliwier', 7),
(NEXTVAL(sekwencja), 'Tobiasz', 27),
(NEXTVAL(sekwencja), 'Gerwazy', 68);

-- RENAME
RENAME TABLE tabela_testowa TO nowa_tabela_testowa;

-- TRUNCATE
TRUNCATE TABLE nowa_tabela_testowa;

-- ALTER
ALTER TABLE nowa_tabela_testowa ADD COLUMN email VARCHAR(100);
ALTER TABLE nowa_tabela_testowa MODIFY COLUMN age SMALLINT;
ALTER TABLE nowa_tabela_testowa RENAME COLUMN name TO full_name;
ALTER TABLE nowa_tabela_testowa ADD CONSTRAINT chk_age CHECK (age >= 0);

-- INSERT
INSERT INTO nowa_tabela_testowa (id, full_name, age) VALUES (NEXTVAL(sekwencja), 'Jan', 30);
INSERT INTO nowa_tabela_testowa (id, full_name, age) VALUES (NEXTVAL(sekwencja), 'Anna', 25);
INSERT INTO nowa_tabela_testowa (id, full_name, age) VALUES (NEXTVAL(sekwencja), 'Piotr', 40);
INSERT INTO nowa_tabela_testowa (id, full_name, age) VALUES (NEXTVAL(sekwencja), 'Kasia', 35);
INSERT INTO nowa_tabela_testowa (id, full_name, age) VALUES (NEXTVAL(sekwencja), 'Tomek', 28);

-- UPDATE
UPDATE nowa_tabela_testowa SET age = 31 WHERE full_name = 'Jan';
UPDATE nowa_tabela_testowa SET age = 26 WHERE full_name = 'Anna';

-- INSERT IGNORE
INSERT IGNORE INTO nowa_tabela_testowa (id, full_name, age) VALUES (6, 'Duplikat Jan', 30);
INSERT IGNORE INTO nowa_tabela_testowa (id, full_name, age) VALUES (7, 'Duplikat Anna', 25);
INSERT IGNORE INTO nowa_tabela_testowa (id, full_name, age) VALUES (8, 'Duplikat Piotr', 40);
INSERT IGNORE INTO nowa_tabela_testowa (id, full_name, age) VALUES (9, 'Duplikat Kasia', 35);
INSERT IGNORE INTO nowa_tabela_testowa (id, full_name, age) VALUES (10, 'Duplikat Tomek', 28);

-- DELETE
DELETE FROM nowa_tabela_testowa WHERE full_name LIKE 'Duplikat%';

-- DROP
DROP TABLE nowa_tabela_testowa;
DROP SEQUENCE sekwencja;