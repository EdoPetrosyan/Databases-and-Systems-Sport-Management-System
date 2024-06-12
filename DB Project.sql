drop schema if exists sport_management_system;
CREATE SCHEMA sport_management_system;
use sport_management_system;


DROP TABLE IF EXISTS admins;
CREATE TABLE admins (
admin_id int(20) PRIMARY KEY,
username varchar(20) NOT NULL,
pass_word varchar(20) NOT NULL,
secure_key varchar(50) NOT NULL,
first_name varchar(50)NOT NULL ,
last_name varchar(50) NOT NULL,
email varchar(50) NOT NULL,
dob varchar(30) NOT NULL
);
CREATE INDEX idx_username ON admins(username) USING BTREE;


DROP TABLE IF EXISTS event;
CREATE TABLE event (
event_id int(20) PRIMARY KEY,
event_name varchar(30) NOT NULL,
address varchar(20),
event_date date NOT NULL
);
CREATE INDEX idx_event_name ON event(event_name) USING BTREE;



DROP TABLE IF EXISTS supervise_events;
CREATE TABLE supervise_events (
  admin_id INT,
  event_id INT,
  FOREIGN KEY (admin_id) REFERENCES admins(admin_id),
  FOREIGN KEY (event_id) REFERENCES event(event_id),
  PRIMARY KEY (admin_id, event_id)
);


DROP TABLE IF EXISTS sport;
CREATE TABLE sport (
    sport_id INT PRIMARY KEY,
    sport_name varchar(50) NOT NULL,
    sp_description varchar(200)
);

CREATE INDEX idx_sport_name ON sport(sport_name) USING BTREE;


DROP TABLE IF EXISTS sport_events;
CREATE TABLE sport_events (
event_id int,
sport_id int,
FOREIGN KEY (event_id) REFERENCES event(event_id),
FOREIGN KEY (sport_id) REFERENCES sport(sport_id),
PRIMARY KEY (event_id, sport_id)
);


DROP TABLE IF EXISTS team;
CREATE TABLE team (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL,
    captain_id INT,
    team_stats VARCHAR(60),
    country varchar(20),
    city varchar(30),
    foundation_date varchar(30) NOT NULL
);
CREATE INDEX idx_team_name ON team(team_name) USING BTREE;



DROP TABLE IF EXISTS users;
CREATE TABLE users (
  user_id int PRIMARY KEY,
  username varchar(40) NOT NULL,
  pass_word varchar(40) NOT NULL,
  secure_key varchar(30) NOT NULL,
  first_name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL,
  gender varchar(8),
  country varchar(30),
  city varchar(30),
  email varchar(20) NOT NULL,
  dob varchar(10) NOT NULL,
  address varchar(40),
  phone varchar(20) NOT NULL,
  join_date varchar(10) NOT NULL,
  team_id int,
  admin_id int NOT NULL,
  UNIQUE INDEX email(email) USING BTREE,
  FOREIGN KEY (admin_id) REFERENCES admins(admin_id),
  FOREIGN KEY (team_id) REFERENCES team(team_id)
);

ALTER TABLE team
ADD FOREIGN KEY (captain_id) REFERENCES users(user_id);

DROP TABLE IF EXISTS user_participation;
CREATE TABLE user_participation (
event_id int,
user_id int,
FOREIGN KEY (event_id) REFERENCES event(event_id),
FOREIGN KEY (user_id) REFERENCES users(user_id),
PRIMARY KEY (event_id, user_id)
);
 


DROP TABLE IF EXISTS user_intsports;
CREATE TABLE user_intsports (
sport_id int,
user_id int,
FOREIGN KEY (sport_id) REFERENCES sport(sport_id),
FOREIGN KEY (user_id) REFERENCES users(user_id),
PRIMARY KEY(sport_id, user_id)
);



DROP TABLE IF EXISTS health_status;
CREATE TABLE health_status (
user_id int NOT NULl,
hid int NOT NULL,
calorie varchar(8),
height varchar(8),
weight varchar(8),
fat varchar(8),
health_issues varchar(100) NOT NULL,
PRIMARY KEY (hid, user_id) USING BTREE,
CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE NO ACTION
);


CREATE TABLE sport_plan (
pid varchar(8),
planName varchar(20) NOT NULL,
sp_description varchar(200) NOT NULL,
start_date date NOT NULL,
end_date date NOT NULL,
user_id int NOT NULL,
PRIMARY KEY (pid) USING BTREE,
FOREIGN KEY (user_id) REFERENCES users(user_id),
INDEX pid(pid) USING BTREE
);



