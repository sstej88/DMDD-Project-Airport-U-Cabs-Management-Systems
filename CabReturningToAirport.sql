/*
    Problem Statement: Create a procedure for Uber Cabs such that whenever they reach the airport, they will be making their status as open to hire.
    Outline: At first, when passenger is added to the database by the customs officer, they are associated with open cabs in the Uber System. Suppose, the trip is successfully done and Uber Cab returns to airports, they need to put the status as Open to Hire so that other passengers will be able to book the cab.
*/
CREATE OR REPLACE PROCEDURE CAB_IS_OPEN_TO_HIRE 
(
    INPUT_CAB_ID IN NUMBER
)
AS
BEGIN
    UPDATE CAB_DETAILS SET OPEN_TO_HIRE=1 WHERE CAB_ID=INPUT_CAB_ID;
    DBMS_OUTPUT.PUT_LINE('CAB : '||INPUT_CAB_ID||' IS OPEN TO HIRE');
END;

EXEC CAB_IS_OPEN_TO_HIRE(1111);

SELECT * FROM CAB_DETAILS;

CREATE OR REPLACE VIEW CAB_DETAILS_AFTER_OPEN_TO_HIRE_VIEW AS SELECT * FROM CAB_DETAILS;

COMMIT;