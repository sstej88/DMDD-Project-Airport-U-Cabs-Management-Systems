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

COMMIT;