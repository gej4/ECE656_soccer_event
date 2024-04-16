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

-
