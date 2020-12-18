/***************
*그룹함수
****************/

select  avg(salary),
        first_name
from employees;
--first_name의 갯수와 avg 갯수가 같지 않음으로 오류남


--그룹함수 avg()
select avg(salary)
from employees;


--그룹함수 count()
select  count(*)
from employees;
--데이터 갯수를 새는 거라 숫자가 아닌 컬럼의 수도 샐 수 있음

select  count(commission_pct)
from employees;
--null은 제외 - count 되지 않음

--조건 붙여보기
select  count(*)
from employees
where salary > 16000;


--그룹함수 sum()
select sum(salary)
from employees;
--숫자로 저장되어 있는 데이터 지정

select sum(salary), count(*)
from employees;

--그룹함수 -avg() null 인 값이 있을 때
--null을 제외하고 계산되는 함수
select  count(*),
        sum(salary),
        avg(salary)
from employees;

--null을 포함하되 null을 숫자로 변경하여 계산되는 함수
select  count(*),
        sum(salary),
        avg(NVL(salary, 0))
from employees;


--그룹함수 - max() / min()
select  max(salary)
from employees;

select  min(salary)
from employees;

--정렬이 필요한 경우 많은 연산을 수행해야한다
select  max(salary),
        min(salary),
        count(*)
from employees;

/*
group by 절
*/

select  department_id,
        avg(salary)         --오류
from employees
order by department_id asc;

--group 짓기
select  department_id,
        avg(salary)
from employees
group by department_id;

--정렬하기
select  department_id,
        avg(salary)
from employees
group by department_id
order by department_id asc;


--group by 절 세분화
--자주 오류나는 예
select  department_id,
        count(*),
        sum(salary)
from employees
group by department_id;

select  department_id,
        count(*),
        sum(salary),
        job_id      --오류
from employees
group by department_id;

select  department_id,
        count(*),
        sum(salary),
        job_id
from employees
group by department_id, job_id;

select  department_id,
        job_id,
        count(*),
        sum(salary),
        avg(salary)
from employees
group by department_id, job_id
order by department_id;


--예제 문제 풀이
--연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요
select  department_id,
        count(department_id),
        sum(salary)
from employees
group by department_id
where sum(salary) >= 20000      --그룹 함수는 where 절 적용 불가
order by department_id asc;

--그룹 함수에서 사용하는 where 절 - having 절
select  department_id,
        count(department_id),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
order by department_id asc;

--having - and 사용 가능
select  department_id,
        count(department_id),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and department_id = 100
order by department_id asc;


/******
*case ~ end
case    when 조건식  then 실행 내용
        else 그 외 실행내용
******/

select  employee_id,
        salary,
        job_id,
        case when job_id = 'AC_ACCOUNT' then salary * 0.1
             when job_id = 'SA_REP' then salary * 0.2
             when job_id = 'ST_CLERK' then salary * 0.3
             else salary * 0
        end bonus
from employees;

/******
*decode 문
*decode( 컬럼명, 조건 컬럼명, 실행내용 )
*주의 - 모든 조건이 같아야 사용가능 (=java switch 문이랑 비슷)
******/
select  employee_id,
        salary,
        job_id,
        decode( job_id, 'AC_ACCOUNT', salary * 0.1,
                        'SA_REP',   salary * 0.2,
                        'ST_CLERK', salary * 0.3,
                salary*0 ) bonus
from employees;

/*
예제 문제
직원의 이름, 부서, 팀을 출력하세요
팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’
60~100이면 ‘B-TEAM’
110~150이면 ‘C-TEAM’
나머지는 ‘팀없음’ 으로 출력하세요.
*/
select  first_name "이름",
        department_id "부서",
        case    when department_id >= 10 and department_id <= 50 then 'A-TEAM'
                when department_id >= 60 and department_id <= 100 then 'B-TEAM'
                when department_id >= 110 and department_id <= 150 then 'C-TEAM'
                else '팀없음'
        end "팀"
from employees
order by department_id asc;
--case - end 문은 조건식을 대입할 수 있어서 범위를 줄 수 있음 실행 내용 뒤에 , 쉼표는 붙이지 않는다


select  first_name "이름",
        department_id "부서",
        decode( department_id, 10, 'A-TEAM', 20, 'A-TEAM', 30, 'A-TEAM', 40, 'A-TEAM', 50, 'A-TEAM',
                               60, 'B-TEAM', 70, 'B-TEAM', 80, 'B-TEAM', 90, 'B-TEAM', 100, 'B-TEAM',
                               110, 'C-TEAM', 120, 'C-TEAM', 130, 'C-TEAM', 140, 'C-TEAM', 150, 'C-TEAM',
                '팀없음'
        ) "팀"
from employees
order by department_id asc;
--decode()문은 조건식 대입이 불가 전부 적어줘야 함