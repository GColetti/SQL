/*Look through Lesson 06b Where and Order By.sql and run the code examples there, then
   practice restricting and sorting data with the excercises below:
*/


-- 1) Show the last name and salary of those employees who earn  more than $12000.
        SELECT last_name, salary
            FROM employees
            WHERE salary > 12000;


-- 2) Display the last name and department number of employee 176.
        SELECT last_name, department_id
            FROM employees
            WHERE employee_id = 176;


/* 3)Display the last name and salary of those employees whose salary is not in the range of $5,000 to $12,000. */
        SELECT last_name, salary
            FROM employees
            WHERE salary NOT BETWEEN 5000 AND 12000;


/* 4) Show the first and last name, salary, and hire date for employees with 
      the last names Matos or Taylor. */
        SELECT first_name, last_name, salary, hire_date
            FROM employees
            WHERE last_name IN ('Matos', 'Taylor');


/* 5) Display the last name and department id of all employees in departments 20
      and 50. Sort the result by last name. */ 
        SELECT last_name, department_id
            FROM employees
            WHERE department_id IN (20, 50)
            ORDER BY last_name;
      

/* 6) Display the last name, salary, and department of employees who earn 
      between $5,000 and $10,000 and are in department 60 or 80. Label the 
      columns Employee and monthly_salary. */
        SELECT last_name, salary, department_id
                FROM employees
                WHERE salary BETWEEN 5000 AND 10000
                AND department_id IN (60, 80)


-- 7) Show the last name and hire date for all emplyees hired in 2004.
        SELECT last_name, hire_date
                FROM employees
                WHERE hire_date LIKE '%2004';
      
  
-- 8) Show the last name and job id of all employees who do not have a manager.
        SELECT last_name, job_id
                FROM employees
                WHERE manager_id IS NULL;


/* 9) Display the last_name, salary, and commission of all employees who earn
      a commission. Sort the result in descending order of salary and commission.
      Use the columns' numeric position in the order by clause. */
        SELECT last_name, salary, commission_pct
                FROM employees
                WHERE commission_pct IS NOT NULL
                ORDER BY 2, 3 DESC;

      
/*  10) Show the last name and salary of employees who earn more than an amount
        the user specifies when prompted. */
        SELECT last_name, salary
                FROM employees
                WHERE salary > '&sal';
        
    
/*  11) Write a query that prompts the user for a manager id and generates 
        employee id, last name, salary and department for that manager's employees.
        Ensure the the report is sorted by a column of the user's choice. */
        SELECT employee_id, last_name, salary, department_id
                WHERE manager_id = '&managerid'
                ORDER BY '&col';
        
        
--  12) Show all last names that have "a" as the third letter.\
        SELECT last_name
                FROM employees
                WHERE last_name LIKE '__a%';


/*  13) Display all last names of employees who have both an "a" and an "e" 
        in their last name. */
        SELECT last_name
                FROM employees
                WHERE last_name LIKE '%a%e%';


/*  14) Show the last name, job, and salary for all employees who are either a
        sales representative or stock clerk, and whose salary is not $2,500, 
        $3,500, or $7,000. Order the result by salary within job. */
        SELECT last_name, job_id, salary
                FROM employees
                WHERE job_id IN ('SA_REP', 'ST_CLERK')
                AND salary NOT IN (2500, 3500, 7000)
                ORDER BY salary;
        
        
/*  15) Show the last name, salary and commission of those employees whose 
        commission is 20%. */
        SELECT last_name, salary, commission_pct
                FROM employees
                WHERE commission_pct = 20;
  

/* 16) Display street address, city, state/province, and a fourth column
        of your choice, either postal code or country id for any row that has
        a state/province value. Sort the result by this fourth column. 
        Prompt the user only once to enter the fourth column name. Make sure 
        you clear the subtitution variable's value from session memory when 
        you are done, so you can run the query again with 
        a different fourth column. */
        SELECT street_address, city, state_province, '&col'
                FROM employees
                ORDER BY '&col';
        
        
        
        
        
        
        