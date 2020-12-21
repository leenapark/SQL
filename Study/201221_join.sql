/***************
******JOIN******
***************/
--기본 개념 equi join
select  first_name,
        department_name,
        em.department_id
from employees em, departments de
where em.department_id = de.department_id; -- <-- employees 의 department_id = departments 의 department_id 만 가져와라


--예제
--모든 직원이름, 부서이름, 업무명 출력
select  em.first_name,
        de.department_name,
        jo.job_title,
        em.job_id,
        jo.job_id,
        em.department_id,
        de.department_id
from employees em, departments de, jobs jo
where em.job_id = jo.job_id
and em.department_id = de.department_id;


--left join (null)도 포함할 수 있음 기준 데이터 설정
select  em.department_id,
        em.first_name,
        de.department_name
from employees em left outer join departments de
on em.department_id = de.department_id;


-- right join
select em.department_id,
        em.first_name,
        de.department_name
from employees em right outer join departments de
on em.department_id = de.department_id;


--데이터 기준으로 값 비교 right join --> left join (122개)
select em.department_id,
        em.first_name,
        de.department_name
from departments de left outer join employees em
on em.department_id = de.department_id;

--employees 가 기준일 때 (107개)
select em.department_id,
        em.first_name,
        de.department_name
from departments de right outer join employees em
on de.department_id = em.department_id;
--left(right) outer join 다른 표현 where - (+) - null이 속한 컬럼에 붙여준다 (기준 데이터 반대쪽에 붙여준다)
select em.department_id,
        em.first_name,
        de.department_name
from departments de, employees em
where de.department_id(+) = em.department_id;



--full outer join
select  em.department_id,
        em.first_name,
        de.department_id,
        de.department_name
from employees em full outer join departments de
on em.department_id = de.department_id;
--full은 모든 데이터를 기준으로 삼기 때문에 null이 전부 포함됨

select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id;
--별명을 생성할 경우 컬럼명이 아닌 별명으로 조건을 만들어야함 ex) 별명.조건명

select  emp.employee_id,
        emp.first_name,
        emp.manager_id,
        man.first_name as manager
from employees emp, employees man
where emp.manager_id = man.employee_id;

--잘못된 사용 예시
select *
from employees em, locations lo
where em.salary = lo.location_id;
--em.salary = lo.location_id 이 우연히 코드속 값이 같아 join 기능은 실행되었지만 사실상 아무 연관성이 없는 잘못된 사용임