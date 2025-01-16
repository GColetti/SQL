/*Look through Lesson 14b Basic Subqueries.sql and run the code examples there, then
   practice Subqueries with the excercises below:
*/
--Practice Writing Subqueries


/* 1) Write a query that prompts the user for an employee last name, and then 
      displays the last name, hire date, and department id for any employee in the same
      department, excluding the given employee.
      */
      SELECT last_name, hire_date
            FROM employees
            WHERE department_id =
            (SELECT department_id FROM employees WHERE last_name LIKE '&name') 
            AND last_name != 'name';

/* 2) Create a report that displays employee number, last name, and salary for
      all employees who earn more than the average salary. Sort the results
      by salary. */
      SELECT employee_id, last_name, salary
            FROM employees
            WHERE salary >
            (SELECT AVG(salary) FROM employees);

      

/* 3) Show the employee number, first and last names, salary, and department id,
      of anybody whose salary is below the company average, and who works in a 
      department with a department name that ends with s. Sort the result
      by department id and employee id. */
      SELECT employee_id, first_name, last_name, salary, department_id
            FROM employees
            WHERE salary < (SELECT AVG(salary) FROM employees)
            AND department_id IN (SELECT department_id FROM departments WHERE department_name LIKE '%s')
            ORDER BY department_id, employee_id;
      
        
		

/* 4) Display the id, first name, last name, and department id of all employees 
      working in Seattle. Use subqueries rather than joins to acheive the results.*/
      SELECT employee_id, first_name, last_name, department_id
            FROM employees
            WHERE department_id = (SELECT department_id FROM locations WHERE city = 'Seattle');

  
  
/* 5) Modify your previous answer to prompt the user to enter a city. Why might 
      some cities result in no rows of output? */ 
      SELECT employee_id, first_name, last_name, department_id
            FROM employees
            WHERE department_id = (SELECT department_id FROM locations WHERE city = '&city');
      
    
/* 6) Recreate the result of question 4, but use joins to acheive your results.*/ 
      SELECT e.employee_id, e.first_name, e.last_name, e.department_id
            FROM employees e JOIN departments d ON e.department_id = d.department_id
            JOIN locations l ON l.location_id = d.location_id
            WHERE l.city = 'Seattle';
    
      
/* 7) Create a report showing the last name, job id, salary, and manager_id of every
      employee who reports to the manager whose job is AD_PRES. */
      SELECT last_name, job_id, salary, manager_id
            FROM employees
            WHERE manager_id IN (SELECT employee_id FROM employees WHERE job_id = 'AD_PRES');   
	  
      
/* 8) Display the employee number, last name, job, salary, and department id of all employees
      that work in the Executive department. Do not use a join to create your output.*/
      SELECT employee_id, last_name, job_id, salary, department_id
            FROM employees
            WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Executive');
      
         
/* 9) Show last_name, salary, and department id for employees who earn more than any 
      employee in department 60, but who do not work in department 60.*/
      SELECT last_name, salary, department_id
            FROM employees
            WHERE salary > (SELECT MAX(salary) FROM employees WHERE department_id = 60)
            AND department_id != 60;
      

/* 10) From the sales table, show every customer id, and the total amount sold
      to the customer. Name the second column sales_total. Include only customers 
      whose email ends in .co or .com. Sort the result by customer id.  
      Use a subquery for your solution. */
      SELECT cust_email,
            (SELECT SUM(sales_amt) FROM sales WHERE cust_email = c.cust_email) AS sales_total
            FROM customers c
            WHERE c.cust_email LIKE '%.co' OR c.cust_email LIKE '%.com'
            ORDER BY cust_id;
         
          
            
            
            
            
            
                    