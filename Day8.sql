BEGIN
   dbms_output.put_line('hello world');
END;
/

BEGIN
  FOR i IN 1..4 LOOP
    FOR j IN 1..i LOOP
      dbms_output.put(j||' ');
      EXIT WHEN j=2;
    END LOOP;
    dbms_output.put_line('');
  END LOOP;
END;
/

--label for the loop
BEGIN
  <<OUTER>>
  FOR i IN 1..4 LOOP
    <<INNER>>
    FOR j IN 1..i LOOP
      dbms_output.put(j||' ');
      EXIT OUTER WHEN j=2;
    END LOOP;
    dbms_output.put_line('');
  END LOOP;
  dbms_output.put_line('');
END;
/


DECLARE
  a NUMBER := 10;
  b NUMBER :=20;
BEGIN
  DECLARE
    a NUMBER := 111;
    c NUMBER := 222;
  BEGIN
    dbms_output.put_line('output of inner block');
    dbms_output.put_line('a='||a);
    dbms_output.put_line('a='||a);
    dbms_output.put_line('b='||b);
    dbms_output.put_line('c='||c);  
  END;
   dbms_output.put_line('output of outer block');
  dbms_output.put_line('a='||a);
  dbms_output.put_line('b='||b);
  --dbms_output.put_line('c='||c);
END;
/
  
BEGIN
  <<OUTER>>
  DECLARE
    a NUMBER := 10;
    b NUMBER :=20;
  BEGIN
    <<INNER>>
    DECLARE
      a NUMBER := 111;
      c NUMBER := 222;
    BEGIN
      dbms_output.put_line('output of inner block');
      dbms_output.put_line('inner a='||a);
      dbms_output.put_line('outer a='||outer.a);
      dbms_output.put_line('b='||b);
      dbms_output.put_line('c='||c);  
    END;
     dbms_output.put_line('output of outer block');
    dbms_output.put_line('a='||a);
    dbms_output.put_line('b='||b);
    --dbms_output.put_line('c='||c);
  END;
END;
/

--WAp to check whether the number is prime or even or odd


DECLARE
 a NUMBER := &NUM;
BEGIN
  IF MOD(a,2) = 0 THEN
    NULL;
  ELSE
    NULL;
  
  END IF;
  FOR i IN 2..a-1 LOOP
    IF MOD(a,i)=0 THEN
      RETURN;
    END IF;
  END LOOP;
 
END;
/

CREATE TABLE emp(ID NUMBER,NAME VARCHAR2(20),salary NUMBER);
INSERT INTO emp VALUES (1,'Jack',1000);
SELECT * FROM emp;
 DELETE emp WHERE ID=2;
--DML
--In plsql block, DML is  allowed
BEGIN
   INSERT INTO emp VALUES (2,'John',2000);
END;
/

BEGIN
   DELETE emp WHERE ID=2;
END;
/

--In plsql block, TCL is  allowed
--TCL
BEGIN
  COMMIT;
  ROLLBACK;
  SAVEPOINT a;
END;


--DDL 
--In plsql block, ddl is not allowed
BEGIN
  CREATE TABLE emp(ID NUMBER,NAME VARCHAR2(20),salary NUMBER);
END;
/

--DCL
--In plsql block, DCL is not allowed
BEGIN
  GRANT SELECT ON emp TO SYSTEM;
END;
/

--Implicit cursor name SQL have 3 attributes
1. %FOUND
2. %NOTFOUND
3. %ROWCOUNT

CREATE OR REPLACE PROCEDURE print(msg VARCHAR2)
IS
BEGIN
  dbms_output.put_line(msg);
END;
/ 

BEGIN
   INSERT INTO emp VALUES (2,'John',2000);
   print(SQL%ROWCOUNT||' row inserted');
END;
/

BEGIN
   DELETE emp WHERE ID=2;
   print(SQL%ROWCOUNT||' row deleted');
   IF SQL%NOTFOUND THEN
     print('invalid id');
   END IF;
END;
/

BEGIN
   INSERT INTO emp SELECT employee_id,last_name,salary FROM employees
   WHERE employee_id<=110;
   print(SQL%ROWCOUNT||' row inserted');
END;
/


--select in plsql block
DECLARE
  lname VARCHAR2(20);
  ID  NUMBER := &ID;
BEGIN
  SELECT last_name  INTO lname FROM employees
  WHERE employee_id =ID;
  print('Last Name: '||lname);
END;
/

--or

DECLARE
  lname employees.last_name%TYPE;
  ID  NUMBER := &ID;
BEGIN
  SELECT last_name  INTO lname FROM employees
  WHERE employee_id =ID;
  print('Last Name: '||lname);
END;
/

--WAP to display the full name of employees => id from 100 to 110;

DECLARE
  lname VARCHAR2(20);
BEGIN
  FOR i IN 100..110 LOOP
    SELECT first_name||' '||last_name  INTO lname FROM employees
    WHERE employee_id =i;
    print('Id: '||i||'   Last Name: '||lname);
  END LOOP;
END;
/


--WAP to display the last name and salary of employees => id from 100 to 110;

DECLARE
  lname VARCHAR2(50);
  sal   NUMBER;
BEGIN
  FOR i IN 100..110 LOOP
    SELECT last_name,salary  INTO lname,sal FROM employees
    WHERE employee_id =i;
    print('Id: '||i||'   Last Name: '||lname||'  salary:'||sal);
  END LOOP;
END;
/


--%type
DECLARE
   today       DATE;
   tomorrow    today%TYPE;
   a           table_name.column_name%TYPE;
BEGIN
   NULL;
END;
/

--WAP to print the differnce of sum and avg of department prompted at run time.

DECLARE
  did   employees.department_id%TYPE := &did;
  sum_sal      NUMBER;
  AVG_sal      NUMBER;
  diff         NUMBER;
BEGIN
  SELECT SUM(salary), AVG(salary) INTO sum_sal, avg_sal
  FROM employees
  WHERE department_id=did;
  diff := sum_sal - avg_sal;
  print('Diff: '||diff);
END;
/


DECLARE
  v_salary  employees.salary%TYPE :=10;
  v_employee_id      employees.employee_id%TYPE := &ID;
BEGIN
  SELECT salary INTO v_salary
  FROM employees
  WHERE employee_id= v_employee_id;
  print('salary : '||v_salary);
END;
/

King
KING
kIng
KIng

Kochhar

GRANT
abel

DECLARE
  v_salary  employees.salary%TYPE :=10;
  v_last_name      employees.last_name%TYPE := '&NAME';
BEGIN
  SELECT salary INTO v_salary
  FROM employees
  WHERE LOWER(last_name) = LOWER(v_last_name);
  print('salary : '||v_salary);
END;
/


WAP TO find THE NAME OF THE employee HAVING highest salary
WITHOUT USING subquery.



DECLARE
  v_max_sal employees.salary%TYPE;
  v_name    employees.last_name%TYPE;
BEGIN
  SELECT MAX(salary) INTO v_max_sal FROM employees;
  
  SELECT last_name INTO v_name 
  FROM employees
  WHERE salary = v_max_sal;
  
  print('Name:; '||v_name);
END;
/











