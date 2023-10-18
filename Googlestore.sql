SELECT * FROM googlestore.googleplaystore;
USE googlestore;
SHOW COLUMNS FROM googleplaystore;

--  SIZE COLUMN ---
-- set the size column with 'varies with device' to NaN--
UPDATE googleplaystore
SET Size = 'NaN'
WHERE Size = 'Varies with device';

-- replace ‘M’ with ‘000 in size column--
UPDATE googleplaystore
SET Size = replace(Size, 'M','000')
WHERE Size LIKE '%M';

-- If the value in the Size column is less than 10 then multiply that value by 1000.
UPDATE googleplaystore
SET Size = CASE
WHEN Size < 10 THEN Size*1000 
ELSE Size
end;

--  replace ‘k’ with empty string--
UPDATE googleplaystore
SET Size = replace(Size, 'k','')
WHERE Size LIKE '%k';

-- to convert size column to megabytes--
UPDATE googleplaystore
SET Size = Size/1000;

-- datatype of size column changed from text to float--
ALTER TABLE googleplaystore
MODIFY COLUMN Size Float;

-----------------------
-- INSTALL Column--
UPDATE googleplaystore
SET Installs = replace(Installs, '+','')
WHERE Installs LIKE '%+';

-- INSTALL Column--
UPDATE googleplaystore
SET Installs = replace(Installs, ',','')
WHERE Installs LIKE '%,%';
-------------------------
-- LAST UPDATED column----
ALTER TABLE googleplaystore
ADD COLUMN NewLastUpdated DATETIME;

UPDATE googleplaystore
SET NewLastUpdated = STR_TO_DATE(`Last Updated`, '%M %e, %Y');

ALTER TABLE googleplaystore
DROP COLUMN `Last Updated`;

ALTER TABLE googleplaystore
CHANGE COLUMN NewLastUpdated LastUpdated DATETIME;

ALTER TABLE googleplaystore
CHANGE COLUMN LastUpdated LastUpdated DATE;






