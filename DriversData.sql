/*
    Problem Statement: Create a table to store the driver's details and write procedures to add the driver's data in the database
    Outline: Now working through the Uber Systems, it is mandatory that Uber should have the data of all the drivers in their database.
*/

/* Creating a table to store drivers details */
CREATE TABLE DRIVER_DETAILS 
(
    DRIVER_ID NUMBER(4) GENERATED ALWAYS as IDENTITY(START WITH 2222 INCREMENT BY 1),
    DRIVER_NAME VARCHAR2(60) NOT NULL,
    DRIVER_RATING FLOAT DEFAULT 9.9 NOT NULL,
    CONSTRAINT PK_DRIVER_DETAILS PRIMARY KEY (DRIVER_ID)
);

/* 
    Problem Statement: Procedure to add the driver to the database.
*/
CREATE OR REPLACE PROCEDURE ADD_DRIVER 
(
    INPUT_DRIVER_NAME IN VARCHAR2
)
AS
BEGIN
    INSERT INTO DRIVER_DETAILS (DRIVER_NAME) VALUES (INPUT_DRIVER_NAME);
    DBMS_OUTPUT.PUT_LINE('DRIVER WITH NAME '||INPUT_DRIVER_NAME||' IS INSERTED');
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('DRIVER CANNOT BE ADDED DUE TO EXCEPTION');
END;

/*
    In order to asssign the cab to the passenger, we need to check whether the given driver is available or not. So we write a function for that.
*/

CREATE OR REPLACE FUNCTION GET_DRIVER_EXISTENCE (INPUT_DRIVER_ID NUMBER) RETURN NUMBER
AS
    OUTPUT_IS_DRIVER_EXISTING NUMBER;
BEGIN
    SELECT COUNT(*) INTO OUTPUT_IS_DRIVER_EXISTING
    FROM DRIVER_DETAILS
    WHERE DRIVER_ID = INPUT_DRIVER_ID;
    RETURN OUTPUT_IS_DRIVER_EXISTING;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('DRIVER EXISTENCE IS NOT VERIFIED');
END;

/* Since uber is already having the data of all drivers with it, to associate the driver to the cab, they can just extract name of driver from driver ID. The function is written as follows. */

CREATE OR REPLACE FUNCTION GET_DRIVER_NAME (INPUT_DRIVER_ID NUMBER) RETURN VARCHAR2
AS
    OUTPUT_NAME VARCHAR2(60);
BEGIN
    SELECT DRIVER_NAME INTO OUTPUT_NAME
    FROM DRIVER_DETAILS
    WHERE DRIVER_ID = INPUT_DRIVER_ID;
    RETURN OUTPUT_NAME;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('DRIVER NAME IS NOT VERIFIED');
END;

/* Similar to above function, we need to get the rating of the driver from the database. So it is retrieved in this manner. */

CREATE OR REPLACE FUNCTION GET_DRIVER_RATING (INPUT_DRIVER_ID NUMBER) RETURN FLOAT
AS
    OUTPUT_RATING FLOAT;
BEGIN
    SELECT DRIVER_RATING INTO OUTPUT_RATING
    FROM DRIVER_DETAILS
    WHERE DRIVER_ID = INPUT_DRIVER_ID;
    RETURN OUTPUT_RATING;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('DRIVER RATING IS NOT VERIFIED');
END;

/* Commiting the data */
COMMIT;