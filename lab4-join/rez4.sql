SELECT 
 TO_CHAR(sysdate,'dd-mm-yyyy hh:mi:ss AM')
 FROM DUAL;
 
/* Exercitiul 12 */
SELECT ROUND
 (TO_DATE('31-12-2016','dd-mm-yyyy')-sysdate) "nr zile"
 FROM DUAL;
 
/* Exercitiul 13*/
SELECT TO_CHAR(sysdate + 1/2, 'hh24:mi AM')
FROM DUAL;

/*Exercitiul 7 */
SELECT first_name || last_name "nume_angajat",
next_day(add_months(hire_date,6), 'Monday') "Negociere"
FROM employees;
/* Se poate schimba limba implicita a sistemului pentru sesiunea curenta*/

/* Exercitiul 8 */
SELECT first_name || last_name "nume_angajat",
next_day(add_months(hire_date,6), 'FRIDAY') "Negociere"
FROM EMPLOYEES; 

/* Exercitiul 9*/
Select last_name, round(months_between(sysdate, hire_date)) "Luni lucrate"
from EMPLOYEES;

/* Exercitiul 3 si prima pozitie in nume de la litera A ceva ceva de la 4*/
SELECT INITCAP(first_name),UPPER(last_name),length(last_name),
INSTR(last_name,'a')
FROM EMPLOYEES
WHERE SUBSTR(LAST_NAME,1,1) IN ('J','M')
/* daca folosim nr negative, pleaca de la dreapta la stanga. Daca nu bagam ultimul argument le ia pe toate */
ORDER BY 3 DESC ;
/*IN LOC DE 2, POATE FI PUS LENGTH(LAST_NAME) DESC, lungime, ALIAS - lungime DESC */
/*ALTERNATIV last_name LIKE 'J%' OR last_name LIKE 'M%' */

/*Exercitiul 5*/
SELECT last_name, RPAD(' ', (sysdate-hire_date)/1000 +1,'*') 
FROM employees;

/*Exercitiul 15 */
SELECT last_name, NVL(TO_CHAR(commission_pct),'fara comision') 
FROM EMPLOYEES;

/* VARIANTA GENERALA PT CASE!!!*/
 SELECT last_name,
  CASE 
  WHEN job_id='IT_PROG' THEN salary*1.2
  WHEN job_id='SA_REP' THEN salary*1.25
  WHEN job_id='SA_MAN' THEN salary*1.35
  ELSE salary
  END "salariu negociat"
  FROM employees;

/*Exercitiul 18*/
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

/*Exercitiul 17 */
SELECT d.department_id, d.department_name, l.city,e.last_name "manager"
FROM departments d, locations l, employees e
WHERE d.location_id=l.location_id AND d.manager_id=e.employee_id
ORDER BY DECODE(l.city,'Seattle',0,1), l.city, d.department_name;

/* LAB 4 */
/* Ex 6*/
SELECT d.department_id, d.department_name,e.last_name, j.job_title
FROM employees e JOIN departments d ON (e.department_id=d.department_id) JOIN jobs j ON (e.job_id=j.job_id);
/* Avantaj: putem separa joinul de conditia de filtrare */

/* Ex 8 */
SELECT e.last_name, d.department_name
FROM employees e JOIN job_history jh ON (e.employee_id=jh.employee_id) 
JOIN job_history coleg ON (e.employee_id!=coleg.employee_id 
AND MONTHS_BETWEEN(jh.start_date, coleg.start_date) >2
AND jh.department_id=coleg.department_id)
JOIN departments d ON (jh.department_id=d.department_id);

/*Ex 4 */
/* IN OUTER JOIN-uri e data o sintaxa specifica Oracle, cu +-uri, care merg pe de-andoaselea, + acolo unde lipseste informatoia */
/* Full outer join,reuniune de tabele - Union e full outer join - Nu folosim dracia in sintaxa Oracle. Se fac left + right outer join-uri si apoi se face un Union, si nu e bine, pentru ca apar niste NULl-uri de la dracu, unde avem alte informatii. Union se foloseste cand avem informatii din 2 tabele complet diferite. */

/* Ex 11 */
SELECT e.last_name, d.department_name
FROM employees e
LEFT JOIN departments d
ON (e.department_id = d.department_id) /* sunt pastrati si cei cu NULL la department id */
LEFT JOIN locations l
ON (d.location_id=l.location_id); /* pentru ca poate fi null */
