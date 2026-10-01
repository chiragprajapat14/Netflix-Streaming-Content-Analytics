-- 1. Netflix Master Catalog Table
CREATE TABLE netflix_titles (
    show_id VARCHAR(10) PRIMARY KEY,
    type VARCHAR(10), -- 'Movie' or 'TV Show'
    title VARCHAR(150),
    director VARCHAR(100),
    country VARCHAR(100),
    release_year INT,
    rating VARCHAR(10), -- 'PG-13', 'R', 'TV-MA', etc.
    duration VARCHAR(50), -- '90 min' or '3 Seasons'
    listed_in VARCHAR(100) -- Genres like 'Comedies, Action'
);

-- 2. User Profiles Table
CREATE TABLE netflix_users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    country VARCHAR(50),
    subscription_plan VARCHAR(20) -- 'Basic', 'Standard', 'Premium'
);

-- 3. Watch History Ledger Table
CREATE TABLE netflix_watch_history (
    watch_id INT PRIMARY KEY,
    user_id INT,
    show_id VARCHAR(10),
    watch_date DATETIME,
    minutes_watched INT,
    device_used VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES netflix_users(user_id),
    FOREIGN KEY (show_id) REFERENCES netflix_titles(show_id)
