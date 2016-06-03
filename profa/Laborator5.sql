select e.employee_id, e.last_name, j.job_title, d.department_name,
           jh.end_date - jh.start_date "perioada"
from 
   employees e join job_history jh on (e.employee_id = jh.employee_id)
   join jobs j on (j.job_id = jh.job_id)
   join departments d on (d.department_id = jh.department_id)
union 
select e.employee_id, e.last_name, j.job_title, d.department_name,
           null
from 
   employees e 
   join jobs j on (j.job_id = e.job_id)
   join departments d on (d.department_id = e.department_id)
order by 1,2; 

Exerciţiul 21. Să se afișeze codurile și numele șefilor de departament 
care au mai avut cel puțin un job anterior.

select d.manager_id, e.last_name, e.first_name
from departments d join employees e 
on d.manager_id = e.employee_id
minus 
select jh.employee_id, e.last_name, e.first_name
from job_history jh join employees e 
on jh.employee_id = e.employee_id;



select d.department_name, e.last_name
from departments d right outer join employees e on
d.department_id = e.department_id;

select d.department_name, e.last_name
from departments d, employees e 
where d.department_id(+) = e.department_id;

Exerciţiul 11: Să se afişeze numele salariaţilor și orașele în care lucrează. 
Se vor afişa şi salariaţii
pentru care nu este cunoscut departamentul.

select d.department_name, e.last_name
from departments d right outer join employees e on
d.department_id = e.department_id
left join locations l on l.location_id = d.location_id;

select e.last_name, 
          decode(j.job_title, null, ja.job_title, j.job_title) , 
          decode(j.job_id, null, ja.min_salary, j.min_salary)
from employees e left join job_history jh
on e.employee_id = jh.employee_id
left join jobs j on jh.job_id = j.job_id
join jobs ja on e.job_id = ja.job_id;



Exerciţiul 1: Să se determine codul angajaţilor, codul job-urilor 
si numele celor al căror salariu este
mai mare decât 3000 sau este egal cu media dintre salariul minim 
si cel maxim pentru job-ul
respectiv.

select employee_id, job_id, last_name
from employees e
where salary > 3000
or salary = (select (min_salary + max_salary)/2 from jobs where job_id = e.job_id);

select e.employee_id, j.job_id, e.last_name
from employees e, jobs j
where  j.job_id = e.job_id
            and (e.salary > 3000
            or e.salary = (j.min_salary + j.max_salary)/2);
            
            
Exerciţiul 2: Să se afiseze numele, numele departamentul, salariul si 
job-ul tuturor angajaţilor al căror salariu si comision coincid cu 
salariul si comisionul unui angajat din Oxford.
 select e.last_name, d.department_name, e.salary, j.job_title 
 from employees e join jobs j on  (e.job_id = j.job_id) 
 join departments d on (e.department_id = d.department_id)
where (salary, commission_pct)       in ( /*sal si com din Oxford*/      
                                                                    select salary, commission_pct
                                                                    from employees
                                                                    where department_id in 
                                                                         (select department_id 
                                                                         from departments
                                                                         where location_id in 
                                                                             (select location_id
                                                                             from locations where city = 'Oxford')
                                                                         )
                                                                );
                                                                
Exerciţiul 4: Folosind subcereri, să se afiseze numele si salariul angajaţilor 
condusi direct de presedintele companiei (acesta este considerat angajatul 
care nu are manager).

select e.last_name, e.salary
from employees e
where e.manager_id = (select employee_id from employees where manager_id is null );
                                                                
Exerciţiul 6: Să se afiseze numele si salariul angajaţilor al căror salariu este maxim.
Folosiţi >=ALL

select last_name, salary from employees 
where salary = (select max(salary) from employees);  

select last_name, salary from employees 
where salary >=ALL (select salary from employees);     


Exerciţiul 10: Să se obţină numele salariaţilor având cea mai mare vechime 
din departamentul în care lucrează.

select e.last_name, e.department_id, e.hire_date from employees e
where e.hire_date = (select min(hire_date) from employees 
                                   where department_id = e.department_id);
                                   
                                   
 SELECT e.employee_id, e.last_name, e.first_name
  FROM employees e
  WHERE  e.department_id in (select jh.department_id  
                                                 from job_history jh
                                                  where e.job_id    != jh.job_id
                                                  AND e.employee_id   =jh.employee_id)
  OR  e.job_id in (select jh.job_id  
                              from job_history jh
                              where e.department_id    != jh.department_id
                              AND e.employee_id   =jh.employee_id);
                              
                              
Exerciţiul 14: Să se obţină salariaţii care nu au subordonaţi (care nu sunt manageri). (Utilizaţi NOT
IN)
select last_name, first_name from employees
where employee_id not in
            (select manager_id from employees where manager_id is not null);

                              
                                   