INSERT INTO admins (admin_id, username, pass_word, secure_key, first_name, last_name, email, dob)
VALUES
  (1, 'admin1', 'pass_word1', 'key_1', 'John', 'Doe', 'johndoe@gmail.com', '2003-03-01'),
  (2, 'admin2', 'pass_word2', 'key_2', 'Jane', 'Smith', 'janesmith@gmail.com', '2003-04-15'),
  (3, 'admin3', 'pass_word3', 'key_3', 'Mike', 'Johnson', 'mikejohnson@gmail.com', '2002-02-10'),
  (4, 'admin4', 'pass_word4', 'key_4', 'Sarah', 'Brown', 'sarahbrown@gmail.com', '2002-02-18'),
  (5, 'admin5', 'pass_word5', 'key_5', 'Michael', 'Wilson', 'michaelwilson@gmail.com', '2003-04-05'),
  (6, 'admin6', 'pass_word6', 'key_6', 'Jessica', 'Roberts', 'jessicaroberts@gmail.com', '2002-02-12'),
  (7, 'admin7', 'pass_word7', 'key_7', 'Andrew', 'Lee', 'andrewlee@gmail.com', '2003-03-12'),
  (8, 'admin8', 'pass_word8', 'key_8', 'Olivia', 'Taylor', 'oliviataylor@gmail.com', '2004-04-25'),
  (9, 'admin9', 'pass_word9', 'key_9', 'Daniel', 'Anderson', 'danielanderson@gmail.com', '2004-03-10'),
  (10, 'admin10', 'pass_word10', 'key_10', 'Sophia', 'Martinez', 'sophiamartinez@gmail.com', '2001-12-15'),
  (11, 'admin11', 'pass_word11', 'key_11', 'Benjamin', 'Clark', 'benjaminclark@gmail.com', '2003-03-20'),
  (12, 'admin12', 'pass_word12', 'key_12', 'Emma', 'Garcia', 'emmagarcia@gmail.com', '2003-01-25'),
  (13, 'admin13', 'pass_word13', 'key_13', 'William', 'Lopez', 'williamlopez@gmail.com', '2004-01-05'),
  (14, 'admin14', 'pass_word14', 'key_14', 'Ava', 'Harris', 'avaharris@gmail.com', '2003-09-12'),
  (15, 'admin15', 'pass_word15', 'key_15', 'James', 'Miller', 'jamesmiller@gmail.com', '2004-02-19');
  
  
  select * 
  from admins;

INSERT INTO event (event_id, event_name, address, event_date)
VALUES
  (101, 'Volleyball', 'Mashtotsi Ave. 8', '2023-06-15'),
  (102, 'Basketball F', 'Movses Khorenatsu St', '2023-07-20'),
  (103, 'FIBA Volleyball', 'Arami St. 3', '2023-08-10'),
  (104, 'ASA League', ' Yervand Kochari St. ', '2023-09-05'),
  (105, 'FIS Football', ' Leoi St. 52', '2023-10-12'),
  (106, 'Tennis', ' 42 Mashtotsi Ave', '2023-11-18'),
  (107, 'Masters league', 'Baghramyan Ave. 24', '2023-12-05'),
  (108, 'ATP Tennis', ' Buzandi St. 1/3', '2024-01-15'),
  (109, 'Open tournament', '33 Manandyan St.', '2024-02-20'),
  (110, 'Summer Games - Football', '14 Titogradyan St', '2024-03-10');
  
select *
from event;

INSERT INTO supervise_events (admin_id, event_id)
VALUES
  (1, 101),
  (1, 102),
  (2, 101),
  (3, 103),
  (4, 104),
  (4, 105),
  (5, 102),
  (6, 103),
  (7, 105),
  (7, 106);

select * from supervise_events;


INSERT INTO sport (sport_id, sport_name, sp_description)
VALUES
    (1001, 'Football', 'Played - two teams of eleven players.'),
    (1002, 'Basketball', 'Played - two teams of five players.'),
    (1003, 'Tennis', 'Played individually against an opponent.'),
    (1004, 'Swimming', 'Individuals or teams compete - the fastest.'),
    (1005, 'Golf', 'Sport - hit balls into a series of holes.'),
    (1006, 'Volleyball', 'Played - two teams of six players.');

select * 
from sport;

INSERT INTO sport_events (event_id, sport_id)
VALUES
    (101, 1006),
    (102, 1002),
    (103, 1006),
    (104, 1005),
    (105, 1001),
    (106, 1003),
    (107, 1001),
    (108, 1003),
    (109, 1004),
    (110, 1001);

select *
from sport_events;



