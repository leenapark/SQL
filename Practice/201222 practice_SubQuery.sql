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
select  *
from employees;