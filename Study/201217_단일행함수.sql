/* 단일행 함수 */

--문자함수 – INITCAP(컬럼명)
select  email,
        INITCAP('email'),
        department_id
from employees
where department_id = 100;

--문자함수 – LOWER(컬럼명)=소문자로 변경 / UPPER(컬럼명)=대문자로 변경
select  first_name,
        lower(first_name),
        upper(first_name)
from employees
where department_id = 100;

--문자함수 – SUBSTR(컬럼명, 시작위치, 글자수)
select  first_name,
        substr(first_name, 3),
        substr(first_name, 2, 6),
        SUBSTR(first_name, -3, 3)
from employees
where department_id = 100;

--문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’) /  RPAD(컬럼명, 자리수, ‘채울문자’)
         -- Left                             Right
select  first_name,
        lpad(first_name, 10, '*'),
        rpad(first_name, 10, '*')       
from employees;

--문자함수 – REPLACE (컬럼명, 문자1, 문자2)
select  first_name,
        replace(first_name, 'a', '*')
        department_id
from employees
where department_id = 100;

--예제 문제(여러 함수가 조합된 예제)
select  first_name,
        replace(first_name, 'a', '*'),
        substr(first_name, 2, 3)
from employees
where department_id = 100;

--위 예제 코드를 조합하여 일부분을 미표기함으로 정보를 보안함
select  first_name,
        replace(first_name, 'a', '*'),
        substr(first_name, 2, 3),
        replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id = 100;
 --substr 함수에서 (컬럼, 시작점, 글자수)임으로 2번째부터 3글자를 변경해주면 남은 글자까지 표기가 됨


--숫자함수 – ROUND(숫자, 출력을 원하는 자리수) 
select  round(123.456, 2) "r02",
        round(123.456, 0) "r01",
        round(123.456, -1) "r-1"
from dual; --dual은 가상 테이블
--뒤 소수점 자리를 표기하나 반올림이 된다


--예제 salay를 3번째 자리까지 변형하기
select  salary,
        round(salary, -3)   "sR2"
from EMPLOYEES;


--숫자함수 – TRUNC(숫자, 출력을 원하는 자리수) 
select  TRUNC(123.456, 2) as "r2",
        TRUNC(123.456, 0) as "r0",
        TRUNC(123.456, -1) as "r-1"
from dual;



--단일함수>날짜함수 – MONTH_BETWEEN(d1, d2)
select  sysdate
from    dual;

select  sysdate,
        first_name
from employees;


--단일함수>날짜함수 – MONTHS_BETWEEN(d1, d2)
--d1 날짜와 d2 날짜의 개월수를 계산해주는 함수
select  sysdate,
        hire_date,
        months_between(sysdate, hire_date) as "workmonth"
from employees
where department_id = 100;

--결과값의 소수점을 버리고 싶음
--trunc + months_between 사용
select  sysdate,
        hire_date,
        months_between(sysdate, hire_date) as "workmonth",
        trunc(months_between(sysdate, hire_date), 0) as "근무개월수"
from employees
where department_id = 100;

--날짜 함수 -LAST_DAY(d1)
--입력한 날짜 달의 마지막 날을 알려줌
select  last_day('19/02/16'),
        last_day(sysdate)
from dual;


--변환 함수
--TO_CHAR(숫자, ‘출력모양’)  숫자형문자형으로 변환하기
select  first_name,
        salary,
        salary*12,
        to_char(salary*1200, '$999,999,999.00'),
        to_char(salary*12, '999,999,999.00'),
        to_char(salary*12, '999,999,999'),
        to_char(salary*12, '099,999'),
        to_char(salary*12, '999999')        
from employees
where department_id = 100;


--단일함수>변환함수>TO_CHAR(날짜, ‘출력모양’)  날짜문자형으로 변환하기
select  sysdate,
        to_char(sysdate, 'yyyy') "yyyy",
        to_char(sysdate, 'yy') "yy",
        to_char(sysdate, 'mm') "mm",
        to_char(sysdate, 'month') "month",
        to_char(sysdate, 'dd') dd,
        to_char(sysdate, 'day') day,
        to_char(sysdate, 'hh') HH,
        to_char(sysdate, 'hh24') hh24,
        to_char(sysdate, 'mi') mi,
        to_char(sysdate, 'ss') ss
from dual;

--년월시분초
select  sysdate,
        to_char(sysdate, 'yy-mm-dd  hh24:mi:ss'),
        to_char(sysdate, 'yy"년"-mm"월"-dd"일"')
from dual;
--"문자"를 사이에 넣을 수 있음


--데이터에 저장되어 있는 시간을 불러오기
--hire_date 출력해보기
select  first_name,
        hire_date,
        to_char(hire_date, 'yy-mm-dd  hh24:mi:ss')
from employees;

--일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
select  first_name,
        commission_pct,
        NVL(commission_pct,0),
        NVL2( commission_pct, 100, 0)
from employees;
