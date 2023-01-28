
--1. How many rows are in the names table?
SELECT COUNT(name) AS count_of_rows_in_table
FROM names;
--ANSWER:1,957,046

--2. How many total registered people appear in the dataset?
SELECT SUM(num_registered) AS total_registered
FROM names;
--ANSWER: 351,653,025

--3. Which name had the most appearances in a single year in the dataset?
SELECT *
FROM names
ORDER BY num_registered DESC
LIMIT 1;
--ANSWER: Linda, 1947

--4. What range of years are included?
SELECT MAX(year) AS max_year, MIN(year) AS min_year
FROM names;
--ANSWER: 1880 - 2018

--5. What year has the largest number of registrations?
SELECT DISTINCT year, sum(num_registered) AS registered_by_year
FROM names
GROUP BY year
ORDER BY sum(num_registered) DESC;
--ANSWER: 1957

--6. How many different (distinct) names are contained in the dataset?
SELECT COUNT(DISTINCT name) AS names_count
FROM names;
--ANSWER: 98,400

--7. Are there more males or more females registered?
SELECT COUNT(gender) as male_count
FROM names
WHERE gender = 'M';
--ANSWER: There are more females (1,156,527) registered than males (800,519)

--8. What are the most popular male and female names overall (i.e., the most total registrations)?
SELECT DISTINCT name, SUM(num_registered) AS total_registered
FROM names
WHERE gender = 'M'
GROUP BY name, gender
ORDER BY total_registered DESC;
--ANSWER: "Mary" (4,125,675) and "James" (5,164,280)

--9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?
SELECT DISTINCT name, SUM(num_registered) AS total_registered
FROM names
WHERE gender = 'F' AND
	year BETWEEN 2000 AND 2009
GROUP BY name
ORDER BY total_registered DESC
LIMIT 1;
--ANSWER: "Jacob" (273,844) & "Emily" (223,690)

--10. Which year had the most variety in names (i.e. had the most distinct names)?
SELECT year, COUNT(DISTINCT names) as distinct_names_count
FROM names
GROUP BY year
ORDER BY distinct_names_count DESC
LIMIT 1;
--ANSWER: 2008 (35,079)

--11. What is the most popular name for a girl that starts with the letter X?
SELECT DISTINCT name, SUM(num_registered) as total_registered
FROM names
WHERE gender = 'F' AND
	name LIKE 'X%'
GROUP BY name
ORDER BY total_registered DESC
LIMIT 1;
--ANSWER: "Ximena" (26,145)

--12. How many distinct names appear that start with a 'Q', but whose second letter is not 'u'?
SELECT COUNT(DISTINCT name) as name_count
FROM names
WHERE name LIKE 'Q%' AND
	name NOT LIKE '_u%';
--ANSWER: 46

--13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.
SELECT name, COUNT(name) AS name_count
FROM names
WHERE name = 'Steven' OR
	name = 'Stephen'
GROUP BY name
ORDER BY name_count DESC;
--ANSWER: "Stephen" (230)

--14. What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls?
SELECT
 (SELECT COUNT(*)
   FROM (SELECT name
   FROM names
   GROUP BY name
   HAVING COUNT(DISTINCT gender ) = 2) AS sub) /
   CAST( COUNT(DISTINCT name) AS DOUBLE PRECISION)AS perc_unisex
FROM names;
--ANSWER: 11%

--15. How many names have made an appearance in every single year since 1880?
SELECT COUNT
	(SELECT COUNT(DISTINCT name)
	FROM names
	GROUP BY name
	HAVING COUNT(DISTINCT year) = 139)
FROM names;

--ANSWER: ???

--16. How many names have only appeared in one year?
SELECT COUNT(DISTINCT name)
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year) = 1;