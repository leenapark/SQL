--from절 where절 표현 방법 (+)<--오라클 용
--left/right/full outer join ~ on

/*
inner join --> 양쪽이 만족하는 경우  (null 제외)
    inner join ~ on

outer join --> 한쪽이 만족하는 경우  (기준이 되는 쪽은 포함 비교되는 쪽에 데이터가 없을 경우 null 로 표시)
    left outer join ~ on
    right outer join ~ on
    full outer join ~ on --> full은 양쪽 모두 기분이 되어 null 포함

*/

select  first_name,
        em.department_id,
        department_name,
        de.department_id
from employees em, departments de
where em.department_id = de.department_id;


/*
inner join --> 양쪽이 만족하는 경우  (null 제외)
    inner join ~ on
    */
select  first_name,
        em.department_id,
        department_name,
        de.department_id
from employees em inner join departments de
on em.department_id = de.department_id;

