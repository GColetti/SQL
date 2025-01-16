/*Look through Lesson 10b Aggregating Data Using Group Functions.sql and run the code examples there, then
   practice Group Functions with the excercises below:
*/
--Practice Group Functions

/* 1) Find the highest, lowest, sum, and average salary of all employees. 
      Label the columns Maximum, Minimum, Sum, and Average. Round any result
      two places past the decimal, if needed. */
      SELECT ROUND(MAX(salary), 2) AS Maximum, ROUND(MIN(salary), 2) AS Minimum, ROUND(SUM(salary), 2) AS Sum, ROUND(AVG(salary), 2) AS Average
      FROM employees;


-- 2) Modify query 1 to display the aggregated data for each job type.
      SELECT ROUND(MAX(salary), 2) AS Maximum, ROUND(MIN(salary), 2) AS Minimum, ROUND(SUM(salary), 2) AS Sum, ROUND(AVG(salary), 2) AS Average
      FROM employees
      GROUP BY job_id;


-- 3) Write a query that counts the number of people in each job type. 
      SELECT job_id, COUNT(job_id)
      FROM employees
      GROUP BY job_id;


-- 4) Generalize query 3 so the user is prompted to enter a job title.
      SELECT COUNT(job_id)
            FROM employees
            WHERE job_id = '&jobid';


/* 5) Display the number of distinct managers. Label the column
      Number of Managers. */ 
      SELECT COUNT(DISTINCT manager_id) AS "Number of Managers"
            FROM employees;
      
      
/* 6) Find the difference between the highest and lowest salary. Label the 
      column Difference. */
      SELECT ROUND(MAX(salary) - MIN(salary), 2) AS "Difference"
            FROM employees;
      
      
      
/* 7) Display the manager number and the salary of the lowest paid employee
      for each manager. Exclude anyone whose manager is unknown. Exclude any 
      group in which the minimum salary is $6000 or less. Sort the output in 
      descending order of lowest salary. */ 
      SELECT MIN(salary) AS "LowestSalary"
            FROM employees
            WHERE manager_id IS NOT NULL AND salary > 6000
            GROUP BY manager_id
            ORDER BY MIN(salary) DESC;
      
      
      
        