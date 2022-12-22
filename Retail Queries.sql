USE w3schools;

SELECT ProductName, Unit, Price
FROM products 
WHERE Price >= 25
ORDER BY Price DESC;

SELECT o.OrderID, c.CustomerName, s.ShipperName, e.FirstName as EmployeeFirstName, e.LastName as EmployeeLastName
FROM orders o JOIN customers c JOIN shippers s JOIN employees e
ON o.CustomerID = c.CustomerID
AND o.ShipperID = s.ShipperID
AND o.EmployeeID = e.EmployeeID
ORDER BY o.OrderID ASC;

SELECT o.OrderID, c.CustomerName, s.ShipperName, e.FirstName as EmployeeFirstName, e.LastName as EmployeeLastName
FROM orders o JOIN customers c JOIN shippers s JOIN employees e
ON o.CustomerID = c.CustomerID
AND o.ShipperID = s.ShipperID
AND o.EmployeeID = e.EmployeeID
WHERE c.Country = 'USA'
AND s.ShipperName = 'Speedy Express'
ORDER BY o.OrderID ASC;

SELECT c.CategoryName, COUNT(p.Price), AVG(p.Price)
FROM products p JOIN categories c
ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY COUNT(p.Price) DESC, AVG(p.Price) ASC;

SELECT *
FROM customers c LEFT JOIN orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

SELECT c.CustomerName, SUM(p.Price*od.Quantity) as TotalSpend
FROM customers c JOIN products p JOIN order_details od JOIN orders o
ON c.CustomerID = o.CustomerID
AND o.OrderID = od.OrderId
AND od.ProductID = p.ProductID
GROUP BY c.CustomerNAme
ORDER BY TotalSpend DESC;

SELECT DISTINCT ProductName 
FROM products p JOIN order_details od JOIN orders o JOIN shippers s
ON p.ProductID = od.ProductID
AND od.OrderID = o.OrderID
AND o.ShipperID= s.ShipperID
WHERE s.ShipperName IN
(
SELECT MAX(ShipperName)
FROM shippers
);

with tot as 
(
select od.OrderID, sum(od.Quantity*p.Price) as total_value
from products p 
join order_details od on od.ProductID = p.ProductID group by od.OrderID
)
select 
OrderID, Total_Value
from tot
where total_value > 
(
select avg(total_value)
from tot
);






