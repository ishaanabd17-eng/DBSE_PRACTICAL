CREATE DATABASE library_joins_db;
USE library_joins_db;

DROP TABLE IF EXISTS class;
DROP TABLE IF EXISTS class_info;

CREATE TABLE class(
    id INT,
    name VARCHAR(30)
);

CREATE TABLE class_info(
    id INT,
    address VARCHAR(30)
);

INSERT INTO class VALUES
(1,'arjun'),
(2,'bella'),
(3,'charlie'),
(4,'diya');

INSERT INTO class_info VALUES
(1,'HYDERABAD'),
(2,'BANGALORE'),
(3,'PUNE');

SELECT *
FROM class
CROSS JOIN class_info;

SELECT *
FROM class
INNER JOIN class_info
ON class.id = class_info.id;

SELECT class.name,
       class_info.address
FROM class
INNER JOIN class_info
ON class.id = class_info.id;

SELECT *
FROM class
NATURAL JOIN class_info;

INSERT INTO class VALUES
(5,'rohan');

INSERT INTO class_info VALUES
(7,'JAIPUR'),
(8,'SURAT');

SELECT *
FROM class
LEFT JOIN class_info
ON class.id = class_info.id;

SELECT *
FROM class
LEFT JOIN class_info
ON class.id = class_info.id
WHERE class_info.id IS NULL;

SELECT *
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id;

SELECT *
FROM class
RIGHT JOIN class_info
ON class.id = class_info.id
WHERE class.id IS NULL;

DROP TABLE IF EXISTS first_table;
DROP TABLE IF EXISTS second_table;

CREATE TABLE first_table(
    id INT,
    name VARCHAR(30)
);

CREATE TABLE second_table(
    id INT,
    name VARCHAR(30)
);

INSERT INTO first_table VALUES
(1,'arjun'),
(2,'bella');

INSERT INTO second_table VALUES
(2,'bella'),
(3,'david');

SELECT *
FROM first_table
UNION
SELECT *
FROM second_table;

SELECT name
FROM first_table
UNION
SELECT name
FROM second_table;

SELECT *
FROM first_table
UNION ALL
SELECT *
FROM second_table;

SELECT COUNT(*)
FROM
(
    SELECT *
    FROM first_table
    UNION ALL
    SELECT *
    FROM second_table
) A;

SELECT *
FROM first_table
WHERE (id,name) IN
(
    SELECT id,name
    FROM second_table
);

SELECT name
FROM first_table
WHERE name IN
(
    SELECT name
    FROM second_table
);

SELECT *
FROM first_table
WHERE id NOT IN
(
    SELECT id
    FROM second_table
);

SELECT name
FROM first_table
WHERE name NOT IN
(
    SELECT name
    FROM second_table
);

SELECT c.id,
       c.name,
       ci.address
FROM class c
INNER JOIN class_info ci
ON c.id = ci.id;

SELECT c.id,
       c.name,
       CASE
           WHEN ci.address IS NULL
           THEN 'Address Missing'
           ELSE 'Address Available'
       END AS Status
FROM class c
LEFT JOIN class_info ci
ON c.id = ci.id;