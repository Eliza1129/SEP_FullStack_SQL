---1.How many products can you find in the Production.Product table?
SELECT COUNT(ProductID) AS productTypes
FROM Production.Product

---2. retrieves the number of products in the Production.Product table that are included in a subcategory. 
-- The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
SELECT COUNT(ProductSubcategoryID) AS productCount
FROM Production.Product

--3. How many Products reside in each SubCategory?
SELECT ProductSubcategoryID, COUNT(*) AS CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID

---4. How many products that do not have a product subcategory.
SELECT COUNT(*) AS NoSubcategoryProduct
FROM Production.Product
WHERE ProductSubcategoryID IS NULL

---5. list the sum of products quantity in the Production.ProductInventory table
SELECT SUM(Quantity) AS ProductsQuantity
FROM Production.ProductInventory

---6.  the sum of products in the Production.ProductInventory table and 
--- LocationID set to 40 and limit the result to include just summarized quantities less than 100.
SELECT ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID 
HAVING SUM(Quantity) < 100

---7. list the sum of products with the shelf information in the Production.ProductInventory table and 
--- LocationID set to 40 and limit the result to include just summarized quantities less than 100
SELECT Shelf,ProductID, SUM(Quantity) AS TheSum
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY Shelf,ProductID
HAVING SUM(Quantity) < 100

---8. list the average quantity for products 
--- where column LocationID has the value of 10 from the table Production.ProductInventory table.
SELECT AVG(Quantity) AS AverageQuantity
FROM Production.ProductInventory
WHERE LocationID = 10

---9. see the average quantity  of  products by shelf  from the table Production.ProductInventory
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf

---10. see the average quantity  of  products by shelf 
--- excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg
FROM Production.ProductInventory
WHERE Shelf <> 'N/A'
GROUP BY ProductID, Shelf

---11. List the members (rows) and average list price in the Production.Product table. 
--- This should be grouped independently over the Color and the Class column. 
--- Exclude the rows where Color or Class are null.
SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class

---Joins
---12.lists the country and province names from person. CountryRegion and person. StateProvince tables. 
--- Join them and produce a result set similar to the following.

SELECT pc.Name AS Country, ps.Name AS Province
FROM person.CountryRegion pc
JOIN person.StateProvince ps 
ON pc.CountryRegionCode = ps.CountryRegionCode

---13. lists the country and province names from person. CountryRegion and person. 
--- StateProvince tables and list the countries filter them by Germany and Canada.
SELECT pc.Name AS Country, ps.Name AS Province
FROM person.CountryRegion pc
JOIN person.StateProvince ps 
ON pc.CountryRegionCode = ps.CountryRegionCode
WHERE pc.Name IN('Germany', 'Canada')


