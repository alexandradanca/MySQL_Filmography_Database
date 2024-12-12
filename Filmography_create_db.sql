DROP DATABASE IF EXISTS `filmography`;
CREATE DATABASE `filmography`;
USE `filmography`;

DROP TABLE IF EXISTS REVENUES;
DROP TABLE IF EXISTS AWARDS_OBTAINED;
DROP TABLE IF EXISTS AWARD_TYPES;
DROP TABLE IF EXISTS CAST;
DROP TABLE IF EXISTS MOVIES;
DROP TABLE IF EXISTS DIRECTORS;



CREATE TABLE DIRECTORS (
    DirectorID INT PRIMARY KEY,
    `Name` VARCHAR(30),
    Age INT,
    Country VARCHAR(30)
);

CREATE TABLE MOVIES (
    MovieID INT PRIMARY KEY,
    MovieName VARCHAR(50) NOT NULL,
    ReleaseYear INT NOT NULL,
    DirectorID INT NOT NULL,
    Country VARCHAR(20),
    BudgetUSD DECIMAL(60, 2) NOT NULL,
    FOREIGN KEY (DirectorID) REFERENCES DIRECTORS (DirectorID)
);

CREATE TABLE CAST (
    MovieID INT,
    `Role` VARCHAR(20),
    ActorID INT NOT NULL,
    SalaryUSD DECIMAL(10, 2),
    PRIMARY KEY (MovieID, Role),
    FOREIGN KEY (MovieID) REFERENCES MOVIES (MovieID)
);

CREATE TABLE AWARD_TYPES (
    AwardID INT PRIMARY KEY,
    AwardName VARCHAR(40)  NOT NULL,
    Location VARCHAR(20) NOT NULL,
    Country VARCHAR(20) NOT NULL
);

CREATE TABLE AWARDS_OBTAINED (
    AwardObtainedID INT PRIMARY KEY,
    AwardID INT NOT NULL,
    YearAwarded INT NOT NULL,
    MovieID INT NOT NULL,
    FOREIGN KEY (AwardID) REFERENCES AWARD_TYPES (AwardID),
    FOREIGN KEY (MovieID) REFERENCES MOVIES (MovieID)
);

CREATE TABLE REVENUES (
    MovieID INT NOT NULL,
    Country VARCHAR(20),
    Year INT NOT NULL,
    RevenueUSD DECIMAL(30, 2) NOT NULL,
    PRIMARY KEY (MovieID, Country, Year),
    FOREIGN KEY (MovieID) REFERENCES MOVIES (MovieID)
);

INSERT INTO DIRECTORS VALUES
(1, 'Steven Spielberg', 1946, 'USA'),
(2, 'Jon Bokenkamp', 1974, 'USA'),
(3, 'James Cameron', 1954, 'Canada'),
(4, 'Robert Zemeckis', 1951, 'USA'),
(5, 'David Crane', 1965, 'USA'),
(6, 'Francis Ford Coppola', 1939, 'USA'),
(7, 'Len Wiseman', 1972, 'USA'),
(8, 'Jeremy Silman', 2000, 'United Kingdom'),
(9, 'Christopher Nolan', 1970, 'United Kingdom'),
(10, 'Carlos Sedes', 1960, 'Spain'),
(11, 'John Fusco', 1957, 'USA'),
(12, 'Roberto Aguirre-Sacasa', 1973, 'USA'),
(13, 'Nikki Ford', 1973, 'Canada'),
(14, 'Bong Joon-ho', 1969, 'South Korea');


INSERT INTO MOVIES VALUES 
(1001, 'Forrest Gump', 1994, 4, 'USA', 8000000.00),
(1002, 'Lucifer', 2019, 7, 'France', 780000.00),
(1003, 'Merlin', 2012, 8, 'France', 3990000.00),
(1004, 'Black List', 2016, 2, 'UK', 8900000.00),
(1005, 'Riverdale', 2008, 12, 'UK', 2200000.00),
(1006, 'Hotel Grand', 2013, 10, 'Spain', 6789500.00),
(1007, 'Marco Polo', 2012, 11, 'USA', 1990000.00),
(1008, 'Friends', 2002, 5, 'Germany', 1230000.00),
(1009, 'Anne', 2019, 13, 'Bulgaria', 7900000.00),
(1010, 'Focus', 2015, 8, 'Russia', 3490000.00),
(1011, 'Jaws', 1975, 1, 'USA', 7000000.00),
(1012, 'Inception', 2010, 9, 'USA', 160000000.00),
(1013, 'Parasite', 2019, 14, 'South Korea', 11400000.00),
(1014, 'Titanic', 1997, 3, 'USA', 200000000.00),
(1015, 'The Godfather', 1972, 6, 'USA', 6000000.00),
(1016, 'The Dark Knight', 2008, 9, 'USA', 185000000.00), 
(1017, 'Dunkirk', 2017, 9, 'UK', 100000000.00),
(1018, 'Interstellar', 2014, 9, 'USA', 165000000.00),
(1019, 'Avatar', 2009, 3, 'USA', 237000000.00),
(1020, 'Aliens', 1986, 3, 'USA', 18500000.00),
(1021, 'The Godfather: Part II', 1974, 6, 'USA', 13000000.00),
(1022, 'Apocalypse Now', 1979, 6, 'USA', 31000000.00);


