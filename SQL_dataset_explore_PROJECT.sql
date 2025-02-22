-- EXPLORING

-- Here we are just going to explore the data and find trends / patterns 


SELECT * 
FROM mostafa_staging_table_2;

-- finding MAX of 'total_laid_off'

SELECT MAX(total_laid_off)
FROM mostafa_staging_table_2;


-- Looking at how big these layoffs were
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM mostafa_staging_table_2
WHERE  percentage_laid_off IS NOT NULL;

-- Which companies had 1 which is basically 100 percent of they company laid off
SELECT *
FROM mostafa_staging_table_2
WHERE  percentage_laid_off = 1;


-- if we order by funcs_raised_millions we can see how big some of these companies were

SELECT *
FROM mostafa_staging_table_2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;



SELECT * 
FROM mostafa_staging_table_2;


-- SOMEWHAT TOUGHER QUERIES -- USING GROUP BY --

-- Companies with the biggest total_laid_off
SELECT company, total_laid_off
FROM mostafa_staging_table_2
ORDER BY 1,2 DESC
;


-- Companies with the most Total Layoffs
SELECT company, SUM(total_laid_off)
FROM mostafa_staging_table_2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;



-- by location
SELECT location, SUM(total_laid_off)
FROM mostafa_staging_table_2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;


SELECT YEAR(date), SUM(total_laid_off)
FROM mostafa_staging_table_2
GROUP BY YEAR(date)
ORDER BY 1 desc
limit 4;


SELECT industry, SUM(total_laid_off)
FROM mostafa_staging_table_2
GROUP BY industry
ORDER BY 2 DESC;


SELECT stage, SUM(total_laid_off)
FROM mostafa_staging_table_2
GROUP BY stage
ORDER BY 2 DESC;






-- MORE TOUGHER QUERIES --



-- Rolling Total of Layoffs Per Month
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM mostafa_staging_table_2
GROUP BY dates
ORDER BY dates ASC;

-- now use it in a CTE so we can query off of it
WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM mostafa_staging_table_2
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;