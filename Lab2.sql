-- this enables warnings to be displayed about invalid data warnings;

-- you can type in the SQL commmands in any case,
-- but you must type in the correct case for tablenames

-- drop the table if it already exists
DROP TABLE MyFilm;



CREATE TABLE Skill (
name VARCHAR (50), 
code INT PRIMARY KEY
) ENGINE=INNODB;

CREATE TABLE BankAccount (
number INT PRIMARY KEY,
balance VARCHAR(10)
) ENGINE=INNODB;

CREATE TABLE Agent (
name VARCHAR(50) PRIMARY KEY,
contact INT,
account INT,
FOREIGN KEY (account) REFERENCES BankAccount(number)
) ENGINE=INNODB;

CREATE TABLE Actor (
name VARCHAR(50) PRIMARY KEY,
DoB DATE,
sex CHAR(1),
fee DECIMAL,
agent VARCHAR(50),
account INT,
FOREIGN KEY (agent) REFERENCES Agent(name),
FOREIGN KEY (account) REFERENCES BankAccount(number)
) ENGINE=INNODB;

CREATE TABLE ActorSkill (
actorName VARCHAR(50),
skillCode INT ,
PRIMARY KEY (actorName, skillCode),
FOREIGN KEY (skillCode) REFERENCES Skill(code),
FOREIGN KEY (actorName) REFERENCES Actor(name)
) ENGINE=INNODB;



INSERT INTO Skill VALUES ("comic timing", 1);
INSERT INTO Skill VALUES ("family friendly", 2);
INSERT INTO Skill VALUES ("gritty drama", 3);
INSERT INTO Skill VALUES ("action", 4);

INSERT INTO Actor VALUES ("Carl Pratt","1982-03-20","M",1100000,"Smith",14839234);
INSERT INTO Actor VALUES ("Anna Stone","1985-02-17","F",1300000,"Jones",18294038);
INSERT INTO Actor VALUES ("Rosie Ridley","1987-07-14","F",1500000,"Jones",19204382);
INSERT INTO Actor VALUES ("Jemma Laurence","1980-12-01","F",1700000,"Lane",13738925);

INSERT INTO ActorSkill VALUES ("Carl Pratt", 1);
INSERT INTO ActorSkill VALUES ("Carl Pratt", 2);
INSERT INTO ActorSkill VALUES ("Anna Stone", 2);
INSERT INTO ActorSkill VALUES ("Anna Stone", 3);
INSERT INTO ActorSkill VALUES ("Anna Stone", 4);
INSERT INTO ActorSkill VALUES ("Rosie Ridley", 2);
INSERT INTO ActorSkill VALUES ("Rosie Ridley", 4);
INSERT INTO ActorSkill VALUES ("Jemma Laurence", 1);
INSERT INTO ActorSkill VALUES ("Jemma Laurence", 2);
INSERT INTO ActorSkill VALUES ("Jemma Laurence", 3);
INSERT INTO ActorSkill VALUES ("Jemma Laurence", 4);

INSERT INTO Agent VALUES ("Smith",729002394,19280293);
INSERT INTO Agent VALUES ("Jones",483920493,16394053);
INSERT INTO Agent VALUES ("Lane",593029348,15293013);

INSERT INTO BankAccount VALUES (14839234,17320000);
INSERT INTO BankAccount VALUES (19280293,180002);
INSERT INTO BankAccount VALUES (18294038,1300000);
INSERT INTO BankAccount VALUES (19204382,-102390);
INSERT INTO BankAccount VALUES (15293013,0);
INSERT INTO BankAccount VALUES (16394053,829302);
INSERT INTO BankAccount VALUES (13738925,10390000);





-- 1. All Data
SELECT * FROM ActorSkill;

-- 2. * for actors with fee > $1.4m
SELECT * FROM Actor 
WHERE fee > 1400000;

-- 3. Actor and Bank Accounts
SELECT * FROM Actor JOIN BankAccount ON account = number;

-- 4. Actors with skill 'comic timing'
SELECT actorName, name AS SkillName FROM ActorSkill JOIN Skill ON skillCode = code 
WHERE skillCode = 1;

-- 5. SkillCode of actor with bank account no. 19204382
SELECT name, account, skillCode FROM Actor JOIN ActorSkill ON name = actorName 
WHERE account = 19204382;

-- 6. Name and DOB of actors with >£2000 balance
SELECT name, DOB FROM Actor JOIN BankAccount ON account = number 
WHERE balance > 2000;

-- 7. Name of agent with phone number 729002394
SELECT name, contact FROM Agent 
WHERE contact = 729002394;

-- 8. Names and DOBs of actors who are good at gritty drama
SELECT name, DOB FROM Actor JOIN ActorSkill ON name = actorName 
WHERE skillCode = 3;

-- 9. Names of agents who supervise male actors
SELECT Agent.name AS AgentName, Actor.name AS ActorName FROM Agent JOIN Actor ON Agent.name = Actor.agent 
WHERE sex = "M";
