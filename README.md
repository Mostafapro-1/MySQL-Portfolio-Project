Excited to Share My Latest Portfolio Projects using MySQL 






PROJECT 1: 

Data Cleaning & Preparation

Goal: Transform raw data into a reliable, analysis-ready dataset.

Steps I Took:

1️⃣ Removed Duplicates

Used ROW_NUMBER() with PARTITION BY to identify duplicates.

Created staging tables to safely delete duplicates without altering raw data.

2️⃣ Standardized Data

Trimmed whitespace in text columns (e.g., company).

Fixed inconsistent categories (e.g., unifying “Crypto” and “Crypto Currency” into one category).

Converted text-based date to a proper DATE type using STR_TO_DATE().

3️⃣ Handled Missing Values

Populated blank industry fields (e.g., Airbnb → Travel).

Removed rows where critical metrics (total_laid_off, percentage_laid_off) were missing.

4️⃣ Optimized Structure

Dropped unnecessary columns and rows to streamline the dataset.





PROJECT 2:

Exploratory Data Analysis

Goal: Uncover trends in global layoffs and company performance.

Key Insights:

1️⃣  Biggest Layoffs

Identified companies with 100% layoffs (e.g., Casper).

Analyzed layoffs by industry, stage, and location (Travel, United States, and late-stage companies hit hardest).

2️⃣ Trends Over Time

Calculated rolling monthly layoffs using a CTE and SUM() OVER (ORDER BY date).

Found a significant spike in layoffs post-2020.

3️⃣ Top Performers

Companies with the most layoffs (Amazon, Google), and industries like Consumer and Transportation leading the list.



Tools & Techniques Used:

1. MySQL for end-to-end data management.

2. Window Functions (ROW_NUMBER(), SUM() OVER).

3. CTEs for modular, readable queries.

4. Data Type Conversions (text → date).



Lessons Learned:

✅ This project not only sharpened my SQL skills but also deepened my understanding of data integrity and preprocessing techniques. I’m looking forward to applying these practices in future projects and exploring more advanced data analytics.

