--author 테이블 만들기
create table author (
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(100),
    primary key(author_id)
);

--book 테이블 만들기
create table book (
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key(book_id),
    constraint book_fk foreign key(author_id)
    references author(author_id)
);

--시퀀스 생성
create sequence seq_author_id
increment by 1
start with 1;

create sequence seq_book_id
increment by 1
start with 1;

--author 데이터 생성
insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '이문열', '경북 양양');

insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '박경리', '경남 통영');

insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '기안84', '기안동에 산 84년생');

insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author (author_id, author_name, author_desc)
values (seq_author_id.nextval, '김영하', '알쓸신잡');


--book 데이터 생성
insert into book (book_id, title, pubs, pub_date, author_id)
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998/02/22', 1);

insert into book
values (seq_book_id.nextval, '삼국지', '민음사', '2002/03/01', 1);

insert into book
values (seq_book_id.nextval, '토지', '마로니에북스', '2012/08/15', 2);

insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의 길', '2015/04/01', 3);

insert into book
values (seq_book_id.nextval, '패션왕', '중앙북스(books)', '2012/02/22', 4);

insert into book
values (seq_book_id.nextval, '순정만화', '재미주의', '2011/08/03', 5);

insert into book
values (seq_book_id.nextval, '오직두사람', '문학동네', '2017/05/04', 6);

insert into book
values (seq_book_id.nextval, '26년', '재미주의', '2012/02/04', 5);


--최종 조회
select  b.book_id "book_id",
        b.title "title",
        b.pubs "pubs",
        b.pub_date "pub_date",
        a.author_id "author_id",
        a.author_name "author_name",
        a.author_desc "author_desc"
from author a, book b
where b.author_id = a.author_id;


--기안 84 삭제
delete from author
where author_id = 4;


--commit
commit;


--test 조회
select *
from author;

select *
from user_sequences;

select *
from book;


--수정 & 삭제용
delete from author;
delete from book;

drop table author;

drop sequence seq_author_id;
drop sequence seq_book_id;