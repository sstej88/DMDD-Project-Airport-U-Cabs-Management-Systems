/* Adding data into passengers will automatically add data into the Uber System using trigger */
DECLARE
    PROCEDURE_OUTPUT NUMBER;
    IS_VALID_OFFICER NUMBER;
BEGIN
    ADD_TO_PASSENGERS('U1814167', 777777777801, 'SAI TEJ SUNKARA', 'IND', 'EVERGREEN, BOSTON', 'I97334885', PROCEDURE_OUTPUT, IS_VALID_OFFICER);
END;

TRUNCATE TABLE CAB_DETAILS;

DECLARE
    PROCEDURE_OUTPUT NUMBER;
    IS_VALID_OFFICER NUMBER;
BEGIN
    ADD_TO_PASSENGERS('E2854667', 777777777801, 'TESTING PASSENGER', 'IND', 'TESTING, BOSTON', 'L92332285', PROCEDURE_OUTPUT, IS_VALID_OFFICER);
END;

SELECT * FROM UBER_SERVICES;

CREATE VIEW UBER_SERVICES_VIEW AS SELECT * FROM UBER_SERVICES;

COMMIT;