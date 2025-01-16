-- =============================================
-- Author:      Gianluca Coletti
-- Create date: 06/23/2022
-- Description: SQL Final Project for Developer, Test, Dev Ops, DA/BI, QA/QE Trainees
-- =============================================
--  1. Show details of the highest paid employee. Display their first and last name, salary, job id, department name, city, and country name. 
--     Do not hard code any values in the WHERE clause.
    SELECT e.first_name, e.last_name, e.salary, e.job_id, e.department_id, l.city, l.country_id
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
        JOIN locations l ON l.location_id = d.location_id
        WHERE e.salary = (SELECT MAX(e2.salary) FROM employees e2);

--  2. Show any employee who still appears as a consultant. Display the first and last name, job id, salary, and manager id, all from the employees table. 
--     Sort the result by last name.
    SELECT e.first_name, e.last_name, e.job_id, e.salary, e.manager_id
        FROM employees e 
        JOIN consultants c ON e.first_name = c.first_name AND e.last_name = c.last_name
        ORDER BY e.last_name;

--  3. For each customer, display their id, first name, last name, city, and their largest sale, total sales, largest sale as a 
--     percentage of total sales, average sales amount, and a count of how many sales they have each transacted. 
--     If they have no sales, show 0 for the aggregated amounts. Sort the result by the customer's id number.
    SELECT cust_id AS "Customer ID", cust_fname AS "First Name", cust_lname AS "Last Name", cust_city AS "City",  NVL(MAX(sales_amt), '0') AS "Max Sale", NVL(SUM(sales_amt), '0') AS "Total Sales Amount", 
    NVL(ROUND(MAX(sales_amt) / SUM(sales_amt) * 100, 2), '0') AS "Max Sale Percentage", NVL(ROUND(AVG(sales_amt), 2), '0') AS "Average Sale", NVL(COUNT(sales_amt), '0') AS "Number of Sales"
        FROM customers c
        LEFT JOIN sales s ON c.cust_id = s.sales_cust_id
        GROUP BY cust_id, cust_fname, cust_lname, cust_city 
        ORDER BY cust_id;

--  4. Show the managers who manage entire departments. Display the first and last names, department names, addresses, cities, and states. 
--     Sort the output by department id.
        SELECT e.first_name, e.last_name, d.department_name, l.STREET_ADDRESS, l.city, l.STATE_PROVINCE
        FROM employees e
        INNER JOIN departments d USING (department_id) 
        INNER JOIN locations l USING (location_id) 
        WHERE department_id IN 
            (SELECT department_id 
            FROM employees 
            GROUP BY department_id 
            HAVING COUNT(department_id) <= 1)
        ORDER BY department_id;
        
--  5. Show any employee who earns the same or more salary as her/his manager. 
--     Show the first name, last name, job id, and salary of the employee, and the first name, last name, job id, and salary of the manager. 
--     Use meaningful column aliases throughout.
    SELECT e.first_name AS "First Name", e.last_name AS "Last Name", e.job_id AS "Job ID", e.salary AS "Salary", 
    m.first_name "Manager First Name", m.last_name AS "Manager Last Name", m.job_id AS "Manager Job ID", m.salary AS "Manager Salary"
        FROM employees e
        JOIN employees m ON e.manager_id = m.employee_id
        WHERE e.salary >= m.salary;

--  6. Find any employee who is now at the same job they had in the past. 
--    That is, they performed a job, moved on to another job, and are now back at their original job. 
--    Show employee id, first name, last name, job id, and salary.
    SELECT e.employee_id AS "Employee ID", e.first_name AS "First Name", e.last_name AS "Last Name", e.job_id AS "Job ID", e.salary AS "Salary"
        FROM employees e 
        JOIN job_history j ON j.employee_id = e.employee_id
        WHERE j.job_id = e.job_id;

--  7. Show any employee who is not a manager, but earns more than any manager in the employees table. 
--    Show first name, last name, job id, and salary. Sort the result by salary.
    SELECT DISTINCT e.first_name AS "First Name", e.last_name AS "Last Name", e.job_id AS "Job ID", e.salary AS "Salary"
        FROM employees e, employees e2
        WHERE e.job_id NOT LIKE '%MAN' AND e.salary > (SELECT MIN(salary) FROM employees WHERE job_id LIKE '%MAN')
        ORDER BY e.salary;

--  8. For every geographic region, provide a count of the employees in that region. Display region name, and the count. Be sure to include all employees, 
--     even if they have not been assigned a department. Sort the result by region name.
    SELECT r.region_name AS "Region Name", COUNT(e.employee_id) AS "Number of Employees"
        FROM employees e
        LEFT OUTER JOIN departments d ON e.department_id = d.department_id
        JOIN locations l ON d.location_id = l.location_id
        JOIN countries c ON c.country_id = l.country_id
        RIGHT JOIN regions r ON r.region_id = c.region_id
        GROUP BY r.region_name
        ORDER BY r.region_name;
    
--  Data Manipulation
--  9. PART 1: Update Kimberely Grant so that her department id matches that of the other sales representatives. 
--            In the same update statement, change her first name to Kimberly.
    UPDATE employees 
        SET first_name = 'Kimberly', department_id = 
            (SELECT DISTINCT department_id
            FROM departments
            JOIN employees USING(department_id)
            JOIN jobs USING (job_id)
            WHERE job_id = 'SA_REP')
        WHERE first_name = 'Kimberely';

