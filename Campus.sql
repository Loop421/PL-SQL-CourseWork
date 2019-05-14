create table Campus
(CampusID number,
CampusName varchar2(25),
Street varchar2(25),
City varchar2(25),
State char(2),
Zip number,
Phone varchar2(15),
CampusDiscount decimal(3,2),
constraint pk_CampusID primary key(CampusID)
);

create table Position
(PositionID number,
Position varchar2(25),
YeartlyMembershipFee DECIMAL(6,2),
constraint pk_PositionID primary key(PositionID)
);

create table Members
(MemberID number,
LastName varchar2(15),
FirstName varchar2(15),
CampusAddress varchar2(30),
CampusPhone varchar2(15),
CampusID number,
PositionID number,
ContractDuration number,
CONSTRAINT pk_MemberID primary key(MemberID),
CONSTRAINT FK_CampusID FOREIGN KEY (CampusID) REFERENCES Campus(CampusID),
CONSTRAINT FK_Position FOREIGN KEY (PositionID) REFERENCES Position(PositionID)
);

create table Prices
(FoodItemTypeID number,
MealType VARCHAR2(20),
MealPrice DECIMAL(4,2),
CONSTRAINT pk_FoodItemTypeID primary key(FoodItemTypeID)
);

ALTER TABLE Campus
MODIFY Phone VARCHAR2(15);

ALTER TABLE Position
MODIFY YeartlyMembershipFee DECIMAL(6,2);

INSERT INTO Campus VALUES ('1','IUPUI','425 University Blvd.','Indianapolis', 'IN','46202', '317-274-4591',.08);																	
INSERT INTO Campus VALUES ('2','Indiana University','107 S. Indiana Ave.','Bloomington','IN','47405','812-855-4848',.07);
INSERT INTO Campus VALUES ('3','Purdue University','475 Stadium Mall Drive','West Lafayette', 'IN','47907', '765-494-1776',.06); 

INSERT INTO Position VALUES ('1','Lecturer', 1050.50);
INSERT INTO Position VALUES ('2','Associate Professor', 900.50);
INSERT INTO Position VALUES ('3','Assistant Professor', 875.50);
INSERT INTO Position VALUES ('4','Professor', 700.75);
INSERT INTO Position VALUES ('5','Full Professor', 500.50);

INSERT INTO Members VALUES ('1','Ellen','Monk','009 Purnell', '812-123-1234', '2', '5', 12);
INSERT INTO Members VALUES ('2','Joe','Brady','008 Statford Hall', '765-234-2345', '3', '2', 10);
INSERT INTO Members VALUES ('3','Dave','Davidson','007 Purnell', '812-345-3456', '2', '3', 10);
INSERT INTO Members VALUES ('4','Sebastian','Cole','210 Rutherford Hall', '765-234-2345', '3', '5', 10);
INSERT INTO Members VALUES ('5','Michael','Doo','66C Peobody', '812-548-8956', '2', '1', 10);
INSERT INTO Members VALUES ('6','Jerome','Clark','SL 220', '317-274-9766', '1', '1', 12);
INSERT INTO Members VALUES ('7','Bob','House','ET 329', '317-278-9098', '1', '4', 10);
INSERT INTO Members VALUES ('8','Bridget','Stanley','SI 234', '317-274-5678', '1', '1', 12);
INSERT INTO Members VALUES ('9','Bradley','Wilson','334 Statford Hall', '765-258-2567', '3', '2', 10);

INSERT INTO Prices VALUES ('1','Beer/Wine', 5.50);
INSERT INTO Prices VALUES ('2','Dessert', 2.75);
INSERT INTO Prices VALUES ('3','Dinner', 15.50);
INSERT INTO Prices VALUES ('4','Soft Drink', 2.50);
INSERT INTO Prices VALUES ('5','Lunch', 7.25);

INSERT INTO Prices VALUES ('6','Brunch', 10.75);

UPDATE Prices
SET MealPrice = 20.50
WHERE MealType = 'Dinner';

DELETE FROM Prices
WHERE MealType = 'Dessert';

SELECT CampusName FROM Campus
WHERE City = 'Indianapolis';

SELECT * FROM Prices
WHERE MealPrice BETWEEN 10 AND 20;

-- give this the same range as above--
SELECT * FROM Prices
WHERE MealPrice > 10 AND MealPrice < 20;

SELECT SUM(MealPrice) AS MealPriceTotal,AVG(MealPrice) AS MealPriceAVG
FROM Prices;

ALTER TABLE Prices
ADD Healthy VARCHAR2(10);

UPDATE Prices
SET Healthy = 'unhealthy';

UPDATE Prices
SET Healthy = 'Healthy'
WHERE MealType = 'Lunch'; 

UPDATE Prices
SET Healthy = 'Healthy'
WHERE MealType = 'Dinner';

-- Members first and last name --
-- CampusName--
-- YeartlyMembershipFee / 12 alias--
-- display in descending order -- 
-- then display ascending order by lastname -- 

SELECT Members.firstName, Members.lastName, Campus.CampusName
, ROUND((Position.YeartlyMembershipFee / 12),2) as Monthly_Dues 
FROM Members
JOIN Campus ON Members.CampusID = Campus.CampusID
JOIN Position ON Members.PositionID = Position.PositionID
ORDER BY Campus.CampusName DESC;

--Joining table without using JOIN Command --
SELECT firstName, lastName, CampusName
, ROUND((YeartlyMembershipFee / 12),2) as Monthly_Dues 
FROM Members, Campus, Position
WHERE Members.CampusID = Campus.CampusID
AND Members.PositionID = Position.PositionID
ORDER BY Campus.CampusName DESC;

SELECT Members.firstName, Members.lastName, Campus.CampusName
, ROUND((Position.YeartlyMembershipFee / 12),2) as Monthly_Dues 
FROM Members
JOIN Campus ON Members.CampusID = Campus.CampusID
JOIN Position ON Members.PositionID = Position.PositionID
ORDER BY Members.lastName ASC;