INSERT INTO team (team_id, team_name, team_stats, country, city, foundation_date)
VALUES
    (10001, 'The Avengers', 'Win-2, Lose-4', 'Armenia', 'Yerevan', '2021-01-01'),
    (10002, 'Avalanche', 'Win-4, Lose-4', 'Armenia', 'Gyumri', '2021-02-01'),
    (10003, 'Weekend Warriors', 'Win-2, Lose-3', 'Armenia', 'Ijevan', '2021-03-01'),
    (10004, 'Bright Reds', 'Win-1, Lose-1', 'Armenia', 'Gyumri', '2021-04-01'),
    (10005, 'First Up', 'Win-1, Lose-2', 'Armenia', 'Yerevan', '2021-05-01'),
    (10006, 'Forever Won', 'Win-3, Lose-1', 'Armenia', 'Ijevan', '2021-06-01'),
    (10007, 'Cool Runnings', 'Win-3, Lose-2', 'Armenia', 'Gyumri', '2021-07-01'),
    (10008, 'Toon Squad', 'Win-2, Lose-0', 'Armenia', 'Yerevan', '2021-08-01'),
    (10009, 'No Lucks Given', 'Win-2, Lose-2', 'Armenia', 'Ashtarak', '2021-09-01'),
    (10010, 'Attack', 'Win-4, Lose-1', 'Armenia', 'Yerevan', '2021-10-01'),
    (10011, 'Masters', 'Win-1, Lose-2', 'Armenia', 'Vanadzor', '2021-11-01'),
    (10012, 'Too Great', 'Win-3, Lose-2', 'Armenia', 'Yerevan', '2021-12-01'),
    (10013, 'Kingmakers', 'Win-2, Lose-2', 'Armenia', 'Gyumri', '2022-01-01'),
    (10014, 'Team Phoenix', 'Win-3, Lose-4', 'Armenia', 'Yerevan', '2022-02-01'),
    (10015, 'No Risk, No Reward', 'Win-2, Lose-0', 'Armenia', 'Vanadzor', '2022-03-01');




select *
from team;


