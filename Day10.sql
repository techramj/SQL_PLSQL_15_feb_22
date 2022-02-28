--Composite datatype
--record

CREATE TABLE employees_dup AS SELECT * FROM employees WHERE 1=2;
SELECT * FROM employees_dup;

-- insert using record
DECLARE
   CURSOR cur1 IS SELECT * FROM employees WHERE department_id IN (10,20,30,40,60);
BEGIN
  FOR rec IN cur1 LOOP
    rec.employee_id := cur1%ROWCOUNT;
    INSERT INTO employees_dup VALUES rec;
  END LOOP;
  COMMIT;
END;
/

--update using record
DECLARE
  rec employees_dup%ROWTYPE;
BEGIN
  SELECT * INTO rec
  FROM employees_dup
  WHERE employee_id=1;
  
  rec.salary := rec.salary+1000;
  
  UPDATE employees_dup
  SET ROW = rec
  WHERE employee_ID=1;
  
  COMMIT;
END;
/


--collection in plsql
--1. plsql table
--2. associative array or nested plsql table
--3. varray
--Attributes of collection
  --1. count
  --2. first
  --3. last
  --4. next
  --5. prior
  --6. delete(m)   delete(m,n)
  --7. exists


--plsql table(table of two column . 1st column  as key and 2nd column as value)
DECLARE
   TYPE tab_type IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
   tab  tab_type;
BEGIN
   tab(3) := 'Mango';
   tab(1) := 'Apple';
   tab(2) := 'Carrot';
   tab(10) := 'Banana';
  
   print('size:'||tab.count);
   print('first index:'||tab.first);
   print('last index:'||tab.last);
   print('next index of 2 :'||tab.next(2));
   print('prior index of 2 :'||tab.prior(2));
   dbms_output.put('index 5 exists or not : ');
   IF tab.exists(5) THEN
     print('   Yes');
   ELSE
     print('   No');
   END IF;
   
   --iterate the collection
   FOR i IN tab.first.. tab.last LOOP
     IF tab.exists(i) THEN
        print(i||' => '||tab(i));
     END IF;
   END LOOP;
   
END;
/

--or
DECLARE
   TYPE tab_type IS TABLE OF VARCHAR2(100) INDEX BY PLS_INTEGER;
   tab  tab_type;
   idx  NUMBER;
BEGIN
   tab(3) := 'Mango';
   tab(1) := 'Apple';
   tab(2) := 'Carrot';
   tab(1000000) := 'Banana';
  
   print('size:'||tab.count);
   print('first index:'||tab.first);
   print('last index:'||tab.last);
   print('next index of 2 :'||tab.next(2));
   print('prior index of 2 :'||tab.prior(2));
   dbms_output.put('index 5 exists or not : ');
   IF tab.exists(5) THEN
     print('   Yes');
   ELSE
     print('   No');
   END IF;
   tab.delete(2);
   --iterate the collection
   idx := tab.first;
   LOOP
     EXIT WHEN idx IS NULL;
     print(idx||' => '||tab(idx));
     idx := tab.next(idx);
   END LOOP; 
END;
/

--wap to populate the plsql table with key as employee_id and value as below
  --Kochhar salary is 20000 and working in department 90.
  --and then iterate the plsql table

 SELECT * FROM employees;

DECLARE
   TYPE tab_type IS TABLE OF VARCHAR2(1000) INDEX BY PLS_INTEGER;
   tab  tab_type;
   idx  NUMBER;
BEGIN
  FOR rec IN (SELECT * FROM employees ORDER BY department_id) LOOP
    tab(rec.employee_id) := rec.Last_name||' salary is '||rec.salary||
                   ' and working in department '||rec.department_id;
  
  END LOOP;
  
  idx := tab.first;
   LOOP
     EXIT WHEN idx IS NULL;
     print(idx||' => '||tab(idx));
     idx := tab.next(idx);
   END LOOP; 
  
END;
/




--Nested table or associative array
--wap to store top five salary
DECLARE
  TYPE sal_tab_type IS TABLE OF NUMBER;
  sal_tab sal_tab_type;
  total_sal NUMBER;
BEGIN
   SELECT DISTINCT salary 
   BULK COLLECT INTO sal_tab
   FROM employees
   ORDER BY salary DESC;
   
   print('total distinct sal: '||sal_tab.count);
   
  --SELECT SUM(COLUMN_VALUE) INTO total_sal FROM TABLE(sal_tab);
  --local collection type cannot be used in sql statement
   
   print('sum of distict salary: '||total_sal);
   
   FOR i IN 1..sal_tab.count LOOP
     print(sal_tab(i));
   END LOOP;
   
END;
/

--OR


DECLARE
  TYPE sal_tab_type IS TABLE OF NUMBER;
  sal_tab sal_tab_type;
  total_sal NUMBER;
BEGIN
   SELECT DISTINCT salary 
   BULK COLLECT INTO sal_tab
   FROM employees 
   ORDER BY salary DESC;
   
   print('total distinct sal: '||sal_tab.count);
   
  --SELECT SUM(COLUMN_VALUE) INTO total_sal FROM TABLE(sal_tab);
  --local collection type cannot be used in sql statement
   
   print('sum of distict salary: '||total_sal);
   
   FOR i IN sal_tab.first..sal_tab.last LOOP
     print(sal_tab(i));
   END LOOP;
   
END;
/

--varray

DECLARE
  TYPE sal_tab_type IS VARRAY(10) OF NUMBER;
  sal_tab sal_tab_type;
  total_sal NUMBER;
BEGIN
   SELECT salary 
   BULK COLLECT INTO sal_tab
   FROM (   SELECT DISTINCT salary 
           FROM employees
           ORDER BY salary DESC
           )
   WHERE ROWNUM<=11;
   
   print('total distinct sal: '||sal_tab.count);
   
  --SELECT SUM(COLUMN_VALUE) INTO total_sal FROM TABLE(sal_tab);
  --local collection type cannot be used in sql statement
   
   print('sum of distict salary: '||total_sal);
   
   FOR i IN 1..sal_tab.count LOOP
     print(sal_tab(i));
   END LOOP;
   
END;
/


--WAP to populate the details of all employees working in department 20,40,60

DECLARE
  TYPE emp_tab_type IS TABLE OF employees%ROWTYPE;
  tab emp_tab_type;
BEGIN
    SELECT * 
    BULK COLLECT INTO tab
    FROM employees
    WHERE department_id IN (20,30,60);


   FOR i IN 1..tab.count LOOP
     print(tab(i).employee_id||'   '||tab(i).last_name||'  '||tab(i).salary||'  '||tab(i).department_id );
   END LOOP;
   
END;
/



