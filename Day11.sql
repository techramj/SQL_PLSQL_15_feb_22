--before handling exception
DECLARE
  v_name employees.last_name%TYPE := '&name';
  v_salary employees.salary%TYPE ;
BEGIN
  SELECT salary INTO v_salary 
  FROM employees
  WHERE LOWER(last_name) = LOWER(v_name);
  
  print(v_salary);
END;
/

--In oracle exceptions are categorized in 3 
--1. Oracle pre-defined exception

DECLARE
  v_name employees.last_name%TYPE := '&name';
  v_salary employees.salary%TYPE ;
BEGIN
  SELECT salary INTO v_salary 
  FROM employees
  WHERE LOWER(last_name) = LOWER(v_name);
  
  print(v_salary);
EXCEPTION
  
  WHEN no_data_found THEN
     print('No employee with name :'||v_name); 
  WHEN too_many_rows THEN 
    print('More then one employee with name '||v_name);
  WHEN OTHERS THEN
    print('error...');

END;
/

--WAP to display the details of employees with name propmpted by user

DECLARE
  v_name employees.last_name%TYPE := '&name';
  rec employees%rowtype ;
BEGIN
  SELECT * INTO rec 
  FROM employees
  WHERE LOWER(last_name) = LOWER(v_name);
  
  print('Id:     '||rec.employee_id);
  print('Name:   '||rec.first_name||' '||rec.last_name);
  print('Salary: '||rec.salary);
  print('Did:    '||rec.department_id);
EXCEPTION
  
  WHEN no_data_found THEN
     print('No employee with name :'||v_name); 
  WHEN too_many_rows THEN 
    print('More then one employee with name '||v_name);
  WHEN OTHERS THEN
    print('error...');

END;
/


--each exception have two part: a. SQLCODE  b.SQLERRM

DECLARE
  v_name employees.last_name%TYPE := '&name';
  rec employees%rowtype ;
BEGIN
  SELECT * INTO rec 
  FROM employees
  WHERE LOWER(last_name) = LOWER(v_name);
  
  print('Id:     '||rec.employee_id);
  print('Name:   '||rec.first_name||' '||rec.last_name);
  print('Salary: '||rec.salary);
  print('Did:    '||rec.department_id);
EXCEPTION
  WHEN OTHERS THEN
    print('error...');
    print(SQLCODE);
    print(SQLERRM);

END;


--2. oracle non predefined exception

DECLARE
  fk_child_exception EXCEPTION;
  fk_parent_exception EXCEPTION;
  PRAGMA EXCEPTION_INIT(fk_child_exception,-2292);
  PRAGMA EXCEPTION_INIT(fk_parent_exception,-2291);
BEGIN
  --DELETE departments WHERE department_id=20;
  UPDATE employees
  SET department_id=11
  WHERE department_id=10;
  
EXCEPTION
   WHEN fk_child_exception THEN
    print('Cannot delete parent key bcz child key is found...');
   WHEN fk_parent_exception THEN
    print('Not a valid did ');
END; 
/  


--3 User defined exception

DECLARE 
  v_ID emp.id%TYPE := &ID;
  invalid_id_exp EXCEPTION;
BEGIN
  DELETE emp WHERE ID= v_id;
 
  IF SQL%NOTFOUND THEN
    RAISE invalid_id_exp;
  ELSE
    print(SQL%ROWCOUNT||' row deleted');
  END IF;
  
EXCEPTION
  WHEN invalid_id_exp THEN
    print('Not a valid Id: '||v_id);
    print(SQLCODE);
    print(SQLERRM);
END;
/

--alternate way to throw the exception with errorcode and errormessage
--user defined error code must be -20NNN
DECLARE 
  v_ID emp.id%TYPE := &ID;
  invalid_id_exp EXCEPTION;
BEGIN
  DELETE emp WHERE ID= v_id;
 
  IF SQL%NOTFOUND THEN
    RAISE_application_error(-20001,'Invalid id:'||v_id);
  ELSE
    print(SQL%ROWCOUNT||' row deleted');
  END IF;

END;
/

--WAP to check whether the prompted department_id is valid or not
DECLARE
 V_did NUMBER := &did;
 v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM departments 
  WHERE department_id =v_did;
 
  IF v_count=0 THEN
    RAISE_application_error(-20001,'Invalid did:'||v_did);
  END IF;
END;
/




--wap to store the top 5 salary in plsql table
  --if 5th highest salary is less than 10000 then throw the exception
 DECLARE
   TYPE tab_type IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
   tab  tab_type;
   CURSOR cur1 IS SELECT DISTINCT salary FROM employees ORDER BY 1 DESC;
 BEGIN
   FOR rec IN cur1 LOOP
     tab(cur1%ROWCOUNT) := rec.salary;
     EXIT WHEN cur1%ROWCOUNT = 5;
   END LOOP;
   
   IF tab(5)<10000 THEN
     raise_application_error(-20002,'5th hightest salary is less than 1000');
   END IF;
   
   --iterate the table
   FOR i IN 1..tab.count LOOP
     print(tab(i));
   END LOOP;
 END;
/



--waq to print 5th highest salary using sql and plsql.
--don't use rownum

SELECT MIN(salary) FROM (
SELECT DISTINCT salary FROM employees
ORDER BY salary DESC
)
WHERE ROWNUM<=5;

SELECT salary FROM (
SELECT last_name,salary,
dense_rank() OVER (ORDER BY salary DESC) AS RANK
FROM employees
)
WHERE RANK=5;

SELECT salary
FROM employees e 
WHERE 4 = (SELECT COUNT(DISTINCT salary) FROM employees WHERE salary>e.salary);

SELECT * FROM (
SELECT ROWNUM AS RANK, salary FROM (
SELECT DISTINCT salary
FROM employees ORDER BY salary DESC
)
)WHERE RANK=5;



--department_wise 2nd highest salary
SELECT * FROM (
SELECT last_name,salary,department_id,
dense_rank() OVER (PARTITION BY department_id ORDER BY salary DESC) AS RANK
FROM employees
)
WHERE RANK=2;

--find the manger having highest no of subordinate

SELECT manager_id
FROM employees
GROUP BY manager_id
HAVING COUNT(*) =(SELECT MAX(COUNT(*))
                  FROM employees 
                  GROUP BY manager_id);
                  
SELECT * FROM (
SELECT manager_id,MAX(RANK) AS no_of_sub
FROM (                 
SELECT manager_id, dense_rank() OVER(PARTITION BY manager_id ORDER BY ROWNUM) AS RANK 
FROM employees
)
GROUP BY manager_id
ORDER BY 2 DESC
)
WHERE ROWNUM=1;

--Stored procedure, stored function, packages, triggers










