/*
Question: What skills are required 
for the top 10 highest-paying Data Analyst jobs ??
*/


SELECT job_title,
       job_location,
       salary_year_avg, 
       name AS company_name,
       skills 
FROM    job_postings_fact jp 
JOIN    company_dim cd 
ON      jp.company_id = cd.company_id
JOIN    skills_job_dim sj
ON      sj.job_id = jp.job_id
JOIN    skills_dim sd
ON      sd.skill_id = sj.skill_id
WHERE 
        job_title_short = 'Data Analyst'
AND     job_location = 'Anywhere'
AND     salary_year_avg IS NOT NULL
ORDER BY  
        salary_year_avg DESC
LIMIT 50; 


-- or USING CTEsss !!!


    WITH SIDE_CTE AS 
(
    SELECT *
FROM    job_postings_fact jp 
JOIN    company_dim cd 
ON       jp.company_id = cd.company_id
WHERE 
        job_title_short = 'Data Analyst'
AND     job_location = 'Anywhere'
AND     salary_year_avg IS NOT NULL
ORDER BY  
        salary_year_avg DESC
LIMIT 10 
) 

SELECT * 
FROM SIDE_CTE
JOIN skills_job_dim ON SIDE_CTE.job_id = skills_job_dim.job_id



WITH MAIN_CTE AS
(
    WITH SIDE_CTE AS 
(
    SELECT *
FROM    job_postings_fact jp 
JOIN    company_dim cd 
ON       jp.company_id = cd.company_id
WHERE 
        job_title_short = 'Data Analyst'
AND     job_location = 'Anywhere'
AND     salary_year_avg IS NOT NULL
ORDER BY  
        salary_year_avg DESC
LIMIT 10 
) 

SELECT * 
FROM SIDE_CTE
JOIN skills_job_dim ON SIDE_CTE.job_id = skills_job_dim.job_id
)
SELECT job_title,
       job_location,
       salary_year_avg, 
       name AS company_name, 
       skills 
FROM MAIN_CTE 
JOIN skills_dim ON MAIN_CTE.skill_id = skills_dim.skill_id
LIMIT 10;

 

