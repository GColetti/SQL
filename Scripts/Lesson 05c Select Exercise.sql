/* Look through Lesson 05b Select Statement.sql and run the code examples there, then
   practice retrieving data using the SELECT excercises below:
*/

/* 1) Determine the structure of the departments table without 
      clicking the table name in the object tree. */
      desc departments

/* 2) Determine the structure of the employees table without 
      clicking the table name in the object tree. */
      desc employees
  
/* 3) Write a query that displays the employee id, last name, job id, and hire date
      for each employee. Provide a column alias STARTDATE for the hire date. */
      select employee_id, last_name, job_id, hire_date as STARTDATE

-- 4) Display all unique job ids in the employees table.
      select distinct job_id

/* 5) Rewrite the query in item 3 with more descriptive column headings.
      Name the column headings Emp #, Employee, Job, and Hire Date. */
      select employee_id as "Emp #", last_name as "Employee", job_id as "Job", hire_date as "Hire Date"
      

/* 6) Write a query that displays city concatenated with country id, separated
      by a comma and space. Name the column City and Country. */
      select city || ", " || country_id as "City and Country"
      
      
/* 7) Display employee number, last name, salary, and salary with an additional 
      $100 bonus multiplied by 12. Label the last column yearly_compensation. */
      select employee_id, last_name, salary, (salary * 12) + 100 as "yearly_compensation"
