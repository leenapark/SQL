/***************************
*subQuery 서브쿼리
***************************/

--where절 사용
-- ->11000 보다 급여가 많은 사람의 이름과 급여는?
select  first_name,
        salary
from employees
where salary > 11000;


--'Den' 보다 급여가 많은 사람의 이름과 급여는?
select  employee_id,
        first_name,
        salary
from employees
where first_name = 'Den';  --> 11000

select  first_name,
        salary
from employees
where salary > 11000;   --> 만약 딘의 월급이 달라지면 코드를 수정해줘야함

--2. 'Den' 보다 급여가 많은 사람의 이름과 급여는?
--하나의 코드로 해결
select  employee_id,
        first_name,
        salary
from employees
where salary > (select  salary
                 from employees
                 where first_name = 'Den'); --where절로 'Den'만 나오게 해줬음으로 비교는 조건인 salary vs salary로 함

--예제 문제
--급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
--1. 가장 적은 급여 액수는 얼마인가?
--2. 가장 적은 급여 액수를 받는 직원의 이름, 급여, 사원번호는?

--1. 가장 작은 급여 액수
select min(salary)
from employees;

--2. 가장 적은 급여 액수를 받는 직원의 이름, 급여, 사원번호는?
select  first_name "이름",
        salary "급여",
        employee_id "사원번호"
from employees
where salary = 2100;

--3. 질문 조합
select  first_name "이름",
        salary "급여",
        employee_id "사원번호"
from employees
where salary = (select min(salary)
                from employees);


--예제
--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
--1. 평균 급여 --> ?
--2. 평균 급여보다 적게 받는 사람의 이름, 급여

--1. 평균 급여
select avg(salary)
from employees;
-- 6461.83

--2. 평균 급여보다 적게 받는 사람의 이름, 급여
select  first_name "이름",
        salary "급여"
from employees
where salary < 6461.83;

--3. 문제 조합
select  first_name "이름",
        salary "급여"
from employees
where salary < (select avg(salary)
                from employees);


/***********
*in
***********/                

--예제
--부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요
--사번, 이름, 급여
--1. 부서 번호 110인 직원의 사번, 이름, 급여
--2. 전제 직원 중 급여가 12008 or 8300 인 직원


--1. 부서 번호 110인 직원의 사번, 이름, 급여
select  first_name "이름",
        salary "급여",
        department_id "사번"
from employees
where department_id = 110;

--2. 전제 직원 중 급여가 12008 or 8300 인 직원
select  department_id "사번",
        first_name "이름",
        salary "급여"
from employees
where salary = 12008
or salary = 8300;

select  department_id "사번",
        first_name "이름",
        salary "급여"
from employees
where salary in (12008, 8300);


--3. 조합
select  department_id "사번",
        first_name "이름",
        salary "급여"
from employees
where   salary in (select   salary "급여"
                    from employees
                    where department_id = 110);
                    
                    
--예제
--각 부서별로 최고급여를 받는 사원을 출력하세요
--1. 각 부서
--2. 각 부서별 최고 급여 --> ?

--1. 각 부서
select  department_id
from employees
GROUP BY department_id;

--2. 각 부서별 최고 급여 --> ?
select  max(salary)
from employees
GROUP BY department_id;

--3. 조합
select  first_name "이름",
        salary "급여",
        department_id "부서아이디"
from employees
where salary in (select  max(salary)
                 from employees
                 GROUP BY department_id);

                 
--예제 풀이
--각 부서별로 최고급여를 받는 사원을 출력하세요

--1. 부서별 최고 급여
select  --employee_id   누구인지는 알 수 없음 그룹을 지었기 때문
        department_id,
        max(salary)
from employees
group by department_id;

--2. 전체 사원 테이블에서 부서번호와 급여가 같은 사람 찾기 - 기준 : 각 부서 최고 급여
select  first_name,
        employee_id,
        salary,
        department_id
from employees
where department_id = 100
and salary = 12008;

--3. 부서아이디 & 급여 비교 대상이 2개일 때 (비교 대상) in (select문)
select  employee_id "사원 번호",
        first_name "이름",
        department_id "부서번호"
from employees
where (department_id, salary) in (select  department_id,
                                          max(salary)
                                  from employees
                                  group by department_id);
--in 을 사용하면 row의 개수는 상관없다


/***********
*ANY
***********/
--예제 문제
--부서번호가 110인 직원의 급여 보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
--1. 부서번호가 110인 직원의 급여
--2. 

--1. 부서번호가 110인 직원의 급여
select *
from employees
where department_id = 110;      --12008 & 8300

--1-1. 직원인 급여보다 큰 사람
select  employee_id,
        first_name,
        salary
from employees
where salary > 12008;

select  employee_id,
        first_name,
        salary
from employees
where salary > 8300;


select  employee_id,
        first_name,
        salary
from employees
where salary >any (select salary
                   from employees
                   where department_id = 110);  --12008 & 8300 둘 중 하나만 만족하는 모든 조건을 구해줌 : or 개념으로 접근
                   -- 조건식any 로 사용된다

/***************************
*All(and) - 모든 조건을 만족해야함
*************************/
select  employee_id,
        first_name,
        salary
from employees
where salary >all (select salary
                   from employees
                   where department_id = 110);
                   
                   
/************
*sub Query - table(가상)
************/
--sub Query 로 table 만들기 --> join으로 사용
--예제
--각 부서별로 최고 급여를 받는 사원을 출력하세요
--1. 각 부서별로 최고 급여 테이블(가상) 생성
--2. 직원 테이블과 (1)테이블(가상) 을 join 한다

--1. 각 부서별로 최고 급여 테이블(가상) 생성
select  department_id,
        max(salary)
from employees
group by department_id;

--2. 직원 테이블과 (1)테이블(가상) 을 join 한다
select  e.employee_id,
        e.first_name,
        e.salary,
        e.department_id,
        s.department_id,
        s."salary"
from employees e, (select  department_id,
                           max(salary) "salary"
                    from employees
                    group by department_id) s
where e.department_id = s.department_id
and e.salary = s."salary";