INSERT INTO users (user_id, username, pass_word, secure_key, first_name, last_name, gender, country, city, email, dob, address, phone, join_date, team_id, admin_id)
VALUES
  (100001, 'johnsmith', 'password123', 'securekey123', 'John', 'Smith', 'Male', 'Armenia', 'Yerevan', 'johnsmith@gmail.com', '2003-01-01', '123 Main St', '+37445678904', '2023-01-01', 10001, 1),
  (100002, 'janedoe', 'password456', 'securekey456', 'Jane', 'Doe', 'Female', 'Armenia', 'Gyumri', 'janedoe@gmail.com', '2002-05-10', '456 Oak Ave', '+37465432101', '2023-02-15', 10004, 2),
  (100003, 'mikesmith', 'password789', 'securekey789', 'Mike', 'Smith', 'Male', 'Armenia', 'Vanadzor', 'mikesmith@gmail.com', '2001-12-05', '789 Elm St', '+37498765432', '2023-03-20', NULL, 3),
  (100004, 'sarahdoe', 'passwordabc', 'securekeyabc', 'Sarah', 'Doe', 'Female', 'Armenia', 'Dilijan', 'sarahdoe@gmail.com', '2004-07-15', 'ABC Cedar Ave', '+37412345678', '2023-04-25', NULL, 12),
  (100005, 'username1', 'password1', 'securekey1', 'John', 'Brown', 'Male', 'Armenia', 'Yerevan', 'johnbrown@gmail.com', '1990-01-01', '1 Address St', '+37412345678', '2023-05-01', 10001, 13),
  (100006, 'username2', 'password2', 'securekey2', 'Jane', 'Davis', 'Female', 'Armenia', 'Gyumri', 'janedavis@gmail.com', '1991-02-02', '2 Address St', '+37423456789', '2023-05-02', 10002, 15),
  (100007, 'username3', 'password3', 'securekey3', 'Mike', 'Johnson', 'Male', 'Armenia', 'Vanadzor', 'mikejohn@gmail.com', '1992-03-03', '3 Address St', '+37434567890', '2023-05-03', 10003, 14),
  (100008, 'username4', 'password4', 'securekey4', 'Sarah', 'Taylor', 'Female', 'Armenia', 'Dilijan', 'sarahor@gmail.com', '1993-04-04', '4 Address St', '+37445678901', '2023-05-04', 10004, 8),
  (100009, 'username5', 'password5', 'securekey5', 'David', 'Wilson', 'Male', 'Armenia', 'Yerevan', 'davn@gmail.com', '1994-05-05', '5 Address St', '+37456789012', '2023-05-05', 10005, 6),
  (100010, 'username6', 'password6', 'securekey6', 'Emily', 'Thomas', 'Female', 'Armenia', 'Gyumri', 'emilys@gmail.com', '1995-06-06', '6 Address St', '+37467890123', '2023-05-06', 10006, 10),
  (100011, 'username7', 'password7', 'securekey7', 'Michael', 'Anderson', 'Male', 'Armenia', 'Vanadzor', 'mierson@gmail.com', '1996-07-07', '7 Address St', '+37478901234', '2023-05-07', NULL, 9),
  (100012, 'username8', 'password8', 'securekey8', 'Jessica', 'Martinez', 'Female', 'Armenia', 'Dilijan', 'jetinez@gmail.com', '1997-08-08', '8 Address St', '+37489012345', '2023-05-08', 10008, 12),
  (100013, 'username9', 'password9', 'securekey9', 'Christopher', 'Hernandez', 'Male', 'Armenia', 'Yerevan', 'chrerheez@gmail.com', '1998-09-09', '9 Address St', '+37490123456', '2023-05-09', 10009, 11),
  (100014, 'username10', 'password10', 'securekey10', 'Ashley', 'Lopez', 'Female', 'Armenia', 'Gyumri', 'apez@gmail.com', '1999-10-10', '10 Address St', '+37401234567', '2023-05-10', 10010, 9),
  (100015, 'username11', 'password11', 'securekey11', 'Matthew', 'Gonzalez', 'Male', 'Armenia', 'Vanadzor', 'matonzlez@gmail.com', '2000-11-11', '11 Address St', '+37412345678', '2023-05-11', 10011, 7),
  (100016, 'username12', 'password12', 'securekey12', 'Emily', 'Rodriguez', 'Female', 'Armenia', 'Dilijan', 'emiddz@gmail.com', '2001-12-12', '12 Address St', '+37423456789', '2023-05-12', 10012, 5),
  (100017, 'username13', 'password13', 'securekey13', 'Daniel', 'Lee', 'Male', 'Armenia', 'Yerevan', 'da0lee@gmail.com', '2002-01-13', '13 Address St', '+37434567890', '2023-05-13', 10013, 4),
  (100018, 'username14', 'password14', 'securekey14', 'Olivia', 'Walker', 'Female', 'Armenia', 'Gyumri', 'olilker@gmail.com', '2003-02-14', '14 Address St', '+37445678901', '2023-05-14', 10014, 1),
  (100019, 'username15', 'password15', 'securekey15', 'Andrew', 'Hall', 'Male', 'Armenia', 'Vanadzor', 'andhall@gmail.com', '2004-03-15', '15 Address St', '+37456789012', '2023-05-15', 10015, 2),
  (100020, 'username16', 'password16', 'securekey16', 'Samantha', 'Young', 'Female', 'Armenia', 'Dilijan', 'saayoung@gmail.com', '2005-04-16', '16 Address St', '+37467890123', '2023-05-16', NULL, 3),
  (100021, 'johnsmith', 'password17', 'securekey17', 'John', 'Smith', 'Male', 'Armenia', 'Yerevan', 'j9ith@gmail.com', '2006-05-17', '17 Address St', '+37478901234', '2023-05-17', 10013, 5),
  (100022, 'emmawilson', 'password18', 'securekey18', 'Emma', 'Wilson', 'Female', 'Armenia', 'Gyumri', 'emson@gmail.com', '2007-06-18', '18 Address St', '+37489012345', '2023-05-18', 10011, 1),
  (100023, 'alexanderryan', 'password19', 'securekey19', 'Alexander', 'Ryan', 'Male', 'Armenia', 'Vanadzor', 'al8rryan@gmail.com', '2008-07-19', '19 Address St', '+37490123456', '2023-05-19', NULL, 6),
  (100024, 'sophiamartinez', 'password20', 'securekey20', 'Sophia', 'Martinez', 'Female', 'Armenia', 'Dilijan', 'soartinez@gmail.com', '2009-08-20', '20 Address St', '+37401234567', '2023-05-20', 10003, 7),
  (100025, 'davidwilson', 'password21', 'securekey21', 'David', 'Wilson', 'Male', 'Armenia', 'Yerevan', 'davson@gmail.com', '2010-09-21', '21 Address St', '+37412345678', '2023-05-21', 10001, 9),
  (100026, 'emilyrodriguez', 'password22', 'securekey22', 'Emily', 'Rodriguez', 'Female', 'Armenia', 'Gyumri', 'emriguez@gmail.com', '2011-10-22', '22 Address St', '+37423456789', '2023-05-22', 10002, 12),
  (100027, 'daniellee', 'password23', 'securekey23', 'Daniel', 'Lee', 'Male', 'Armenia', 'Vanadzor', 'dallee@gmail.com', '2012-11-23', '23 Address St', '+37434567890', '2023-05-23', NULL, 14),
  (100028, 'oliviawalker', 'password24', 'securekey24', 'Olivia', 'Walker', 'Female', 'Armenia', 'Dilijan', 'olilr90@gmail.com', '2013-12-24', '24 Address St', '+37445678901', '2023-05-24', 10004, 8),
  (100029, 'matthewgonzalez', 'password25', 'securekey25', 'Matthew', 'Gonzalez', 'Male', 'Armenia', 'Yerevan', 'matgez7@gmail.com', '2014-01-25', '25 Address St', '+37456789012', '2023-05-25', 10005, 12),
  (100030, 'sophiehill', 'password26', 'securekey26', 'Sophie', 'Hill', 'Female', 'Armenia', 'Gyumri', 'soph9ll3@gmail.com', '2015-02-26', '26 Address St', '+37467890123', '2023-05-26', 10006, 13),
  (100031, 'michaelperez', 'password27', 'securekey27', 'Michael', 'Perez', 'Male', 'Armenia', 'Vanadzor', 'mic2@gmail.com', '2016-03-27', '27 Address St', '+37478901234', '2023-05-27', 10007, 7),
  (100032, 'ameliasanchez', 'password28', 'securekey28', 'Amelia', 'Sanchez', 'Female', 'Armenia', 'Dilijan', 'amehez@gmail.com', '2017-04-28', '28 Address St', '+37489012345', '2023-05-28', 10008, 6),
  (100033, 'jacobrobinson', 'password29', 'securekey29', 'Jacob', 'Robinson', 'Male', 'Armenia', 'Yerevan', 'jacoson@gmail.com', '2018-05-29', '29 Address St', '+37490123456', '2023-05-29', 10009, 4),
  (100034, 'olivialopez', 'password30', 'securekey30', 'Olivia', 'Lopez', 'Female', 'Armenia', 'Gyumri', 'olivoez8@gmail.com', '2019-06-30', '30 Address St', '+37401234567', '2023-05-30', NULL, 5),
  (100035, 'ethanjackson', 'password31', 'securekey31', 'Ethan', 'Jackson', 'Male', 'Armenia', 'Vanadzor', 'ethan8@gmail.com', '2020-07-31', '31 Address St', '+37412345678', '2023-05-31', 10001, 1);
  
  SET SQL_SAFE_UPDATES = 0;
  select * from users;
  
