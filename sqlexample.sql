-- List authors(id, first_name, last_name, country_name), book name, ISBN, price,
-- discount, is_hard_copy - if they have books, or null if they don't.
-- Order by author last_name, first_name.

SELECT a.id, a.first_name, a.last_name, c.name as country_name, b.title, b.isbn, bd.price, bd.discount, bd.is_hard_copy 
FROM Author AS a
JOIN Country AS c on a.country_id=c.id
LEFT JOIN Book AS b on b.author_id=a.id
left join bookdetails as bd on bd.book_id=b.id
order by a.last_name, a.first_name desc

-- List authors (id, first_name, last_name, country_name) where country code is the USA.
select a.id, a.first_name, a.last_name, c.name
from Author as a
join Country as c on a.country_id=c.id
where c.name='USA'

--  List authors(id, first_name, last_name, country_name) with books.
-- Order by the number of books descending.

select a.id, a.first_name, a.last_name, c.name
from Author as a
left join Book as b on b.author_id=a.id
join Country as c on a.country_id=c.id
where a.country_id = c.id and b.title is not null
group by a.id, c.name
order by count(b.title) desc

--  Select how many books are from USA authors.

select COUNT(b.title) 
from Book as b
join Author as A on a.id=b.author_id 
join Country as c on c.id=a.country_id
where b.author_id = a.id and a.country_id = c.id and c.name = 'USA'

-- Select books (title, isbn, discount, price) where 20 <= discount <=30, order by price
-- increasing.

select b.title, b.isbn, bd.discount, bd.price
from Book as b
join BookDetails as bd on bd.book_id=b.id
where bd.discount >= 20 and bd.discount <= 30
order by bd.price asc

-- List the cheapest book (price) of every author (first_name, last_name).
-- If an author does not have books, display -1 as the price.

select coalesce(min(bd.price), -1), a.first_name, a.last_name
from author as a
left join book as b on a.id=b.author_id 
left join bookdetails as bd on b.id=bd.book_id 
group by a.first_name, a.last_name
