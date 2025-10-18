-- Switch to the database
\c OnlineBookstore;


-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM '‪D:/SQL POSTGRE/ST - SQL ALL PRACTICE FILES/All Excel Practice Files/Books.csv' 
CSV HEADER;

-- Import Data into Customers Table
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM '‪D:\SQL POSTGRE\ST - SQL ALL PRACTICE FILES\All Excel Practice Files\Customers.csv' 
CSV HEADER;

-- Import Data into Orders Table
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Orders.csv' 
CSV HEADER;

-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books
WHERE genre='Fiction';

-- 2) Find books published after the year 1950:

SELECT * FROM Books
WHERE published_year>1950;

-- 3) List all customers from the Canada:

SELECT * FROM  Customers
WHERE country='Canada';

-- 4) Show orders placed in November 2023:

SELECT * FROM Orders
WHERE order_date Between '2023-11-01' and '2023-11-30';


-- 5) Retrieve the total stock of books available:
SELECT SUM(stock) AS Total_Stock
FROM Books;

-- 6) Find the details of the most expensive book:
SELECT * FROM Books
 order by price desc
 limit 1;

 -- 7) Show all customers who ordered more than 1 quantity of a book:
 
SELECT * FROM Orders
where quantity>1;


-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
where total_amount>20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT genre FROM Books;

-- 10) Find the book with the lowest stock:
SELECT * FROM Books
 ORDER BY stock ASC
 LIMIT 1;

 -- 11) Calculate the total revenue generated from all orders:
 SELECT SUM(total_amount) as Total_revenue
  from Orders;



  --Advanced Section
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


  -- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT * FROM ORDERS;

SELECT b.genre ,SUM (o.quantity) AS Total_Quantity 
from Books b
JOIN Orders o
On b.book_id=o.book_id
group by b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) as avg_price
 from Books
  where genre='Fantasy';

  -- 3) List customers who have placed at least 2 orders:
SELECT customer_id,count(order_id) as order_count
from Orders 
group by customer_id
having count(order_id)>=2;


-- 4) Find the most frequently ordered book:
SELECT book_id,count(order_id) as order_count
from Orders 
group by book_id
order by order_count desc
limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM Books
where genre='Fantasy'
order by price desc
limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
select b.author,sum(o.quantity) as total_quantity
from
Books b
join 
Orders o
on b.book_id=o.book_id
group by b.author;

-- 7) List the cities where customers who spent over $30 are located:
select distinct c.city,o.total_amount
from
customers c
join 
orders o
on c.customer_id=o.customer_id

where o.total_amount>30;

-- 8) Find the customer who spent the most on orders:

SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;


