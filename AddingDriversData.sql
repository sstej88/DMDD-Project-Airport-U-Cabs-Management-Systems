
EXEC ADD_DRIVER('Allaire');
EXEC ADD_DRIVER('Babineaux');
EXEC ADD_DRIVER('Gagnon');
EXEC ADD_DRIVER('Montagne');
EXEC ADD_DRIVER('Vincent');
EXEC ADD_DRIVER('Roche');

SELECT * FROM DRIVER_DETAILS;

DROP TABLE DRIVER_DETAILS;

COMMIT;