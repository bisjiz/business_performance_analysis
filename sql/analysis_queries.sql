Create Database busniess_alaytics;
Use business_analytics;

Create Table Customers(
	customer_id INT PRIMARY KEY,
    signup_date Date,
    acquisition_channel VARCHAR(30),
    city VARCHAR(30)
);
Describe Customers;

CREATE TABLE Products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price INT
);
Describe Products;

CREATE TABLE Orders(
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    order_value INT
);
Describe Orders;

CREATE TABLE Engagements(
    engagement_id INT PRIMARY KEY,
    customer_id INT,
    engagement_date DATE,
    engagement_type VARCHAR(50)
);
Describe Engagements;

INSERT INTO Customers VALUES
(1, '2024-01-05', 'Organic', 'Delhi'),
(2, '2024-01-10', 'Referral', 'Mumbai'),
(3, '2024-01-20', 'Paid Ads', 'Bangalore'),
(4, '2024-01-15', 'Organic', 'Pune'),
(5, '2024-02-01', 'Referral', 'Kolkata');
Select * from Customers;

INSERT INTO Products VALUES
(101, 'Math Foundation', 'Academics', 5000),
(102, 'Physics Crash Course', 'Academics', 6000),
(103, 'Coding Basics', 'Skills', 7000);
Select * from Products;

INSERT INTO Orders VALUES
(1001, 1, 101, '2024-01-06', 5000),
(1002, 2, 102, '2024-01-12', 6000),
(1003, 3, 103, '2024-02-05', 7000),
(1004, 1, 102, '2024-02-20', 6000),
(1005, 4, 101, '2024-03-05', 5000);
Select * from Orders;


INSERT INTO Engagements VALUES
(1, 1, '2024-01-06', 'Class Attended'),
(2, 1, '2024-02-21', 'Class Attended'),
(3, 2, '2024-01-13', 'Class Attended'),
(4, 3, '2024-02-06', 'Class Attended'),
(5, 3, '2024-02-10', 'Practice Session'),
(6, 4, '2024-03-06', 'Class Attended');
Select * from Engagements;

Select Count(*) as Total_Customers from Customers;

Select Sum(price) as Total_Revenue from Products;

SELECT acquisition_channel,
       COUNT(*) AS customers from Customers
GROUP BY acquisition_channel
ORDER BY customers DESC;

Select c.acquisition_channel,SUM(order_value) as total_revenue from Orders a 
Join Customers c on a.customer_id=c.customer_id GROUP BY c.acquisition_channel;

SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(order_value) AS monthly_revenue from Orders
GROUP BY year, month
ORDER BY year, month;

SELECT 
    customer_id,
    COUNT(order_id) AS number_of_orders,
    SUM(order_value) AS total_spending from Orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

SELECT
    o.customer_id,
    o.total_revenue,
    e.total_engagements
from (
    SELECT
        customer_id,
        SUM(order_value) AS total_revenue
    FROM Orders
    GROUP BY customer_id
) o
LEFT JOIN (
    SELECT
        customer_id,
        COUNT(engagement_id) AS total_engagements
    from Engagements
    GROUP BY customer_id
) e
ON o.customer_id = e.customer_id;

Select a.acquisition_channel from customers a left join orders b on a.customer_id=b.customer_id;

SELECT
    a.acquisition_channel,
    avg(b.total_revenue) AS avg_revenue_per_customer
from customers a
LEFT JOIN (
    SELECT
        customer_id,
        SUM(order_value) AS total_revenue
    from Orders
    GROUP BY customer_id
) b
ON a.customer_id = b.customer_id
GROUP BY a.acquisition_channel;







