--liquibase formatted sql

--changeset SteveZ:45555-createtablecontacts labels:JIRA-1000
CREATE TABLE contacts (
  id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  firstname VARCHAR(255),
  lastname VARCHAR(255)
);
--rollback drop table contacts;

--changeset SteveZ:45555-createtableactor labels:JIRA-1000
CREATE TABLE actor (
	"Name" char(1) NULL
);
--rollback drop table actor;

--changeset MikeO:45556-altertableactor labels:JIRA-1000
ALTER TABLE actor
  ADD COLUMN twitter VARCHAR(15);
--rollback alter table actor drop column twitter;
 
--changeset AmyS:45678-createtablecolors labels:JIRA-1000
CREATE TABLE colors (
  id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  bcolor VARCHAR,
  fcolor VARCHAR
);
--rollback drop table colors;
 
--changeset BenG:45679-insertcolors labels:JIRA-1000
INSERT INTO colors (bcolor, fcolor)
VALUES
  ('red', 'red'),
  ('red', 'red'),
  ('red', NULL),
  (NULL, 'red'),
  ('red', 'green'),
  ('red', 'blue'),
  ('green', 'red'),
  ('green', 'blue'),
  ('green', 'green'),
  ('blue', 'red'),
  ('blue', 'green'),
  ('blue', 'blue');
--rollback delete from colors where bcolor = 'red' and fcolor = 'red';
--rollback delete from colors where bcolor = 'red' and fcolor IS NULL;
--rollback delete from colors where bcolor IS NULL and fcolor = 'red';
--rollback delete from colors where bcolor = 'red' and fcolor = 'green';
--rollback delete from colors where bcolor = 'red' and fcolor = 'blue';
--rollback delete from colors where bcolor = 'green' and fcolor = 'red';
--rollback delete from colors where bcolor = 'green' and fcolor = 'blue';
--rollback delete from colors where bcolor = 'green' and fcolor = 'green';
--rollback delete from colors where bcolor = 'blue' and fcolor = 'red';
--rollback delete from colors where bcolor = 'blue' and fcolor = 'green';
--rollback delete from colors where bcolor = 'blue' and fcolor = 'blue';

--changeset MikeO:50000-createtablecontacts1 labels:JIRA-1001
CREATE TABLE contacts1 (
  id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  firstname VARCHAR(255),
  lastname VARCHAR(255)
);
--rollback drop table contacts1;