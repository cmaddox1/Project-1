/* Amy Jiang, Christopher Maddox, David Butsko */

USE Weiner;
GO

CREATE TABLE HotDog(
  HotDogID bigint NOT NULL PRIMARY KEY,
  HotDogName varchar(50) NOT NULL);

CREATE TABLE Customer(
  CustomerID bigint NOT NULL PRIMARY KEY,
  CustomerName varchar(50) NOT NULL,
  CustomerEmail varchar(50) NOT NULL,
  CustomerPhoneNumber varchar(50) NOT NULL,
  CustomerAddress varchar(50) NOT NULL,
  CustomerCity varchar(50) NOT NULL,
  CustomerState varchar(50) NOT NULL,
  CustomerZIP varchar(50) NOT NULL);

CREATE TABLE Purchases(
  PurchaseOrderID bigint NOT NULL PRIMARY KEY,
  OrderQuantity bigint NOT NULL,
  CustomerID bigint ,
  SalesAmount bigint NOT NULL,
  OrderCost bigint NOT NULL,
  HotDogID bigint,
  LocationID bigint);

  CREATE TABLE Locations(
  LocationID bigint NOT NULL PRIMARY KEY,
  LocationName varchar(50) NOT NULL,
  LocationAddress varchar(50) NOT NULL,
  LocationCity varchar(50) NOT NULL,
  LocationState varchar(50) NOT NULL,
  LocationZIP varchar(50) NOT NULL,
  LocationType varchar(50) NOT NULL,
  SquareFeet bigint NOT NULL);

  /* Relationship Creation */

ALTER TABLE Purchases ADD CONSTRAINT CustomerID 
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);
GO

ALTER TABLE Purchases ADD CONSTRAINT HotDogID 
FOREIGN KEY (HotDogID) REFERENCES HotDog(HotDogID);
GO

ALTER TABLE Purchases ADD CONSTRAINT LocationID 
FOREIGN KEY (LocationID) REFERENCES Locations(LocationID);
GO

/* Insert Data into Tables */

INSERT INTO HotDog(HotDogID, HotDogName) VALUES 
(1, 'The Dawg');

INSERT INTO Customer(CustomerID, CustomerName, CustomerEmail, CustomerPhoneNumber,
	CustomerAddress, CustomerCity, CustomerState, CustomerZIP) VALUES 
(1, 'Je Hak Lee', 'jlee24@babson.edu', '7815683258', '185 Linden St', 'Wellesley', 'MA', '02482'),
(2, 'David Butsko', 'dskoboobop100@clowncollege.edu', '6789998212', '45 Yusuckle Lane', 'Fargo', 'ND', '45632'),
(3, 'Angela Leung', 'aleung2@babson.edu', '3125686458', '407 Forest St', 'Waltham', 'MA', '02452'),
(4, 'Alex Chau', 'achau1@babson.edu', '8172699567', '178 El St', 'Houston', 'TX', '12345'),
(5, 'Tara Bunnag', 'tbunnag1@babson.edu', '312598397', '231 Doty St', 'Hammond', 'IN', '46320'),
(6, 'Diamond Franklin', 'dfranklin1@babson.edu', '7819883768', '209 Geer St', 'Durham', 'NC', '27701'),
(7, 'Andrei Volkov', 'avolkov1@babson.edu', '6504749399', '300 2nd Ave', 'Needham', 'MA', '02494'),
(8, 'Cynthia Yong', 'cyong24@babson.edu', '7815678258', '176 Bob St', 'San Jose', 'MA', '02879'),
(9, 'Leticia Jackson', 'ljackson5@EDMUS.edu', '2587654432', '85 Dogsline Circle', 'Jones', 'OR', '35667'),
(10,'Jamie Kate', 'jkate@aol.com', '777894567', '667 Map Hill Drt', 'Austin', 'TX', '77836');

INSERT INTO Customer(CustomerID, CustomerName, CustomerEmail, CustomerPhoneNumber,
	CustomerAddress, CustomerCity, CustomerState, CustomerZIP) VALUES 
(11,'Eleven', 'strangerthings@netflix.com', '9999999999', '666 Kreeperdale Dr', 'Salem', 'UT', '90210');

INSERT INTO Purchases(PurchaseOrderID, OrderQuantity, CustomerID, SalesAmount, OrderCost,
	HotDogID, LocationID) VALUES
(123, 2, 1, 6, 2, 1, 01111),
(234, 3, 2, 9, 3, 1, 02222),
(345, 1, 3, 3, 1, 1, 05555),
(456, 2, 4, 6, 2, 1, 04444),
(567, 2, 5, 6, 2, 1, 03333),
(678, 1, 6, 3, 1, 1, 02222),
(789, 2, 7, 6, 2, 1, 03333),
(246, 2, 8, 6, 2, 1, 04444),
(468, 3, 9, 9, 3, 1, 05555),
(369, 1, 10, 3, 1, 1, 01111);

INSERT INTO Locations (LocationID, LocationName, LocationAddress, LocationCity, LocationState, LocationZIP,
	LocationType, SquareFeet) VALUES
(01111, 'Bird St Dogs', '432 Gang Gang Way', 'Bronx', 'NY', '12834', 'Store', 100),
(02222, 'No1 Weiners', '76 Hahvahd St', 'Cambridge', 'MA', '21454', 'Stand', 5),
(03333, 'Hot Dogs Galore', '8 Webster Rd', 'Chicago', 'IL', '76291', 'Stand', 10),
(04444, 'Not Actual Dogs', '105 Voldemort Ave', 'El Paso', 'TX', '56333', 'Store', 150),
(05555, 'Weiner World', '49 Third Eye St', 'Los Angeles', 'CA', '31279', 'Store', 80);

/* Deliverable 3 */

/* 1 */
SELECT * FROM Customer;
SELECT * FROM HotDog;
SELECT * FROM Locations;
SELECT * FROM Purchases;

/* 2 */
SELECT LocationID, SUM(SalesAmount) as RevenuePerLocation
FROM Purchases
GROUP BY LocationID;

/* 3 */
SELECT c.CustomerName, c.CustomerEmail, p.SalesAmount
FROM dbo.Customer as c
Inner Join dbo.Purchases as p
	ON c.CustomerID = p.CustomerID
ORDER BY p.SalesAmount DESC;

/* 4 */
SELECT c.CustomerName, c.CustomerEmail, p.SalesAmount
FROM dbo.Customer as c
Left Join dbo.Purchases as p
	ON c.CustomerID = p.CustomerID
ORDER BY p.SalesAmount DESC;
/* We needed to do a left join because the information in the sales amount column was not available for all the
data, we had a customer who had not yet purchased a hot dog. This was likely the result of our ad campaign in which
we got prospective customers to sign up for our email list. */

/* 5 */
SELECT a.*, b.SalesTotal FROM Locations as a
Left Join (SELECT b.LocationID, SUM(b.SalesAmount) as SalesTotal
	FROM Purchases as b 
	GROUP BY b.LocationID) as b
ON a.LocationID = b.LocationID;
/* Subquery joining tables to see sales by location */