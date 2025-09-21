create database good_read;
Use good_read;
SELECT * FROM books;

-- Q1: List all books with a rating above 4.0.

Select * from books where rating>4;
-- Q2: Find the top 5 authors with the highest average book rating.
Select author_detail, avg(rating) from books group by author_detail order by avg(rating)  desc limit 5;
-- Q3: Count the total number of books per genre.
SELECT 
    genre, COUNT(*)
FROM
    books
GROUP BY genre;

-- Q4: Find books published before 1980 with more than 1000 reviews.
Select * from books where year<1980;

-- Q5: List all books with duplicate titles.
Select title, count(*) as count_title from books group by title having count_title>1;

-- Q6: Find the author who has the maximum number of books in the dataset.

Select author_detail, count(*) from books group by author_detail order by count(*) desc limit 1;
-- Q7: Calculate the average rating for each year.
Select year, round(avg(rating),2) from books group by year;
-- Q8: List the books with the highest number of ratings per genre.

SELECT genre, title, No_of_rating 
FROM (
    SELECT 
        genre, 
        title, 
        No_of_rating,
        RANK() OVER (PARTITION BY genre ORDER BY No_of_rating DESC) AS rnk
    FROM books
) ranked
WHERE rnk = 1;

-- Q9: Count the number of books per binding type.
Select binding1,count(*) from books group by binding1;

-- Q10: Find books where the number of reviews is greater than the number of ratings / 10

Select * from books where No_of_review >(No_of_rating / 10);
-- Q11: List authors whose names appear inconsistently (e.g., "Kerouac Jack" vs "Jack Kerouac").
SELECT author_detail, COUNT(DISTINCT author_detail)
FROM books
GROUP BY REPLACE(author_detail,' ','')  -- crude way to detect name inconsistencies
HAVING COUNT(DISTINCT author_detail) > 1;

-- Q12: Find books published in January that have rating > 4.
SELECT 
    *
FROM
    books
WHERE
    Month = 'January' AND rating > 4;
    
-- Q13: List the 10 most recently published books.
Select * from books order by year desc limit 10;

-- Q14: Count the total number of ratings per author.
Select author_detail, count(*)  from books group by author_detail;
-- Q15: List books with missing page count or zero pages.
SELECT * FROM books
WHERE Pages = 0 OR Pages IS NULL;