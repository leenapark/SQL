--단일 주석
/*
주석
*/
select * from employees;

select *
from departments;

--원하는 컬럼 조회하기
select employee_id, first_name, last_name from employees;

select employee_id,
        first_name,
        last_name
from employees;

--사원의 이름(first_name)과 전화번호 입사일 연봉을 출력하세요
select  first_name,
        phone_number,
        hire_date,
        salary
from employees;

--사원의 이름(first_name)과 성(last_name), 급여, 전화번호, 이메일, 입사일을 출력하세요
select  first_name,
        last_name,
        salary,
        phone_number,
        email,
        hire_date
from employees;
--적은 순서대로 출력이 됨
--명령어대로 출력이 되어서 중복 출력도 가능함 *주의*

/*출력할 때 컬럼에 별명 지어주고 사용하기*/
select  employee_id as empNo,
        first_name "f name", --as 생략하는 법 띄어쓰기 후 별명 사용 // 공백/특수기호/대소문자 사용 시 "별명" 사용
        salary 연봉 --한글 사용도 가능하지만 권장하지 않음 사용 시 "" 쓰는 게 좋음
from employees;

--사원의 이름(fisrt_name)과 전화번호 입사일 급여 로 표시되도록 출력
select  first_name "이름",
        phone_number "전화번호",
        hire_date "입사일",
        salary "급여"
from employees;


--사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시되도록 출력
select  employee_id as "사원번호",
        first_name as "이름",
        last_name as "성",
        salary as "급여",
        phone_number as "전화번호",
        email as "이메일",
        hire_date as "입사일"
from employees;

/*연결 연산자(concatenation)로 컬럼들 붙이기*/
select first_name || last_name
from employees;

/* 표기법 : 데이타||''||데이타 *데이타 사이에 뭔가를 넣어줄 때* */
select first_name ||' '|| last_name name
from employees;

select first_name|| ' hire data is '|| last_name
from employees;

select first_name|| ' '' hire data is '' '|| last_name  --'' 표를 넣고 싶을 땐 ''''두개 사용
from employees;

/*산술 연산자 사용하기*/
select first_name, salary
from employees;

select  first_name,
        salary,
        salary*12 "연봉"
from employees;

select  first_name,
        salary,
        salary*12,
        (salary+300)*12
from employees;

/* 다음 코드 오류 분석 */
select  job_id*12 --job_id 는 문자열 12 곱하기가 되지 않음
from employees;

/*전체 직원 정보 출력*/
select  first_name||'-'||last_name "성명",
        salary "급여",
        salary*12 "연봉",
        phone_number "전화번호"
from employees;

select *
from employees; --데이터는 원본이 아니라 가상임을 인지

/* select 문 > where 절 */
select first_name
from employees
where department_id = 10;

/*연봉이 15000 이상인 사원들의 이름과 연봉을 출력하세요*/
select  first_name "이름",
        salary "급여",
        salary*12 "연봉"
from employees
where salary >= 15000;

--07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select  first_name "이름",
        hire_date "입사일"
from employees
where hire_date > '07/01/01';

--이름이 Lex인 직원의 연봉을 출력하세요
select salary*12 "연봉"
from employees
where first_name = 'Lex';

/*2개 이상인 조건을 만족하는 값 출력하기 (and 연산자)*/
select  first_name,
        salary
from employees
where salary >= 14000
and salary <= 17000;

/*연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력 - 두 조건 중 하나만 만족해도 출력가능 (or 연산자)*/
select  first_name,
        salary
from employees
where salary <= 14000
or salary >= 17000;

/*입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력*/
select  first_name "이름",
        hire_date "입사일"
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

/*연봉이 14000 이상 17000 이하인
사원의 이름과 연봉을 구하시오
BETWEEN and*/
select  first_name,
        salary
from employees
where salary BETWEEN 14000 and 17000;   --작은 것 and 큰 것 의 형태로 비교할 수 있다


--in
select first_name, last_name, salary
from employees
where first_name in ('Neena', 'Lex', 'John');

select first_name, last_name, salary
from employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John';


--연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오
select  first_name "이름",
        salary*12 "연봉"
from employees
where salary in (2100, 3100, 4100, 5100);


--like 연산자
select  first_name,
        last_name,
        salary
from employees
where first_name like 'L%';


/*% 표현식*/
select  first_name,
        last_name,
        salary
from employees
where first_name like '%a';

select  first_name,
        last_name,
        salary
from employees
where first_name like '%a%';

select  first_name,
        last_name,
        salary
from employees
where first_name like 'A%';
/*%__ - %가 앞에 붙으면 맨끝자리 값을 %다음 조건을 충족하는 값을 찾음
  %__% - %사이에 있는 값을 충족하는 값을 찾음%
  __% - %가 끝으로 가면 그 앞에 조건을 충족하는 값을 찾음
  % 표현식은 글자 수 제한이 없음
*/

/*_ 언더바 표현식*/

select  first_name,
        last_name,
        salary
from employees
where first_name like '_a___';


select  first_name,
        last_name,
        salary
from employees
where first_name like '___a%';
/* _ 언더바 표현식은 글자수를 제한한다 */


--이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
select  first_name "이름",
        salary "연봉"
from employees
where first_name like '%am%';

--이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select  first_name "이름",
        salary "연봉"
from employees
where first_name like '_a%';

--이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select  first_name "이름"
from employees
where first_name like '___a%';

--이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name "이름"
from employees
where first_name like '__a_';

--null
--직원 테이블 에서 급여가 13000 <= salary <= 15000 인
--직원의 이름 급여 커미션 급여*커미션 출력
select  first_name,
        salary,
        commission_pct,
        salary*commission_pct
from employees
where salary BETWEEN 13000 and 15000;

--null 을 가지고 있는 값만 출력 - 조건 null 일 것
select *
from employees
where commission_pct is null;

--null 값을 가진 값은 제외
select *
from employees
where commission_pct is not null;


--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select  first_name "이름",
        salary "급여",
        commission_pct "커미션 비율"
from employees
WHERE commission_pct is not null;


--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select  first_name "이름"
from employees
where commission_pct is null
and manager_id is null;

select email, employee_id
from employees
where employee_id = 110;

/*
select 문
    select 절
    from 절
    where 절
    order by 절 --> 정렬
*/

--order by 절
select *
from employees
order by employee_id desc;

select  first_name,
        salary
from employees
order by salary desc;   --> 내림차순

select  first_name,
        salary
from employees
where salary >= 9000
order by salary asc;    --> 오름차순


--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select  department_id "부서번호",
        salary "급여",
        first_name "이름"
from employees
ORDER BY department_id asc;


--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요(오름차순)
select  first_name "이름",
        salary "급여"
from employees
where salary >= 10000
order by salary desc;


--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요  
select  department_id "부서번호",
        salary "급여",
        first_name "이름"
from employees
order by department_id asc, salary desc;