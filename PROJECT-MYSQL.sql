CREATE DATABASE Library;
USE Library;
-- CREATING BRANCH TABLE
CREATE TABLE Branch(
      Branch_no INT PRIMARY KEY,
      Manager_id INT,
      Branch_address VARCHAR(255),
      Contact_no VARCHAR(15)
      );
INSERT INTO Branch(Branch_no,Manager_id,Branch_address,Contact_no) VALUES
	  (1,101,'Downtown Library','1234567890'),
      (2,102,'City Center Library','0987654321'),
      (3,103,'Westside Library','9876543210'),
      (4,104,'Eastside Library','9756782310'),
      (5,105,'Northside Library','8907657975');
      
-- EMPLOYEE TABLE
CREATE TABLE Employee (
      Emp_id INT PRIMARY KEY,
      Emp_name VARCHAR(100),
      Position VARCHAR(50),
      Salary DECIMAL(10,2),
      Branch_no INT,
      FOREIGN KEY(Branch_no) REFERENCES Branch(Branch_no)
      );
INSERT INTO Employee (Emp_id,Emp_name,Position,Salary,Branch_no) VALUES
      (101, 'Ameya','Manager',60000,1),
      (102,'Justin','Assistant',45000,1),
      (103,'Tessa','Manager',70000,2),
      (104,'Arav','Librarian',40000,3),
      (105,'Thomas','Assistant',42000,3);
-- BOOKS TABLE
CREATE TABLE Books(
      ISBN INT PRIMARY KEY,
      Book_title VARCHAR(255),
      Category VARCHAR(100),
      Rental_price DECIMAL(10,2),
      Status CHAR(3) CHECK (Status IN('YES','NO')),
      Author VARCHAR(100),
      Publisher VARCHAR(100)
      );
INSERT INTO Books(ISBN,Book_title,Category,Rental_price,Status,Author,Publisher) VALUES
      (1001, 'The Great Gatsby', 'Fiction', 30.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
	  (1002, 'A Brief History of Time', 'Science', 25.00, 'no', 'Stephen Hawking', 'Bantam Books'),
      (1003, 'The Alchemist', 'Fiction', 20.00, 'yes', 'Paulo Coelho', 'HarperOne'),
      (1004, 'Sapiens', 'History', 35.00, 'yes', 'Yuval Noah Harari', 'Harper'),
      (1005, '1984', 'Fiction', 28.00, 'no', 'George Orwell', 'Secker & Warburg');
-- CUSTOMER TABLE
CREATE TABLE Customer (
      Customer_id INT PRIMARY KEY,
      Customer_name VARCHAR(100),
      Customer_address VARCHAR(255),
      Reg_date DATE 
      );
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
(1, 'John Doe', '123 Elm Street', '2021-12-15'), 
(2, 'Jane Smith', '456 Oak Avenue', '2022-03-10'),
(3, 'Alice Brown', '789 Pine Road', '2021-08-05'),
(4, 'Bob White', '321 Maple Lane', '2023-06-20'),
(5, 'Eva Green','654 Cedar Drive','2020-11-20');     
-- ISSUESTATUS TABLE
CREATE TABLE IssueStatus(
      Issue_id INT PRIMARY KEY,
      Issued_cust INT,
      Issued_book_name VARCHAR(255),
      Issue_date DATE,
      Isbn_book INT,
      FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_id),
      FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
      );
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
(1, 1, 'The Great Gatsby', '2023-06-15', 1001),
(2, 2, '1984', '2023-06-16', 1005),
(3, 3, 'Sapiens', '2023-06-17', 1004),
(4, 4, 'A Brief History of Time', '2023-06-18', 1002),
(5, 5,'The Alchemist','2023-06-19',1003);
-- RETURN STATUS TABLE
CREATE TABLE ReturnStatus (
       Return_id INT PRIMARY KEY,
       Return_cust INT,
       Return_book_name VARCHAR(255),
       Return_date DATE,
       Isbn_book2 INT,
       FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_id),
       FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
       );
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES 
(1, 1, 'The Great Gatsby', '2023-06-20', 1001),
(2, 2, '1984', '2023-06-21', 1005),
(3, 3, 'Sapiens', '2023-06-22', 1004),
(4, 4, 'A Brief History of Time', '2023-06-23', 1002),
(5, 5, 'The Alchemist','2023-06-24',1003);       
       
SELECT * FROM Branch;INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES 
(1, 1, 'The Great Gatsby', '2023-06-20', 1001),
(2, 2, '1984', '2023-06-21', 1005),
(3, 3, 'Sapiens', '2023-06-22', 1004),
(4, 4, 'A Brief History of Time', '2023-06-23', 1002),
(5, 5, 'The Alchemist', '2023-06-24', 1003);
SELECT * FROM Employee;
SELECT * FROM Books;
SELECT * FROM Customer;
SELECT * FROM IssueStatus;
SELECT * FROM ReturnStatus;

SELECT Book_title,Category,Rental_price FROM Books WHERE Status='YES';

SELECT Emp_name,Salary FROM Employee ORDER BY Salary DESC;

SELECT B.Book_title,C.Customer_name  FROM Books B
JOIN IssueStatus I ON B.ISBN=I.Isbn_book
JOIN Customer C ON I.Issued_cust=C.Customer_id;

SELECT Category,COUNT(*) AS Total_books FROM Books GROUP BY Category;

SELECT Emp_name,Position FROM Employee WHERE Salary > 50000;

SELECT C.Customer_name FROM Customer C 
LEFT JOIN IssueStatus I ON C.Customer_id=I.Issued_cust
WHERE C.Reg_date <'2022-01-01' AND I.Issue_id IS NULL;

SELECT Branch_no,COUNT(*) AS Employee_count FROM Employee GROUP BY Branch_no;

SELECT DISTINCT C.Customer_name FROM Customer C
JOIN IssueStatus I ON C.Customer_id=I.Issued_cust
WHERE MONTH(Issue_date) = 6 AND YEAR(Issue_date)=2023;

SELECT Book_title FROM Books WHERE Book_title LIKE '%history%';

SELECT Branch_no,COUNT(*) AS Employee_count FROM Employee 
GROUP BY Branch_no
HAVING COUNT(*) >5;

SELECT E.Emp_name,B.Branch_address FROM Employee E
JOIN Branch B ON E.Emp_id=B.Manager_id;

SELECT DISTINCT C.Customer_name FROM Customer C 
JOIN IssueStatus I ON C.Customer_id=I.Issued_cust
JOIN Books B ON I.Isbn_book= B.ISBN
WHERE B.Rental_price >25;

  


	

