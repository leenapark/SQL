/*******************
******subQuery******
*******************/

/*
문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건)
*/
--1. 평균 급여 구하기
select avg(salary)
from employees;

select  count(*)
from employees
where salary < (select avg(salary)
                 from employees);
                 

/*
문제2. 
평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
직원번호(employee_id),
이름(first_name),
급여(salary),
평균급여,
최대급여를
급여의 오름차순으로 정렬하여 출력하세요 
(51건)
*/
--1. 평균 급여 & 최대 급여

select  avg(salary),
        max(salary)
from employees;

select  employee_id "직원번호",
        first_name "이름",
        salary "급여"
from employees e, (select   avg(salary) avg,
                            max(salary) max
                   from employees) s
where e.salary >= avg
and e.salary <= max
order by salary desc;


/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id),
거리명(street_address),
우편번호(postal_code),
도시명(city),
주(state_province),
나라아이디(country_id) 를 출력하세요
(1건)
*/
--1. Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳
select  *
from employees em
where em.first_name = 'Steven'
and em.last_name = 'King';

select  em.first_name,
        em.department_id,
        de.location_id
from employees em, departments de
where em.department_id = de.department_id
and em.first_name = 'Steven'
and em.last_name = 'King';

/*2. 도시아이디(location_id), 거리명(street_address), 우편번호(postal_code),
     도시명(city), 주(state_province), 나라아이디(country_id)*/
select  lo.location_id "도시아이디",
        lo.street_address "거리명",
        lo.postal_code "우편번호",
        lo.city "도시명",
        lo.state_province "주",
        lo.country_id "나라아이디"
from locations lo, departments de
where lo.location_id = de.location_id
and de.department_id =all (select  em.department_id
                           from employees em, departments de
                           where em.first_name = 'Steven'
                           and em.last_name = 'King');
                           
                           
/*
문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의
사번,
이름,
급여를
급여의 내림차순으로 출력하세요  -ANY연산자 사용
(74건)
*/

--1. job_id 가 'ST_MAN' 인 직원의 급여
select  job_id,
        salary
from employees
where job_id = 'ST_MAN';


select  employee_id "사번",
        first_name "이름",
        salary "급여"
from employees
where salary <any (select  salary
                   from employees
                   where job_id = 'ST_MAN')
order by salary asc;


/*
문제5. 
각 부서별로 최고의 급여를 받는 사원의
직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)
*/
--1. 각 부서별 최고 급여
select  department_id,
        max(salary)
from employees
GROUP BY department_id;

--조건절비교
select  em.employee_id,
        em.first_name,
        em.salary,
        em.department_id
from employees em
where (em.department_id, em.salary) in (select  department_id,
                                                max(salary)
                                        from employees
                                        GROUP BY department_id)
order by salary asc;

--테이블조인
select  em.employee_id,
        em.first_name,
        em.salary,
        em.department_id
from employees em, (select  department_id,  
                            max(salary) salary
                    from employees
                    GROUP BY department_id) se
where em.salary = se.salary
and em.department_id = se.department_id;


/*
문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
(19건)
*/
--업무별 연봉 총합
select  em.job_id,
        sum(em.salary)
from employees em
group by em.job_id;

select  jo.job_title,
        em.salary
from employees em, jobs jo
where (jo.job_id, em.salary) in (select  emp.job_id,
                                         sum(emp.salary)
                                from employees emp
                                group by emp.job_id);
                            
--table join
select  j.job_title,
        e.salary
from employees e, jobs j, (select  emp.job_id,
                                   sum(emp.salary) salary
                                from employees emp
                                group by emp.job_id) s
where e.job_id = j.job_id
and e.salary = s.salary;
                                

/*
문제7.
자신의 부서 평균 급여보다 연봉(salary)이
많은 직원의 직원번호(employee_id),
이름(first_name)과
급여(salary)을 조회하세요 
(38건)
*/
--부서 평균 급여
select  department_id,
        avg(salary) avg
from employees
group by department_id;

/*실패 재도전 해보기
select  em.employee_id,
        em.first_name "이름",
        em.salary "급여"
from employees em
where em.salary >any (select avg(mpl.salary)
                      from employees mpl
                      )
                      and em.department_id =any (select  e.department_id de
                      from employees e
                      group by e.department_id);
*/                   

select  em.employee_id,
        em.first_name "이름",
        em.salary "급여"
from employees em, (select  e.department_id,
                            avg(salary) avg
                            from employees e
                            group by department_id) s
where em.department_id = s.department_id
and em.salary > s.avg;


/*
문제8.
직원 입사일이 11번째에서 15번째의
직원의 사번,
이름,
급여,
입사일을
입사일 순서로 출력하세요
*/
select  rn,
        employee_id,
        first_name,
        salary,
        hire_date
        from(select rownum rn,  --조건문
                    employee_id,
                    first_name,
                    salary,
                    hire_date
                    from(select employee_id,
                                first_name,
                                salary,
                                hire_date
                         from employees
                         order by hire_date asc)    --가장 처음 조건을 생성 = 정렬 & 실행 내용
                         )
where rn >=11
and rn <=15;        --rownum 조건은 where절로 생성