-- Create a sequence
CREATE SEQUENCE sekwencja
  START WITH 1  
  INCREMENT BY 1
  MAXVALUE 100;

-- Create a table
CREATE TABLE testTable (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  age INT
);

-- Insert data into the table
INSERT INTO testTable (id, name, age) VALUES (NEXTVAL(sekwencja), 'John Doe', 30);
INSERT INTO testTable (id, name, age) VALUES (NEXTVAL(sekwencja), 'Jane Smith', 25);

-- Insert data with INSERT IGNORE (useful in MySQL to ignore duplicate key errors)
INSERT IGNORE INTO testTable (id, name, age) VALUES (1, 'Duplicate John', 30);

-- Update data in the table
UPDATE testTable SET age = 31 WHERE name = 'John Doe';

-- Delete data from the table
DELETE FROM testTable WHERE name = 'Jane Smith';

-- Alter the table to add a new column
ALTER TABLE testTable ADD COLUMN email VARCHAR(100);

-- Rename the table
RENAME TABLE testTable TO newTestTable;

-- Truncate the table
TRUNCATE TABLE newTestTable;

-- Drop the table
DROP TABLE newTestTable;

-- Drop the sequence
DROP SEQUENCE sekwencja;