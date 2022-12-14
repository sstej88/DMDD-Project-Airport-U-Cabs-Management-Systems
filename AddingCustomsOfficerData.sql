/*
    Problem Statement: Using the procedures created, we will insert the data into the table "CUSTOMS_OFFICERS"
    Outline: Admin will enter the data into the customs officer database
*/

/* It is just to show the functionality of the table. Final running will use this table */

/* TRUNCATING TABLE CUSTOMS_DATA */
TRUNCATE TABLE CUSTOMS_OFFICERS;

/* Executing the procedures created to add the passengers || Inserting data into the Passengers Data table */

EXEC ADD_TO_CUSTOMS_OFFICERS('JOHN WESLEY');

EXEC ADD_TO_CUSTOMS_OFFICERS('PETER RUSSO');

EXEC ADD_TO_CUSTOMS_OFFICERS('Maria Garcia', INPUT_OFFICER_COUNTRY => 'UAE');

EXEC ADD_TO_CUSTOMS_OFFICERS('James Johnson', INPUT_OFFICER_COUNTRY => 'ENG');

EXEC ADD_TO_CUSTOMS_OFFICERS('James Smith', 'CAD');

EXEC ADD_TO_CUSTOMS_OFFICERS('BIANCO AJELLO');

SELECT * FROM CUSTOMS_OFFICERS;

CREATE OR REPLACE VIEW CUSTOMS_OFFICERS_VIEW AS SELECT * FROM CUSTOMS_OFFICERS;

COMMIT;