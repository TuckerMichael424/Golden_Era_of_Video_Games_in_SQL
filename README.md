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
LIMIT 10 ;]

[-- QUERY 2: Top 10 Years by Critic Score (min 4 games)
SELECT game_sales.year,
	COUNT(DISTINCT game_sales.name) AS num_games, 
	ROUND(AVG(reviews.critic_score), 2) AS avg_critic_score
FROM public.reviews
INNER JOIN game_sales ON reviews.name = game_sales.name
GROUP BY game_sales.year
HAVING COUNT(DISTINCT game_sales.name) >= 4
ORDER BY avg_critic_score DESC
LIMIT 10 ; 
]

[-- QUERY 3: Golden Years (critic OR user score > 9)
SELECT users_avg_year_rating.year,
	users_avg_year_rating.num_games,
	critics_avg_year_rating.avg_critic_score,
	users_avg_year_rating.avg_user_score,
	critics_avg_year_rating.avg_critic_score - users_avg_year_rating.avg_user_score AS diff
FROM public.users_avg_year_rating
INNER JOIN critics_avg_year_rating ON users_avg_year_rating.year = critics_avg_year_rating.year
WHERE avg_critic_score > 9 OR avg_user_score > 9
ORDER BY users_avg_year_rating.year ASC;]
```
## Results 🧪

### Best-Selling Games
- The top 10 best-selling games are dominated by Nintendo platform games with (8 of the 10 results), and specifically the Nintendo Wii platform (4 of 10 of the results) dominating with releases like Wii Sports, Mario Kart, Wii Sports Resort, and New Super Mario Bros.
- PC platforms come in a close second (3 out of 10 games) with titles like Counter-Strike: Global Offensive selling 40 million copies, Playerunknown's Battlegrounds selling 36.6 million, and Minecraft at 33.15 million. These three were released between 2010 - 2017, representing a 7 year period of success for the PC platform. 
- Each of those 4 games also released between 2006 and 2009 represents the most commercially successful period, with Wii Sports selling over 82.9 (million) copies that year. 

### Top Critic-Rated Years
- The years with the highest critic scores (minimum 4 games) are concentrated in 1998, with 10 games released, and an average critic score of 9.32. 
- This suggests the "golden era" for critics was the late 90's. 

### Golden Years (Critic OR User Score > 9)
- Only 6 years met the threshold for exceptional scores from critics or users. 
- The difference (diff) column shows that critics and users disagreed most in 1997, with a gap of -1.57 (critics averaged a 7.93 rating versus users at 9.5). 
- 1998 stands out as having both high critic AND user scores. 

### Final Conclusion
The golden era splits depending on what you value: commercially it’s the mid-2000’s, critically it peaks in 1998, where both users and critics gave high ratings. 
If we were to separate this into three ears with a focus on commercial success, critic consensus, and user consensus we would get: 
- Commercially, the golden era would be the early 2000's - with half of the top 10 games releasing before 2010.
- For critic reviews, the golden era appears to be divided between the early 2000's and post 2010.
	Both decades had 4 separate years with a minimum of 9 games released and an average score of 8.86 for 2000-2009, and 8.67 for 2010 - 2020.

While this can be expanded to take into account socio-political/technological changes, for now, I will leave it as is and state with confidence the golden era of video games was the early 2000's. 
