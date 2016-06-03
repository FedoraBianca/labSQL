Exerciţiul 9: Să se obţina codul, titlul şi salariul mediu al job-ului
pentru care salariul mediu este minim.

select * from 
  (select e.job_id, j.job_title, avg(salary)
  from employees e join jobs j on (e.job_id = j.job_id)
  group by e.job_id, j.job_title
  order by  avg(salary)
  )
where rownum <=1  ;

select min(medie) from
  (
    select avg(salary) medie
    from employees e join jobs j on (e.job_id = j.job_id)
    group by e.job_id, j.job_title  
    order by  avg(salary)
  );
  
select e.job_id, j.job_title, avg(salary)
  from employees e join jobs j on (e.job_id = j.job_id)
  group by e.job_id, j.job_title
  having  avg(salary)  = ( select min(avg(salary)) medie
                                                    from employees e join jobs j on (e.job_id = j.job_id)
                                                    group by e.job_id, j.job_title  
                                          )  ;
  Exercițiul 11: Să se afișeze codul si numele angajatului, 
  numele departamentului și suma salariilor pe departamente.;

select e.last_name, e.employee_id, dep.suma_sal
from  employees e join 
                   (select    d.department_id, d.department_name, sum(salary) suma_sal
                    from employees e join departments d on (e.department_id = d.department_id)              
                    group by d.department_id, d.department_name
                  ) dep on ( dep.department_id =  e.department_id);

*** Pentru fiecare angajat sa se afiseze data de inceput a ultimului job avut anterior.
last_name, start_date
last_name, job_title, start_date



  
  