/*Look through Lesson 16c Data Definition Language - Tables.sql and 
  run the code examples there, then practice creating tables with the excercises below:
*/
--Practice creating tables

/* 1) Create the depts table per the following specification. Be sure to name
      the constraints other than NOT NULL.
      ------------------------------------------
      |Column Name |Datatype  |Size|Constraint |
      |------------|----------|----|-----------|
      |DEPT_NO     | NUMBER   | 4  |Primary Key|
      |------------|----------|----|-----------|
      |DEPT_NAME   | VARCHAR2 | 15 | NOT NULL  |
      ------------------------------------------
      
      Confirm the table structure after you create it.
  */
     
     CREATE TABLE depts
     (
      dept_no NUMBER(4)       CONSTRAINT dept_no_pk PRIMARY KEY,
      dept_name VARCHAR2(15)  NOT NULL
     );

      desc depts

/* 2) Create the emps table per the following specification. Be sure to name
      the constraints other than NOT NULL.
      --------------------------------------------
      |Column Name |Datatype   |Size|Constraint  |
      |------------|-----------|----|------------|
      |EMP_NO      | NUMBER    | 4  |Primary Key |
      |------------|-----------|----|------------|
      |EMP_FNAME   | VARCHAR2  | 15 | NOT NULL   |
      |------------|-----------|----|------------|
      |EMP_LNAME   | VARCHAR2  | 15 | NOT NULL   |
      --------------------------------------------
      |EMP_DEPT_NO | NUMBER    | 4  | Foreign Key|
      --------------------------------------------
      
      Confirm the table structure after you create it.  */
     
     CREATE TABLE emps
     (
      emp_no    	NUMBER(4)     CONSTRAINT emp_no_pk PRIMARY KEY,
      emp_fname 	VARCHAR2(15)  NOT NULL,
      emp_lname 	VARCHAR2(15)  NOT NULL,
      emp_dept_no 	NUMBER(4) CONSTRAINT emp_dept_no_fk REFERENCES depts(dept_no)
     );

      desc emps
      
      
/* 3) The emps and depts tables need some tweaking. Increase the maximum 
      length of dept_name to 30 characters. Increase the emp_no to 6 digits
      maximum, and increase the first and last names to a maximum length of
      25 characters. You must drop the tables and recreate them in the correct 
      order. Verify the correct table structures after recreating them. */
      
      DROP TABLE emps;  -- drop the child first
      DROP TABLE depts; -- then drop the parent
      
      CREATE TABLE depts
     (
      dept_no NUMBER(4)       CONSTRAINT dept_no_pk primary key ,
      dept_name VARCHAR2(30)  NOT NULL
     );
      desc depts
      
      CREATE TABLE emps
     (
      emp_no    	NUMBER(6)     CONSTRAINT emp_no_pk primary key ,
      emp_fname 	VARCHAR2(25)  NOT NULL,
      emp_lname 	VARCHAR2(25)  NOT NULL,
      emp_dept_no 	NUMBER(4) CONSTRAINT emp_dept_no_fk REFERENCES depts(dept_no)
     );

      desc emps

            
/* 4) Run the following insert statement to populate the depts table with data 
      from all the rows in the departments table. You will learn how to copy rows
      from another table using the Insert statement in Lesson 18a Data Manipulation 
      Language and TCL. */
      
        INSERT INTO depts
          SELECT department_id, department_name
            FROM departments;
  
      
/* 5) Create a table na_locs based on the structure and data of the locations 
      table. Include only the rows that have a country_id of CA, US, or MX. Confirm
      the table structure and data after you create it. */
      
      CREATE TABLE na_locs AS
        SELECT *
          FROM locations
          WHERE country_id IN ('CA' , 'US' , 'MX');
      
      desc na_locs
	  
	  SELECT *
      FROM na_locs;
		
        
/* 6) Create an emp_archive table based on the structure of the employees table.
      The table must be empty. CREATE and populate the table with a subselect.*/ 
      
      CREATE TABLE emp_archive AS
        SELECT *
          FROM employees
          WHERE 1 = 2;
      
/* 7) In a separate session, write a script that will drop and create the trainees 
      and streams tables in the correct order. Name all constraints except 
      NOT NULL. Test your script by running it with the Run Script [F5] button.
      
      ----------
      |STREAMS |
      --------------------------------------------
      |Column Name |Datatype   |Size|Constraint  |
      |------------|-----------|----|------------|
      |STREAM_ID   | NUMBER    | 5  |Primary Key |
      |------------|-----------|----|------------|
      |STREAM_NAME | VARCHAR2  | 15 | NOT NULL   |
      |------------|-----------|----|------------|
      |STREAM_DESC | VARCHAR2  | 40 | NOT NULL   |
      --------------------------------------------
         
      
      -----------
      |TRAINEEs |
      -------------------------------------------------------------------
      |Column Name        |Datatype    |Size|Default Value |Constraint  |
      |-------------------|------------|----|--------------|-------------
      |TRAINEE_ID         | NUMBER     | 7  |              |PRIMARY KEY |
      |-------------------|------------|----|--------------|------------|
      |TRAINEE_SSN        | CHAR       | 9  |              |UNIQUE      |
      |-------------------|------------|----|--------------|------------|
      |TRAINEE_FNAME      | VARCHAR2   | 15 |              | NOT NULL   |
      --------------------|------------|----|--------------|------------|
      |TRAINEE_LNAME      | VARCHAR2   | 15 |              | NOT NULL   |
      --------------------|------------|----|--------------|------------|
      |TRAINEE_START_DATE | DATE       |    | SYSDATE      | NOT NULL   |
      |-------------------|------------|----|--------------|------------|
      |TRAINEE_TUITION    | NUMBER     | 9,2|              | > than zero|
      --------------------|------------|----|--------------|------------|
      |TRAINEE_STREAM_ID  | NUMBER     | 5  |              | FOREIGN KEY|
      -------------------------------------------------------------------
*/      
      DROP TABLE trainees;
      DROP TABLE streams;
      
      CREATE TABLE streams
      (
        stream_id   NUMBER(5) CONSTRAINT stream_id_pk PRIMARY KEY  ,
        stream_name VARCHAR2(15)  NOT NULL                          ,
        stream_desc VARCHAR(40)   NOT NULL
      );
      
      CREATE TABLE trainees
      (
        trainee_id    NUMBER(7) CONSTRAINT trainee_id_pk PRIMARY KEY  ,
        trainee_ssn   CHAR(9)   CONSTRAINT trainee_ssn_uk UNIQUE      ,                          
        trainee_fname VARCHAR2(15)   NOT NULL                         ,
        trainee_lname VARCHAR2(15)   NOT NULL                         ,
        trainee_start_date DATE DEFAULT SYSDATE  NOT NULL             ,
        trainee_tuition NUMBER(9,2)  CONSTRAINT trainee_tuition_ck
                                     CHECK(trainee_tuition >= 0)      ,
        trainee_stream_id NUMBER(5) CONSTRAINT trainee_stream_id_fk
                                    REFERENCES streams(stream_id) 
      );
      