/*Look through Lesson 08b Single-Row Functions Part 1.sql and run the code examples there, then
   practice single-row functions with the excercises below:
*/

/* 1) Display the first_name, last_name, and the first four letters of 
      the first name with the last four letters of the last name of 
      each employee in department 50. Label the column SHORT_NAME. */

      SELECT first_name, last_name, 
            SUBSTR(first_name, 1, 4) || SUBSTR(last_name, -4, 4) AS short_name
          FROM employees
          WHERE department_id = 50;

/* 2) Display the employee number, last_name, salary, and salary increased by
      4.8125% for each employee. Round the result two places past the decimal 
      and label the column NEW_PAY. */

    SELECT employee_id, last_name, salary, ROUND(salary * 1.048125,2) AS new_pay
      FROM employees;

/* 3) Repeat query 2 but add a column that subtracts the old salary from the
      new salary. Insure that this column is also rounded 2 places.
      Label the column PAY_INCREASE. */

    SELECT employee_id, last_name, salary, ROUND(salary * 1.048125,2) AS new_pay,
          ROUND(salary * 1.048125,2) - salary AS pay_increase
        FROM employees;

/* 4) Display the last name, length of the last name, for any employee
      whose last name begins with A, J, or M. Give each column an appropriate
      alias. */

      SELECT last_name, LENGTH(last_name) as how_long
        FROM employees
        WHERE SUBSTR(last_name, 1,1) IN ('A' ,'J','M');

/* 5) Rewrite the previous query to prompt the user to enter a letter that the 
      last name starts with. */ 
      
      SELECT last_name, length(last_name) as how_long
        FROM employees
        WHERE substr(last_name, 1,1) = UPPER('&first_letter');

/* 6) Show the last name and the number of months each employee has worked.
      Label the column MONTHS_WORKED. Round the number of months to the 
      closest whole number. */
      
      SELECT last_name, 
          ROUND(MONTHS_BETWEEN(SYSDATE, hire_date),0) AS months_worked
        FROM employees;
    
/* 7) Show the last name and salary of all employees. Display a 
      fixed dollar sign concatenated with the salary padded with asterisks 
      up to a width of 9 characters.  Label the column SALARY.  */
      
      SELECT last_name, '$'||LPAD(salary, 9, '*') AS salary
        FROM employees;
 

/* 8) Display the last_name, and the number of weeks each employee has worked
      in department 90. Label the column TENURE. Trunc the number of weeks
      zero places past the decimal. Sort the result in descending order of
      tenure. */
      
      SELECT last_name, TRUNC((sysdate - hire_date)/7,0) AS tenure
        FROM employees
        WHERE department_id = 90
        ORDER BY tenure DESC;
      
/* 9) Show the characters in the street address in the locations table beginning
      with the character after the first space. For example, if the address is 
      10 Downing Street, just show Downing Street. Label the column street.*/
        
       SELECT SUBSTR(street_address,INSTR(street_address,' ') +1) AS street
            FROM locations;
        
/* 10) Display last name, the date of their first performance review, and the
        number of months the employee has worked. The first review occurred six 
        months after being hired. Round the months two places, and label the 
        columns first_review and tenure. */
        
        SELECT last_name, ADD_MONTHS(hire_date,6) AS first_review,
            ROUND(MONTHS_BETWEEN(SYSDATE, hire_date),2) AS tenure
            FROM employees;
            
            
/* 11) Show last name, manager, job, date of first paycheck, and the date
        benefits began. Paychecks are paid each Friday and benefits begin
        the first day of the month after hire. Label the columns first_payday,
        and benefits_start. */ 
        
        SELECT last_name, manager_id, job_id, 
            NEXT_DAY(hire_date, 'Friday') AS first_payday,
            LAST_DAY(hire_date) + 1 AS benefits_start
            FROM employees;
        
       
        