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
      SELECT employees.first_name, employees.last_name, employees.job_id, departments.department_id, departments.department_name, locations.city
            FROM employees 
            JOIN departments USING(department_id) 
            JOIN locations USING(location_id)
            WHERE locations.city = 'Toronto';


/* 3) Display employee number, last name, manager's number and last name.
      Label the columns Emp#, Employee, Mgr#, Manager. Show all employees, even
      if they have no manager. Sort the result by employee's id number. */
      SELECT e.employee_id AS "Emp#", e.last_name AS "Employee", b.manager_id AS "Mgr#", b.last_name AS "Manager"
            FROM employees e LEFT JOIN employees b ON e.manager_id = b.employee_id
            ORDER BY e.employee_id;


/* 4) For every department name, show the name of the country where the department
      is located. Show all countries even if the have no departments. */ 
      SELECT  department_name, country_name
            FROM departments d 
            RIGHT JOIN locations l ON d.location_id = l.location_id 
            RIGHT JOIN countries c ON l.country_id = c.country_id;
        
      
/* 5) Create a report showing employee first and last name, department number, 
      and first and last names of their department colleagues. Do not display 
      the same employee twice in any row. Label the columns appropriately to 
      clarify the results. Order the results by employee id, even
      though it is not displayed.*/
      SELECT e.first_name AS "First Name", e.last_name AS "Last Name", d.department_id AS "Department #", d.department_name AS "Department Name", e2. first_name || ' ' || e2.last_name AS "Colleague Name"
            FROM employees e JOIN departments d ON e.department_id = d.department_id
            JOIN employees e2 ON e.department_id = e2.department_id
            ORDER BY e.employee_id;
      

/* 6) Display last name, job, department name, salary, and salary grade level
      for all employees, even if the employee is not assigned to a department.
      Order the result by department name, job, and last name.*/ 
      SELECT e.last_name, e.job_id, d.department_name, e.salary, s.grade_level
            FROM sal_grades s, employees e JOIN departments d ON e.department_id = d.department_id
            WHERE e.salary BETWEEN s.lowest_sal AND s.highest_sal
            ORDER BY d.department_name, e.job_id, e.last_name;
      
      
        
/* 7) Write a query that displays employees who have had different jobs. Show
      employee number, first and last name, hire date, previous job, previous 
      job end date, and current job. Use appropriate column aliases to clarify 
      the results. Order the result by employee id and end date. */
      SELECT e.employee_id AS "Emp #", e.first_name AS "First Name", e.last_name AS "Last Name", e.hire_date, jh.job_id AS "Previous Job", jh.end_date AS "Previous Job End Date", c.job_id AS "Current Job"
            FROM employees e JOIN job_history jh ON e.employee_id = jh.employee_id
            JOIN jobs c ON e.job_id = c.job_id
            ORDER BY e.employee_id, jh.end_date;
      
      
/* 8) Find the first and last names and hire dates of all employees who were 
      hired before their bosses. Also display the boss's last name 
      and hire date. Be sure to use apprpriate column aliases where needed. */
      SELECT e.first_name AS "First Name", e.last_name AS "Last Name", e.hire_date AS "Hire Date", b.last_name AS "Boss's Last Name", b.hire_date AS "Boss's Hire Date"
            FROM employees e JOIN employees b ON e.manager_id = b.employee_id
            WHERE e.hire_date < b.hire_date;
      
    
        
  
/* 9) For every country name, show how many departments are located in that country.
       Use a column alias to clarify the meaning of the numbers.*/
      SELECT country_name AS "Country Name", COUNT(d.department_name) AS "Number of Departments"
            FROM locations l JOIN departments d ON (d.location_id = l.location_id) 
            JOIN countries c ON c.country_id = l.country_id
            GROUP BY country_name;
       

         
--------- CUST SALES Tables ----------------------

/* 10)For every sale, show the id, first and last names, email, and phone of the customer, 
      the first and last names of the sales representative, and the sales amount. 
      Order the result by customer id and sales amount.*/
SELECT s.sales_id, c.cust_fname, c.cust_lname, c.cust_email, c.cust_phone, r.first_name, r.last_name, s.sales_amt
            FROM sales s JOIN customers c ON s.sales_cust_id = c.cust_id
            JOIN employees r ON s.sales_rep_id = r.employee_id
            ORDER BY s.sales_cust_id, s.sales_amt;
   
    