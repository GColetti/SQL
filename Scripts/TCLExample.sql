  
        CREATE TABLE my_employee
      (
        empID NUMBER(3) CONSTRAINT my_employee_id1_pk primary key,
        last_name   VARCHAR2(15)  NOT NULL,
        first_name  VARCHAR2(15)  NOT NULL,
        userid      VARCHAR2(8)   NOT NULL,
        salary      NUMBER(7,2)   CONSTRAINT my_employee_salary1_ck 
                      CHECK(salary > 0)
      );  
      
      
        --Insert into tables
        INSERT INTO my_employee
          VALUES(1,'Kurt', 'Samuel', 'sdechamp', 1608);
               
        INSERT INTO my_employee_1(empid, last_name, first_name, userid, salary)
            VALUES(2, 'Jane' , 'Betsy' , 'bross' , 960);
         
         --Step 2 Save point
          savepoint step_2;
          
          delete from my_employee;
                    
           SELECT *
                   FROM my_employee;
                   
          ROLLBACK to step_2;
          
        SELECT *
                   FROM my_employee;
          commit;