UPDATE team
SET captain_id = 
  CASE 
    WHEN captain_id IS NULL AND team_id = '10001' THEN '100001'
    WHEN captain_id IS NULL AND team_id = '10002' THEN '100002'
    WHEN captain_id IS NULL AND team_id = '10003' THEN '100003'
    WHEN captain_id IS NULL AND team_id = '10006' THEN '100006'
    WHEN captain_id IS NULL AND team_id = '10007' THEN '100007'
    WHEN captain_id IS NULL AND team_id = '10009' THEN '100009'
    WHEN captain_id IS NULL AND team_id = '10010' THEN '100010'
    WHEN captain_id IS NULL AND team_id = '10011' THEN '100011'
    WHEN captain_id IS NULL AND team_id = '10012' THEN '100012'
    WHEN captain_id IS NULL AND team_id = '10015' THEN '100015'
    ELSE captain_id
  END;



  
  
  INSERT INTO health_status (user_id, hid, calorie, height, weight, fat, health_issues)
VALUES
  (100001, 2001, '2000', '170', '70', '18', 'None'),
  (100002, 2002, '1800', '165', '60', '15', 'High cholesterol'),
  (100003, 2003, '2200', '180', '80', '20', 'Diabetes'),
  (100004, 2004, '2500', '175', '75', '22', 'Hypertension'),
  (100005, 2005, '1900', '160', '55', '12', 'None'),
  (100006, 2006, '2100', '172', '68', '19', 'None'),
  (100007, 2007, '2400', '178', '82', '23', 'Asthma'),
  (100008, 2008, '1950', '163', '57', '14', 'None'),
  (100009, 2009, '2300', '175', '76', '21', 'High blood pressure'),
  (100010, 2010, '1850', '158', '53', '11', 'None'),
  (100011, 2011, '2050', '170', '65', '17', 'None'),
  (100012, 2012, '2200', '180', '80', '20', 'Diabetes'),
  (100013, 2013, '2500', '185', '88', '25', 'Obesity'),
  (100014, 2014, '1900', '162', '58', '13', 'None'),
  (100015, 2015, '2250', '173', '71', '19', 'None'),
  (100016, 2016, '2050', '168', '70', '18', 'None'),
  (100017, 2017, '2300', '172', '78', '21', 'Allergies'),
  (100018, 2018, '1900', '165', '62', '16', 'None'),
  (100019, 2019, '2200', '176', '75', '19', 'Migraines'),
  (100020, 2020, '1950', '160', '55', '12', 'None'),
  (100021, 2021, '2100', '170', '65', '17', 'None'),
  (100022, 2022, '2400', '180', '85', '23', 'Asthma'),
  (100023, 2023, '1850', '162', '58', '14', 'None'),
  (100024, 2024, '2250', '173', '72', '19', 'None'),
  (100025, 2025, '2500', '182', '88', '25', 'Obesity'),
  (100026, 2026, '2000', '170', '70', '18', 'None'),
  (100027, 2027, '2350', '175', '80', '20', 'High blood pressure'),
  (100028, 2028, '1950', '165', '62', '15', 'None'),
  (100029, 2029, '2250', '178', '77', '22', 'Asthma'),
  (100030, 2030, '1900', '160', '55', '12', 'None'),
  (100031, 2031, '2100', '170', '68', '19', 'None'),
  (100032, 2032, '2400', '180', '85', '23', 'Diabetes'),
  (100033, 2033, '1850', '162', '58', '14', 'None'),
  (100034, 2034, '2150', '173', '71', '18', 'None'),
  (100035, 2035, '2500', '185', '88', '25', 'Obesity');

  
  select * from health_status;
  
