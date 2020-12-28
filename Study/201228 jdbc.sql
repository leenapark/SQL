--복습 & jdbc 코드 test

select *
from author;

update author
set author_desc = '서울시 양천구 신정동'
where author_id = 21;

rollback;
commit;

--author test
delete from author
where author_id = 21;

--author 출력 test
select  author_id,
        author_name,
        author_desc
from author;

--delete 확인용
delete from book
where book_id = 7;


--book 출력 test용
select  book_id id,
        title title,
        pubs pubs,
        to_char(pub_date, 'YYYY-MM-DD') pub_date,
        author_id authorId
from book;


--book & author 함께 출력
select  b.book_id id,
        b.title title,
        b.pubs pubs,
        to_char(b.pub_date, 'YYYY-MM-DD') pub_date,
        b.author_id authorId,
        a.author_name authorName,
        a.author_desc authorDesc
from book b, author a
where b.author_id = a.author_id;