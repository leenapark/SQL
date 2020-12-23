/*****************
******rownum******
*****************/

--급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
select  rownum,
        employee_id,
        first_name,
        salary
from employees emp
order by salary desc;

/*실행순서
from - 가상 row 생성 - rownum 부여 - where - select - order by
rownum이 먼저 실행되고 order by(정렬)이 더 늦게 작동해서 정렬과 rownum을 같이 사용하면 정렬이 뒤섞임
*/

--정렬하고 rownum 사용
select  rownum,
        employee_id,
        first_name,
        salary
from employees;  --이 테이블을 먼저 정렬해줘서 정렬된 테이블을 가져온다


select  rownum,
        o.employee_id,
        o.first_name,
        o.salary
from (select  employee_id,
              first_name,
              salary
      from employees
      order by salary desc) o ;  -- 가상 테이블에 별명을 붙여준다
      --가상 테이블 안에 실행내용은 보여줘야 하는 컬럼을 전부 적어준다
    

select  rownum,
        ord.employee_id,
        ord.first_name,
        ord.salary
from (select  emp.employee_id,
              emp.first_name,
              emp.salary
      from employees emp
      order by salary desc) ord 
where rownum >= 1
and rownum <=5;


--시작 부분이 1이 아닐 경우 결과값이 없음
select  rownum,
        ord.employee_id,
        ord.first_name,
        ord.salary
from (select  emp.employee_id,
              emp.first_name,
              emp.salary
      from employees emp
      order by salary desc) ord 
where rownum >= 2
and rownum <=5;
--1번이 부여된 rownum 이 조건 미달성으로 삭제 되고 다음 row에 다시 1이 부여가 됨 계속 조건을 만족하지 못해 삭제가 되어 결과값이 없어짐

-- 일련 번호 부여(order by) 후 바로 조건을 부여함(rownum)
select  *
from (rownum(order by));


select  ro.rnum,
        ro.employee_id,
        ro.first_name,
        ro.salary
from (select  rownum rnum,      --별명을 반드시 붙여줘야함
        o.employee_id,
        o.first_name,
        o.salary
      from (select  emp.employee_id,        --order by
                    emp.first_name,
                    emp.salary
            from employees emp
            order by salary desc) o
        ) ro                --rownum
where rnum >=11
and rnum <=20;


--07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? /문제에서 요구하는 정렬이 뭔지 파악한다
--1. 급여가 많은 직원 정렬 (order by)
--2. 07년에 입사한 직원

--1. 급여가 많은 직원 정렬
select  e.first_name,
        e.salary,
        e.hire_date
from employees e
order by salary desc;
--우선 정렬을 가장 먼저 해준다 (order by)

--2. 07년에 입사한 직원 (rownum)
select  rownum rnum,
        em.first_name,
        em.salary,
        em.hire_date
from (select  e.first_name,
              e.salary,
              e.hire_date
      from employees e
      order by salary desc) em
where em.hire_date >= '07/01/01'
and em.hire_date <= '07/12/31';
--두번째 조건인 07년도 입사한 직원과 번호를 부여한다

--3. 3-7 직원의 이름, 급여, 입사일
select  emp.rnum,
        emp.first_name,
        emp.salary,
        emp.hire_date
from (select  rownum rnum,
              em.first_name,
              em.salary,
              em.hire_date
      from (select  e.first_name,
                    e.salary,
                    e.hire_date
            from employees e
            order by salary desc) em
            where em.hire_date >= '07/01/01'
            and em.hire_date <= '07/12/31') emp
where emp.rnum >= 3
and emp.rnum <= 7;


--강사님과 풀이
select  ro.rnum,
        ro.employee_id,
        ro.first_name,
        ro.salary,
        ro.hire_date
from(select  rownum rnum,
             o.employee_id,
             o.first_name,
             o.salary,
             o.hire_date
     from (select  employee_id,
                   first_name,
                   salary,
                   hire_date
           from employees
           where hire_date >= '07/01/01'
           and hire_date <= '07/12/31'
           order by salary desc
           ) o
      ) ro
where ro.rnum >= 3
and ro.rnum <=7;
