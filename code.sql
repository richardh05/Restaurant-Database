DROP TABLE IF EXISTS RestaurantOrder
DROP TABLE IF EXISTS DeliveryOrder
DROP TABLE IF EXISTS OrderedItem
DROP TABLE IF EXISTS CompleteOrder
DROP TABLE IF EXISTS ItemDiscount
DROP TABLE IF EXISTS DiscountEvent
DROP TABLE IF EXISTS MenuItem
DROP TABLE IF EXISTS Category
DROP TABLE IF EXISTS Restaurant
DROP TABLE IF EXISTS Customer
DROP TABLE IF EXISTS Address


CREATE TABLE Address(
	AddressID int NOT NULL PRIMARY KEY,
	StreetNumber smallint NOT NULL,
	StreetName varchar(95) NOT NULL,
	Town varchar(35),
	County varchar(35),
	Country varchar(70)
)

CREATE TABLE Customer(
	CustomerID int NOT NULL PRIMARY KEY,
	AddressID int NOT NULL FOREIGN KEY REFERENCES Address(AddressID),
	Forename varchar(25) NOT NULL,
	Surname varchar(25),
	email varchar(40),
	Phone char(11),
	DateOfBirth date
)

CREATE TABLE Restaurant(
	RestaurantID int NOT NULL PRIMARY KEY,
	AddressID int NOT NULL FOREIGN KEY REFERENCES Address(AddressID),
	RestaurantName varchar(50) NOT NULL,
	RestaurantDescription varchar(300),
	email varchar(40),
	Phone char(11)
)

CREATE TABLE Category(
	CategoryID int NOT NULL PRIMARY KEY,
	CategoryName varchar(40) NOT NULL,
	CategoryDescription varchar(300),
	Course varchar(40)
)

CREATE TABLE MenuItem(
	MenuItemID int NOT NULL PRIMARY KEY,
	RestaurantID int NOT NULL FOREIGN KEY REFERENCES Restaurant(RestaurantID),
	CategoryID int NOT NULL FOREIGN KEY REFERENCES Category(CategoryID),
	ItemName varchar(40) NOT NULL,
	ItemDescription varchar(300),
	Price float,
	Vegetarian bit,
	Vegan bit,
	NutFree bit,
	GlutenFree bit,
	DairyFree bit
)

CREATE TABLE DiscountEvent(
	DiscountEventID int NOT NULL PRIMARY KEY,
	EventName varchar(50) NOT NULL,
	EventDescription varchar(300),
	EventStartDate date NOT NULL,
	EventEndDate date NOT NULL
)

CREATE TABLE ItemDiscount(
	DiscountEventID int NOT NULL FOREIGN KEY REFERENCES DiscountEvent(DiscountEventID),
	MenuItemID int NOT NULL FOREIGN KEY REFERENCES MenuItem(MenuItemID),
	EventItemPrice float NOT NULL
)

CREATE TABLE CompleteOrder(
	CompleteOrderID int NOT NULL PRIMARY KEY,
	RestaurantID int NOT NULL FOREIGN KEY REFERENCES Restaurant(RestaurantID)
)

CREATE TABLE OrderedItem(
	CompleteOrderID int NOT NULL FOREIGN KEY REFERENCES CompleteOrder(CompleteOrderID),
	MenuItemID int NOT NULL FOREIGN KEY REFERENCES MenuItem(MenuItemID),
	Adjustments varchar(80)
)

CREATE TABLE DeliveryOrder(
	CompleteOrderID int NOT NULL FOREIGN KEY REFERENCES CompleteOrder(CompleteOrderID),
	CustomerID int NOT NULL FOREIGN KEY REFERENCES Customer(CustomerID),
	DeliveryCost float NOT NULL
)

CREATE TABLE RestaurantOrder(
	CompleteOrderID int NOT NULL FOREIGN KEY REFERENCES CompleteOrder(CompleteOrderID),
	TableNo smallint NOT NULL
)

INSERT INTO Address (AddressID, StreetNumber, StreetName, Town, County, Country)
VALUES(1,10,'Fruit Street','Durian','Cheshire','United Kingdom'),
(2,45,'Brie Avenue','Stilton','Merseyside','United Kingdom'),
(3,626,'Legume Road','Brussels','Brussels','Belgium'),
(4,29,'Acadia Road','Nutty Town',NULL,NULL),
(5,52,'Festive Road','London','London','United Kingdom'),
(6,36,'Magic Garden','Magic Roundabout',Null,Null)

INSERT INTO Customer (CustomerID,AddressID,Forename,Surname,email,Phone,DateOfBirth)
VALUES (1,4,'Eric','Wimp','BananaMad@Dandy.com','07845263374','11-02-2005'),
(2,5,'William','Benn','MrBenn@fancydress.com','07326629551','02-03-2005'),
(3,6,'Dougal','Dog','Dougal@Magic.com', '05638384938','04-05-1997')

