create table author (
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
    );
    
insert into author
values (1, '박경리', '토지 작가');
/*
insert into author
values(2, '이문열');
value(모든 값을 넣어줘야 함 null로 만들고 싶으면 '' 넣어줘서라도 표시해야함)
*/
insert into author
values(2, '이문열', '');

--명시적 방법
insert into author (author_id, author_name)
values(3, '박경리');

--명시적 방법 오류상황
insert into author (author_id, author_desc)
values(3, '나혼자 산다 출연');
--not null 이란 설정을 처음에 줬기 때문에 해당 값이 없으면 오류남

update author
set author_name = '싱숑',
    author_desc = '전지적 독자 시점'
where author_id = 1;

update author
set author_name = '싱숑'
where author_id = 1;

delete from author
where author_id = 2;

delete from author;

insert into author(author_id, author_name, author_desc)
values(1, '이문열', '경북 양양');

insert into author(author_id, author_name, author_desc)
values(2, '박경리', '경남 통영');

insert into author(author_id, author_name, author_desc)
values(3, '유시민', '17대 국회의원');

insert into author
values(seq_author_id.nextval, '싱숑', '전지적 독자 시점');

--시퀀스 정보 조회
select *
from user_sequences;

--다음 시퀀스 조회 /번호를 꺼내고 currval을 실행해줘야함
select seq_author_id.nextval
from dual;

--현재 시퀀스 조회
select seq_author_id.currval
from dual;

--자동으로 순서대로 들어가게 하는 것
--시퀀스 만들기
create sequence seq_author_id
increment by 1
start with 1;

--시퀀스 삭제
drop sequence seq_author_id;

--시퀀스 사용해서 데이터 넣어주기
insert into author(author_id, author_name, author_desc)
values(seq_author_id.nextval, '이문열', '경북 양양');

insert into author(author_id, author_name, author_desc)
values(seq_author_id.nextval, '박경리', '경남 통영');

insert into author(author_id, author_name, author_desc)
values(seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author(author_id, author_name, author_desc)
values(seq_author_id.nextval, '싱숑', '전지적 독자 시점');


select *
from author;