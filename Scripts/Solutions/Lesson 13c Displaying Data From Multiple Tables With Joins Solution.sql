/*Look through Lesson 13b Displaying Data From Multiple Tables with Joins.sql and 
  run the code examples there, then practice Joins with the excercises below:
*/
--Practice Joining Tables

/* 1) Produce a query that shows addresses of all the departments. Show
      department name, location id, street address, city, and state or province. 
      Use NATURAL JOIN to produce your output.*/

      SELECT department_name, location_id, street_address, city, state_province
          FROM departments NATURAL JOIN locations;

/* 2) Produce a report showing employees who work in Toronto. Display first and 
      last name, job, department number, department name, and city. 
      Produce your results with JOIN USING.*/
     
      SELECT first_name, last_name, department_name, city, state_province
          FROM employees JOIN departments USING (department_id) 
          JOIN locations USING(location_id)
          WHERE city = 'Toronto';

/* 3) Display employee number, last name, manager's number and last name.
      Label the columns Emp#, Employee, Mgr#, Manager. Show all employees, even
      if they have no manager. Sort the result by employee's id number. */

    SELECT  e.employee_id as "Emp#" , e.last_name as employee, 
      m.employee_id AS "Mgr#", m.last_name AS manager 
      FROM employees e LEFT OUTER JOIN employees m ON e.manager_id = m.employee_id
      ORDER BY 1;


/* 4) For every department name, show the name of the country where the department
      is located. Show all countries even if the have no departments. */ 
      
      SELECT department_name, country_name
        FROM departments d JOIN locations l USING (location_id) 
        RIGHT OUTER JOIN countries c USING(country_id);
        
      
/* 5) Create a report showing employee first and last name, department number, 
      and first and last names of their department colleagues. Do not display 
      the same employee twice in any row. Label the columns appropriately to 
      clarify the results. Order the results by employee id, even
      though it is not displayed.*/
      
      SELECT e.first_name, e.last_name, e.department_id, c.first_name AS colleague_fname, 
        c.last_name AS colleague_lname
        FROM employees e JOIN employees c ON e.department_id = c.department_id
        AND e.employee_id != c.employee_id
        ORDER BY e.employee_id;
      
      
/* 6) Display last name, job, department name, salary, and salary grade level
      for all employees, even if the employee is not assigned to a department.
      Order the result by department name, job, and last name.*/ 
      
      SELECT last_name, job_id, department_name, salary, grade_level
        FROM employees e LEFT OUTER JOIN departments USING (department_id)
        JOIN SAL_GRADES ON salary BETWEEN lowest_sal AND highest_sal
        ORDER BY 3,2,1;
        
/* 7) Write a query that displays employees who have had different jobs. Show
      employee number, first and last name, hire date, previous job, previous 
      job end date, and current job. Use appropriate column aliases to clarify 
      the results. Order the result by employee id and end date. */
      
      SELECT employee_id, first_name, last_name, e.hire_date, 
          j.job_id as previous_job, j.end_date AS previous_job_end, e.job_id
          FROM employees e JOIN job_history j USING(employee_id)
          ORDER BY employee_id, end_date;
      
/* 8) Find the first and last names and hire dates of all employees who were 
      hired before their bosses. Also display the boss's last name 
      and hire date. Be sure to use apprpriate column aliases where needed. */
      
      SELECT e.first_name, e.last_name, e.hire_date, b.last_name as boss, 
        b.hire_date AS boss_hire_date
        FROM employees e JOIN employees b ON e.manager_id = b.employee_id
        AND e.hire_date < b.hire_date;
        
  
/* 9) For every country name, show how many departments are located in that country.
       Use a column alias to clarify the meaning of the numbers.*/
       
      SELECT country_name , count(*) AS how_many_departments
        FROM departments d JOIN locations l USING (location_id) 
        JOIN countries c USING(country_id)
        GROUP BY country_name;
         
--------- CUST SALES Tables ----------------------

/* 10)For every sale, show the id, first and last names, email, and phone of the customer, 
      the first and last names of the sales representative, and the sales amount. 
      Order the result by customer id and sales amount.*/
   
    SELECT cust_id, cust_fname, cust_lname, cust_email, cust_phone, first_name,
        last_name, sales_amt
        FROM customers JOIN sales ON cust_id = sales_cust_id
        JOIN employees on sales_rep_id = employee_id
        ORDER BY 1, sales_amt;