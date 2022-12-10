CREATE TABLE PAYMENT_DETAILS 
(
    PAYMENT_ID NUMBER(12) GENERATED ALWAYS as IDENTITY(START WITH 121212121212 INCREMENT BY 2),
    CARD_NUMBER NUMBER(16) NOT NULL,
    TRANSACTION_TIME DATE NOT NULL,
    BILLING_ADDRESS VARCHAR2(60) NOT NULL,
    PASSENGER_ID NUMBER(12) UNIQUE NOT NULL
);

ALTER TABLE PAYMENT_DETAILS ADD PRIMARY KEY (PAYMENT_ID);

ALTER TABLE PAYMENT_DETAILS ADD FOREIGN KEY (PASSENGER_ID) REFERENCES PASSENGERS_DATA (PASSENGER_ID);

CREATE OR REPLACE PROCEDURE ADD_PAYMENT_DETAILS 
(
    INPUT_PASSENGER_ID IN NUMBER,
    INPUT_CARD_NUMBER IN NUMBER,
    INPUT_BILLING_ADDRESS OUT VARCHAR2
)
AS
BEGIN
    SELECT DESTINATION_ADDRESS INTO INPUT_BILLING_ADDRESS FROM PASSENGERS_DATA WHERE PASSENGER_ID=INPUT_PASSENGER_ID;
    INSERT INTO PAYMENT_DETAILS (CARD_NUMBER, TRANSACTION_TIME, BILLING_ADDRESS, PASSENGER_ID) 
    VALUES (INPUT_CARD_NUMBER, CURRENT_TIMESTAMP, INPUT_BILLING_ADDRESS, INPUT_PASSENGER_ID);
    UPDATE AIRPORT_TAXI_BOOKING_MACHINE SET PAYMENT_ID=(SELECT PAYMENT_ID FROM PAYMENT_DETAILS WHERE PASSENGER_ID=INPUT_PASSENGER_ID) WHERE PASSENGER_ID=INPUT_PASSENGER_ID;
    UPDATE AIRPORT_TAXI_BOOKING_MACHINE SET CARD_NUMBER=(SELECT CARD_NUMBER FROM PAYMENT_DETAILS WHERE PASSENGER_ID=INPUT_PASSENGER_ID) WHERE PASSENGER_ID=INPUT_PASSENGER_ID;
    UPDATE AIRPORT_TAXI_BOOKING_MACHINE SET TAXI_BOOKING_STATUS=1 WHERE PASSENGER_ID=INPUT_PASSENGER_ID;
    DBMS_OUTPUT.PUT_LINE('Payment is done successfully! Please check the Taxi vending machine for update');
END;

DECLARE
    BILLING_ADDRESS VARCHAR2(60);
BEGIN
    ADD_PAYMENT_DETAILS(100000000011, 2222405343248877, BILLING_ADDRESS);
END;

DECLARE
    BILLING_ADDRESS VARCHAR2(60);
BEGIN
    ADD_PAYMENT_DETAILS(100000000012, 2222990905257051, BILLING_ADDRESS);
END;

SELECT * FROM AIRPORT_TAXI_BOOKING_MACHINE;

CREATE VIEW AIRPORT_TAXI_BOOKING_MACHINE_WITH_UPDATED_PAYMENTS AS SELECT * FROM AIRPORT_TAXI_BOOKING_MACHINE;

DROP TABLE PAYMENT_DETAILS;

COMMIT;