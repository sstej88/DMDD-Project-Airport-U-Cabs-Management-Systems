/*
    Problem Statement: Creating a procedure to validate whether customs officer exists in the database and adding the passengers by the valid customs officer
    Outline: Customs officer will be entering the passengers data after the customs check in the airport
*/

/* Setting server output on to get the output from procedueres */
SET SERVEROUTPUT ON;

/* Create procedure to add the customs officer in the database */
CREATE OR REPLACE PROCEDURE ADD_TO_CUSTOMS_OFFICERS 
(
    INPUT_OFFICER_NAME IN VARCHAR2,
    INPUT_OFFICER_COUNTRY IN VARCHAR2 DEFAULT 'USA'
)
AS
BEGIN
    IF INPUT_OFFICER_COUNTRY IN ('USA') THEN
        INSERT INTO CUSTOMS_OFFICERS (OFFICER_FULL_NAME)
        VALUES (INPUT_OFFICER_NAME);
        DBMS_OUTPUT.PUT_LINE('OFFICER WITH NAME '||INPUT_OFFICER_NAME||' IS INSERTED');
    ELSE
        INSERT INTO CUSTOMS_OFFICERS (OFFICER_COUNTRY, OFFICER_FULL_NAME)
        VALUES (INPUT_OFFICER_COUNTRY, INPUT_OFFICER_NAME);
        DBMS_OUTPUT.PUT_LINE('OFFICER WITH NAME '||INPUT_OFFICER_NAME||' AND ORIGIN COUNTRY '||INPUT_OFFICER_COUNTRY||' IS INSERTED');
    END IF;
END;

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
    INPUT_PASSENGER_NAME IN VARCHAR2, 
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

COMMIT;