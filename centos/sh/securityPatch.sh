#!/bin/bash
psql -h localhost -d adcms -U adcsmartdba -c "ALTER TABLE MNG_ACCNT ADD COLUMN HISTORY VARCHAR NULL DEFAULT NULL, ADD COLUMN CHANGED_TIME TIMESTAMP NULL"
psql -h localhost -d adcms -U adcsmartdba -c "UPDATE MNG_ACCNT SET CHANGED_TIME = NOW() WHERE CHANGED_TIME IS NULL"
echo "done"