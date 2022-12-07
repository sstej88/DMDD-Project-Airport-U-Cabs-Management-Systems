/*
    Problem Statement: Creating a table - In this table, customs officer will enter all the passengers information which will be further taken by the Uber Services
*/

/* To check the current user - usually it will be admin while logging into the database */
SELECT USER FROM DUAL;
SHOW USER;

/* Showing all users in the database */
SELECT * FROM all_users ORDER BY CREATED DESC;
SELECT * FROM dba_users;
SELECT * from user_users;

/* Creating customs table in the database - has access to admin only to add the customs officer in the list */
CREATE TABLE CUSTOMS_OFFICERS
(
    OFFICER_ID NUMBER(12) GENERATED ALWAYS as IDENTITY(START WITH 777777777777 INCREMENT BY 12),
    OFFICER_COUNTRY VARCHAR2(3) DEFAULT 'USA',
    OFFICER_NAME VARCHAR2(60) NOT NULL,
    CONSTRAINT PK_CUSTOMS PRIMARY KEY (OFFICER_ID)
);

ALTER TABLE CUSTOMS_OFFICERS RENAME COLUMN OFFICER_NAME TO OFFICER_FULL_NAME;

/* Only admin can add the customs officer */
INSERT INTO CUSTOMS_OFFICERS (OFFICER_FULL_NAME) VALUES ('JOHN WESLEY');
INSERT INTO CUSTOMS_OFFICERS (OFFICER_FULL_NAME) VALUES ('PETER RUSSO');
INSERT INTO CUSTOMS_OFFICERS (OFFICER_FULL_NAME) VALUES ('BIANCO AJELLO');

SELECT * FROM CUSTOMS_OFFICERS;

/* Creating a passengers table in the database - has access to admin and customs officers. Mostly used by the customs officers to add the migrated passengers */
CREATE TABLE PASSENGERS_DATA 
(
    PASSPORT_NUMBER VARCHAR2(8) NOT NULL,
    PASSENGER_ID NUMBER(12) GENERATED ALWAYS as IDENTITY(START WITH 100000000000 INCREMENT BY 1),
    VALIDATED_OFFICER_ID NUMBER(12) NOT NULL,
    PASSENGER_NAME VARCHAR2(60) NOT NULL,
    COUNTRY_OF_ORIGIN VARCHAR2(3) NOT NULL,
    DESTINATION_ADDRESS VARCHAR2(60) DEFAULT '',
    TAXI_BOOKING_STATUS NUMBER(1) DEFAULT 0,
    I94_FORM_NUMBER VARCHAR2(9) NOT NULL,
    CONSTRAINT PK_PASSENGERS_DATA PRIMARY KEY (PASSENGER_ID),
    CONSTRAINT FK_PASSENGERS_DATA_TO_CUSTOMS_OFFICER FOREIGN KEY (VALIDATED_OFFICER_ID) REFERENCES CUSTOMS_OFFICERS (OFFICER_ID)
);

/* Creating a user in the database and granting connecting, resource and storage permissions */
CREATE USER CUSTOMS_OFFICER IDENTIFIED BY Datahuskies123;
GRANT CONNECT, RESOURCE TO CUSTOMS_OFFICER;
GRANT UNLIMITED TABLESPACE TO CUSTOMS_OFFICER;

CONNECT CUSTOMS_OFFCER/Datahuskies123;

/* Commiting the operations */
COMMIT;
/* Dropping user - CASCADE is used for removing the database of the objects */
DROP USER CUSTOMS_OFFICER CASCADE;
DROP TABLE PASSENGERS_DATA;
DROP TABLE CUSTOMS_OFFICERS;