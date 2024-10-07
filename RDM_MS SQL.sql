/* QUESTION 1 : Convertir le diagramme entité-relation donné en un modèle relationnel. */
WINE(NumW, Category, Year, Degree)
PRODUCER(NumP, FirstName, LastName, Region)
HARVEST(NumW, NumP, Quantity)


/* QUESTION 2 : Implémentez le modèle relationnel à l’aide de SQL. */
-- Création de la table VIN
CREATE TABLE WINE (
    NumW INT PRIMARY KEY,
    Category VARCHAR(50) NOT NULL,
    Year INT CHECK (Year > 1900),
    Degree DECIMAL(3, 1) CHECK (Degree >= 0)
);

-- Création de la table PRODUCTEUR
CREATE TABLE PRODUCER (
    NumP INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Region VARCHAR(50) NOT NULL
);

-- Création de la table RÉCOLTE
CREATE TABLE HARVEST (
    NumW INT,
    NumP INT,
    Quantity INT CHECK (Quantity >= 0),
    PRIMARY KEY (NumW, NumP), -- Composite primary key
    FOREIGN KEY (NumW) REFERENCES WINE(NumW) ON DELETE CASCADE,
    FOREIGN KEY (NumP) REFERENCES PRODUCER(NumP) ON DELETE CASCADE
);


/* QUESTION 3 : Insérez des données dans les tables de la base de données. */
-- Insérer des enregistrements dans la table WINE
INSERT INTO WINE (NumW, Category, Year, Degree) VALUES
(1, 'Red', 2019, 13.5),
(2, 'White', 2020, 12.0),
(3, 'Rose', 2018, 11.5),
(4, 'Red', 2021, 14.0),
(5, 'Sparkling', 2017, 10.5),
(6, 'White', 2019, 12.5),
(7, 'Red', 2022, 13.0),
(8, 'Rose', 2020, 11.0),
(9, 'Red', 2018, 12.0),
(10, 'Sparkling', 2019, 10.0),
(11, 'White', 2021, 11.5),
(12, 'Red', 2022, 15.0);

-- Insérer des enregistrements dans la table PRODUCER
INSERT INTO PRODUCER (NumP, FirstName, LastName, Region) VALUES
(1, 'John', 'Smith', 'Sousse'),
(2, 'Emma', 'Johnson', 'Tunis'),
(3, 'Michael', 'Williams', 'Sfax'),
(4, 'Emily', 'Brown', 'Sousse'),
(5, 'James', 'Jones', 'Sousse'),
(6, 'Sarah', 'Davis', 'Tunis'),
(7, 'David', 'Miller', 'Sfax'),
(8, 'Olivia', 'Wilson', 'Monastir'),
(9, 'Daniel', 'Moore', 'Sousse'),
(10, 'Sophia', 'Taylor', 'Tunis'),
(11, 'Matthew', 'Anderson', 'Sfax'),
(12, 'Amelia', 'Thomas', 'Sousse');


/* QUESTION 4 : Récupérez une liste de tous les producteurs. */
SELECT * FROM PRODUCER;


/* QUESTION 5 : Récupérez une liste triée de producteurs par nom. */
SELECT FirstName, LastName 
FROM PRODUCER 
ORDER BY LastName ASC, FirstName ASC;


/* QUESTION 6 : Récupérez une liste de producteurs de Sousse. */
SELECT FirstName, LastName
FROM PRODUCER
WHERE Region = 'Sousse';


/* QUESTION 7 : Calculez la quantité totale de vin produite avec le numéro de vin 12. */
SELECT SUM(Quantity) AS TotalQuantity
FROM HARVEST
WHERE NumW = 12;


/* QUESTION 8 : Calculez la quantité de vin produite pour chaque catégorie. */
SELECT 
    W.Category,
    SUM(H.Quantity) AS TotalQuantity
FROM 
    WINE W
JOIN 
    HARVEST H ON W.NumW = H.NumW
GROUP BY 
    W.Category;


/* QUESTION 9 : Retrouvez des producteurs de la région de Sousse qui ont récolté au moins un vin en quantités supérieures à 300 litres. */
SELECT p.FirstName, p.LastName
FROM PRODUCER p
JOIN HARVEST h ON p.NumP = h.NumP
WHERE p.Region = 'Sousse' AND h.Quantity > 300
ORDER BY p.LastName, p.FirstName;


/* QUESTION 10 : Énumérez les numéros de vin d’un degré supérieur à 12, produits par le producteur numéro 24. */
SELECT W.NumW
FROM WINE W
INNER JOIN HARVEST H ON W.NumW = H.NumW
WHERE W.Degree > 12 AND H.NumP = 24;


/* QUESTION 11 : Find the producer who has produced the highest quantity of wine. */
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


/* QUESTION 12 : Retrouvez le degré moyen de vin produit. */
SELECT AVG(Degree) AS AverageDegree FROM WINE;


/* QUESTION 13 : Trouvez le vin le plus ancien dans la base de données. */
SELECT *
FROM WINE
WHERE Year = (SELECT MIN(Year) FROM WINE);


/* QUESTION 14 : Récupérez une liste de producteurs ainsi que la quantité totale de vin qu’ils ont produite. */
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


/* QUESTION 15 : Récupérez une liste de vins avec les coordonnées de leur producteur. */
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


