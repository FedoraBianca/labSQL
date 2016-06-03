
/*LABORATOR 5: SELECTURI IN ALTE SELECTURI - SUBCERERI
NECORELATE- pot fi luate de acolo si tot are totul sens. Returneaza o multime de linii
CORELATE- preiau ceva dintr-un select mare, nu au sens de sine statator. Iau o linie din selectul principal. Ca si cum toata conditia de la cerere nu exista. Pentru fiecare din selectul rezultat 
se evalueaza conditia din subcerere cu "extern". In spate sunt join-uri.

EX. 1 - var cu subcereri*/

select employee_id, job_id,last_name
from employees e
where salary > 3000
or salary = (select ( min_salary + max_salary) / 2 
from jobs where job_id = e.job_id);

/*EX. 1 - var cu joinuri*/

select e.employee_id, j.job_id,e. last_name
from employees e,jobs j
where j.job_id = e.job_id
and e.salary > 3000 
or e.salary=(j.min_salary+ j.max_salary)/2;

/*2*/

select e.employee_id,d.department_name,e.salary
from employees e join jobs j on (e.job_id=j.job_id)
join departments d on (e.department_id = d.department_id)
where(salary,commission_pct)
in(/*salariu si comision din Oxford:*/
select salary, commission_pct from employees where department_id
in(select department_id from departments where location_id in (select location_id from locations where city='Oxford')
));

/*4*/
select e.employee_id,e.first_name, e.last_name,e.salary
from employees e
where e.manager_id=(select employee_id from employees  where manager_id is null);

/*6*/
select last_name,salary from employees
where salary =
(select max(salary) from employees);

/*alternativ
salary >=ALL (select salary from employees):
salary >=1000 AND salary >=2000 AND salary >= 30000 AND ........
salary >=ANY(select salary from employees):
salary >=1000 OR salary >=2000.......
*/

select last_name,salary from employees
where salary >= ALL (select salary from employees); /*Avem nevoie si de o conditie cu sakariul diferit de null*/

/*10*/
select e.last_name, e.department_id, e.hire_date from employees e
where e.hire_date = (select min(hire_date) from employees where department_id=e.department_id);
