/* Setting server output on to get the output from procedueres */
SET SERVEROUTPUT ON;

/* Create procedure to validate officer */
CREATE OR REPLACE PROCEDURE VALIDATE_CUSTOMS_OFFICER
(
    INPUT_OFFICER_ID IN NUMBER,
    IS_VALID_OFFICER OUT NUMBER
)
AS
BEGIN
    SELECT COUNT(*) INTO IS_VALID_OFFICER FROM CUSTOMS_OFFICERS WHERE OFFICER_ID = INPUT_OFFICER_ID;
END;

/* Creating a procedure to add the passengers in the database */
CREATE OR REPLACE PROCEDURE ADD_TO_PASSENGERS
(
    INPUT_PASSPORT_NUMBER IN VARCHAR2, 
    INPUT_VALIDATED_OFFICER_ID IN NUMBER, 
    INPUT_PASSENGER_NAME VARCHAR2, 
    INPUT_COUNTRY_OF_ORIGIN IN VARCHAR2, 
    INPUT_DESTINATION_ADDRESS IN VARCHAR2, 
    INPUT_I94_FORM_NUMBER IN VARCHAR2,
    PROCEDURE_OUTPUT OUT NUMBER,
    IS_VALID_OFFICER OUT NUMBER
)
AS
BEGIN
    VALIDATE_CUSTOMS_OFFICER(INPUT_VALIDATED_OFFICER_ID, IS_VALID_OFFICER);
    IF IS_VALID_OFFICER>0 THEN
        INSERT INTO PASSENGERS_DATA (PASSPORT_NUMBER, VALIDATED_OFFICER_ID, PASSENGER_NAME, COUNTRY_OF_ORIGIN, DESTINATION_ADDRESS, I94_FORM_NUMBER)
        VALUES (INPUT_PASSPORT_NUMBER, INPUT_VALIDATED_OFFICER_ID, INPUT_PASSENGER_NAME, INPUT_COUNTRY_OF_ORIGIN, INPUT_DESTINATION_ADDRESS, INPUT_I94_FORM_NUMBER);
        SELECT COUNT(*) INTO PROCEDURE_OUTPUT FROM PASSENGERS_DATA WHERE PASSPORT_NUMBER = INPUT_PASSPORT_NUMBER;
        DBMS_OUTPUT.PUT_LINE('OFFICER WITH OFFICER ID '||INPUT_VALIDATED_OFFICER_ID||' IS VALID OFFICER: '||IS_VALID_OFFICER);
        DBMS_OUTPUT.PUT_LINE('IS PASSENGER DATA WITH PASSPORT NUMBER '||INPUT_PASSPORT_NUMBER||' IS INSERTED INTO PASSENGERS DATA: '||PROCEDURE_OUTPUT);
    ELSE
        DBMS_OUTPUT.PUT_LINE('IS VALID OFFICER: '||IS_VALID_OFFICER);
    END IF;
END;

/* TRUNCATING TABLE PASSENGERS_DATA */
TRUNCATE TABLE PASSENGERS_DATA;

/* Executing the procedures created to add the passengers */
DECLARE
    PROCEDURE_OUTPUT NUMBER;
    IS_VALID_OFFICER NUMBER;
BEGIN
    ADD_TO_PASSENGERS('U1852134', 777777777777, 'STACY', 'ENG', 'RIVERWAY, BOSTON', 'I94333762', PROCEDURE_OUTPUT, IS_VALID_OFFICER);
    ADD_TO_PASSENGERS('T1853125', 777777777789, 'PORT JANE', 'SPN', 'EVERGREEN, BOSTON', 'I94333763', PROCEDURE_OUTPUT, IS_VALID_OFFICER);
    ADD_TO_PASSENGERS('E1852134', 777777777789, 'WADE SETH', 'FRA', 'BROOKLINE, BOSTON', 'I94333764', PROCEDURE_OUTPUT, IS_VALID_OFFICER);
    ADD_TO_PASSENGERS('T1256167', 777777777801, 'RILEY JORGE', 'SAF', 'PLANE J., BOSTON', 'I94333765', PROCEDURE_OUTPUT, IS_VALID_OFFICER);
END;

/* Showing passengers data which is inserted into the database */
SELECT * FROM PASSENGERS_DATA;

COMMIT;