INSERT INTO Restaurant(RestaurantID,AddressID,RestaurantName,RestaurantDescription,email,Phone)
VALUES(1,1,'Tropical Island Desserts','Specialises is fruity desserts and drinks.','Tropical.Islands@DragonFruit.com','12443542234'),
(2,2,'Cheesy Cheeseria','The cheesiest eating place is town.','Cheesy.Cheese@Rockfort.co.uk','01513390232'),
(3,3,'Carrot Top','Specialist vegetarian restaurant for all your veggie needs.',NULL,NULL)

INSERT INTO Category(CategoryID,CategoryName,CategoryDescription,Course)
VALUES(1,'Vegetarian/Vegan Dessert','Desserts that can be enjoyed by vegan and vegetarian customers.','Dessert'),
(2,'Salad','Light, healthy main meals that can be enjoyed by vegan customers','Main Meal'),
(3,'Skewers','A selection of food items held together by a stick','Starter'),
(4,'Pizza','A classic Italian meal to share with others.','Main Meal'),
(5,'Lasagne','An type of Italian dish made of layered cheese, ground meat and vegetables','Main Meal'),
(6,'Cheese','Enjoy our whimsical selection of fine cheeses','Dessert'),
(7,'Raw Food Selection','Meat that has not been cooked.','Main Meal'),
(8,'Burger','A slab of meat(or veggie meat) and two buns. What more could you want?','Main Meal'),
(9,'Chefs Specials','Chef approved.','Main Meal')


INSERT INTO MenuItem(MenuItemID,RestaurantID,CategoryID,ItemName,ItemDescription,Price, Vegetarian, Vegan, NutFree, GlutenFree, DairyFree)
VALUES(1,1,1,'Banana Special','3 banana dessert covered in vanilla ice cream.',2.99,1,1,1,1,0),
(2,1,2,'Three fruit salad','A fruit salad containing kiwis, bananas and melons.',4.99,1,1,1,1,1),
(3,1,3,'Fruit and Cheese Skewer','Strawberries and grapes interleaved with cheddar cheese on a stick.',1.99,1,0,1,1,0),
(4,2,4,'Cheesey Margherita Pizza','Three cheese pizza with a tangy tomato sauce.',5.99,1,0,1,0,0),
(5,2,5,'Mozzarella Lasagne','Super stretchy mozzarella lasagne.',6.99,0,0,1,0,0),
(6,2,6,'Cheese board','Selection of cheeses for the cheesiest cheese enthusiasts.',3.99,1,0,1,1,0),
(7,3,7,'Rabbit food special','Medley of raw carrots, cabbage, and turnips.',4.99,1,1,1,1,1),
(8,3,8,'Herbivorous Burger','Plant based meat alternative with lettuce, cheese, and chunky chips.',5.99,1,1,1,0,0),
(9,3,9,'Courgette frittata','Courgette, spring onions and goat’s cheese.',NULL,1,0,1,0,0)

INSERT INTO DiscountEvent(DiscountEventID,EventName,EventDescription,EventStartDate,EventEndDate)
VALUES(1,'Christmas Dessert Discounts','Discounts on all dessert items till the new year!','2023-12-18','2024-01-01'),
(2,'Cheese Wendesday','Cheese for all on Wednesdays.', '2023-12-20', '2023-12-20'),
(3,'Monday rabbit food buffet','All rabbit food must go!','2023-12-18','2023-12-18')

INSERT INTO ItemDiscount(DiscountEventID, MenuItemID, EventItemPrice)
VALUES(1,1,1.99),
(1,6,1.99),
(2,4,4.99),
(2,5,5.99),
(2,6,2.99),
(3,7,2.99)

INSERT INTO CompleteOrder(CompleteOrderID,RestaurantID)
VALUES(1,1),
(2,2),
(3,3),
(4,1),
(5,2),
(6,3)

INSERT INTO OrderedItem(CompleteOrderID,MenuItemID,Adjustments)
VALUES(1,1,NULL),
(2,4,NULL),
(2,6,NULL),
(3,7,NULL),
(3,9,NULL),
(4,2,NULL),
(5,4,NULL),
(5,5,NULL),
(6,8,'No Cheese')

INSERT INTO DeliveryOrder(CompleteOrderID,CustomerID,DeliveryCost)
VALUES(1,1,2.00),
(2,2,1.00),
(3,3,7.00)

INSERT INTO RestaurantOrder(CompleteOrderID,TableNo)
VALUES(4,10),
(5,21),
(6,3)