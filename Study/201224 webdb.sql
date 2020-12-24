--테이블 만드는 명령어
--컬럼명 자료형으로 적어준다
create table book(
    book_id number(5),
    title varchar2(50),
    author varchar2(10),
    pub_date date
);

alter table book add (pubs varchar2(50));

select *
from book;

--자료형 수정
alter table book modify (title varchar2(100));
--컬럼명 수정
alter table book rename column title to subject;
--테이블 삭제
alter table book drop (author);
--테이블명 변경
rename areicle to article;
--테이블 삭제
drop table article;