INSERT INTO CAST VALUES
(1001, 'Principal', 18, 500000.00),
(1002, 'Principal', 12, 550000.00),
(1003, 'Secondary', 3, 450000.00),
(1006, 'Principal', 19, 900000.00),
(1007, 'Principal', 8, 456000.00),
(1008, 'Secondary', 4, 200000.00),
(1009, 'Secondary', 54, 123000.00),
(1010, 'Principal', 10, 880000.00),
(1011, 'Principal', 22, 1000000.00),
(1012, 'Secondary', 30, 800000.00),
(1013, 'Principal', 50, 1200000.00),
(1014, 'Principal', 15, 1500000.00),
(1015, 'Secondary', 12, 700000.00),
(1015, 'Principal', 22, 1300000.00),
(1014, 'Secondary', 30, 900000.00),
(1016, 'Principal', 12, 2000000.00),
(1017, 'Principal', 22, 1500000.00),
(1018, 'Principal', 30, 3000000.00),
(1019, 'Principal', 45, 4000000.00),
(1020, 'Secondary', 50, 1200000.00),
(1021, 'Principal', 22, 2500000.00),
(1022, 'Principal', 30, 2000000.00);

INSERT INTO AWARD_TYPES VALUES
(123, 'Oscar Direction', 'Hollywood', 'USA'),
(124, 'Oscar Best Film', 'Rome', 'Italy'),
(125, 'Oscar Editing', 'Hollywood', 'USA'),
(126, 'Oscar Makeup', 'Hollywood', 'USA'),
(127, 'Oscar Sound', 'Bucharest', 'Romania'),
(128, 'Oscar Direction', 'London', 'UK'),
(129, 'Oscar Animation Film', 'Dublin', 'Ireland'),
(136, 'Oscar Best Picture', 'Los Angeles', 'USA'),
(137, 'BAFTA Best Film', 'London', 'UK'),
(138, 'Cannes Best Director', 'Cannes', 'France'),
(139, 'Golden Globe Best Drama', 'Beverly Hills', 'USA'),
(140, 'Critics Choice Best Picture', 'Los Angeles', 'USA');

INSERT INTO AWARDS_OBTAINED VALUES
(11111, 123, 1994, 1001),
(11112, 124, 1997, 1001),
(11113, 125, 1994, 1003),
(11114, 127, 1995, 1004),
(11115, 128, 1996, 1005),
(11116, 129, 1995, 1005),
(11117, 127, 1999, 1006),
(11123, 136, 1998, 1014),
(11124, 137, 2010, 1012),
(11125, 138, 2019, 1013),
(11126, 139, 1976, 1011),
(11127, 140, 1973, 1015),
(11128, 136, 2009, 1019),
(11129, 137, 2014, 1018), 
(11130, 138, 2017, 1017),
(11131, 139, 1975, 1021),
(11132, 140, 1979, 1022);

INSERT INTO REVENUES VALUES
(1001, 'USA', 1994, 20000000.00),
(1001, 'USA', 1995, 50000000.00),
(1004, 'UK', 1997, 40000000.00),
(1005, 'UK', 1998, 67500000.00),
(1006, 'Spain', 1999, 20700000.00),
(1007, 'USA', 2000, 29000000.00),
(1008, 'Germany', 2001, 20670000.00),
(1009, 'Bulgaria', 2002, 98700000.00),
(1010, 'Russia', 2003, 25400000.00),
(1010, 'France', 2016, 20000000.00),
(1011, 'USA', 1975, 470000000.00),
(1012, 'USA', 2010, 825532764.00),
(1013, 'South Korea', 2019, 53500000.00),
(1014, 'USA', 1997, 2187463944.00),
(1015, 'USA', 1972, 246120974.00),
(1013, 'USA', 2020, 25700000.00),
(1014, 'UK', 1998, 100000000.00),
(1016, 'USA', 2008, 1004558444.00),
(1017, 'UK', 2017, 526940665.00),
(1018, 'USA', 2014, 677471339.00),
(1019, 'USA', 2009, 2847246203.00),
(1020, 'USA', 1986, 183316455.00),
(1021, 'USA', 1974, 477545974.00),
(1022, 'USA', 1979, 150000000.00);

