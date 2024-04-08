-- CREATE USER 'ece656'@'localhost' IDENTIFIED BY '12345';
GRANT SESSION_VARIABLES_ADMIN ON *.* TO 'ece656'@'localhost';

drop table if exists actions;
drop table if exists matches_England;
drop table if exists player_games;
drop table if exists coaches;
drop table if exists matches_European_Championship;
drop table if exists playerank;
drop table if exists competitions;
drop table if exists players;
drop table if exists eventid2name;
drop table if exists referees;
drop table if exists events_England;
drop table if exists features;
drop table if exists tags2name;
drop table if exists events_European_Championship;
drop table if exists games;
drop table if exists teams;
drop table if exists labels;

CREATE TABLE actions (
	a INT NOT NULL, 
	game_id INT NOT NULL, 
	period_id INT NOT NULL, 
	time_seconds DECIMAL(38, 17) NOT NULL, 
	team_id INT NOT NULL, 
	player_id INT NOT NULL, 
	start_x DECIMAL(38, 16) NOT NULL, 
	start_y DECIMAL(38, 16) NOT NULL, 
	end_x DECIMAL(38, 16) NOT NULL, 
	end_y DECIMAL(38, 16) NOT NULL, 
	original_event_id INT, 
	bodypart_id INT NOT NULL, 
	type_id INT NOT NULL, 
	result_id INT NOT NULL, 
	action_id INT NOT NULL, 
	type_name char(20) NOT NULL, 
	result_name char(10) NOT NULL, 
	bodypart_name char(10) NOT NULL
);
CREATE TABLE events_England (
	eventId INT NOT NULL,
    subEventName char(30) NOT NULL,
    tags TEXT NOT NULL,
    playerId INT NOT NULL,
    positions TEXT NOT NULL,
    matchId INT NOT NULL,
    eventName char(30) NULL,
    teamId INT NULL,
    matchPeriod char(2) NULL,
    eventSec DECIMAL(38, 17) NULL,
    subEventId INT NULL,
    id INT NOT NULL,
    tagsList TEXT NULL,
    pos_orig_y INT NOT NULL,
    pos_orig_x INT NOT NULL,
    pos_dest_y INT NOT NULL,
    pos_dest_x INT NOT NULL
);
CREATE TABLE player_games (
	a INT NOT NULL, 
	player_id INT NOT NULL, 
	nickname VARCHAR(22) NOT NULL, 
	firstname VARCHAR(35) NOT NULL, 
	lastname VARCHAR(32) NOT NULL, 
	birth_date DATE NOT NULL, 
	player_name VARCHAR(49) NOT NULL, 
	team_id INT NOT NULL, 
	jersey_number BOOL NOT NULL, 
	minutes_played INT NOT NULL, 
	is_starter BOOL NOT NULL, 
	game_id INT NOT NULL
);
CREATE TABLE coaches (
	`wyId` INT NOT NULL, 
	`shortName` VARCHAR(21) NOT NULL, 
	`firstName` VARCHAR(20) NOT NULL, 
	`middleName` BOOL, 
	`lastName` VARCHAR(31) NOT NULL, 
	`birthDate` DATE, 
	`birthArea` VARCHAR(81) NOT NULL, 
	`passportArea` VARCHAR(81) NOT NULL, 
	`currentTeamId` INT NOT NULL
);
CREATE TABLE events_Italy (
	eventId INT NOT NULL,
    subEventName char(30) NOT NULL,
    tags TEXT NOT NULL,
    playerId INT NOT NULL,
    positions TEXT NOT NULL,
    matchId INT NOT NULL,
    eventName char(30) NULL,
    teamId INT NULL,
    matchPeriod char(2) NULL,
    eventSec DECIMAL(38, 17) NULL,
    subEventId INT NULL,
    id INT NOT NULL,
    tagsList TEXT NULL,
    pos_orig_y INT NOT NULL,
    pos_orig_x INT NOT NULL,
    pos_dest_y INT NOT NULL,
    pos_dest_x INT NOT NULL
);
CREATE TABLE playerank (
	`goalScored` INT NOT NULL, 
	`playerankScore` DECIMAL(38, 4) NOT NULL, 
	`matchId` INT NOT NULL, 
	`playerId` INT NOT NULL, 
	`roleCluster` char(30) NOT NULL, 
	`minutesPlayed` INT NOT NULL
);
CREATE TABLE competitions (
	name char(25) NOT NULL,
    wyId INT NOT NULL,
    format char(20) NOT NULL,
    area TEXT NOT NULL,
    type char(20) NOT NULL
);
CREATE TABLE events_Spain (
	eventId INT NOT NULL,
    subEventName char(30) NOT NULL,
    tags TEXT NOT NULL,
    playerId INT NOT NULL,
    positions TEXT NOT NULL,
    matchId INT NOT NULL,
    eventName char(30) NULL,
    teamId INT NULL,
    matchPeriod char(2) NULL,
    eventSec DECIMAL(38, 17) NULL,
    subEventId INT NULL,
    id INT NOT NULL,
    tagsList TEXT NULL,
    pos_orig_y INT NOT NULL,
    pos_orig_x INT NOT NULL,
    pos_dest_y INT NOT NULL,
    pos_dest_x INT NOT NULL
);
CREATE TABLE players (
	passportArea TEXT,
    weight INT,
    firstName VARCHAR(255),
    middleName VARCHAR(255),
    lastName VARCHAR(255),
    currentTeamId FLOAT,
    birthDate DATE,
    height INT,
    role TEXT,
    birthArea TEXT,
    wyId INT PRIMARY KEY,
    foot VARCHAR(50),
    shortName VARCHAR(255),
    currentNationalTeamId FLOAT
);
CREATE TABLE eventid2name (
    event INT,
    subevent INT,
    event_label VARCHAR(255),
    subevent_label VARCHAR(255)
);
CREATE TABLE referees (
    wyId INT PRIMARY KEY,
    shortName VARCHAR(255),
    firstName VARCHAR(255),
    middleName VARCHAR(255),
    lastName VARCHAR(255),
    birthDate DATE,
    birthArea_id INT,
    birthArea_alpha2code CHAR(2),
    birthArea_alpha3code CHAR(3),
    birthArea_name VARCHAR(255),
    passportArea_id INT,
    passportArea_alpha2code CHAR(2),
    passportArea_alpha3code CHAR(3),
    passportArea_name VARCHAR(255)
);
CREATE TABLE tags2name (
    Tag INT PRIMARY KEY,
    Label VARCHAR(255),
    Description TEXT
);
CREATE TABLE games (
    id INT,
    game_id INT PRIMARY KEY,
    competition_id INT,
    season_id INT,
    game_date DATETIME,
    game_day INT,
    home_team_id INT,
    away_team_id INT
);
CREATE TABLE teams (
    city VARCHAR(255),
    name VARCHAR(255),
    wyId INT PRIMARY KEY,
    officialName VARCHAR(255),
    area TEXT,
    type VARCHAR(50)
);
CREATE TABLE matches_England (
    status VARCHAR(50),
    roundId INT,
    gameweek INT,
    teamsData TEXT,
    seasonId INT,
    dateutc DATETIME,
    winner INT,
    venue VARCHAR(255),
    wyId INT,
    label VARCHAR(255),
    date DATE,
    referees TEXT,
    duration VARCHAR(50),
    competitionId INT,
    team1_scoreET INT,
    team1_coachId INT,
    team1_side VARCHAR(50),
    team1_teamId INT,
    team1_score INT,
    team1_scoreP INT,
    team1_hasFormation BOOLEAN,
    team1_formation TEXT,
    team1_scoreHT INT,
    team2_scoreET INT,
    team2_coachId INT,
    team2_side VARCHAR(50),
    team2_teamId INT,
    team2_score INT,
    team2_scoreP INT,
    team2_hasFormation BOOLEAN,
    team2_formation JSON,
    team2_scoreHT INT
);

#SET GLOBAL local_infile=1;
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\actions.csv' INTO TABLE actions FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\events_England.csv' INTO TABLE events_England FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\player_games.csv' INTO TABLE player_games FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\coaches.csv' INTO TABLE coaches FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\playerank.csv' INTO TABLE playerank FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\competitions.csv' INTO TABLE competitions FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\players.csv' INTO TABLE players FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\eventid2name.csv' INTO TABLE eventid2name FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\referees.csv' INTO TABLE referees FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\tags2name.csv' INTO TABLE tags2name FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\games.csv' INTO TABLE games FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\teams.csv' INTO TABLE teams FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE 'D:\\codes\\waterloo_assignments\\ECE656\\project\\ECE656_soccer_event\\data\\matches_England.csv' INTO TABLE matches_England FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;