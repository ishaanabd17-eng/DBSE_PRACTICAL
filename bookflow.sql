CREATE DATABASE bookflow_db;

USE bookflow_db;


-- =========================================================
-- STEP 2: CREATE BOOKS TABLE
-- =========================================================

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    published_year INT CHECK (published_year < 2027)
);


-- =========================================================
-- STEP 3: INSERT BOOKS
-- =========================================================

INSERT INTO Books
(book_id, title, isbn, published_year)
VALUES
(1, 'Pride and Prejudice', '9780141439518', 1813),
(2, 'The Hobbit', '9780261102217', 1937),
(3, 'The Catcher in the Rye', '9780316769488', 1951);


-- =========================================================
-- STEP 4: DISPLAY BOOKS
-- =========================================================

SELECT * FROM Books;


-- =========================================================
-- STEP 5: CREATE MEMBERS TABLE
-- =========================================================

CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);


-- =========================================================
-- STEP 6: INSERT MEMBERS
-- =========================================================

INSERT INTO Members
(member_id, full_name, email)
VALUES
(101, 'Arjun Mehta', 'arjun.mehta@email.com'),
(102, 'Sofia Williams', 'sofia.williams@email.com'),
(103, 'Daniel Thomas', 'daniel.thomas@email.com');


-- =========================================================
-- STEP 7: DISPLAY MEMBERS
-- =========================================================

SELECT * FROM Members;


-- =========================================================
-- STEP 8: CREATE LOANS TABLE
-- =========================================================

CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    loan_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);


-- =========================================================
-- STEP 9: INSERT LOANS
-- =========================================================

INSERT INTO Loans
(loan_id, member_id, book_id, loan_date)
VALUES
(1, 101, 2, '2025-01-12'),
(2, 102, 1, '2025-01-18'),
(3, 103, 3, '2025-01-25'),
(4, 101, 3, '2025-02-06'),
(5, 102, 2, '2025-02-14'),
(6, 103, 1, '2025-02-22'),
(7, 101, 1, '2025-03-05'),
(8, 102, 3, '2025-03-13'),
(9, 103, 2, '2025-03-21'),
(10, 101, 2, '2025-04-03');


-- =========================================================
-- STEP 10: DISPLAY LOANS
-- =========================================================

SELECT * FROM Loans;


-- =========================================================
-- STEP 11: JOIN QUERY
-- SHOW MEMBER NAME AND BOOK TITLE
-- =========================================================

SELECT
    m.full_name AS Member_Name,
    b.title AS Book_Title
FROM Loans l
INNER JOIN Members m
    ON l.member_id = m.member_id
INNER JOIN Books b
    ON l.book_id = b.book_id;


-- =========================================================
-- STEP 12: GROUP BY QUERY
-- NUMBER OF BOOKS PUBLISHED IN EACH YEAR
-- =========================================================

SELECT
    published_year,
    COUNT(book_id) AS Total_Books
FROM Books
GROUP BY published_year
ORDER BY published_year;


-- =========================================================
-- STEP 13: CREATE DONATION HISTORY TABLE
-- =========================================================

CREATE TABLE Donation_History (
    donation_id INT PRIMARY KEY,
    book_id INT,
    donor_name VARCHAR(100),
    donation_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);


-- =========================================================
-- STEP 14: START TRANSACTION
-- =========================================================

START TRANSACTION;


-- =========================================================
-- STEP 15: ADD NEW BOOK
-- =========================================================

INSERT INTO Books
(book_id, title, isbn, published_year)
VALUES
(4, 'The Book Thief', '9780375842207', 2005);


-- =========================================================
-- STEP 16: RECORD DONATION
-- =========================================================

INSERT INTO Donation_History
(donation_id, book_id, donor_name, donation_date)
VALUES
(1, 4, 'Neha Sharma', CURDATE());


-- =========================================================
-- STEP 17: COMMIT TRANSACTION
-- =========================================================

COMMIT;


-- =========================================================
-- DISPLAY DONATION HISTORY
-- =========================================================

SELECT * FROM Donation_History;


-- =========================================================
-- DISPLAY UPDATED BOOKS
-- =========================================================

SELECT * FROM Books;


-- =========================================================
-- STEP 18: CREATE INDEX ON ISBN
-- =========================================================

CREATE INDEX idx_books_isbn
ON Books(isbn);


-- =========================================================
-- SEARCH BOOK USING ISBN
-- =========================================================

SELECT *
FROM Books
WHERE isbn = '9780261102217';


-- =========================================================
-- FINAL STATE OF ALL TABLES
-- =========================================================

-- BOOKS
SELECT * FROM Books;

-- MEMBERS
SELECT * FROM Members;

-- LOANS
SELECT * FROM Loans;

-- DONATION HISTORY
SELECT * FROM Donation_History;