# 🎮 When Was the Golden Era of Video Games?

## 📋 Project Overview
This project analyzes video game sales and review scores to identify the "golden era" of gaming—release years that were most highly rated by critics and users. The analysis uses SQL to query game sales data and Metacritic scores for the top 400 games released since 1977.

## 🎯 Business Question
Are games getting better, or has the golden age of video games already passed? This analysis identifies:
- The best-selling games of all time
- Years with the highest average critic scores (with sufficient sample size)
- Years where both critics AND users agreed games were exceptional

## 🛠️ SQL Skills Demonstrated
| Skill | Application |
|-------|-------------|
| **INNER JOIN** | Connecting game sales with review scores |
| **Aggregation** | COUNT, AVG with GROUP BY |
| **Filtering** | WHERE clauses, HAVING for group conditions |
| **Calculated Fields** | Difference between critic and user scores |
| **Sorting & Limiting** | ORDER BY with DESC and LIMIT |
| **Logical Operators** | OR condition in WHERE clause |

## 📊 Key Findings

### Top 10 Best-Selling Games
```sql
[-- QUERY 1: Top 10 Best-Selling Games
SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 10;]

[-- QUERY 2: Top 10 Years by Critic Score (min 4 games)
SELECT game_sales.year,
    COUNT(DISTINCT game_sales.name) AS num_games_released, 
    ROUND(AVG(reviews.critic_score), 2) AS avg_critic_score
FROM public.reviews
INNER JOIN game_sales ON reviews.name = game_sales.name
GROUP BY game_sales.year
HAVING COUNT(DISTINCT game_sales.name) >= 4
ORDER BY avg_critic_score DESC
LIMIT 10;
]

[-- QUERY 3: Golden Years (critic OR user score > 9)
SELECT users_avg_year_rating.year,
    users_avg_year_rating.num_games,
    critics_avg_year_rating.avg_critic_score,
    users_avg_year_rating.avg_user_score,
    critics_avg_year_rating.avg_critic_score - users_avg_year_rating.avg_user_score AS diff
FROM public.users_avg_year_rating
INNER JOIN critics_avg_year_rating 
    ON users_avg_year_rating.year = critics_avg_year_rating.year
WHERE critics_avg_year_rating.avg_critic_score > 9 
    OR users_avg_year_rating.avg_user_score > 9
ORDER BY users_avg_year_rating.year ASC;]
