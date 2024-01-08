CREATE DATABASE URGAYS;

USE URGAYS;

CREATE TABLE Gamer (
    ID INT AUTO_INCREMENT PRIMARY KEY,
	Token VARCHAR(255),
    Username VARCHAR(255),
    Password VARCHAR(255),
    Gender VARCHAR(255),
    Birthday DATE,
    Email VARCHAR(255),
    Phone VARCHAR(255),
    Address VARCHAR(255),
    Image VARCHAR(255)
);

CREATE TABLE Company (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(255),
    Address VARCHAR(255),
    Image VARCHAR(255)
);

CREATE TABLE Discount (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ExpirationDate DATE,
    Percent INT
);

CREATE TABLE Game (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Image VARCHAR(255),
    SystemRequirement VARCHAR(255),
    Price INT,
    ReleaseDate DATE,
    Description TEXT,
    CompanyID INT,
    DiscountID INT,
    FOREIGN KEY (CompanyID) REFERENCES Company(ID),
    FOREIGN KEY (DiscountID) REFERENCES Discount(ID)
);

CREATE TABLE Comment (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    PostDate DATE,
    Recommend BOOL,
    Likes INT,
    Dislikes INT,
    Content TEXT,
    GameID INT,
    GamerID INT,
    FOREIGN KEY (GameID) REFERENCES Game(ID),
    FOREIGN KEY (GamerID) REFERENCES Gamer(ID)
);

CREATE TABLE GamerDiscount (
    GamerID INT,
    DiscountID INT,
    PRIMARY KEY (GamerID, DiscountID),
    FOREIGN KEY (GamerID) REFERENCES Gamer(ID),
    FOREIGN KEY (DiscountID) REFERENCES Discount(ID)
);

CREATE TABLE Orders (
    GameID INT,
    GamerID INT,
    OrderDate DATE,
    PRIMARY KEY (GameID, GamerID),
    FOREIGN KEY (GameID) REFERENCES Game(ID),
    FOREIGN KEY (GamerID) REFERENCES Gamer(ID)
);

CREATE TABLE Genre (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE GameGenre (
    GameID INT,
    GenreID INT,
    PRIMARY KEY (GameID, GenreID),
    FOREIGN KEY (GameID) REFERENCES Game(ID),
    FOREIGN KEY (GenreID) REFERENCES Genre(ID)
);

CREATE TABLE Library (
    GamerID INT,
    GameID INT,
    PRIMARY KEY (GamerID, GameID),
    FOREIGN KEY (GamerID) REFERENCES Gamer(ID),
    FOREIGN KEY (GameID) REFERENCES Game(ID)
);

CREATE TABLE Cart (
    GamerID INT,
    GameID INT,
    PRIMARY KEY (GamerID, GameID),
    FOREIGN KEY (GamerID) REFERENCES Gamer(ID),
    FOREIGN KEY (GameID) REFERENCES Game(ID)
);
