-- 1. Director
-- 1.1. Which are the movies directed by the same director?
SELECT MovieName, d.DirectorID, `Name`
FROM directors d
INNER JOIN movies m ON d.DirectorID=m.DirectorID
WHERE d.DirectorID IN (
SELECT DirectorID
FROM movies
GROUP BY DirectorID
HAVING COUNT(DirectorID) > 1)
ORDER BY 2;

-- 1.2. What is the total revenue per director?
SELECT d.DirectorID, `Name`, SUM(RevenueUSD) AS total_USD_per_director
FROM directors d
INNER JOIN  movies m ON d.DirectorID = m.DirectorID
INNER JOIN revenues r ON m.MovieID=r.MovieID
GROUP BY DirectorID
ORDER BY 3 DESC;

-- 1.3. What is the number of awards won by each director?
SELECT d.DirectorID, `Name`, COUNT(AwardObtainedID) AS count_awards
FROM directors d
INNER JOIN movies m ON d.DirectorID=m.DirectorID
INNER JOIN awards_obtained ab ON m.MovieID=ab.MovieID
GROUP BY DirectorID
ORDER BY 3 DESC;

-- 1.4. Directors with movies that won awards after 1997
WITH director_awards_in_mult_countries AS (
SELECT DirectorID
FROM movies
NATURAL JOIN awards_obtained
NATURAL JOIN award_types
WHERE YearAwarded > 1997
GROUP BY DirectorID
)
SELECT DISTINCT(DirectorID), `Name`
FROM directors
NATURAL INNER JOIN director_awards_in_mult_countries;

-- 1.5. What are the directors with the most collaborations with the actors?
SELECT COUNT(DISTINCT ActorID) AS counter_actors_per_director, `Name` AS directors_name
FROM directors d
INNER JOIN movies m ON d.DirectorID = m.DirectorID
INNER JOIN cast c on m.MovieID = c.MovieID
GROUP BY `Name`
HAVING  counter_actors_per_director > 1
ORDER BY 1 DESC;

-- 2. Movies
-- 2.1. Movies that won multiple awards
WITH movie_multiple_awards AS (
SELECT COUNT(MovieID), MovieID
FROM awards_obtained
GROUP BY MovieID
HAVING COUNT(MovieID) > 1)
SELECT MovieName, AwardObtainedID,
ROW_NUMBER() OVER(PARTITION BY MovieName) As row_num
FROM movie_multiple_awards
NATURAL JOIN movies
NATURAL JOIN awards_obtained;

-- 2.2. Top 5 movies with the highest revenue-to-budget ratio
SELECT MovieID, MovieName, (SUM(RevenueUSD)/SUM(BudgetUSD)) AS revenue_to_budget_ratio
FROM revenues
NATURAL JOIN movies
GROUP BY MovieID
ORDER BY revenue_to_budget_ratio DESC
LIMIT 5;

-- 2.3. Movies directed and acted in by the same director
SELECT MovieName, `Name` AS directors_name,
ROW_NUMBER() OVER(PARTITION BY `Name`) AS row_num
FROM movies m
INNER JOIN directors d ON m.DirectorID=d.DirectorID;

-- 2.4. Top 3 movies that generated the highest revenue
SELECT MovieName, RevenueUSD
FROM movies
NATURAL JOIN revenues
ORDER BY 2 DESC
LIMIT 3;

-- 2.5. Movies that no win awards
SELECT *
FROM movies m
LEFT JOIN awards_obtained a
ON m.MovieID = a.MovieID
WHERE a.MovieID IS NULL;

-- 3. Actor
-- 3.1. Actor having different roles in movies
SELECT Role, MovieName, ActorID
FROM movies
NATURAL JOIN cast
WHERE ActorID IN (
SELECT ActorID
FROM cast
GROUP BY ActorID
HAVING COUNT(DISTINCT Role)> 1
)
ORDER BY 3, 1;

-- 3.2. Actors who appeared in movies from the most diverse countries
SELECT ActorID, COUNT(DISTINCT Country) AS counter_distinct_country
FROM movies
NATURAL JOIN cast
GROUP BY ActorID
HAVING COUNT(DISTINCT Country) > 1
ORDER BY 2 DESC;

-- 3.3. Actors who won awards for different roles
SELECT ActorID
FROM cast c
INNER JOIN movies m ON c.MovieID=m.MovieID
INNER JOIN awards_obtained ab ON m.MovieID=ab.MovieID
WHERE m.MovieID IN (
   SELECT MovieID
   FROM cast
   WHERE ActorID IN (
      SELECT ActorID
      FROM cast c
      GROUP BY ActorID
      HAVING COUNT(DISTINCT `Role`)>1)
)
GROUP BY ActorID
HAVING COUNT(ActorID)>1;

-- 3.4. Which actors have a salary lower or highter than the average of all salaries? 
WITH avg_salary AS (
SELECT AVG(SalaryUSD) as average
FROM cast
)
SELECT ActorID, SalaryUSD,
CASE
   WHEN SalaryUSD < average THEN 'less'
   WHEN SalaryUSD > average THEN 'more'
   ELSE 'average'
END AS salary_group
FROM avg_salary
NATURAL JOIN cast
ORDER BY 2;

-- 4. Revenue
-- 4.1 Highest-grossing movies by country
SELECT SUM(RevenueUSD) AS Total_revenue_per_country, Country
FROM revenues
GROUP BY Country
ORDER BY 1 DESC;

-- 4.2. Revenue trends over the years for a specific director
SELECT DirectorID, RevenueUSD, `Year`,
ROW_NUMBER() OVER(PARTITION BY DirectorID ORDER BY `Year`) AS row_num
FROM revenues
NATURAL JOIN movies;

-- 4.3. Revenue by decade
WITH minYear AS (
SELECT MIN(`Year`) AS min_year
FROM revenues
),
decade_group AS (
SELECT RevenueUSD, `Year`,
CASE
   WHEN `Year` BETWEEN min_year AND min_year+9 THEN CONCAT(min_year, '-', min_year + 9)
   WHEN `Year` BETWEEN min_year+10 AND min_year+19 THEN CONCAT(min_year+10 , '-', min_year+19)
   WHEN `Year` BETWEEN min_year+20 AND min_year+29 THEN CONCAT(min_year+20 , '-', min_year+29)
   WHEN `Year` BETWEEN min_year+30 AND min_year+39 THEN CONCAT(min_year+30 , '-', min_year+39)
   WHEN `Year` BETWEEN min_year+40 AND min_year+49 THEN CONCAT(min_year+40 , '-', min_year+49)
   ELSE '>2021'
END AS decade
FROM minYear
NATURAL JOIN revenues
)
SELECT decade, SUM(RevenueUSD) AS total_revenue_USD_by_decade
FROM decade_group
GROUP BY decade
ORDER BY 2 DESC;