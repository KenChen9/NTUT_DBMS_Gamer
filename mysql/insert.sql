INSERT INTO Gamer (Token, Username, Password, Gender, Birthday, Email, Phone, Address, Image)
VALUES
(null, 'Player1', 'password123', 'Male', '1990-01-15', 'player1@example.com', '123-456-7890', '123 Main St, Cityville', 'player1.jpg'),
(null, 'GamerGirl', 'gaming456', 'Female', '1985-08-22', 'gamergirl@gmail.com', '987-654-3210', '456 Oak St, Gametown', 'gamergirl.jpg');

INSERT INTO Company (Name, Email, Phone, Address, Image)
VALUES
('GameCo', 'info@gameco.com', '555-1234', '789 Park Ave, Game City', 'gameco_logo.jpg'),
('Epic Games', 'info@epicgames.com', '555-5678', '456 Tech St, Digital City', 'epic_logo.jpg');

INSERT INTO Discount (ExpirationDate, Percent)
VALUES
('2024-12-31', 10),
('2024-10-15', 20);

INSERT INTO Game (Name, Image, SystemRequirement, Price, ReleaseDate, Description, CompanyID, DiscountID)
VALUES
('Awesome Game', 'awesome_game.jpg', 'Minimum requirements: Windows 10, 8GB RAM, GTX 1060', 50, '2024-01-01', 'An amazing gaming experience.', 1, 1),
('Epic Adventure', 'epic_adventure.jpg', 'Minimum requirements: macOS Catalina, 16GB RAM, RX 5700', 60, '2024-02-15', 'Embark on an epic journey.', 2, 2);

INSERT INTO Comment (PostDate, Recommend, Likes, Dislikes, Content, GameID, GamerID)
VALUES
('2024-01-05', true, 15, 3, 'This game is fantastic!', 1, 1),
('2024-02-20', false, 8, 1, 'Not worth the money.', 2, 2);

INSERT INTO GamerDiscount (GamerID, DiscountID)
VALUES
(1, 1),
(2, 2);

INSERT INTO Orders (GameID, GamerID, OrderDate)
VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-02-25');

INSERT INTO Genre (Name)
VALUES
('Action'),
('Adventure');

INSERT INTO GameGenre (GameID, GenreID)
VALUES
(1, 1),
(2, 2);

INSERT INTO Library (GamerID, GameID)
VALUES
(1, 1),
(2, 2);

INSERT INTO Cart (GamerID, GameID)
VALUES
(1, 2),
(2, 1);
