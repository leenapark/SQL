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
(rownum(order by))
*/
select  ro.rnum,
        ro.employee_id "사번",
        ro.first_name "이름",
        ro.department_name "부서명",
        ro.salary "급여",
        ro.hire_date "입사일"
from (select  rownum rnum,
        sor.employee_id,
        sor.first_name,
        sor.department_name,
        sor.salary,
        sor.hire_date
      from (select  e.employee_id,
                    e.first_name,
                    d.department_name,
                    e.salary,
                    e.hire_date
            from employees e, departments d
            where e.hire_date > '04/12/31'
            and e.department_id = d.department_id
            order by e.hire_date
            ) sor
      ) ro
where ro.rnum >= 11
and ro.rnum <=20;


/*
문제6.
가장 늦게 입사한 직원의
이름(first_name last_name)과
연봉(salary)과
근무하는 부서 이름(department_name)은?
*/
select  em.first_name||' '||em.last_name,
        em.salary,
        de.department_name,
        em.hire_date
from employees em, departments de
where em.department_id = de.department_id
and em.hire_date = (select  max(hire_date)
                    from employees);
                    

/*
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의
직원번호(employee_id),
이름(firt_name),
성(last_name)과
업무(job_title),
연봉(salary)을 조회하시오.
*/
--가장 높은 평균 연봉
select  max(avg(salary)) sal
from employees
group by department_id
order by sal desc;

--평균 연봉 & 부서
select  department_id,
        avg(salary)
from employees
group by department_id;

select  e.employee_id "직원번호",
        e.first_name "이름",
        e.last_name "성",
        j.job_title "업무",
        e.salary "급여",
        se.msal "평균급여"
from employees e, jobs j, (select  department_id de,
                                   avg(salary) sal
                           from employees
                           group by employee_id, department_id
                           order by sal desc) s,  (select  max(avg(salary)) msal
                                                   from employees
                                                   group by department_id
                                                   order by msal desc) se
where e.job_id = j.job_id
and s.sal > se.msal
and e.department_id = s.de;


/*
문제8.
평균 급여(salary)가 가장 높은 부서는? 
*/
--부서별 평균 급여
select  avg(salary)
from employees
group by department_id;

--가장 높은 평균 급여
select  max(avg(salary))
from employees
group by department_id;

select  d.department_name
from employees e, departments d,(select  max(avg(salary)) sal
                                 from employees
                                 group by department_id) s
where e.department_id = d.department_id
and e.salary > s.sal;
 

/*
문제9.
평균 급여(salary)가 가장 높은 지역은? 
*/
select  r.region_name,
        avg(e.salary) sal
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
group by r.region_name
order by sal desc;

select  ro.region_name
from   (select  rownum rnum,
                o.region_name
        from   (select  r.region_name,
                        avg(e.salary) sal
                from employees e, departments d, locations l, countries c, regions r
                where e.department_id = d.department_id
                and d.location_id = l.location_id
                and l.country_id = c.country_id
                and c.region_id = r.region_id
                group by r.region_name
                order by sal desc
                ) o
        ) ro
where ro.rnum = 1;


/*
문제10.
평균 급여(salary)가 가장 높은 업무는? 
*/
select  j.job_title,
        avg(salary) sal
from employees e, jobs j
where e.job_id = j.job_id
group by j.job_title
order by sal desc;


select  ro.job_title
from (select  rownum rnum,
              job_title
      from (select  j.job_title,
                    avg(salary) sal
            from employees e, jobs j
            where e.job_id = j.job_id
            group by j.job_title
            order by sal desc
            ) o
      ) ro
where ro.rnum = 1;      