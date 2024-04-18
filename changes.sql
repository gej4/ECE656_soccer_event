--1
ALTER TABLE events_England
DROP COLUMN subEventName;

ALTER TABLE events_England
DROP COLUMN eventName;

--2

ALTER TABLE events_England
DROP COLUMN teamID;

--3
ALTER TABLE matches_England
DROP COLUMN teamsData;

--5
CREATE TABLE TeamsData(     matchID INT PRIMARY KEY,  team1side VARCHAR(50),     team1formation TEXT,     team1_hasFormation TINYINT(1),     team1score INT,     team1scoreP INT,     team1scoreHT INT,     team1scoreET INT,   team2formation TEXT,     team2side VARCHAR(50),      team2score INT,     team2_hasFormation TINYINT(1),     team2scoreP INT,     team2scoreHT INT,     team2scoreET INT,  FOREIGN KEY (matchID) REFERENCES Matches_England(ID) )
INSERT INTO TeamsData(matchId, team1side, team1formation, team1_hasFormation, team1score, team1scoreP, team1scoreHT, team1scoreET,team2formation, team2side, team2score, team2_hasFormation, team2scoreP, team2scoreHT, team2scoreET)  SELECT wyId,team1_side, team1_formation, team1_hasFormation, team1_score, team1_scoreP, team1_scoreHT, team1_scoreET,team2_formation, team2_side, team2_score, team2_hasFormation, team2_scoreP, team2_scoreHT, team2_scoreET FROM matches_England 
ALTER TABLE matches_England DROP COLUMN team1_coachId, DROP COLUMN team1_formation, DROP COLUMN team1_hasFormation, DROP COLUMN team1_score, DROP COLUMN team1_scoreET, DROP COLUMN team1_scoreHT, DROP COLUMN team1_scoreP, DROP COLUMN team1_side, DROP COLUMN team2_coachId, DROP COLUMN team2_formation, DROP COLUMN team2_hasFormation, DROP COLUMN team2_score, DROP COLUMN team2_scoreET, DROP COLUMN team2_scoreHT, DROP COLUMN team2_scoreP, DROP COLUMN team2_side

--6
ALTER TABLE playerank
ADD COLUMN jerseyNumber TINYINT(1),
ADD COLUMN is_starter TINYINT(1);

INSERT INTO playerank (jerseyNumber, is_starter)
SELECT jersey_Number, is_starter 
FROM player_games JOIN playerank using (playerID)

ALTER TABLE player_games
DROP COLUMN jersey_Number,
DROP COLUMN is_starter;









