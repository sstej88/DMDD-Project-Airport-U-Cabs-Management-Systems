
/* Adding Payment Data */
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


/* Cab Returning to Airport - Execute from Cab Drivers User */

EXEC CAB_IS_OPEN_TO_HIRE(1111);