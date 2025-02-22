SELECT *
FROM mostafa_khaled.dataset;

-- now when we will data cleaning following these steps:
-- 1. remove duplicates
-- 2. standardize data and fix errors
-- 3. working with null/blank values 
-- 4. remove any columns and rows that are not necessary


-- first thing we want to do is create a staging table.
-- This is the one we will work with to clean the data. 
-- We want the table with raw data untouched in case something happens.

CREATE TABLE mostafa_khaled.mostafa_staging_table
LIKE mostafa_khaled.dataset;

INSERT mostafa_staging_table
SELECT *
FROM mostafa_khaled.dataset;

SELECT * 
FROM MOSTAFA_STAGING_TABLE;

-- now when we are data cleaning
-- 1. Remove Duplicates

SELECT * ,
ROW_NUMBER() OVER (PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,
country,funds_raised_millions) AS row_num
FROM MOSTAFA_STAGING_TABLE;

WITH MOSTAFA_CTE AS
(
SELECT * ,
ROW_NUMBER() OVER (PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,
country,funds_raised_millions) AS row_num
FROM MOSTAFA_STAGING_TABLE
) 
SELECT *
FROM MOSTAFA_CTE
WHERE row_num > 1;

-- lets check if we actually got the dup
SELECT *
FROM MOSTAFA_STAGING_TABLE
WHERE company = 'Casper';

-- turns out casper is actually a dup

--  now we need to create another table to put data into it so we get to delete them
-- as we cant delete data from a CTE

CREATE TABLE `mostafa_staging_table_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM mostafa_staging_table_2;

INSERT INTO mostafa_staging_table_2
SELECT * ,
ROW_NUMBER() OVER (PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off,`date`,stage,
country,funds_raised_millions) AS row_num
FROM MOSTAFA_STAGING_TABLE;

DELETE
FROM mostafa_staging_table_2
WHERE row_num > 1;

SELECT *
FROM mostafa_staging_table_2
WHERE row_num =1;

-- done delete DUPS !!!!

-- now step 2.standardize data and fix errors
 

 SELECT company , trim(company) 
 FROM mostafa_staging_table_2;
 
 UPDATE mostafa_staging_table_2
 SET company =  trim(company);
 
 -- we trimed any space in 'company' column
 
SELECT *
FROM mostafa_staging_table_2;

SELECT DISTINCT(location)
FROM mostafa_staging_table_2;

-- nothing found
 
SELECT DISTINCT(industry)
FROM mostafa_staging_table_2;

UPDATE mostafa_staging_table_2
SET industry = 'Crypto'
WHERE industry LIKE 'crypto%';
 
SELECT industry
FROM mostafa_staging_table_2
WHERE industry LIKE '%Cry%';

-- DONE WITH INDUSTRY 
-- now changing `date` into standerd date format using STR_TO_DATE

SELECT *
FROM mostafa_staging_table_2;

SELECT `date`,
STR_TO_DATE( `date` , '%m/%d/%Y')
FROM mostafa_staging_table_2;

UPDATE mostafa_staging_table_2
SET `date` = STR_TO_DATE( `date` , '%m/%d/%Y');

ALTER TABLE mostafa_staging_table_2
MODIFY COLUMN `date` DATE;

-- done with date
-- moving on to country

SELECT DISTINCT(country)
FROM mostafa_staging_table_2;

SELECT DISTINCT(country)
FROM mostafa_staging_table_2
WHERE country like '%united%';

-- found an issue 'United States.' and another without a '.'  in 'United States'

UPDATE mostafa_staging_table_2
SET country = 'United States'
WHERE country LIKE 'United St%';

ALTER TABLE mostafa_staging_table_2
DROP COLUMN row_num;

SELECT *
FROM mostafa_staging_table_2;

-- DONE with all columns !!

-- we move to step 3.working with null/blank values 

-- first we got some issues in industry column

SELECT *
FROM mostafa_staging_table_2
WHERE  industry IS NULL
OR industry = '';

-- '' not ' ' 

SELECT *
FROM mostafa_staging_table_2
WHERE  company = 'Airbnb';

UPDATE mostafa_staging_table_2
SET industry='Travel'
WHERE company = 'Airbnb';

SELECT *
FROM mostafa_staging_table_2;


-- now removing unnecessary rows and columns


SELECT *
FROM mostafa_staging_table_2
WHERE total_laid_off = ' '
OR total_laid_off IS NULL
AND total_laid_off = ' '
OR percentage_laid_off IS NULL;

SELECT *
FROM mostafa_staging_table_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM mostafa_staging_table_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM mostafa_staging_table_2;


