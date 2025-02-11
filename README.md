# 🥼 Healthcare
<img src="https://github.com/lengvangz/images/blob/main/healthcare.png" alt="Image" width="75%" height="75%">

## 📖 Table of Contents
- [Situation](#Situation)
- [Task](#Task)
- [Actions](#Actions)
	- [Dashboard](#Dashboard)
	- [SQL](#SQL) 	

***

## Situation 
Yaroslav got married recently. A year into their marriage, his wife shared the exciting news that she was pregnant. Motivated by this, Yaroslav decided to invest in a coffee vending machine as a source of income. He also began collecting data to help maximize his earnings.

***

## Task
Yaroslav wants to analyze the data to answer some key questions about his business, including time series trends, sales predictions for the next day, week, and month, and customer purchase behaviors. 

***

## Actions 

### Dashboard

[<img src="https://github.com/lengvangz/images/blob/main/coffee%20sales%20dashboard.png" alt="Image" width="75%" height="75%">](https://public.tableau.com/app/profile/leng.vang/viz/coffeesales_17369660569190/Dashboard1#1)

click on image for the interactive version

### SQL 

** What is the average age of patients for each test result category?**

````sql
SELECT
	test_results,
	ROUND(AVG(age),2)
FROM
	healthcare.dataset
GROUP BY
	test_results;

````

#### Answer:
| test_results | avg |
| ----------- | ----------- |
| Abnormal           | 51.63          |
| Inconclusive           | 51.68          |
| Normal           | 51.32          |

***

**Are there significant gender-based differences in test outcomes?**

````sql
SELECT
	test_results,
	gender,
	ROUND(AVG(age),2)
FROM
	healthcare.dataset
GROUP BY
	test_results,
	gender
ORDER BY
	test_results;

````

#### Answer:
| coffee_name | count | count |
| ----------- | ----------- | ----------- |
| Abnormal | Male           | 51.61 | 
| Abnormal | Female           | 51.64 | 
| Inconclusive | Male           | 51.78 | 
| Inconclusive | Female           | 51.58 | 
| Normal | Male           | 51.32 | 
| Normal | Female           | 51.31 | 

***

**Which age group has the highest rate of abnormal test results?**

````sql
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
	test_results;

````

#### Answer:
| test_results | children  | young_adult  | older_adult  | senior  |    
| ----------- | ----------- | 
| Abnormal           | 47  | 4240  | 8373  | 5457 |        
| Inconclusive           | 33  | 4193 | 8223  | 5379 |         
| Normal           | 36 | 4400 | 8096  | 5414 |        	   

***

**Which medical conditions are most commonly associated with abnormal test results?**

````sql
SELECT 
	medical_condition,
	COUNT(*)
FROM 
	healthcare.dataset
GROUP BY
	medical_condition
ORDER BY 
	COUNT(*) DESC
````

#### Answer:
| medical_condition | count  |
| ----------- | ------------- |
| Arthritis           | 9308  	      | 
| Diabetes           | 9304         |
| Hypertension           | 9245         |
| Obesity	      | 9231         |
| Cancer	      | 9227         |
| Asthma	      | 9185         | 

***

**Are there specific medical conditions that result in longer hospital stays on average?**

````sql
SELECT 
	medical_condition,
	AVG(discharge_date - date_of_admission) AS hospital_stay
FROM
	healthcare.dataset
GROUP BY
	medical_condition
ORDER BY
	hospital_stay DESC
````

#### Answer:
| medical_condition | hospital_stay  |  
| ----------- | ------------- |  
| Asthema           | 15.70  	      |
| Arthritis          | 15.52         |
| Cancer           | 15.50         |
| Hypertension	      | 15.46         |
| Obesity	      | 15.46        |
| Diabetes	      | 15.42         |

***

**Does blood type have any significant relationship with the frequency of abnormal or inconclusive test results?**

````sql
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
````

#### Answer:
| test_results | blood_type  | count | 
| ----------- | ----------- | ------------ |
| Inconclusive           | B+  | 2366        |
| Normal           | AB- | 2362        |
| Abnormal	      | B- | 2348	   |
| Abnormal	      | O+ | 2347	   |
| Abnormal	      | A-  | 2336	   |

PS. The answer above shows 5 out of 24 rows

***

**Which day of the week has the highest number of discharges? **

````sql
SELECT
	discharge_date,
	COUNT(*) as num_discharge
FROM
	healthcare.dataset
GROUP BY
	discharge_date
ORDER BY
	COUNT(*) DESC
````

#### Answer:
| discharge_date | num_dischrage |  
| ----------- | ----------- | 
| 2020-03-15           | 53         | 
| 2021-12-13           | 51         |
| 2023-04-29           | 51         | 


***

