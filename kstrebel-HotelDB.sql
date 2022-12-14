DROP DATABASE IF EXISTS HOTEL_SCHEMA;

CREATE DATABASE HOTEL_SCHEMA;

USE HOTEL_SCHEMA;

CREATE TABLE ROOM_TYPE(
    UniqueID INT PRIMARY KEY AUTO_INCREMENT,
    RoomName VARCHAR(10) NOT NULL,
    KitchenType ENUM("full", "microwave and refrigerator", "microwave", "refrigerator") NOT NULL,
    MaxPeople INT NOT NULL,
    BasePrice DECIMAL(5, 2) NOT NULL,
    BaseAdults INT NOT NULL,
    AddAdultPrice DECIMAL(4, 2)
);

CREATE TABLE ROOM_NUMBER(
    RoomNumber INT PRIMARY KEY AUTO_INCREMENT,
    RoomTypeID INT NOT NULL,
    ADACompliant BOOLEAN NOT NULL,
    Jacuzzi BOOLEAN NOT NULL,
    CONSTRAINT FK_RoomType FOREIGN KEY (RoomTypeID) REFERENCES ROOM_TYPE(UniqueID)
);

CREATE TABLE GUEST(
    UniqueID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Address VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(30),
    Zip VARCHAR(5),
    Phone VARCHAR(14)
);

CREATE TABLE RESERVATION(
    UniqueID INT PRIMARY KEY AUTO_INCREMENT,
    RoomNumber INT NOT NULL,
    GuestID INT NOT NULL,
    Adults INT NOT NULL,
    Children INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    TotalCost DECIMAL(7, 2) NOT NULL,
    CONSTRAINT FK_RoomNumber FOREIGN KEY (RoomNumber) REFERENCES ROOM_NUMBER(RoomNumber),
    CONSTRAINT FK_GuestID FOREIGN KEY (GuestID) REFERENCES GUEST(UniqueID)
);