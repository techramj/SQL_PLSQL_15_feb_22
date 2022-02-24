SQL> DECLARE
  2    num1 number;
  3    num2 number;
  4    res number;
  5  begin
  6    num1 := 11;
  7    num2 := 22;
  8    res := num1+num2;
  9    dbms_output.put_line(re
 10  .
SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number;
  3    num2 number;
  4    res number;
  5  begin
  6    num1 := 11;
  7    num2 := 22;
  8    res := num1+num2;
  9    dbms_output.put_line('result '+res);
 10* END;
SQL> /
DECLARE
*
ERROR at line 1:
ORA-06502: PL/SQL: numeric or value error: character to number conversion error 
ORA-06512: at line 9 


SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number;
  3    num2 number;
  4    res number;
  5  begin
  6    num1 := 11;
  7    num2 := 22;
  8    res := num1+num2;
  9    dbms_output.put_line('result '||res);
 10* END;
SQL> /
result 33                                                                       

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number;
  3    num2 number;
  4    res number;
  5  begin
  6    num1 := 11;
  7    num2 := 22;
  8    res := num1%num2;
  9    dbms_output.put_line('result '||res);
 10* END;
SQL> /
  res := num1%num2;
              *
ERROR at line 8:
ORA-06550: line 8, column 15: 
PLS-00208: identifier 'NUM2' is not a legal cursor attribute 
ORA-06550: line 8, column 3: 
PL/SQL: Statement ignored 


SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number;
  3    num2 number;
  4    res number;
  5  begin
  6    num1 := 11;
  7    num2 := 22;
  8    res := mod(num1,num2);
  9    dbms_output.put_line('result '||res);
 10* END;
SQL> /
result 11                                                                       

PL/SQL procedure successfully completed.

SQL> select 2**3 from dual;
select 2**3 from dual
         *
ERROR at line 1:
ORA-00936: missing expression 


SQL> select 2*3 from dual;

       2*3                                                                      
----------                                                                      
         6                                                                      

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number;
  3    num2 number;
  4    res number;
  5  begin
  6    num1 := 5;
  7    num2 := 4;
  8    res := num1**num2;  
  9    dbms_output.put_line('result '||res);
 10* END;
SQL> /
result 625                                                                      

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number := 4;
  3    num2 number default 5;  --num2 number := 5;
  4    res number;
  5  begin
  6    res := num1**num2;  
  7    dbms_output.put_line('result '||res);
  8* END;
SQL> /
result 1024                                                                     

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number := 4;
  3    num2 number default 5;  --num2 number := 5;
  4    res number;
  5    a constant number;
  6  begin
  7    res := num1**num2;  
  8    dbms_output.put_line('result '||res);
  9* END;
 10  /
  a constant number;
  *
ERROR at line 5:
ORA-06550: line 5, column 3: 
PLS-00322: declaration of a constant 'A' must contain an initialization 
assignment 
ORA-06550: line 0, column 0: 
PL/SQL: Compilation unit analysis terminated 


SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number := 4;
  3    num2 number default 5;  --num2 number := 5;
  4    res number;
  5    a constant number := 10;
  6  begin
  7    res := num1**num2;  
  8    dbms_output.put_line('result '||res);
  9* END;
SQL> /
result 1024                                                                     

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number := 4;
  3    num2 number default 5;  --num2 number := 5;
  4    res number;
  5    a constant number := 10;
  6  begin
  7    res := num1**num2;  
  8    dbms_output.put_line('result '||res);
  9    a := 20;
 10* END;
SQL> /
  a := 20;
  *
ERROR at line 9:
ORA-06550: line 9, column 3: 
PLS-00363: expression 'A' cannot be used as an assignment target 
ORA-06550: line 9, column 3: 
PL/SQL: Statement ignored 


SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number := &num1;
  3    num2 number := &num2;
  4  begin
  5    if num1>num2 then
  6       dbms_output.put_line(num1||' is greater than '||num2);
  7    end if;
  8* END;
  9  /
Enter value for num1: 10
old   2:   num1 number := &num1;
new   2:   num1 number := 10;
Enter value for num2: 8
old   3:   num2 number := &num2;
new   3:   num2 number := 8;
10 is greater than 8                                                            

PL/SQL procedure successfully completed.

SQL> /
Enter value for num1: 20
old   2:   num1 number := &num1;
new   2:   num1 number := 20;
Enter value for num2: 30
old   3:   num2 number := &num2;
new   3:   num2 number := 30;

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number := &num1;
  3    num2 number := &num2;
  4  begin
  5    if num1>num2 then
  6       dbms_output.put_line(num1||' is greater than '||num2);
  7    else
  8       dbms_output.put_line(num2||' is greater than '||num1); 
  9    end if;
 10* END;
 11  /
Enter value for num1: 10
old   2:   num1 number := &num1;
new   2:   num1 number := 10;
Enter value for num2: 20
old   3:   num2 number := &num2;
new   3:   num2 number := 20;
20 is greater than 10                                                           

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number := &num1;
  3    num2 number := &num2;
  4    num3 number := &num3;
  5    res  number;
  6  begin
  7    if num1>num2 and num1>num2 then
  8       res := num1;
  9    elsif num2>num3 then
 10       res := num2;
 11    else
 12       res := num3; 
 13    end if;
 14    dbms_output.put_line(res||' is greatest number');
 15* END;
SQL> /
Enter value for num1: 10
old   2:   num1 number := &num1;
new   2:   num1 number := 10;
Enter value for num2: 2
old   3:   num2 number := &num2;
new   3:   num2 number := 2;
Enter value for num3: 40
old   4:   num3 number := &num3;
new   4:   num3 number := 40;
10 is greatest number                                                           

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    num1 number := &num1;
  3    num2 number := &num2;
  4    num3 number := &num3;
  5    res  number;
  6  begin
  7    if num1>num2 and num1>num3 then
  8       res := num1;
  9    elsif num2>num3 then
 10       res := num2;
 11    else
 12       res := num3; 
 13    end if;
 14    dbms_output.put_line(res||' is greatest number');
 15* END;
SQL> /
Enter value for num1: 10
old   2:   num1 number := &num1;
new   2:   num1 number := 10;
Enter value for num2: 20
old   3:   num2 number := &num2;
new   3:   num2 number := 20;
Enter value for num3: 4
old   4:   num3 number := &num3;
new   4:   num3 number := 4;
20 is greatest number                                                           

PL/SQL procedure successfully completed.

SQL> set verify off
SQL> /
Enter value for num1: 10
Enter value for num2: 20
Enter value for num3: 3
20 is greatest number                                                           

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  DECLARE
  2    mark number := &mark;
  3    grade varchar2(10);
  4  BEGIN
  5    if mark>=80 then
  6       grade := 'A';
  7    elsif mark>=60 then
  8       grade := 'B';
  9    elsif mark>=40 then
 10       grade := 'C';
 11    else
 12       grade := 'FAIL';
 13    end if;
 14    dbms_output.put_line('Grade: '||grade);
 15* END;
SQL> /
Enter value for mark: 40
Grade: C                                                                        

PL/SQL procedure successfully completed.

SQL> /
Enter value for mark: 88
Grade: A                                                                        

PL/SQL procedure successfully completed.

SQL> /
Enter value for mark: 1
Grade: FAIL                                                                     

PL/SQL procedure successfully completed.

SQL> /
Enter value for mark: 67
Grade: B                                                                        

PL/SQL procedure successfully completed.

SQL> declare
  2    a &datatype := 10;
  3  begin
  4   dbms_output.put_line(a);
  5  end;
  6  /
Enter value for datatype: number
10                                                                              

PL/SQL procedure successfully completed.

SQL> /
Enter value for datatype: varchar2(10)
10                                                                              

PL/SQL procedure successfully completed.

SQL> /
Enter value for datatype: date
  a date := 10;
            *
ERROR at line 2:
ORA-06550: line 2, column 13: 
PLS-00382: expression is of wrong type 
ORA-06550: line 0, column 0: 
PL/SQL: Compilation unit analysis terminated 


SQL> declare
  2   i number := 1;
  3  begin
  4   loop
  5    dbms_output.put_line(i);
  6    i := i+1;
  7    exit when i>10;
  8  end loop;
  9  end;
 10  /
1                                                                               
2                                                                               
3                                                                               
4                                                                               
5                                                                               
6                                                                               
7                                                                               
8                                                                               
9                                                                               
10                                                                              

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  declare
  2   i number := 1;
  3  begin
  4   while i<=10 loop
  5    dbms_output.put_line(i);
  6    i := i+1;
  7  end loop;
  8* end;
SQL> /
1                                                                               
2                                                                               
3                                                                               
4                                                                               
5                                                                               
6                                                                               
7                                                                               
8                                                                               
9                                                                               
10                                                                              

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  begin
  2   FOR i in 1..10 loop
  3    dbms_output.put_line(i);
  4  end loop;
  5* end;
  6  /
1                                                                               
2                                                                               
3                                                                               
4                                                                               
5                                                                               
6                                                                               
7                                                                               
8                                                                               
9                                                                               
10                                                                              

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  begin
  2   FOR i in 1..10 loop
  3    dbms_output.put(i+'   ');
  4  end loop;
  5* end;
SQL> /
begin
*
ERROR at line 1:
ORA-06502: PL/SQL: numeric or value error: character to number conversion error 
ORA-06512: at line 3 


SQL> ed
Wrote file afiedt.buf

  1  begin
  2   FOR i in 1..10 loop
  3    dbms_output.put(i||'   ');
  4  end loop;
  5* end;
SQL> /

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  begin
  2   FOR i in 1..10 loop
  3    dbms_output.put(i||'   ');
  4  end loop;
  5  dbms_output.put_line('')
  6* end;
SQL> /
end;
*
ERROR at line 6:
ORA-06550: line 6, column 1: 
PLS-00103: Encountered the symbol "END" when expecting one of the following: 
:= . ( % ; 
The symbol ";" was substituted for "END" to continue. 


SQL> ed
Wrote file afiedt.buf

  1  begin
  2   FOR i in 1..10 loop
  3    dbms_output.put(i||'   ');
  4  end loop;
  5  dbms_output.put_line('');
  6* end;
SQL> /
1   2   3   4   5   6   7   8   9   10                                          

PL/SQL procedure successfully completed.

SQL> 
SQL> ed
Wrote file afiedt.buf

  1  begin
  2   FOR i in 10..1 loop
  3    dbms_output.put(i||'   ');
  4  end loop;
  5  dbms_output.put_line('');
  6* end;
SQL> /

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  begin
  2   FOR i in reverse 1..10 loop
  3    dbms_output.put(i||'   ');
  4  end loop;
  5  dbms_output.put_line('');
  6* end;
SQL> /
10   9   8   7   6   5   4   3   2   1                                          

PL/SQL procedure successfully completed.

SQL> ed
Wrote file afiedt.buf

  1  begin
  2   FOR i in 1..4 loop
  3     --print  space or dot
  4     for j in 1..4-i loop
  5       dbms_output.put('.');
  6     end loop;
  7     --print  star
  8     for j in 1..2*i-1 loop
  9       dbms_output.put('*');
 10     end loop;
 11     dbms_output.put_line('');
 12   end loop;
 13  dbms_output.put_line('');
 14* end;
 15  /
...*                                                                            
..***                                                                           
.*****                                                                          
*******                                                                         

PL/SQL procedure successfully completed.

SQL> select lpad(' ',4-rownum,' ')||lpad('*', 2*rownum-1,'*')
  2  from employees where rownum<=4;
from employees where rownum<=4
     *
ERROR at line 2:
ORA-00942: table or view does not exist 


SQL> ed
Wrote file afiedt.buf

  1  select lpad(' ',4-rownum,' ')||lpad('*', 2*rownum-1,'*')
  2* from all_tables where rownum<=4
SQL> /

LPAD('',4-ROWNUM,'')||LPAD('*',2*ROWNUM-1,'*')                                  
--------------------------------------------------------------------------------
   *                                                                            
  ***                                                                           
 *****                                                                          
*******                                                                         

SQL> ed
Wrote file afiedt.buf

  1  select lpad(' ',abs(4-rownum),' ')||lpad('*', 2*(4-abs(4-rownum))-1,'*')
  2* from all_tables where rownum<=7
SQL> /

LPAD('',ABS(4-ROWNUM),'')||LPAD('*',2*(4-ABS(4-ROWNUM))-1,'*')                  
--------------------------------------------------------------------------------
   *                                                                            
  ***                                                                           
 *****                                                                          
*******                                                                         
 *****                                                                          
  ***                                                                           
   *                                                                            

7 rows selected.

SQL> ed
Wrote file afiedt.buf

  1  declare
  2    k number; 
  3    x number;
  4  begin
  5       FOR i in 1..7 loop
  6          k := abs(4-i);
  7         --print  space or dot
  8         for j in 1..k loop
  9           dbms_output.put('.');
 10         end loop;
 11         --print  star
 12         x := 4-k;
 13         for j in 1..2*x-1 loop
 14           dbms_output.put('*');
 15        end loop;
 16        dbms_output.put_line('');
 17      end loop;
 18     dbms_output.put_line('');
 19* end;
SQL> /
...*                                                                            
..***                                                                           
.*****                                                                          
*******                                                                         
.*****                                                                          
..***                                                                           
...*                                                                            

PL/SQL procedure successfully completed.

SQL> spool off
