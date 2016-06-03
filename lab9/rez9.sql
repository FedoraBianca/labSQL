8/l6
select e.last_name,  e.manager_id, m.last_name
from employees e, employees m
where e.manager_id = m.employee_id;

select count(*) nr_sub,  e.manager_id, m.last_name, m.email, m.phone_number, l.city
from employees e, employees m, departments d, locations l
where e.manager_id = m.employee_id
and m.department_id = d.department_id
and d.location_id = l.location_id and m.manager_id is not null
and l.city = ( select l.city
                  from employees e, departments d, locations l
                  where e.manager_id is null 
                  and e.department_id = d.department_id
                  and d.location_id = l.location_id   )
group by e.manager_id, m.last_name , m.email, m.phone_number, l.city
having count(*) >=5;
13/l6  numarul joburilor avute anterior (inclusiv 0).

select count(jh.employee_id), e.employee_id, e.last_name, 
           round(months_between(min(nvl(jh.end_date,sysdate)), min(nvl(jh.start_date, e.hire_date))), 2)
from employees e, job_history jh
where e.employee_id = jh.employee_id(+)
group by  e.employee_id, e.last_name;

Exerciţiul 14: Să se determine numărul angajaţilor care nu câştigă comision.
select count(*) - count(commission_pct) "ang care au comision"
from employees;

select department_id , sum(grila_comision)
from (
  select last_name, department_id, commission_pct, 
           case when commission_pct < 0.2 then 1
           else 0 end grila_comision        
  from employees
  )
group by department_id  ;


select department_id, job_id, sum(salary)
from employees
group by department_id, job_id
union
select department_id, null, sum(salary)
from employees
group by department_id
union
select null, null, sum(salary)
from employees;

select department_id, job_id, sum(salary), grouping(department_id), grouping(job_id) 
from employees
group by rollup (department_id, job_id);

select department_id, job_id, sum(salary), grouping(department_id), grouping(job_id) 
from employees
group by cube (department_id, job_id);

select department_id, job_id, sum(salary), grouping(department_id), grouping(job_id) 
from employees
group by grouping sets ((department_id, job_id), (  ));

8/l7
select * from
(select d.department_name, sm.nr_sub, md.medie_sal
from departments d,  (select manager_id cod_ang, count(*) nr_sub 
                                     from employees
                                     group by manager_id) sm,
                                     (select department_id, avg(salary) medie_sal
                                      from employees
                                      group by department_id) md
where d.manager_id = sm.cod_ang and d.department_id = md.department_id
order by sm.nr_sub desc) 
where rownum <=3;



CREATE TABLE dept_tib
AS SELECT * FROM departments;
CREATE TABLE employees_tib
AS SELECT * FROM employees;
delete from dept_tib;
--12/l9 
delete from employees_tib where commission_pct is null;
delete from employees_tib e 
where not exists (select 'x' from employees where manager_id = e.employee_id);
commit;

insert into dept_tib(department_id, department_name, location_id)
values (1, 'Departament 1', 1100);

insert into dept_tib(department_id, department_name, location_id, manager_id )
select department_id, department_name, location_id, manager_id 
from departments;

Exercițiul 20: Schimbaţi salariul şi comisionul celui mai prost plătit salariat 
din firmă, astfel încât să fie egale cu salariul si comisionul directorului.

drop table  employees_tib;
CREATE TABLE employees_tib
AS SELECT * FROM employees;

update  employees_tib 
set  (salary, commission_pct) = (select salary, commission_pct from employees 
                                                      where manager_id is  null)
where salary = (select min(salary) from employees);

rollback;

Exercițiul 21: Pentru fiecare departament să se mărească salariul celor care au fost angajaţi primii
astfel încât să devină media salariilor din departament, comisionul sa fie marit  0.5.
update employees_tib e
set  commission_pct = commission_pct + 0.5,
       salary                  = (select avg(salary) from employees where department_id = e.department_id)
where hire_date = (select min(hire_date) from employees where department_id = e.department_id); 


