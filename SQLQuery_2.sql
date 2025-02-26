USE AdventureWorks2019
GO

---1. retrieves the columns ProductID, Name, Color and ListPrice from the Production.
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product;

---2.  retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, 
---    excludes the rows that ListPrice is 0
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice <> 0;

---3. retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, 
---   the rows that are NULL for the Color column.
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NULL;

---4. retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, 
--- the rows that are not NULL for the Color column.
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL;

---5. retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, 
--- the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL AND ListPrice > 0;

--6. concatenates the columns Name and Color from the Production.Product table 
---   by excluding the rows that are null for color.
SELECT Name + ' '+ Color AS ProductDescription
FROM Production.Product
WHERE Color IS NOT NULL; 

---7. a query that generates the following result set from Production.Product
SELECT TOP 6 'NAME:' + Name + ' -- COLOR:' + Color AS ProductDescription
FROM Production.Product
WHERE Color IS NOT NULL;

---8. retrieve the to the columns ProductID and Name from the Production.Product 
--- table filtered by ProductID from 400 to 500
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500;

---9. retrieve the to the columns  ProductID, Name and color from the Production.Product table 
--- restricted to the colors black and blue
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IN('Black' , 'Blue');

---10. to get a result set on products that begins with the letter S
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Name LIKE 'S%';

---11. retrieves the columns Name and ListPrice from the Production.Product table.
--- Order the result set by the Name column
SELECT TOP 6 Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'S%'
ORDER BY Name;

---12. retrieves the columns Name and ListPrice from the Production.Product table. 
-- Order the result set by the Name column. The products name should start with either 'A' or 'S'
SELECT TOP 6 Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'S%' OR Name LIKE 'A%'
ORDER BY Name;

---13. retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. 
--- After this zero or more letters can exists. Order the result set by the Name column.
SELECT Name
FROM Production.Product
WHERE Name LIKE 'SPO[^K]%'
ORDER BY Name;

---14. retrieves unique colors from the table Production.Product. Order the results in descending  manner.
SELECT DISTINCT Color 
FROM Production.Product
ORDER BY Color DESC;