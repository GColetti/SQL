--Practice Set operators

/* 1) 	Show department ids from the departments table that do not contain employees 
		who work as ST_CLERK. Use a set operator to create this report. */
      
      SELECT department_id
        FROM departments
      MINUS
      SELECT department_id
        FROM employees
        WHERE job_id = 'ST_CLERK';


/* 2) Create a report showing countries that have no departments located in them. 
      Display the country id and the name. Use a set operator and join to create 
      the result.*/

      SELECT country_id, country_name
        FROM countries
      MINUS
      SELECT c.country_id, country_name
        FROM countries c JOIN locations l ON l.country_id = c.country_id
        JOIN departments d ON d.location_id = l.location_id;

/* 3) Show all consultants and employees in department 80. List their ids, first name, 
      and last name. Order the result by the id. Allow any duplicate rows to 
      appear in the result.*/
      
      SELECT consultant_id as id, first_name, last_name
        FROM consultants
      UNION ALL
      SELECT employee_id, first_name, last_name
        FROM employees
        WHERE department_id = 80
        ORDER BY 1;
  
      
/* 4) Display any employee who is working at the same job as when they were 
      first hired. That is, they changed jobs, but have gone back to doing 
      their original job. Show employee id and job id.*/
      
      SELECT employee_id, job_id
        FROM employees
      INTERSECT
      SELECT employee_id, job_id
        FROM job_history;

        
/* 5) Display all employee and consultant last names and department ids. Also
      show department id and department name from the departments table. Place the
      results in three output columns. Do not join tables.*/  
      
      SELECT last_name, department_id, null as department_name
        FROM employees
      UNION
      SELECT last_name, department_id, null
        FROM consultants
      UNION
      SELECT null, department_id, department_name
        FROM departments;
      
      