--Practice Creating Views:
--------------------------------------------------------------------------------

/* 1) Create a view called emps_vu that hides some columns in the employees
    table. It must display employee number, last name, job, and department 
    number. Give the columns the following aliases: empno, lname, job, and deptno.
*/
      
  CREATE OR REPLACE VIEW emps_vu (empno, lname, job, deptno) AS
    SELECT employee_id, last_name, job_id, department_id
      FROM employees;
 
-- 2) Confirm the view works by selecting from it.
 
    SELECT *
      FROM emps_vu;
 
/* 3) Query the emps_vu so that it gives you a count of employees for each deptno.
      Order the result by deptno. */
     
      SELECT deptno, COUNT(*) as emp_count
        FROM emps_vu
        GROUP BY deptno
        ORDER BY deptno;
     
/* 4) Create a view called four_dept_vu that shows employee id, first name, last name,
      email,phone number, hire date, salary, and  manager id from the employees 
      table only for departments 30, 50, 60, and 80. Also display the department name,
      and the city where the department is located.  */
      
      CREATE OR REPLACE VIEW four_depts_vu AS
          SELECT employee_id, first_name, last_name, email, phone_number, hire_date,
                job_id, salary, e.manager_id, department_name, city
            FROM employees e JOIN departments d ON e.department_id = d.department_id
            JOIN locations using (location_id)
            WHERE e.department_id IN (30, 50, 60, 80);
          
-- 5) Describe the view and query it.
        
          DESC four_depts_vu
          
          SELECT *
            FROM four_depts_vu;
