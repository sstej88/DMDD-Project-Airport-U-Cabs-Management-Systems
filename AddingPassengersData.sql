/*
    Problem Statement: Using the procedures created, we will insert the data into the table "PASSENGERS_DATA"
    Outline: When Customs officer enters the passengers data into his/her system, system will call these functions to enter the passengers data
*/

/* It is just to show the functionality of the table. Final running will use this table */

/* TRUNCATING TABLE PASSENGERS_DATA */
TRUNCATE TABLE PASSENGERS_DATA;

/* Executing the procedures created to add the passengers || Inserting data into the Passengers Data table */
DECLARE
    PROCEDURE_OUTPUT NUMBER;
    IS_VALID_OFFICER NUMBER;
BEGIN
    ADD_TO_PASSENGERS('U1852134', 777777777777, 'STACY', 'ENG', 'RIVERWAY, BOSTON', 'I94333762', PROCEDURE_OUTPUT, IS_VALID_OFFICER);
END;

DECLARE
    PROCEDURE_OUTPUT NUMBER;
    IS_VALID_OFFICER NUMBER;
BEGIN
    ADD_TO_PASSENGERS('T1853125', 777777777789, 'PORT JANE', 'SPN', 'EVERGREEN, BOSTON', 'I94333763', PROCEDURE_OUTPUT, IS_VALID_OFFICER);
END;

DECLARE
    PROCEDURE_OUTPUT NUMBER;
    IS_VALID_OFFICER NUMBER;
BEGIN
    ADD_TO_PASSENGERS('E1852134', 777777777789, 'WADE SETH', 'FRA', 'BROOKLINE, BOSTON', 'I94333764', PROCEDURE_OUTPUT, IS_VALID_OFFICER);
END;

DECLARE
    PROCEDURE_OUTPUT NUMBER;
    IS_VALID_OFFICER NUMBER;
BEGIN
    ADD_TO_PASSENGERS('T1256167', 777777777801, 'RILEY JORGE', 'SAF', 'PLANE J., BOSTON', 'I94333765', PROCEDURE_OUTPUT, IS_VALID_OFFICER);
END;

/* Showing passengers data which is inserted into the database */
SELECT * FROM PASSENGERS_DATA;

CREATE OR REPLACE VIEW PASSENGERS_DATA_VIEW AS SELECT * FROM PASSENGERS_DATA;

COMMIT;