INSERT INTO sport_plan (pid, planName, sp_description, start_date, end_date, user_id)
VALUES
  ('SP001', 'Weight Loss', 'A 12-week weight loss plan focusing on cardio and strength training.', '2023-01-01', '2023-03-26', 100001),
  ('SP002', 'Muscle Gain', 'A 16-week muscle gain plan incorporating weightlifting and proper nutrition.', '2023-02-15', '2023-06-15', 100002),
  ('SP003', 'Endurance ', 'An 8-week endurance training plan for improving stamina and performance.', '2023-03-01', '2023-04-25', 100003),
  ('SP004', 'Flexibility ', 'A 4-week flexibility routine focusing on stretching and mobility exercises.', '2023-04-01', '2023-04-30', 100004),
  ('SP005', 'Strength ', 'A 10-week strength training plan using compound exercises and progressive overload.', '2023-05-15', '2023-07-23', 100005),
  ('SP006', 'Ag Training', 'A 6-week agility training plan for enhancing speed and quickness.', '2023-06-01', '2023-07-12', 100006),
  ('SP007', 'Cardio Fitness', 'An 8-week cardio fitness plan incorporating running, cycling, and HIIT workouts.', '2023-07-01', '2023-08-26', 100007),
  ('SP008', 'Weight Workout', 'A 12-week bodyweight workout plan for strength and muscle tone without equipment.', '2023-08-15', '2023-11-15', 100008),
  ('SP009', 'Core Strength', 'A 4-week core strength plan focusing on abdominal and lower back exercises.', '2023-09-01', '2023-09-30', 100009),
  ('SP010', 'Cardio Fitness', 'A 10-week plan combining yoga and meditation for stress relief and mindfulness.', '2023-10-15', '2023-12-23', 100010),
  ('SP011', 'Cardio Fitness', 'An 8-week Pilates plan for improving flexibility, posture, and body awareness.', '2023-11-01', '2023-12-25', 100011),
  ('SP012', 'Cardio Fitness', 'A 16-week powerlifting program for increasing strength in the squat, bench press, and deadlift.', '2023-12-01', '2024-03-30', 100012),
  ('SP013', 'Circuit Training', 'A 6-week circuit training plan combining strength and cardio exercises for full-body workouts.', '2023-01-15', '2024-02-25', 100013),
  ('SP014', 'Outdoor Adventure', 'A 12-week outdoor adventure plan involving hiking, kayaking, and rock climbing.', '2023-02-01', '2024-04-30', 100014),
  ('SP015', 'Swimming Technique', 'An 8-week swimming technique plan for improving stroke efficiency and speed.', '2023-03-15', '2024-05-15', 100015),
  ('SP016', 'Swimming Technique', 'A 4-week HIIT plan for intense calorie burning and cardiovascular fitness.', '2023-04-01', '2024-04-30', 100016),
  ('SP017', 'CrossFit Workout', 'A 12-week CrossFit workout plan combining strength, endurance, and functional movements.', '2023-05-15', '2024-08-15', 100017),
  ('SP018', 'Cycling Endurance', 'An 8-week cycling endurance plan for building stamina and improving cycling performance.', '2023-06-01', '2024-07-26', 100018),
  ('SP019', 'Swimming Technique', 'A 6-week plan focusing on flexibility, mobility, and joint health exercises.', '2023-07-01', '2024-08-12', 100019),
  ('SP020', 'Bodyweight Workout', 'A 10-week martial arts training plan for learning self-defense and improving discipline.', '2023-08-15', '2024-10-23', 100020),
  ('SP021', 'Running Program', 'A 16-week running program for beginners to train for a 10K race.', '2023-09-01', '2024-12-29', 100021),
  ('SP022', 'Full Body ', 'An 8-week full body strength plan using compound exercises and progressive overload.', '2023-10-15', '2024-12-23', 100022),
  ('SP023', 'Bodyweight', 'A 6-week yoga plan focusing on relaxation, stress relief, and mindfulness.', '2024-11-01', '2024-12-12', 100023),
  ('SP024', 'Golf Improvement', 'A 12-week plan for improving golf swing technique and overall performance on the course.', '2023-12-01', '2024-03-01', 100024),
  ('SP025', 'Bodyweight', 'An 8-week plan for exploring nature through hiking, trail running, and outdoor activities.', '2023-01-15', '2024-03-25', 100025),
  ('SP026', 'Body Training', 'A 4-week bodyweight circuit training plan for full-body strength and conditioning.', '2023-04-01', '2024-04-30', 100026),
  ('SP027', 'Tr Training', 'A 12-week triathlon training plan incorporating swimming, cycling, and running.', '2023-05-15', '2024-08-15', 100027),
  ('SP028', 'Plyometric Workout', 'An 8-week plyometric workout plan for explosive power and athletic performance.', '2023-06-01', '2024-07-26', 100028),
  ('SP029', 'Stability', 'A 6-week plan focusing on improving balance, stability, and proprioception.', '2023-07-01', '2024-08-12', 100029),
  ('SP030', 'Bodyweight', 'A 10-week dance fitness plan incorporating various dance styles for cardio and fun.', '2023-08-15', '2024-10-23', 100030),
  ('SP031', 'Marathon Training', 'A 16-week marathon training plan for experienced runners preparing for a marathon.', '2023-09-01', '2024-12-29', 100031),
  ('SP032', 'Body Strength', 'An 8-week upper body strength plan focusing on arms, chest, and back exercises.', '2023-10-15', '2024-12-23', 100032),
  ('SP033', 'Bodyweight ', 'A 6-week plan for practicing meditation and mindfulness for mental well-being.', '2023-11-01', '2024-12-12', 100033),
  ('SP034', 'BSkills ', 'A 12-week plan for improving basketball skills including shooting, dribbling, and defense.', '2023-12-01', '2024-03-01', 100034),
  ('SP035', 'B Volleyball', 'An 8-week conditioning plan for beach volleyball athletes focusing on agility and strength.', '2023-01-15', '2024-03-25', 100035);


