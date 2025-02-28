---1. List all cities that have both Employees and Customers
SELECT DISTINCT E.City
FROM dbo.Employees E
JOIN dbo.Customers C ON E.City = C.City;

---2. List all cities that have Customers but no Employee.
--- a.Use sub-query 
--- b.Do not use sub-query
SELECT DISTINCT C.City
FROM dbo.Customers C
WHERE C.City NOT IN (SELECT DISTINCT E.City FROM dbo.Employees E)

SELECT DISTINCT C.City
FROM dbo.Customers C
LEFT JOIN dbo.Employees E ON C.City = E.City
WHERE E.City IS NULL;

--3. List all products and their total order quantities throughout all orders.
SELECT P.ProductName, SUM(OD.Quantity) AS TotalOrder
FROM dbo.[Order Details] OD
JOIN dbo.Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalOrder DESC

---4. List all Customer Cities and total products ordered by that city.
SELECT C.City, SUM(OD.Quantity) AS TotalProductsOrdered
FROM dbo.Customers C
JOIN dbo.Orders O ON C.CustomerID = O.CustomerID
JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.City
ORDER BY TotalProductsOrdered DESC

---5. List all Customer Cities that have at least two customers.
SELECT City, COUNT(CustomerID) AS TotalCustomers
FROM dbo.Customers
GROUP BY City
HAVING COUNT(CustomerID) >= 2
ORDER BY TotalCustomers DESC

---6. List all Customer Cities that have ordered at least two different kinds of products
SELECT C.City, COUNT(DISTINCT OD.ProductID) AS TotalDistinctProducts
FROM dbo.Customers C
JOIN dbo.Orders O ON C.CustomerID = O.CustomerID
JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.City
HAVING COUNT(DISTINCT OD.ProductID) >= 2
ORDER BY TotalDistinctProducts DESC

---7. List all Customers who have ordered products, 
-- but have the ‘ship city’ on the order different from their own customer cities
SELECT DISTINCT C.CustomerID, C.CompanyName, C.City AS CustomerCity, O.ShipCity
FROM dbo.Customers C
JOIN dbo.Orders O ON C.CustomerID = O.CustomerID
WHERE C.City <> O.ShipCity

---8. List 5 most popular products, their average price, 
--- and the customer city that ordered the most quantity of it.
WITH ProductPopularity AS (
    SELECT TOP 5 OD.ProductID, P.ProductName, AVG(OD.UnitPrice) AS AvgPrice, SUM(OD.Quantity) AS TotalOrdered
    FROM dbo.[Order Details] OD
    JOIN dbo.Products P ON OD.ProductID = P.ProductID
    GROUP BY OD.ProductID, P.ProductName
    ORDER BY TotalOrdered DESC
),
CityOrders AS (
    SELECT OD.ProductID, C.City, SUM(OD.Quantity) AS CityTotalOrdered
    FROM dbo.[Order Details] OD
    JOIN dbo.Orders O ON OD.OrderID = O.OrderID
    JOIN dbo.Customers C ON O.CustomerID = C.CustomerID
    GROUP BY OD.ProductID, C.City
)
SELECT PP.ProductName, PP.AvgPrice, CO.City AS TopOrderingCity
FROM ProductPopularity PP
JOIN CityOrders CO ON PP.ProductID = CO.ProductID
WHERE CO.CityTotalOrdered = (SELECT MAX(CityTotalOrdered) FROM CityOrders CO2 WHERE CO2.ProductID = CO.ProductID);

---9. List all cities that have never ordered something but we have employees there.
--- a.Use sub-query 
--- b.Do not use sub-query
SELECT DISTINCT E.City
FROM dbo.Employees E
WHERE E.City NOT IN (SELECT DISTINCT O.ShipCity FROM dbo.Orders O)

SELECT DISTINCT E.City
FROM dbo.Employees E
LEFT JOIN dbo.Orders O ON E.City = O.ShipCity
WHERE O.OrderID IS NULL

---10. List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, 
-- and also the city of most total quantity of products ordered from
WITH EmployeeSales AS (
    SELECT TOP 1 E.City AS EmployeeCity, COUNT(O.OrderID) AS TotalOrders
    FROM dbo.Orders O
    JOIN dbo.Employees E ON O.EmployeeID = E.EmployeeID
    GROUP BY E.City
    ORDER BY TotalOrders DESC
),
CustomerOrders AS (
    SELECT TOP 1 C.City AS CustomerCity, SUM(OD.Quantity) AS TotalQuantity
    FROM dbo.Orders O
    JOIN dbo.Customers C ON O.CustomerID = C.CustomerID
    JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
    GROUP BY C.City
    ORDER BY TotalQuantity DESC
)
SELECT ES.EmployeeCity, CO.CustomerCity
FROM EmployeeSales ES
JOIN CustomerOrders CO ON ES.EmployeeCity = CO.CustomerCity

---11. How do you remove the duplicates record of a table?
-- To remove duplicate records, one approach is to use the ROW_NUMBER() function. 
-- This assigns a unique row number to each record based on duplicate columns, allowing you to delete extra occurrences while keeping one. 
-- This method is useful when a table lacks a primary key and contains unintended duplicate data.  
-- Another approach is to create a new table with only distinct records using the DISTINCT keyword. 
-- After extracting unique records, the original table is dropped and replaced with the cleaned version.




