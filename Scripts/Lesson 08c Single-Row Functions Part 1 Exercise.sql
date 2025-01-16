/*Look through Lesson 07b Single-Row Functions Part 1.sql and run the code examples there, then
   practice single-row functions with the excercises below:
*/

/* 1) Display the first_name, last_name, and the first four letters of 
      the first name with the last four letters of the last name of 
      each employee in department 50. Label the column SHORT_NAME. */
      SELECT first_name, last_name, CONCAT(LEFT(first_name, 4), RIGHT(last_name, 4)) AS SHORT_NAME
      FROM employees
      WHERE department_id = 50;



/* 2) Display the employee number, last_name, salary, and salary increased by
      4.8125% for each employee. Round the result two places past the decimal 
      and label the column NEW_PAY. */
      SELECT employee_id, last_name, salary, ROUND(salary * 1.048125, 2) AS NEW_PAY
      FROM employees;



/* 3) Repeat query 2 but add a column that subtracts the old salary from the
      new salary. Label the column PAY_INCREASE. */
      SELECT employee_id, last_name, salary, ROUND(salary * 1.048125, 2) AS NEW_PAY, NEW_PAY - salary AS PAY_INCREASE
      FROM employees;


/* 4) Display the last name, length of the last name, for any employee
      whose last name begins with A, J, or M. Give each column an appropriate
      alias. */
      SELECT last_name AS "Last Name", LENGTH(last_name) AS "Length of Last Name", 
      FROM employees
      WHERE last_name LIKE 'A%' OR last_name LIKE 'J%' OR last_name LIKE 'M%';

/* 5) Rewrite the previous query to prompt the user to enter a letter that the 
      last name starts with. */ 
      SELECT last_name AS "Last Name", LENGTH(last_name) AS "Length of Last Name",
      FROM employees
      WHERE last_name LIKE '&last%';

      
/* 6) Show the last name and the number of months each employee has worked.
      Label the column MONTHS_WORKED. Round the number of months to the 
      closest whole number. */
      SELECT last_name, ROUND(MONTH(hire_date) - MONTH(CURRENT_DATE)) AS MONTHS_WORKED
      FROM employees;
    

/* 7) Show the last name and salary of all employees. Display a 
      fixed dollar sign concatenated with the salary padded with asterisks 
      up to a width of 9 characters.  Label the column SALARY. */
      SELECT last_name, CONCAT('$', LPAD(salary, 9, '*')) AS SALARY
      FROM employees;


/* 8) Display the last_name, and the number of weeks each employee has worked
      in department 90. Label the column TENURE. Trunc the number of weeks
      zero places past the decimal. Sort the result in descending order of
      tenure. */
      SELECT last_name, TRUNC(ROUND(WEEK(hire_date) - WEEK(CURRENT_DATE))) AS TENURE
      FROM employees
      WHERE department_id = 90
      ORDER BY TENURE DESC;
      
      
/* 9) Show the characters in the street address in the locations table beginning
      with the character after the first space. For example, if the address is 
      10 Downing Street, just show Downing Street. Label the coulmn street.*/
      SELECT SUBSTR(street, INSTR(street, 1, ' ')) AS "Street"
      FROM locations;
                 
        
/* 10) Display last name, the date of their first performance review, and the
       number of months the employee has worked. The first review occurred six 
       months after being hired. Round the months two places, and label the 
       columns first_review and tenure. */
      SELECT last_name, DATE_ADD(hire_date, INTERVAL 6 MONTH) AS first_review, ROUND(MONTH(hire_date) - MONTH(CURRENT_DATE), 2) AS "Tenure"
      FROM employees;
       
       
/* 11) Show last name, manager, job, date of first paycheck, and the date
        benefits began. Paychecks are paid each Friday and benefits begin
        the first day of the month after hire. Label the columns first_payday,
        and benefits_start. */ 
      SELECT last_name, manager, job, DATE_ADD(hire_date, INTERVAL 1 WEEK) AS "first_payday", DATE_ADD(hire_date, INTERVAL 1 MONTH) AS "benefits_start"
       
       
       
       