SELECT department_id, avg(salary) medie_sal
FROM employees
group BY department_id
order by department_id;
order by avg(salary)
order by 2   order by medie_sal


Exerciţiul 5/l6: Scrieţi o cerere pentru a se afişa numele departamentului, 
orasul, numărul de angajaţi şi salariul mediu pentru angajaţii din acel departament. 
Coloanele vor fi etichetate corespunzător.

select e.last_name, d.department_id, d.department_name, e.salary, l.city
from employees e join departments d on (e.department_id = d.department_id)
                              join locations l on (d.location_id = l.location_id)
order by d.department_id, d.department_name, l.city;
     
select d.department_id, d.department_name, l.city, round(avg(e.salary), 2) medie, 
           count(*) nr_ang
from employees e join departments d on (e.department_id = d.department_id)
                               join locations l on (d.location_id = l.location_id)
group by d.department_id, d.department_name, l.city;

***
Pentru fiecare departament si fiecare job, sa se afiseze salariul minim castigat de angajati.
select e.last_name, d.department_id, d.department_name, e.salary, j.job_title
from employees e join departments d on (e.department_id = d.department_id)
                              join jobs j on (e.job_id = j.job_id)
order by d.department_id, d.department_name, j.job_title;


select d.department_id, d.department_name, j.job_title, min(e.salary) sal_min 
from employees e join departments d on (e.department_id = d.department_id)
                              join jobs j on (e.job_id = j.job_id)
group by d.department_id, d.department_name, j.job_title
having min(salary) > 5000
order by d.department_id, d.department_name, j.job_title;


*** sa se afiseze pentru fiecare oras, media comisioanelor castigate de angajatii 
care lucreaza in orasul respectiv

select e.employee_id,e.last_name, l.city, e.commission_pct
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
order by l.city;

select l.city, avg(e.commission_pct),  round(avg(nvl(e.commission_pct,0)),2),
                                                             round(sum(e.commission_pct)/count(*),2) 
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
group by l.city
order by l.city;

***
sa se afiseze pentru fiecare angajat numele, salariul si diferenta fata de salariul minim
in departamentul sau.

select e.last_name, e.salary, e.salary- dep.minim
from employees e, (select department_id, min(salary)  minim 
                                 from employees 
                                 group by department_id
                                 ) dep
where e.department_id = dep.department_id;


Exercițiul 17/l5 : Să se obțina media salariului noilor veniti (ultimii 10 angajati).
select avg(salary) from (
      select salary, hire_date, last_name
      from employees 
      order by hire_date desc
)
where rownum <=10
order by hire_date desc;

SELECT e.first_name , e.last_name , e.phone_number , e.email , COUNT(*) subordonat, 
   count(e1.commission_pct) sub_cu_comision, 
   count(distinct e1.commission_pct) comisioane_distincte
  FROM employees e , departments d , employees e1
  WHERE e.employee_id =e1.manager_id
  AND e.department_id =d.department_id
  AND e.manager_id   IS NOT NULL
  AND d.location_id   =
    (SELECT d.location_id
      FROM employees e , departments d WHERE e.employee_id IS NOT NULL
    AND e.manager_id    IS NULL
    AND e.department_id  = d.department_id
    )
GROUP BY e.first_name , e.last_name , e.phone_number , e.email;



SELECT e.first_name , e.last_name , e.phone_number , e.email  , e1.last_name
  FROM employees e , departments d , employees e1
  WHERE e.employee_id =e1.manager_id
  AND e.department_id =d.department_id
  AND e.manager_id   IS NOT NULL
  AND d.location_id   =
    (SELECT d.location_id
      FROM employees e , departments d
      WHERE e.employee_id IS NOT NULL
    AND e.manager_id    IS NULL
    AND e.department_id  = d.department_id
    );
  






update employees 
set commission_pct  = 0.80
where employee_id = 100;
commit;





