create database Academy
go
use Academy
go

CREATE TABLE [Departments] (
  [Id] INT PRIMARY KEY IDENTITY,
  [Financing] MONEY NOT NULL DEFAULT 0,
  [Name] NVARCHAR(100) NOT NULL UNIQUE,
);

CREATE TABLE Faculties (
    [Id] INT PRIMARY KEY IDENTITY,
    [Dean] NVARCHAR(MAX) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL UNIQUE,
);

CREATE TABLE Groups (
    [Id] INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(10) NOT NULL UNIQUE,
    [Rating] INT NOT NULL,
    [Year] INT NOT NULL CHECK (Year >= 1 AND Year <= 5),

	constraint chk_Rating CHECK (Rating >= 0 AND Rating <= 5),
	constraint chk_Year CHECK (Year >= 0 AND Year <= 5),
);

CREATE TABLE Teachers (
    [Id] INT PRIMARY KEY IDENTITY,
    [EmploymentDate] DATE NOT NULL,
    [IsAssistant] BIT NOT NULL DEFAULT 0,
    [IsProfessor] BIT NOT NULL DEFAULT 0,
    [Name] NVARCHAR(MAX) NOT NULL,
    [Position] NVARCHAR(MAX) NOT NULL,
    [Premium] MONEY NOT NULL DEFAULT 0,
    [Salary] MONEY NOT NULL,
    [Surname] NVARCHAR(MAX) NOT NULL,

	constraint chk_EmploymentDate CHECK (EmploymentDate >= '1990-01-01'),
	constraint chk_Premium CHECK (Premium >= 0),
	constraint chk_Salary CHECK (Salary > 0),
);

INSERT INTO Departments (Financing, Name) VALUES 
(100000, 'Finance Department'),
(150000, 'Computer Science Department'),
(120000, 'Mathematics Department');

INSERT INTO Faculties (Dean, Name) VALUES 
('John Doe', 'Engineering Faculty'),
('Jane Smith', 'Science Faculty'),
('Bob Johnson', 'Business Faculty');

INSERT INTO Groups (Name, Rating, Year) VALUES 
('Group A', 4, 2),
('Group B', 5, 3),
('Group C', 3, 1);

INSERT INTO Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname) VALUES 
('2020-01-15', 1, 0, 'Alice', 'Assistant Professor', 5000, 60000, 'Johnson'),
('2018-05-20', 0, 1, 'Bob', 'Professor', 8000, 90000, 'Smith'),
('2019-09-10', 1, 0, 'Charlie', 'Assistant Professor', 4500, 55000, 'Doe');


--1. Вивести таблицю кафедр, але розташувати її поля у зворотному порядку.
SELECT [Name], [Financing], [Id] FROM [Departments];

--2. Вивести назви груп та їх рейтинги, використовуючи, як назви полів, що виводяться, “Group Name” та “Group Rating” відповідно.
SELECT [Name] AS 'Group Name', [Rating] AS 'Group Rating' FROM [Groups];

--3. Вивести для викладачів їхнє прізвище, відсоток ставки по відношенню до надбавки та відсоток ставки по відношенню до зарплати (сума ставки та надбавки).
SELECT [Surname], ([Premium] / [Salary]) * 100 AS 'Premium Percentage', (([Salary] + [Premium]) / [Salary]) * 100 AS 'Total Salary Percentage' FROM [Teachers];

--4. Вивести таблицю факультетів у вигляді одного поля у такому форматі: “The dean of faculty [faculty] is [dean].”
SELECT 'The dean of faculty ' + [Name] + ' is ' + [Dean] AS 'Faculty Information' FROM [Faculties];

--5. Вивести прізвища викладачів, які є професорами та ставка яких перевищує 1050.
SELECT [Surname] FROM [Teachers] WHERE [IsProfessor] = 1 AND [Salary] > 1050;

--6. Вивести назви кафедр, фонд фінансування яких менший за 11000 або більше 25000.
SELECT [Name] FROM [Departments] WHERE [Financing] < 11000 OR [Financing] > 25000;

--7. Вивести назви факультетів, окрім факультету “Computer Science”.
SELECT [Name] FROM [Faculties] WHERE [Name] <> 'Computer Science';

--8. Вивести прізвища та посади викладачів, які не є професорами.
SELECT [Surname], [Position] FROM [Teachers] WHERE [IsProfessor] = 0;

--9. Вивести прізвища, посади, ставки та надбавки асистентів, у яких надбавка у діапазоні від 160 до 550.
SELECT [Surname], [Position], [Salary], [Premium] FROM [Teachers] WHERE [IsAssistant] = 1 AND [Premium] BETWEEN 160 AND 550;

--10. Вивести прізвища та ставки асистентів.
SELECT [Surname], [Salary] FROM [Teachers] WHERE [IsAssistant] = 1;

--11. Вивести прізвища та посади викладачів, які були прийняті на роботу до 01.01.2000.
SELECT [Surname], [Position] FROM [Teachers] WHERE [EmploymentDate] < '2000-01-01';

--12.Вивести назви кафедр, які в алфавітному порядку розміщуються до кафедри “Software Development”. Поле, що виводиться повинно мати назву “Name of Department”.
SELECT [Name] AS 'Name of Department' FROM [Departments] WHERE [Name] < 'Software Development' ORDER BY [Name];

--13. Вивести прізвища асистентів, які мають зарплату (сума ставки та надбавки) не більше 1200.
SELECT [Surname] FROM [Teachers] WHERE [IsAssistant] = 1 AND ([Salary] + [Premium]) <= 1200;

--14. Вивести назви груп 5-го курсу, які мають рейтинг у діапазоні від 2 до 4.
SELECT [Name] FROM [Groups] WHERE [Year] = 5 AND [Rating] BETWEEN 2 AND 4;

--15. Вивести прізвища асистентів зі ставкою менше 550 або надбавкою менше 200
SELECT [Surname] FROM [Teachers] WHERE [IsAssistant] = 1 AND ([Salary] < 550 OR [Premium] < 200);




