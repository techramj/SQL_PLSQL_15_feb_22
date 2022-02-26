--Record

--Datatype
   --scalar
   --composite
       --Record => type record_name_type is record(col1 datatype, col2 dataype,...);
       --Cursor
           --attributes => %FOUND, %NOTFOUND, %ROWCOUNT
   
   
DECLARE
  v_salary employees.salary%TYPE;
  v_name   employees.last_name%TYPE;
  
BEGIN
  SELECT salary, last_name INTO v_salary,v_name
  FROM employees
  WHERE employee_id = 100;
  
  print('Name: '||v_name||'     Salary: '||v_salary);
  
END;
/


DECLARE
  v_salary1 employees.salary%TYPE;
  v_name1   employees.last_name%TYPE;
  
  v_salary2 employees.salary%TYPE;
  v_name2   employees.last_name%TYPE;

  
BEGIN
  SELECT salary, last_name INTO v_salary1,v_name1
  FROM employees
  WHERE employee_id = 100;
  
  SELECT salary, last_name INTO v_salary2,v_name2
  FROM employees
  WHERE employee_id = 101;
  
  print('Name: '||v_name1||'     Salary: '||v_salary1);
  print('Name: '||v_name2||'     Salary: '||v_salary2);
  
END;
/


DECLARE
   TYPE emp_rec_type IS RECORD(NAME VARCHAR2(20), salary NUMBER);
   rec1 emp_rec_type;
   rec2 emp_rec_type;
BEGIN
  SELECT salary, last_name INTO rec1.salary,rec1.name
  FROM employees
  WHERE employee_id = 100;
  
  SELECT salary, last_name INTO rec2.salary,rec2.name
  FROM employees
  WHERE employee_id = 101;
  
  print('Name: '||rec1.name||'     Salary: '||rec1.salary);
  print('Name: '||rec2.name||'     Salary: '||rec2.salary);

END;
/

--WAP to store employee_id,last_name, salary, department_id,manager_d 
--for the employee prompted by the user


DECLARE
   TYPE emp_rec_type IS RECORD(
       ID   NUMBER,
       NAME VARCHAR2(20), 
       salary NUMBER,
       did NUMBER,
       mgr_id NUMBER
       );
   rec emp_rec_type;
   
BEGIN
  SELECT employee_id,last_name,salary,department_id,manager_id 
  INTO rec
  FROM employees
  WHERE employee_id = 101;
  print(rec.id||'  '||rec.name||'   '||rec.salary);
  
END;
/

--WAP to store all columns
--for the employee prompted by the user

DECLARE
   rec  employees%ROWTYPE;
BEGIN
  SELECT *
  INTO rec
  FROM employees
  WHERE employee_id = 101;
  print(rec.employee_id||'  '||rec.last_name||'   '||rec.salary);
END;
/




--CURSOR
--Step 1: declare the cursor
--step 2: open the cursor
--step 3: fetch the cursor data
--step 4: check the cursor
--step 5: close the cursor


DECLARE
   CURSOR cur1 IS 
     SELECT last_name,salary FROM employees 
     WHERE department_id=30;
   v_name VARCHAR2(20);
   v_salary NUMBER; 
BEGIN
   OPEN cur1;
   
   LOOP
     FETCH cur1 INTO v_name,v_salary;
     EXIT WHEN cur1%NOTFOUND;
     print(v_name||'  '||v_salary);
   END LOOP;
   
   CLOSE cur1;
END;
/

OR 
   
DECLARE
   CURSOR cur1 IS 
     SELECT last_name AS NAME,salary AS sal FROM employees 
     WHERE department_id=30;
   
   rec cur1%ROWTYPE;
BEGIN
   OPEN cur1;
   
   LOOP
     FETCH cur1 INTO rec;
     EXIT WHEN cur1%NOTFOUND;
     print(rec.name||'  '||rec.sal);
   END LOOP;
   
   CLOSE cur1;
END;

  --oR

DECLARE
   CURSOR cur1 IS 
     SELECT last_name AS NAME,salary*12 AS sal FROM employees 
     WHERE department_id=30;
   
   rec cur1%ROWTYPE;
BEGIN
   OPEN cur1;
   
   LOOP
     FETCH cur1 INTO rec;
     EXIT WHEN cur1%NOTFOUND;
     print(rec.name||'  '||rec.sal);
   END LOOP;
   IF cur1%ISOPEN THEN 
      CLOSE cur1;
   END IF;
END;
/

  --oR

DECLARE
   CURSOR cur1 IS 
     SELECT last_name AS NAME,salary*12 AS sal FROM employees 
     WHERE department_id=30;
BEGIN
  
   FOR rec IN cur1 LOOP
     print(rec.name||'  '||rec.sal);
   END LOOP;
END;
/





