--- 06-10-2024 13:02:05
--- MS SQL
SELECT W.NumW
FROM WINE W
INNER JOIN HARVEST H ON W.NumW = H.NumW
WHERE W.Degree > 12 AND H.NumP = 24;

--- 06-10-2024 13:06:10
--- MS SQL
/***** ERROR ******
Error 102 Incorrect syntax near 'LIMIT'.
 ----- 
SELECT p.FirstName, p.LastName, SUM(h.Quantity) AS TotalQuantity
FROM PRODUCER p
JOIN HARVEST h ON p.NumP = h.NumP
GROUP BY p.NumP
ORDER BY TotalQuantity DESC
LIMIT 1;
*****/

--- 06-10-2024 13:20:39
--- MS SQL
SELECT TOP 1 
    P.FirstName, 
    P.LastName, 
    SUM(H.Quantity) AS TotalQuantity
FROM 
    HARVEST H
JOIN 
    PRODUCER P ON H.NumP = P.NumP
GROUP BY 
    P.NumP, P.FirstName, P.LastName
ORDER BY 
    TotalQuantity DESC;

--- 06-10-2024 13:27:18
--- MS SQL
SELECT AVG(Degree) AS AverageDegree FROM WINE;

--- 06-10-2024 13:36:38
--- MS SQL
/***** ERROR ******
Error 102 Incorrect syntax near 'LIMIT'.
 ----- 
SELECT * 
FROM WINE 
ORDER BY Year ASC 
LIMIT 1;
*****/

--- 06-10-2024 13:40:57
--- MS SQL
SELECT *
FROM WINE
WHERE Year = (SELECT MIN(Year) FROM WINE);

--- 06-10-2024 13:41:11
--- MS SQL
SELECT TOP 1 
    P.FirstName, 
    P.LastName, 
    SUM(H.Quantity) AS TotalQuantity
FROM 
    HARVEST H
JOIN 
    PRODUCER P ON H.NumP = P.NumP
GROUP BY 
    P.NumP, P.FirstName, P.LastName
ORDER BY 
    TotalQuantity DESC;

--- 06-10-2024 13:43:55
--- MS SQL
/***** ERROR ******
Error 8120 Column 'PRODUCER.FirstName' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
 ----- 
WITH ProducerQuantities AS (
    SELECT 
        p.NumP,
        p.FirstName,
        p.LastName,
        SUM(h.Quantity) AS TotalQuantity
    FROM 
        PRODUCER p
    JOIN 
        HARVEST h ON p.NumP = h.NumP
    GROUP BY 
        p.NumP
)
SELECT 
    FirstName, 
    LastName, 
    TotalQuantity
FROM 
    ProducerQuantities
WHERE 
    TotalQuantity = (SELECT MAX(TotalQuantity) FROM ProducerQuantities);
*****/

--- 06-10-2024 13:52:41
--- MS SQL
/***** ERROR ******
Error 8120 Column 'PRODUCER.FirstName' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
 ----- 
WITH ProducerQuantities AS (
    SELECT 
        P.FirstName,
        P.LastName,
        SUM(H.Quantity) AS TotalQuantity
    FROM 
        HARVEST H
    JOIN 
        PRODUCER P ON H.NumP = P.NumP
    GROUP BY 
        P.NumP
)
SELECT 
    FirstName,
    LastName,
    TotalQuantity
FROM 
    ProducerQuantities
WHERE 
    TotalQuantity = (SELECT MAX(TotalQuantity) FROM ProducerQuantities);
*****/

--- 06-10-2024 14:38:53
--- MS SQL
/***** ERROR ******
Error 8120 Column 'PRODUCER.FirstName' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
 ----- 
WITH ProducerQuantities AS (
    SELECT 
        P.FirstName, 
        P.LastName, 
        SUM(H.Quantity) AS TotalQuantity
    FROM 
        PRODUCER P
    JOIN 
        HARVEST H ON P.NumP = H.NumP
    GROUP BY 
        P.NumP
)
SELECT 
    FirstName, 
    LastName, 
    TotalQuantity
FROM 
    ProducerQuantities
WHERE 
    TotalQuantity = (SELECT MAX(TotalQuantity) FROM ProducerQuantities);
*****/

--- 06-10-2024 14:40:41
--- MS SQL
SELECT TOP 1 
    P.FirstName, 
    P.LastName, 
    SUM(H.Quantity) AS TotalQuantity
FROM 
    HARVEST H
JOIN 
    PRODUCER P ON H.NumP = P.NumP
GROUP BY 
    P.NumP, P.FirstName, P.LastName
ORDER BY 
    TotalQuantity DESC;

--- 06-10-2024 14:51:05
--- MS SQL
/***** ERROR ******
Error 102 Incorrect syntax near '|'.
 ----- 
SELECT 
    P.FirstName || ' ' || P.LastName AS ProducerName,
    SUM(H.Quantity) AS TotalQuantity
FROM 
    PRODUCER P
JOIN 
    HARVEST H ON P.NumP = H.NumP
JOIN 
    WINE W ON H.NumW = W.NumW
GROUP BY 
    P.NumP
ORDER BY 
    ProducerName;
*****/

--- 07-10-2024 12:06:50
--- MS SQL
/***** ERROR ******
Error 102 Incorrect syntax near '|'.
 ----- 
SELECT 
    P.FirstName || ' ' || P.LastName AS ProducerName,
    SUM(H.Quantity) AS TotalQuantity
FROM 
    PRODUCER P
JOIN 
    HARVEST H ON P.NumP = H.NumP
JOIN 
    WINE W ON H.NumW = W.NumW
GROUP BY 
    P.NumP
ORDER BY 
    ProducerName;
*****/

--- 07-10-2024 14:05:25
--- MS SQL
/***** ERROR ******
Error 102 Incorrect syntax near '|'.
 ----- 
SELECT 
    P.FirstName || " " || P.LastName AS ProducerName,
    SUM(H.Quantity) AS TotalQuantity
FROM 
    HARVEST H
JOIN 
    PRODUCER P ON H.NumP = P.NumP
GROUP BY 
    P.NumP;
*****/

--- 07-10-2024 14:10:16
--- MS SQL
/***** ERROR ******
Error 8120 Column 'PRODUCER.FirstName' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
 ----- 
SELECT 
    CONCAT(P.FirstName, ' ', P.LastName) AS ProducerName,
    SUM(H.Quantity) AS TotalQuantity
FROM 
    PRODUCER P
JOIN 
    HARVEST H ON P.NumP = H.NumP
JOIN 
    WINE W ON H.NumW = W.NumW
GROUP BY 
    P.NumP
ORDER BY 
    ProducerName;
*****/

--- 07-10-2024 14:15:56
--- MS SQL
SELECT 
    CONCAT(FirstName, ' ', LastName) AS ProducerName,
    SUM(Quantity) AS TotalQuantity
FROM 
    PRODUCER p
JOIN 
    HARVEST h ON p.NumP = h.NumP
JOIN 
    WINE w ON h.NumW = w.NumW
GROUP BY 
    p.NumP, FirstName, LastName;

--- 07-10-2024 14:18:39
--- MS SQL
SELECT 
    W.NumW AS WineID,
    W.Category,
    W.Year,
    W.Degree,
    P.FirstName,
    P.LastName,
    P.Region
FROM 
    WINE W
JOIN 
    HARVEST H ON W.NumW = H.NumW
JOIN 
    PRODUCER P ON H.NumP = P.NumP;