--  PART 2: Employees Stiles and Seo are going to be earning the same pay as employee Ladwig. 
--         Write an update statement to change both salaries in one statement, but do not hard-code the new amount. Instead, use a subquery.
    UPDATE employees 
        SET salary = (SELECT salary FROM employees WHERE last_name = 'Ladwig')
        WHERE last_name IN ('Stiles', 'Seo');

--  10. Remove any consultants who are now full-time employees with one delete statement. Do not hard-code any values.
    DELETE FROM consultants
        WHERE job_id IS NOT NULL;

--  11. The regions are expanding. Americas will now be called North America, and Middle East and Africa will now be called Middle East. 
--     Write the update statements to change these regions.
    UPDATE regions
        SET region_name = 'North America'
        WHERE region_name = 'Americas';
    UPDATE regions
        SET region_name = 'Middle East'
        WHERE region_name = 'Middle East and Africa';

--  12. Add a new row for South America to the Regions table. Add another row for Africa.
    INSERT INTO regions (region_name)
        VALUES ('South America');
    INSERT INTO regions (region_name)
        VALUES ('Africa');

--  Additional Queries
--  13. For each sales representative, show their biggest sale. Display the sales representative's id, first and last names, their largest sales amount, 
--     the timestamp of the sale, the customer id, and customer last name. Sort the result by the sales rep's id number.
    SELECT s.sales_rep_id AS "Sales Rep ID", e.first_name AS "Sales Rep First Name", e.last_name AS "Sales Rep Last Name", MAX(s.sales_amt) AS "Largest Sale", 
    TO_CHAR(ROUND(s.sales_timestamp,'MI'), 'DD-MON-YY HH:MI AM') AS "Timestamp", s.sales_cust_id AS "Customer ID", c.cust_lname AS "Customer Last Name"
        FROM employees e
        INNER JOIN sales s ON e.employee_id = s.sales_rep_id
        INNER JOIN customers c ON s.sales_cust_id = c.cust_id 
        INNER JOIN 
            (SELECT sales_rep_id, MAX(sales_amt) AS maxsal_amount -- select columns sales_rep_id, MAX(sales_amt) as maxsal_amount
                FROM sales
                GROUP BY sales_rep_id) sa 
                ON s.sales_rep_id = sa.sales_rep_id AND s.sales_amt = sa.maxsal_amount 
        GROUP BY s.sales_rep_id, e.first_name, e.last_name, s.sales_timestamp, s.sales_cust_id, c.cust_lname
        ORDER BY s.sales_rep_id;


--  14. Show the commissioned employees whose total pay is above the average total pay of commissioned employees. 
--     Total pay is salary added to the product of commission percent multiplied by the total sales for that salesperson. 
--     Show first name, last name, and total pay. Sort the result by the total pay.
    SELECT e.first_name AS "First Name", e.last_name AS "Last Name", ROUND(e.salary + (e.commission_pct * (SELECT AVG(s.sales_amt) 
    FROM sales s 
    WHERE s.sales_rep_id = e.employee_id)), 2) AS "Total Pay"
        FROM employees e
        JOIN sales s ON e.employee_id = s.sales_rep_id
        WHERE e.salary + (e.commission_pct * (SELECT SUM(s.sales_amt) FROM sales s WHERE s.sales_rep_id = e.employee_id)) > (SELECT AVG(e2.salary + (e2.commission_pct * (SELECT AVG(s.sales_amt) FROM sales s WHERE s.sales_rep_id = e2.employee_id))) FROM employees e2)
        GROUP BY e.first_name, e.last_name, e.salary, e.commission_pct
        ORDER BY 3;
    
--  15. Sales managers earn a commission on the total sales of all their sales representatives. For each sales manager, calculate their total compensation, 
--     which is the manager's salary added to the product of the manager's commission percent multiplied by the total sales of the manager's sales  
--     representatives. Show the manager's employee id, the manager's last name, and their total compensation. Sort by the managers’ employee id number.
    SELECT m.employee_id AS "Employee ID", m.last_name   AS "Last Name", m.salary + (m.commission_pct * (SUM(s.sales_amt))) AS "Total Compensation"
        FROM employees e
        JOIN employees m ON e.manager_id = m.employee_id
        JOIN jobs j ON m.job_id = j.job_id
        JOIN sales s ON e.employee_id = s.sales_rep_id
        WHERE j.job_title = 'Sales Manager'
        GROUP BY m.employee_id, m.last_name, m.salary, m.commission_pct
        ORDER BY m.employee_id;

--  16. For every customer’s biggest sales amount, show the sales representative’s last name, his or her manager’s last name, the customer’s first and 
--     last names, customer’s city and country, and the amount of their largest sale. Sort by the salesperson’s last name.
    SELECT e.last_name AS "Sales Rep Last Name", m.last_name AS "Manager Last Name", c.cust_fname AS "Customer First Name", c.cust_lname AS "Customer Last Name", c.cust_city AS "City", c.cust_country AS "Country", s.sales_amt AS "Largest Sale"
    FROM employees e
        JOIN sales     s ON e.employee_id = s.sales_rep_id
        JOIN customers c ON s.sales_cust_id = c.cust_id
        JOIN employees m ON e.manager_id = m.employee_id
        JOIN (select sales_cust_id, MAX(sales_amt) AS maxsal FROM sales GROUP BY sales_cust_id) sa 
        ON s.sales_cust_id = sa.sales_cust_id AND s.sales_amt = sa.maxsal
    ORDER BY last_name;
