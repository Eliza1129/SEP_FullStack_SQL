---14. List all Products that has been sold at least once in last 27 years.
SELECT DISTINCT P.ProductID, P.ProductName
FROM dbo.Products P
JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE O.OrderDate >= DATEADD(YEAR, -27, GETDATE())

---15. List top 5 locations (Zip Code) where the products sold most.
SELECT TOP 5 C.PostalCode AS ZipCode, SUM(OD.Quantity) AS TotalProductsSold
FROM dbo.Orders O
JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
JOIN dbo.Customers C ON O.CustomerID = C.CustomerID
WHERE C.PostalCode IS NOT NULL 
GROUP BY C.PostalCode
ORDER BY TotalProductsSold DESC

---16. List top 5 locations (Zip Code) where the products sold most in last 27 years.
SELECT TOP 5 C.PostalCode AS ZipCode, SUM(OD.Quantity) AS TotalProductsSold
FROM dbo.Orders O
JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
JOIN dbo.Customers C ON O.CustomerID = C.CustomerID
WHERE C.PostalCode IS NOT NULL
AND O.OrderDate >= DATEADD(YEAR, -27, GETDATE())
GROUP BY C.PostalCode
ORDER BY TotalProductsSold DESC

---17. List all city names and number of customers in that city.
SELECT City, COUNT(CustomerID) AS CustomerCount
FROM dbo.Customers
GROUP BY City
ORDER BY CustomerCount DESC

---18. List city names which have more than 2 customers, and number of customers in that city
SELECT City, COUNT(CustomerID) AS CustomerCount
FROM dbo.Customers
GROUP BY City
HAVING COUNT(CustomerID) > 2
ORDER BY CustomerCount DESC

---19. List the names of customers who placed orders after 1/1/98 with order date.
SELECT DISTINCT C.CompanyName AS CustomerName, O.OrderDate
FROM dbo.Orders O
JOIN dbo.Customers C ON O.CustomerID = C.CustomerID
WHERE O.OrderDate > '1998-01-01'
ORDER BY O.OrderDate

---20.List the names of all customers with most recent order dates
SELECT DISTINCT C.CompanyName AS CustomerName, MAX(O.OrderDate) AS MostRecentOrderDate
FROM dbo.Orders O
JOIN dbo.Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName
ORDER BY MostRecentOrderDate DESC

---21.Display the names of all customers  along with the count of products they bought
SELECT C.CompanyName AS CustomerName, SUM(OD.Quantity) AS TotalProductsBought
FROM dbo.Orders O
JOIN dbo.Customers C ON O.CustomerID = C.CustomerID
JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName
ORDER BY TotalProductsBought DESC

---22. Display the customer ids who bought more than 100 Products with count of products.
SELECT C.CustomerID, SUM(OD.Quantity) AS TotalProductsBought
FROM dbo.Orders O
JOIN dbo.Customers C ON O.CustomerID = C.CustomerID
JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID
HAVING SUM(OD.Quantity) > 100
ORDER BY TotalProductsBought DESC

---23. List all of the possible ways that suppliers can ship their products.
SELECT DISTINCT 
    S.CompanyName AS [Supplier Company Name], 
    SH.CompanyName AS [Shipping Company Name]
FROM dbo.Suppliers S
JOIN dbo.Products P ON S.SupplierID = P.SupplierID
JOIN dbo.[Order Details] OD ON P.ProductID = OD.ProductID
JOIN dbo.Orders O ON OD.OrderID = O.OrderID
JOIN dbo.Shippers SH ON O.ShipVia = SH.ShipperID
ORDER BY S.CompanyName, SH.CompanyName

---24. Display the products order each day. Show Order date and Product Name.
SELECT O.OrderDate, P.ProductName
FROM dbo.Orders O
JOIN dbo.[Order Details] OD ON O.OrderID = OD.OrderID
JOIN dbo.Products P ON OD.ProductID = P.ProductID
ORDER BY O.OrderDate, P.ProductName


---25. Displays pairs of employees who have the same job title
SELECT E1.EmployeeID AS Employee1_ID, E1.FirstName + ' ' + E1.LastName AS Employee1_Name,
       E2.EmployeeID AS Employee2_ID, E2.FirstName + ' ' + E2.LastName AS Employee2_Name,
       E1.Title
FROM dbo.Employees E1
JOIN dbo.Employees E2 
ON E1.Title = E2.Title 
AND E1.EmployeeID < E2.EmployeeID
ORDER BY E1.Title, E1.EmployeeID, E2.EmployeeID

---26. Display all the Managers who have more than 2 employees reporting to them
SELECT M.EmployeeID AS ManagerID, 
       M.FirstName + ' ' + M.LastName AS ManagerName, 
       M.Title, 
       COUNT(E.EmployeeID) AS TotalReports
FROM dbo.Employees M
JOIN dbo.Employees E ON M.EmployeeID = E.ReportsTo 
WHERE M.Title LIKE '%Manager%'  
GROUP BY M.EmployeeID, M.FirstName, M.LastName, M.Title
HAVING COUNT(E.EmployeeID) > 2 
ORDER BY TotalReports DESC

---27. Display the customers and suppliers by city.
SELECT City, CompanyName AS Name, ContactName, 'Customer' AS 'Type(Customer or Supplier)'
FROM dbo.Customers
UNION ALL
SELECT City, CompanyName AS Name, ContactName, 'Supplier' AS 'Type(Customer or Supplier)'
FROM dbo.Suppliers
ORDER BY City, 'Type(Customer or Supplier)'




