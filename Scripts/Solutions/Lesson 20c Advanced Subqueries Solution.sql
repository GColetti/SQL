/*Look through Lesson 20b Advanced Subqueries.sql and run the code examples there, 
then practice advanced subqueries with the excercises below:
*/
--Practice advanced subqueries

/*1)  Show those employees who earn the lowest salary in their department, using  
      a correlated subquery. Display the employee number, first and last names, 
      their job, salary, manager name and department name. Use a correlated subquery
      to retrieve the lowest salary for the employee's department.
      Sort the result by salary. */
  
  SELECT e.employee_id, e.first_name, e.last_name, e.job_id, e.salary,
      b.first_name as mgr_fname, b.last_name as mgr_lname, department_name
      FROM employees e JOIN employees b on e.manager_id = b.employee_id
      JOIN departments d on e.department_id = d.department_id
      AND e.salary = (SELECT MIN(salary)
                        FROM employees
                        WHERE department_id = e.department_id)
      ORDER BY 5;

/* 2) Show the above result using using pairwise comparison, instead of a correlated
      subquery.

  SELECT e.employee_id, e.first_name, e.last_name, e.job_id, e.salary,
      b.first_name as mgr_fname, b.last_name as mgr_lname, department_name
      FROM employees e JOIN employees b on e.manager_id = b.employee_id
      JOIN departments d on e.department_id = d.department_id
      AND (e.department_id, e.salary) IN (SELECT department_id, MIN(salary)
                                              FROM employees
                                              GROUP BY department_id)
      ORDER BY 5;

/* 3) Use the EXISTS operator to show the departments in the departments table
      that are found in the employees table. Show the department number and name. */
  
  SELECT department_id, department_name
    FROM departments d
    WHERE EXISTS (SELECT 'x'
                    FROM employees
                    WHERE department_id = d.department_id);

--4) Now use a plain, non-correlated subquery to do the same.
    
    SELECT department_id, department_name
    FROM departments d
    WHERE department_id IN (SELECT department_id
                              FROM employees);

/* 5) Use NOT EXISTS to show those employees who do not have a previous
      job with the company. Show employee number, first and last name,
      current job and salary. */
    
    SELECT employee_id, first_name, last_name, job_id, salary
      FROM employees e
      WHERE NOT EXISTS (SELECT 'x'
                          FROM job_history
                          WHERE employee_id = e.employee_id);

/* 6) Show any employee who is now at the same job they had in the past. That is,
      they performed a job, moved on to another job, and are now back at their
      original job. Use pairwise comparison to find the result. */
  

    SELECT employee_id, first_name, last_name, job_id, salary
      FROM employees e
      WHERE (employee_id, job_id) IN (SELECT employee_id, job_id
                                        FROM job_history); 


/*  7) Use the WITH clause to find the the total pay for each salesperson whose total pay
        is below average. Total pay is salary added to the product of total sales 
        multiplied by their commission percent. Display first and last names, 
        salary, commission_pct, and total pay. Use the column alias total_pay 
        for the last column. Sort the result by total_pay descending. */

      WITH a as (
      SELECT first_name, last_name, salary, commission_pct, 
        salary + (SUM(sales_amt) * commission_pct) as total_pay
        FROM employees JOIN sales ON employee_id = sales_rep_id
        GROUP BY first_name, last_name, commission_pct, salary),
      b as (SELECT AVG(total_pay) as avg_compensation
              FROM a)
      --SELECT * FROM b;
      SELECT *
        FROM a
        WHERE total_pay < (SELECT avg_compensation
                              FROM b)
        ORDER BY total_pay DESC;


/* 8) Use the WITH clause to find those managers who manage a larger than 
      average staff. Show manager's id, first and last name, 
      and the size of their staff. Remember, there is a null manager. Include 
      it in your calculations. Use an id of 999 for it. */

 WITH a as (SELECT NVL(boss.employee_id,999) as boss_id, boss.first_name, 
             boss.last_name, count(*) as size_of_staff
              FROM employees e LEFT OUTER JOIN employees boss 
              ON e.manager_id = boss.employee_id
              GROUP BY boss.employee_id, boss.first_name, boss.last_name
              ORDER BY boss_id),
    b as( SELECT round(AVG(size_of_staff),2) AS avg_staff_size
            FROM a)
  --SELECT * FROM b;
  SELECT * 
    FROM a
    WHERE size_of_Staff > (SELECT avg_staff_size
                              FROM b);
   
