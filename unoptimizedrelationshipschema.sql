
-- Table for Coaches
CREATE TABLE Coaches (
    ID INT PRIMARY KEY,
    shortName VARCHAR(255),
    firstName VARCHAR(255),
    middleName VARCHAR(255),
    lastName VARCHAR(255),
    birthDate DATE,
    birthArea VARCHAR(255),
    passportArea VARCHAR(255),
    currentTeamID INT,
    FOREIGN KEY (currentTeamID) REFERENCES Teams(ID)
);

-- Table for Teams
CREATE TABLE Teams (
    ID INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255),
    area VARCHAR(255),
    type VARCHAR(255),
    officialName VARCHAR(255),
    clubTeam BOOLEAN,
    countryTeam BOOLEAN
);

-- Table for Players
CREATE TABLE Players (
    ID INT PRIMARY KEY,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    birthDate DATE,
    birthArea VARCHAR(255),
    preferredFoot VARCHAR(50),
    height INT,
    middleName VARCHAR(255),
    passportArea VARCHAR(255),
    role VARCHAR(255),
    shortName VARCHAR(255),
    weight INT
    currentClubTeamID INT,
    currentCountryTeamID INT
    FOREIGN KEY (currentClubTeamID) REFERENCES Teams(ID)
    FOREIGN KEY (currentCountryTeamID) REFERENCES Teams(ID)
);

-- Table for Referee
CREATE TABLE Referee (
    ID INT PRIMARY KEY,
    shortName VARCHAR(255),
    firstName VARCHAR(255),
    middleName VARCHAR(255),
    lastName VARCHAR(255),
    birthDate DATE,
    birthArea VARCHAR(255),
    passportArea VARCHAR(255)
);

-- Table for Competitions
CREATE TABLE Competitions (
    ID INT PRIMARY KEY,
    area VARCHAR(255),
    format VARCHAR(255),
    name VARCHAR(255),
    nameLong VARCHAR(255),
    type VARCHAR(255)
);

-- Table for Matches_England (assuming the table name from the ER diagram)
CREATE TABLE Matches_England (
    ID INT PRIMARY KEY,
    date DATE,
    duration INT,
    gameweek INT,
    label VARCHAR(255),
    roundID INT,
    seasonID INT,
    status VARCHAR(255),
    venue VARCHAR(255),
    winner VARCHAR(255),
    teamData TEXT,
    score VARCHAR(255),
    competitionID INT,
    referees TEXT,
    team1formation VARCHAR(255),
    team1scoreP INT,
    team1scoreHT INT,
    team1scoreET INT,
    team2formation VARCHAR(255),
    team2scoreP INT,
    team2scoreHT INT,
    team2scoreET INT,
    FOREIGN KEY (competitionID) REFERENCES Competitions(ID)
);

-- Table for Events_England (assuming the table name from the ER diagram)
CREATE TABLE Events_England (
    ID INT PRIMARY KEY,
    positionsX INT,
    positionsY INT,
    matchPeriod VARCHAR(255),
    eventSec FLOAT,
    matchID INT,
    eventID INT,
    subeventID INT,
    eventName VARCHAR(255),
    subeventName VARCHAR(255),
    tagID INT,
    playerID INT,
    teamID INT,
    FOREIGN KEY (matchID) REFERENCES Matches_England(ID),
    FOREIGN KEY (eventID,subeventID) REFERENCES EventNames(eventID,subeventID),
    FOREIGN KEY (tagID) REFERENCES TagNames(tagID),
    FOREIGN KEY (playerID) REFERENCES Players(ID),
    FOREIGN KEY (teamID) REFERENCES Teams(ID)

);

-- Table for EventNames
CREATE TABLE EventNames (
    eventID INT,
    subeventID INT,
    PRIMARY KEY (eventID,subeventID),
    eventlabel VARCHAR(255),
    subeventlabel VARCHAR(255)
);

-- Table for TagNames
CREATE TABLE TagNames (
    tagID INT PRIMARY KEY,
    label VARCHAR(255),
    description TEXT
);

CREATE TABLE Player_Ranks (
    playerID INT,
    matchID INT,
    PRIMARY KEY (playerID, matchID),
    score INT,
    minutesPlayed INT,
    role VARCHAR(255),
    FOREIGN KEY (playerID) REFERENCES Players(ID),
    FOREIGN KEY (matchID) REFERENCES matches_England(ID)
);

CREATE TABLE Player_Games(
    playerID INT,
    matchID INT,
    PRIMARY KEY (playerID, matchID),
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    birthDate DATE,
    birthArea VARCHAR(255),
    preferredFoot VARCHAR(50),
    height INT,
    minutesPlayed INT,
    jerseyNumber INT,
    FOREIGN KEY (playerID) REFERENCES Players(ID),
    FOREIGN KEY (matchID) REFERENCES matches_England(ID)

);