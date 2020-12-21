/***********************
******join 실습문제******
***********************/

/*
문제1.
직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을 조회하여
부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세요.
(106건)
*/
select  em.employee_id "사번",
        em.first_name "이름",
        em.last_name "성",
        de.department_name "부서명"
from employees em, departments de
where em.department_id = de.department_id
order by de.department_name desc, em.employee_id asc;


/*
문제2.
employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 현재업무(job_title)를
사번(employee_id) 오름차순 으로 정렬하세요.
부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
(106건)
*/
select  em.employee_id "사번",
        em.first_name "이름",
        em.salary "급여",
        de.department_name "부서명",
        jo.job_title "현재 업무"
from employees em, departments de, jobs jo
where em.job_id = jo.job_id
and em.department_id = de.department_id;

/*
문제2-1.
문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요
(107건)
*/
select department_id
from employees;

select  em.employee_id "사번",
        em.first_name "이름",
        em.salary "급여",
        de.department_name "부서명",
        jo.job_title "현재 업무"
from employees em, departments de, jobs jo
where em.department_id = de.department_id(+)
and em.job_id = jo.job_id;

/*
문제3.
도시별로 위치한 부서들을 파악하려고 합니다.
도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요 
부서가 없는 도시는 표시하지 않습니다.
(27건)
*/
select  lo.country_id "도시아이디",
        lo.city "도시명",
        de.department_name "부서명",
        de.department_id "부서아이디"
from departments de, locations lo
where de.location_id = lo.location_id
order by de.location_id desc;


/*
문제3-1.
문제3에서 부서가 없는 도시도 표시합니다. 
(43건)
*/
select  lo.country_id "도시아이디",
        lo.city "도시명",
        de.department_name "부서명",
        de.department_id "부서아이디"
from departments de, locations lo
where de.location_id(+) = lo.location_id;


/*
문제4.
지역(regions)에 속한 나라들을
지역이름(region_name), 나라이름(country_name)으로 출력하되
지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.
(25건)
*/
select  re.region_name "지역이름",
        co.country_name "나라이름"
from regions re, countries co
where re.region_id(+) = co.region_id
order by re.region_name desc, co.country_name asc;


/*
문제5. 
자신의 매니저보다 채용일(hire_date)이 빠른 사원의 
사번(employee_id), 이름(first_name)과
채용일(hire_date), 매니저이름(first_name),
매니저입사일(hire_date)을 조회하세요.
(37건)
*/
select *
from employees emt, employees men;