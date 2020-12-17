--사원의 이름(fisrt_name)과 전화번호 입사일 연봉을 출력하세요
select  first_name,
        phone_number,
        hire_date,
        salary
from employees;

/*
사원의 이름(first_name)과 성(last_name) 급여, 전화번호, 이메일, 입사일을 출력하세요
    →컬럼명이 많을때 표기팁
*/
select  first_name,
        last_name,
        salary,
        phone_number,
        email,
        hire_date
from employees;


--    사원의 이름(fisrt_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
select  first_name as "이름",
        phone_number as "전화번호",
        hire_date as "입사일",
        salary as "급여"
from employees;


--사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시되도록 출력하세요
select  first_name as "이름",
        last_name as "성",
        salary as "급여",
        phone_number as "전화번호",
        email as "이메일",
        hire_date as "입사일"
from employees;


/*
전체직원의 정보를 다음과 같이 출력하세요
성명(first_name last_name)
      성과 이름사이에 - 로 구분 ex) William-Gietz
      급여
      연봉(급여*12)
      연봉2(급여*12+5000)
      전화번호
*/
select  first_name||'-'||last_name "성명",
        salary "급여",
        salary*12 "연봉",
        salary*12+5000 "연봉2",
        phone_number "전화번호"
from employees;


--연봉이 15000 이상인 사원들의 이름과 연봉을 출력하세요
select  first_name "이름",
        salary
from employees
where salary >= 15000;


--07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select  first_name "이름",
        hire_date "입사일"
from employees
where hire_date >= '07/01/01';


--이름이 Lex인 직원의 연봉을 출력하세요
--문자, 날짜는 ‘ ‘ 로 감싸줌    ‘ ‘는 대소문자를 구분한다
select  first_name,
        salary*12
from employees
where first_name = 'Lex';


--연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요
select  first_name "이름",
        salary "급여"
from employees
where salary <= 14000
or salary >= 17000;


--입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
--and 연산자
select  first_name "이름",
        hire_date
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';


--연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오
select  first_name "이름",
        salary "급여"
from employees
where salary in (2100, 3100, 4100, 5100); --in 연산자 / 여러 조건을 한꺼번에 검사하는 연산자


--like 연산자
--이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
select  first_name "이름",
        salary "급여"
from employees
where first_name like '%am%';


--이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select  first_name "이름",
        salary
from employees
where first_name like '_a%';


--이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select  first_name "이름"
from employees
where first_name like '___a%';


--이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select  first_name "이름"
from employees
where first_name like '__a_';


--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select  first_name "이름",
        salary "급여",
        commission_pct "커미션비율"
from employees
where commission_pct is not null;


--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select  first_name "이름"
from employees
where manager_id is null
and commission_pct is null;


--order by
--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select  department_id "부서번호",
        salary "급여",
        first_name "이름"
from employees
order by department_id asc;


--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select  first_name "이름",
        salary "급여"
from employees
where salary >= 10000
order by salary desc;


--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 
--부서번호 급여 이름을 출력하세요  
select  department_id "부서번호",
        salary "급여",
        first_name "이름"
from employees
order by department_id asc, salary desc;