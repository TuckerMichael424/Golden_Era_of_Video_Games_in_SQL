-- best_selling_games
SELECT name,
	games_sold AS game_sales
FROM game_sales
ORDER BY games_sold DESC 
LIMIT 10 ;

-- critics_top_ten_years
SELECT game_sales.year,
	COUNT(DISTINCT game_sales.name) AS num_games_released, 
	ROUND(AVG(reviews.critic_score), 2) AS avg_critic_score
FROM public.reviews
INNER JOIN game_sales ON reviews.name = game_sales.name
GROUP BY game_sales.year
HAVING COUNT(DISTINCT game_sales.name) >= 4
ORDER BY avg_critic_score DESC
LIMIT 10 ; 

-- Comparing average user and critic ratings to determine the "golden years" of video games
SELECT users_avg_year_rating.year,
	users_avg_year_rating.num_games,
	critics_avg_year_rating.avg_critic_score,
	users_avg_year_rating.avg_user_score,
	critics_avg_year_rating.avg_critic_score - users_avg_year_rating.avg_user_score AS diff
FROM public.users_avg_year_rating
INNER JOIN critics_avg_year_rating ON users_avg_year_rating.year = critics_avg_year_rating.year
WHERE avg_critic_score > 9 OR avg_user_score > 9
ORDER BY users_avg_year_rating.year ASC
