
SELECT employee_id as cod, job_id as departament  FROM emps WHERE trim(first_name) = 'Steven';

/*Ex 3 */
SELECT INITCAP(first_name),UPPER(last_name),length(last_name),
INSTR(last_name,'a')
FROM EMPLOYEES
WHERE (SUBSTR(LAST_NAME,1,1) IN ('J','M')) OR (LAST_NAME LIKE '_b%')
/* daca folosim nr negative, pleaca de la dreapta la stanga. Daca nu bagam ultimul argument le ia pe toate */
ORDER BY 3 DESC ;
/*IN LOC DE 2, POATE FI PUS LENGTH(LAST_NAME) DESC, lungime, ALIAS - lungime DESC */
/*ALTERNATIV last_name LIKE 'J%' OR last_name LIKE 'M%' */

/*Ex 4 */
SELECT employee_id "cod", last_name "nume", LENGTH(last_name) "lungime nume", INSTR(LOWER(last_name), 'a') "prima poz. a" FROM employees WHERE LOWER(SUBSTR(last_name,-1))='e';

/*Ex 5 */
SELECT last_name, hire_date, RPAD(' ', (sysdate-hire_date)/1000 +1,'*')
FROM employees;

/* Ex 7 prima zi de luni dupa 6 luni de la angajate */
SELECT first_name || last_name "nume_angajat", hire_date,
next_day(add_months(hire_date,6), 'Monday') "Negociere"
FROM employees;

/* Ex 8 */
SELECT 
TO_DATE(next_day(TO_DATE(add_months(sysdate,3),'dd-mm-yyy hh24:mi:ss'),'Friday'),'dd-mm-yyy hh24:mi') "urm, vineri de peste 3 luni"
FROM DUAL;

/*Ex 9 */
Select last_name, round(months_between(sysdate, hire_date)) "Luni lucrate"
from EMPLOYEES ORDER BY "Luni lucrate";

/* Ex 12 - nr. de zile ramase pana la sfarsitul anului*/
SELECT ROUND
(TO_DATE('31-12-2016','dd-mm-yyyy')-sysdate) "nr zile"
FROM DUAL;

/* Ex 13 - data de peste 2 ore */
SELECT TO_CHAR(sysdate + 2/24, 'hh24:mi AM')
FROM DUAL;

/*Ex 15 */
SELECT last_name "NUME", NVL(TO_CHAR(commission_pct),'fara comision') "Comision"
FROM EMPLOYEES;

16. 
SELECT last_name, job_id, salary, DECODE(job_id,'IT_PROG',salary*1.2,'SA_REP',salary*1.25,'SA_MAN',salary*1.35,salary
)"Salariu negociat" FROM employees; 
sau
SELECT last_name, job_id, salary, 
CASE job_id
WHEN 'IT_PROG' THEN salary*1.2
WHEN 'SA_REP' THEN salary*1.5
WHEN 'SA_MAN' THEN salary*1.35
ELSE salary
END "Salariu negociat" 
FROM employees;

/* ex cu case */
SELECT last_name, job_title, department_name,
CASE
WHEN MONTHS_BETWEEN(sysdate, hire_date) >0
AND MONTHS_BETWEEN(sysdate, hire_date) <100
THEN MONTHS_BETWEEN(sysdate, hire_date) * 10*salary
WHEN MONTHS_BETWEEN(sysdate, hire_date) >100
THEN MONTHS_BETWEEN(sysdate, hire_date) * 5 * salary
ELSE salary
END "Salariu in functie de vechime"
FROM employees e, departments d, jobs j
WHERE e.department_id=d.department_id AND e.job_id=j.job_id;

/* Ex 17 */
SELECT d.department_id, d.department_name, l.city, NVL2(e.last_name, e.last_name, 'manager necunoscut') "manager"
FROM departments d, locations l, employees e
WHERE d.location_id=l.location_id AND d.manager_id=e.employee_id
ORDER BY DECODE(l.city,'Seattle',0,1), l.city, d.department_name;