select * from sport_plan;

INSERT INTO user_intsports (sport_id, user_id) VALUES
  (1001, 100001),
  (1001, 100002),
  (1001, 100003),
  (1001, 100004),
  (1001, 100005),
  (1001, 100006),
  (1002, 100007),
  (1002, 100008),
  (1002, 100009),
  (1002, 100010),
  (1002, 100011),
  (1002, 100012),
  (1003, 100013),
  (1003, 100014),
  (1003, 100015),
  (1003, 100016),
  (1003, 100017),
  (1003, 100018),
  (1004, 100019),
  (1004, 100020),
  (1004, 100021),
  (1004, 100022),
  (1004, 100023),
  (1004, 100024),
  (1005, 100025),
  (1005, 100026),
  (1005, 100027),
  (1005, 100028),
  (1005, 100029),
  (1005, 100030),
  (1006, 100031),
  (1006, 100032),
  (1006, 100033),
  (1006, 100034),
  (1006, 100035),
  (1002, 100001),
  (1003, 100002),
  (1004, 100003),
  (1002, 100004),
  (1003, 100005),
  (1006, 100006),
  (1001, 100007),
  (1001, 100008),
  (1005, 100009),
  (1003, 100010),
  (1003, 100011),
  (1004, 100012),
  (1001, 100013),
  (1001, 100014),
  (1002, 100019),
  (1003, 100020),
  (1001, 100021),
  (1002, 100022),
  (1001, 100023),
  (1003, 100024),
  (1002, 100025),
  (1001, 100026),
  (1004, 100027),
  (1004, 100028),
  (1006, 100029);
  
  
  select * from user_intsports;

INSERT INTO user_participation (event_id, user_id)
VALUES
  (101, 100001),
  (101, 100002),
  (101, 100003),
  (101, 100004),
  (101, 100005),
  (102, 100006),
  (102, 100007),
  (102, 100008),
  (102, 100009),
  (102, 100010),
  (103, 100011),
  (103, 100012),
  (103, 100013),
  (103, 100014),
  (103, 100015),
  (104, 100016),
  (104, 100017),
  (104, 100018),
  (104, 100019),
  (104, 100020),
  (105, 100021),
  (105, 100022),
  (105, 100023),
  (105, 100024),
  (105, 100025),
  (106, 100026),
  (106, 100027),
  (106, 100028),
  (106, 100029),
  (106, 100030),
  (107, 100031),
  (107, 100032),
  (107, 100033),
  (107, 100034),
  (107, 100035),
  (108, 100001),
  (108, 100002),
  (108, 100003),
  (108, 100004),
  (108, 100005),
  (109, 100006),
  (109, 100007),
  (109, 100008),
  (109, 100009),
  (109, 100010),
  (110, 100011),
  (110, 100012),
  (110, 100013),
  (110, 100014),
  (110, 100015);

select * 
from user_participation;

  
-- Function 1

DELIMITER //

CREATE FUNCTION calculate_admin_age(dob DATE)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE age INT;
  SET age = TIMESTAMPDIFF(YEAR, dob, CURDATE());
  IF DATE_FORMAT(CURDATE(), '%m-%d') < DATE_FORMAT(dob, '%m-%d') THEN
    SET age = age - 1;
  END IF;
  RETURN age;
END//
DELIMITER ;

SELECT calculate_admin_age('2002-02-12') AS age;
SELECT calculate_admin_age('2003-04-05') AS age;
SELECT calculate_admin_age('2004-03-10') AS age;


