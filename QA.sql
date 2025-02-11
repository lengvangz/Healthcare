-- What is the average age of patients for each test result category?

SELECT
	test_results,
	AVG(age)
FROM
	healthcare.dataset
GROUP BY
	test_results

-- Are there significant gender-based differences in test outcomes?

SELECT
	test_results,
	gender,
	AVG(age)
FROM
	healthcare.dataset
GROUP BY
	test_results,
	gender
ORDER BY
	test_results

-- Which age group has the highest rate of abnormal test results?

SELECT
	test_results,
	COUNT(CASE 
			WHEN age < 18 THEN 1
		END) AS children,
	COUNT(CASE
			WHEN age BETWEEN 19 AND 34 THEN 1
		END) AS young_adult,
	COUNT(CASE
			WHEN age BETWEEN 35 AND 64 THEN 1
		END) AS older_adult,
	COUNT(CASE 
			WHEN age > 65 THEN 1
		END) AS senior

FROM
	healthcare.dataset
GROUP BY
	test_results
ORDER BY
	test_results

-- Which medical conditions are most commonly associated with abnormal test results?

SELECT 
	medical_condition,
	COUNT(*)
FROM 
	healthcare.dataset
GROUP BY
	medical_condition
ORDER BY 
	COUNT(*) DESC

-- Are there specific medical conditions that result in longer hospital stays on average?

SELECT 
	medical_condition,
	AVG(discharge_date - date_of_admission) AS hospital_stay
FROM
	healthcare.dataset
GROUP BY
	medical_condition
ORDER BY
	hospital_stay DESC

-- Does blood type have any significant relationship with the frequency of abnormal or inconclusive test results?

SELECT 
	test_results,
	blood_type,
	COUNT(*)
FROM
	healthcare.dataset
GROUP BY
	test_results,
	blood_type
ORDER BY
	COUNT(*) DESC

-- Which day of the week has the highest number of discharges?

SELECT
	discharge_date,
	COUNT(*)
FROM
	healthcare.dataset
GROUP BY
	discharge_date
ORDER BY
	COUNT(*) DESC

-- Does the length of stay vary significantly based on test results?

SELECT
	test_results,
	SUM(discharge_date - date_of_admission) AS hospital_stay
FROM
	healthcare.dataset
GROUP BY
	test_results

-- Is there a correlation between the date of admission and the likelihood of inconclusive test results?

SELECT
	EXTRACT(MONTH FROM date_of_admission) AS month_of_addmission,
	COUNT(*)
FROM
	healthcare.dataset
WHERE
	test_results = 'Inconclusive'
GROUP BY 
	month_of_addmission
ORDER BY
	month_of_addmission

-- What are the most significant predictors of abnormal test results?

SELECT
	age,
	gender,
	blood_type,
	medical_condition,
	COUNT(*)
FROM 
	healthcare.dataset
WHERE
	test_results = 'Abnormal'
GROUP BY
	age,
	gender,
	blood_type,
	medical_condition
ORDER BY
	COUNT(*) DESC
LIMIT 7

