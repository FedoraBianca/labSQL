Exemplul 13: Să se obţină codurile si numele departamentelor în 
care nu lucrează nimeni.

select department_id, department_name
from departments 
where department_id not in (select department_id from employees 
                                                 where department_id is not null)
***
Sa se afiseze angajatii care au subordonati care castiga 
un comision mai mare decat ei.;
select e.last_name, nvl(e.commission_pct, 0)
from employees e
where nvl(e.commission_pct, 0) <ANY (  select  nvl(commission_pct,0)
                                                                 from employees 
                                                                 where manager_id = e.employee_id
                                                                 );

*** 
Sa se afiseze numele angajatilor care au salariul cel mai apropiat 
de media grilei de salarizare pentru jobul lor.

select last_name
from employees e join jobs j on (e.job_id = j.job_id)
where abs(e.salary - (j.max_salary + j.min_salary)/2) =
                                        (select  min(abs(ee.salary - (jj.max_salary + jj.min_salary)/2))
                                         from employees ee join jobs jj on (ee.job_id = jj.job_id)
                                         where jj.job_id =  e.job_id );

***
Pentru fiecare angajat care a mai avut un job sa se afiseze primul 
oras in care a lucrat.

***
Sa se afiseze lista tutoror oraselor si a managerilor care conduc departamente
din aceste orase.  (coloane oras, manager_departament sortare dupa oras)
Pentru orasele in care nu exista departamente, va aparea o singura linie cu 
null pentru manager.


select l.city, e.last_name
from locations l, departments d, employees e
where l.location_id = d.location_id(+) and d.manager_id = e.employee_id(+)
order by 1;

select l.city, decode(d.department_id, null,  'fara departamente',  e.last_name)
from locations l left join departments d on (l.location_id = d.location_id)
                           left join employees e on (d.manager_id = e.employee_id)
order by 1;