-- Function 2 

DELIMITER //

CREATE FUNCTION get_user_sport_count(user_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE count_users INT;
  SELECT COUNT(*) INTO count_users FROM user_intsports WHERE user_id = user_id;
  RETURN count_users;
END//
DELIMITER ;

SELECT get_user_sport_count(100005);




-- Queries

-- Retrieve all events supervised by a specific admin:
SELECT e.event_id, e.event_name, e.address, e.event_date
FROM event e
JOIN supervise_events se ON e.event_id = se.event_id
JOIN admins a ON se.admin_id = a.admin_id
WHERE a.username = 'admin1';


-- Retrieve the usernames and their corresponding team names for users who are captains of a team:
SELECT u.username, t.team_name
FROM users u
JOIN team t ON u.user_id = t.captain_id;


-- Retrieve the number of users interested in each sport:
SELECT s.sport_name, COUNT(ui.user_id) AS user_count
FROM sport s
LEFT JOIN user_intsports ui ON s.sport_id = ui.sport_id
GROUP BY s.sport_name;


-- Retrieve the event names that have not been supervised by any admin:
SELECT e.event_name
FROM event e
LEFT JOIN supervise_events se ON e.event_id = se.event_id
WHERE se.event_id IS NULL;


-- Retrieve all users who have participated in a specific event:
SELECT u.user_id, u.username, u.first_name, u.last_name
FROM users u
JOIN user_participation up ON u.user_id = up.user_id
JOIN event e ON up.event_id = e.event_id
WHERE e.event_name = 'FIBA Volleyball';


-- All Users - 'No health isses'
SELECT u.username, hs.calorie, hs.height, hs.weight, hs.fat, hs.health_issues
FROM users u
JOIN health_status hs ON u.user_id = hs.user_id
WHERE hs.health_issues IS NULL OR hs.health_issues = 'None';


-- The event name in which the maximum number of users have participated,
SELECT e.event_name, COUNT(up.user_id) AS participant_count
FROM event e
JOIN user_participation up ON e.event_id = up.event_id
GROUP BY e.event_name
ORDER BY participant_count DESC
LIMIT 3;


-- Retrieve the usernames of users who have participated in all events:
SELECT u.username
FROM users u
WHERE NOT EXISTS (
  SELECT e.event_id
  FROM event e
  WHERE NOT EXISTS (
    SELECT up.event_id
    FROM user_participation up
    WHERE up.event_id = e.event_id AND up.user_id = u.user_id
  )
);


-- Retrieve the top 5 users with the highest number of sport interests:
SELECT u.username, COUNT(ui.sport_id) AS sport_count
FROM users u
LEFT JOIN user_intsports ui ON u.user_id = ui.user_id
GROUP BY u.user_id
ORDER BY sport_count DESC
LIMIT 5;


-- Retrieve the event names along with the total number of participants in each event:
SELECT e.event_name, COUNT(up.user_id) AS participant_count
FROM event e
LEFT JOIN user_participation up ON e.event_id = up.event_id
GROUP BY e.event_id, e.event_name;



-- Retrieve the users who have participated in at least 2 different sports:
SELECT u.*
FROM users u
JOIN user_intsports ui ON u.user_id = ui.user_id
GROUP BY u.user_id
HAVING COUNT(DISTINCT ui.sport_id) >= 2;


-- Retrieve the event names and the number of sports associated with each event:
SELECT e.event_name, COUNT(se.sport_id) AS sport_count
FROM event e
JOIN sport_events se ON e.event_id = se.event_id
GROUP BY e.event_id, e.event_name;






-- Views
-- -- This view figures out the average data for every team, including the name of the team, the average height, weight, and caloric consumption;
CREATE VIEW team_average_stats AS
SELECT t.team_name, AVG(hs.height) AS avg_height, AVG(hs.weight) AS avg_weight, AVG(hs.calorie) AS avg_calorie
FROM team t
JOIN users u ON t.team_id = u.team_id
JOIN health_status hs ON u.user_id = hs.user_id
GROUP BY t.team_id, t.team_name;


-- drop view team_average_stats;

-- This view lists the sports that each user has participated in, including their username and the corresponding sports;
CREATE VIEW user_participated_sports AS
SELECT u.username, s.sport_name
FROM users u
JOIN user_intsports ui ON u.user_id = ui.user_id
JOIN sport s ON ui.sport_id = s.sport_id;

-- drop view user_participated_sports;


-- This view calculates the total participation count for each event, including the event ID, event name, and the number of participants.
CREATE VIEW event_participation_count AS
SELECT e.event_id, e.event_name, COUNT(up.user_id) AS participation_count
FROM event e
LEFT JOIN user_participation up ON e.event_id = up.event_id
GROUP BY e.event_id, e.event_name;

-- drop view event_participation_count;









