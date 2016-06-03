SELECT  last_name     as nume,
               salary           as "Salariu", 
               job_id           "titlu job",
               job_id  
FROM     employees;


SELECT rownum nr_crt, 
             first_name, 
            last_name
FROM employees;


SELECT sysdate
FROM dual;

select * from dual;

SELECT sysdate
FROM employees;


--Exerciţiul 7: Să se afișeze pentru fiecare angajat codul, numele, codul departamentului în care
--lucreaza fiecare angajat și numărul de zile care au trecut de la data angajării.
/*   comment */

select employee_id, first_name, department_id, round(sysdate- hire_date, 2) "nr de zile de la ang"
from employees;

--Exerciţiul 8: Să se afişeze numele angajaţilor, codul_angajaţilor (employee_id) şi venit anual al
--acestora (salary * 12).

select employee_id, last_name,
           first_name, 
           (salary + salary * nvl(commission_pct, 0)  )* 12 "venit anual"
from employees;


select  employee_id, last_name,
           first_name, 
           (salary + salary * nvl(commission_pct, 0)  )* 12 "venit anual"
from employees
where  commission_pct = null; 


select  employee_id, last_name,
           first_name, 
           (salary + salary * nvl(commission_pct, 0)  )* 12 "venit anual"
from employees
where  commission_pct is null;

select  employee_id, last_name,
           first_name, 
           (salary + salary * nvl(commission_pct, 0)  )* 12 "venit anual"
from employees
where  commission_pct is not null;


SELECT last_name || ' ' || first_name || ' ' || job_id || ' ' || salary "nume si functie salariu"
FROM employees;



SELECT employee_id, last_name, first_name, department_id
FROM employees
WHERE department_id IN (10, 20, 80);

SELECT employee_id, last_name, first_name, department_id
FROM employees
WHERE department_id = 10 or  department_id = 20  or  department_id =  80;

--Exerciţiul 18: Să se afişeze numele şi codul departamentului
--pentru angajaţii care au codul jobului
--IT_PROG sau HR_REP.

select last_name, department_id, job_id
from employees
where job_id in (  'IT_PROG'  , 'HR_REP'  );


select last_name, department_id, job_id
from employees
where job_id not in (  'IT_PROG'  , 'HR_REP'  );


SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 7000 AND 17000;

--25


where job_id like '%CLERK%' sau job_id like  '%REP%' 
and salary not in (1000,2000,3000);


--26
where upper(last_name)  like '%L%L%'   and (department_id = 30 or manager_id = 102)
;


SELECT first_name, last_name, TO_CHAR(hire_date,'dd-mon-yy')
FROM employees
WHERE hire_date LIKE ('%87%');

SELECT first_name, last_name, TO_CHAR(hire_date,'dd-mon-yy')
FROM employees
WHERE TO_CHAR(hire_date,'dd-mm-yyyy') = '17-06-1987';


select distinct to_char( hire_date, 'mm-yyyy'  )
from employees;



--Exerciţiul 16: Să se afişeze data curentă în fomatul ”zi – lună – an ora:minut”.


select to_char( sysdate + 1/2, 'dd-mon-yy  hh hh24:mi AM'   ) 
from dual;

--Nr de zile pana la sfarsitul anului
select   to_date( '31-12-2016' , ' dd-mm-yyyy ' )    -   sysdate
from dual;


SELECT SYSTIMESTAMP FROM dual;
SELECT CAST (SYSDATE AS TIMESTAMP) FROM dual;
SELECT TO_TIMESTAMP('03-02-2014 10:30:50.45', 'dd-mm-yyyy hh24:mi:ss.ff') from dual;
SELECT sysdate + INTERVAL '3-2' YEAR TO MONTH from dual;
SELECT systimestamp + INTERVAL '1 1:05:30.40' DAY TO SECOND FROM DUAL;



















































