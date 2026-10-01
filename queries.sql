select * from netflix_titles nt ;
select * from netflix_users nu ;
select * from netflix_watch_history nwh ;

#The product team wants to identify highly engaging content. A title is flagged as "Binge Completed" if a user watches the entire runtime in a single session 
#or across multiple sessions. For Movies, look for instances where a single user's total minutes_watched for that movie matches or exceeds its catalog duration.


SELECT 
    nu.username,
    nt.title,
    SUM(nwh.minutes_watched) AS total_minutes_streamed
FROM netflix_users nu 
INNER JOIN netflix_watch_history nwh 
ON nu.user_id = nwh.user_id 
INNER JOIN netflix_titles nt 
ON nwh.show_id = nt.show_id 
WHERE nt.type = 'Movie' 
GROUP BY nu.username, nt.title
HAVING total_minutes_streamed >= CAST(SUBSTRING_INDEX(MAX(nt.duration), ' ', 1) AS UNSIGNED);

#The marketing team wants to see a clean list of all content that was produced in 'South Korea' or 'Spain'

select * from netflix_titles nt 
where nt.country in ('South Korea','Spain');

#Content acquisition needs to count how many titles in our database are classified strictly as 'Movie' and how many are 'TV Show'

select 
    type,
    COUNT(type) numbers
    from netflix_titles nt 
    GROUP by type;

The product design team wants to see if the 'Smart TV' app is popular. Find all watch logs where the user streamed content on a 'Smart TV'

select user_id,watch_id,minutes_watched,device_used from netflix_watch_history nwh 
where nwh.device_used = 'Smart TV'

 #The billing team wants to extract a contact sheet of all customers who are paying for the 'Premium' tier subscription plan.
 
select * from netflix_users nu 
where nu.subscription_plan = 'Premium';

#Finance needs to report the absolute total sum of minutes streamed across the entire platform by all users combined

select device_used,
    SUM(minutes_watched) minutes
    from netflix_watch_history nwh 
    group by device_used 
    
#The marketing team wants to analyze regional platform health. Calculate the total number of minutes spent streaming content strictly by users living in 'India'
 
select nwh.user_id,
    nu.username,
    nu.country,
    SUM(minutes_watched) minutes
    from netflix_watch_history nwh 
    inner join netflix_users nu 
    on nwh.user_id = nu.user_id 
    where nu.country = "india"
    group by nwh.user_id
    

#The licensing board wants to audit catalog distribution. Group all titles into two distinct operational buckets:
'New Content' (released in or after 2024) and 'Classic Content' (released before 2024)    

alter TABLE netflix_titles modify COLUMN release_year YEAR; 

select title,
    CASE 
    	when release_year >= "2024" then 'New Content' 
    	else "Classic Content"
    END as Class
    FROM netflix_titles nt 
    
    SELECT 
    CASE 
        WHEN release_year >= 2024 THEN 'New Content' 
        ELSE 'Classic Content'
    END AS Content_Class,
    COUNT(*) AS Total_Titles
FROM netflix_titles
GROUP BY 1; 

    
 #Netflix wants to find out which creative directors retain user attention the longest.
 #Find the total streaming minutes accumulated by each individual director's catalog

select 
    nwh.show_id,
    nt.director,
    sum(minutes_watched) minutes
    from netflix_titles nt 
    inner JOIN 
    netflix_watch_history nwh 
    on nt.show_id = nwh.show_id 
    where nt.director is NOT null
    group by nt.director,nwh.show_id
    order by minutes DESC 
    
    
 #Customer loyalty wants to gift profile badges to power users. Identify all users who have streamed more than 100 total minutes of
 #content across the entire application history
    
select nwh.user_id,
    username,
    sum(minutes_watched) minutes
    from netflix_users nu 
    inner JOIN 
    netflix_watch_history nwh 
    ON nu.user_id =nwh.user_id 
    group by nwh.user_id ,username 
    having minutes > 100
    
    
#The finance team wants to check if premium users actually stream more content than base tier subscribers.
#Calculate the average minutes watched per streaming session for each individual subscription_plan (Basic, Standard, Premium)
    
select subscription_plan,
    count(nu.user_id) users,
    round(avg(minutes_watched),2) minutes
    from netflix_users nu 
    inner JOIN 
    netflix_watch_history nwh 
    on nu.user_id = nwh.user_id 
    group by subscription_plan 
    
#The product hardware team wants to distribute budgeting funds for upgrading app performance on different devices. 
#Calculate the total minutes streamed on each device class, and its exact percentage contribution compared to global app-wide watch time
    
SELECT 
    device_used devices,
    SUM(minutes_watched) minutes,
    concat(round(SUM(minutes_watched)/SUM(SUM(minutes_watched)) OVER() * 100,2),"%") pers
    from netflix_watch_history nwh 
    group by devices 
    
    
#The recommendation algorithm team wants to see a user's chronological session flow. For every watch history entry,
#check what content that same user watched next   

SELECT 
    username,
    watch_date,
    title,
    LEAD(nt.title,1) OVER(partition by nwh.user_id order by nwh.watch_date ) next_title
    from netflix_titles nt 
    inner join netflix_watch_history nwh 
    on nt.show_id  = nwh.show_id 
    INNER join netflix_users nu
    on nwh.user_id = nu.user_id
 
#The content curation team flags movies over 120 minutes as "Long Format Cinema". For each country, 
#calculate the total number of titles produced, and what percentage of those titles are "Long Format Cinema"

SELECT 
    country,
    COUNT(*) AS total_movies,
    SUM(CASE WHEN CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 120 THEN 1 ELSE 0 END) AS long_movies_count,
    CONCAT(ROUND((SUM(CASE WHEN CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 120 THEN 1 ELSE 0 END) / COUNT(*)) * 100,2),'%') AS long_format_cinema_percent
    FROM netflix_titles
    WHERE type = 'Movie' 
    GROUP BY country;

 #The CRM automated email team needs a master customer preference lookup sheet. For every unique subscriber profile, extract a clean, alphabetical comma-separated 
 #list of all distinct categories/genres (listed_in) they have watched 

select 
    username,
    GROUP_CONCAT(distinct(listed_in)," ") types
    from netflix_titles nt 
    inner JOIN netflix_watch_history nwh 
    on nt.show_id = nwh.show_id 
    inner join netflix_users nu 
    on nwh.user_id = nu.user_id 
    GROUP by username 

#The retention management team wants to group subscribers based on their activity speed. If a user's most recent stream (MAX(watch_date)) was on or after January 15th, 2026, label them as 'Active User'. 
#If their last watch action was before that day, label them as 'Churn Risk'  
    

select
    username,
    case 
    	when max(watch_date) > "2026-01-15 00:00:00" then 'Active User' else 'Churn Risk'
    end as class
    from netflix_watch_history nwh
    inner join netflix_users nu 
    on nwh.user_id = nu.user_id
    group by 1
