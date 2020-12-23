/**********************
******SQL 실습문제******
**********************/


/*
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)
*/
select  first_name "이름",
        manager_id "매니저아이디",
        commission_pct "커미션 비율",
        salary "월급"
from employees
where salary > 3000
and commission_pct is null
and manager_id is not null;


/*
문제2. 
각 부서별로 최고의 급여를 받는 사원의
직원번호(employee_id),
이름(first_name),
급여(salary),
입사일(hire_date),
전화번호(phone_number),
부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/
select  employee_id "직원번호",
        first_name "이름",
        salary "급여",
        to_char(hire_date, 'YYYY-MM-DD DAY') "입사일",
        replace(phone_number, '.', '-') "전화번호",
        department_id "부서번호"
from employees
where (department_id, salary) in (select    department_id,
                                            max(salary) sal
                                  from employees
                                  group by department_id)
order by salary asc;


/*
문제3
매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
(9건)
*/
--1. 조건 1-1. 매니저별 1-2. 2005년 이후 입사자 1-3. 매니저별 평균 급여 5000이상 1-4. 평균 급여 내림차순 1-5. 소수점 첫째자리에서 반올림
select  manager_id "매니저아이디",
        round(avg(salary), 0) sal,
        min(salary) "최소급여",
        max(salary) "최대급여"
from employees
where hire_date >= '2005/01/01'
group by manager_id
having round(avg(salary), 0) >= 5000
order by sal asc;



select  se."매니저아이디",
        e.first_name "매니저이름",
        se.sal "평균급여",
        se."최소급여",
        se."최대급여"
from employees e,  (select  manager_id "매니저아이디",
                            round(avg(salary), 0) sal,
                            min(salary) "최소급여",
                            max(salary) "최대급여"
                    from employees
                    where hire_date >= '2005/01/01'
                    group by manager_id
                    having round(avg(salary), 0) >= 5000
                    order by sal asc) se
where e.employee_id = se."매니저아이디";


/*
문제4.
각 사원(employee)에 대해서
사번(employee_id),
이름(first_name),
부서명(department_name),
매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/
select  em.employee_id "사번",
        man.first_name "이름",
        de.department_name "부서명",
        em.first_name "매니저"        
from employees man left outer join departments de
on man.department_id = de.department_id
inner join employees em
on man.manager_id = em.employee_id
order by de.department_name asc;


/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/