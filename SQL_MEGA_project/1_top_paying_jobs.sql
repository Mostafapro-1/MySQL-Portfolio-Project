/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries 
- BONUS: Include company names of top 10 roles
*/

SELECT *
FROM job_postings_fact;

-- top 10 highest-paying Data Analyst roles that are available remotely!

SELECT 
       job_title,
       job_location,
       salary_year_avg
FROM job_postings_fact 
WHERE job_title_short = 'Data Analyst'
AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;  

--- Focusing on job postings with specified salaries

SELECT
       job_title,
       job_location,
       salary_year_avg
FROM 
WHERE job_title_short = 'Data Analyst'
AND job_location = 'Anywhere'
AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;  

-- BONUS: Include company names of top 10 roles

SELECT 
        *
FROM job_postings_fact 
JOIN company_dim ON 
job_postings_fact.company_id = company_dim.company_id
WHERE 
        job_title_short = 'Data Analyst'
AND  job_location = 'Anywhere'
AND  salary_year_avg IS NOT NULL
ORDER BY  
        salary_year_avg DESC
LIMIT 10; 



