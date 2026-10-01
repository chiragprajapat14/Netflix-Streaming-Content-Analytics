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

    -- Injecting Catalog Data
INSERT INTO netflix_titles VALUES 
('s1', 'Movie', 'Stranger Corporate', 'Matt Duffer', 'USA', 2024, 'TV-14', '120 min', 'Sci-Fi, Dramas'),
('s2', 'TV Show', 'SQL Games', 'Hwang Dong-hyuk', 'South Korea', 2025, 'TV-MA', '1 Season', 'Thriller, International'),
('s3', 'Movie', 'The Coding Heist', 'Álex Pina', 'Spain', 2023, 'TV-MA', '145 min', 'Action, International'),
('s4', 'Movie', 'Data Romance', 'Richard Curtis', 'UK', 2026, 'PG-13', '105 min', 'Comedies, Romantic'),
('s5', 'TV Show', 'Tech Chronicles', NULL, 'USA', 2024, 'TV-PG', '4 Seasons', 'Docuseries, Sci-Fi');

-- Injecting User Base
INSERT INTO netflix_users VALUES 
(901, 'Aarav Sharma', 'India', 'Premium'),
(902, 'Emily Smith', 'USA', 'Standard'),
(903, 'Carlos Ruiz', 'Spain', 'Premium'),
(904, 'Yuki Tanaka', 'Japan', 'Basic');

-- Injecting Streaming Logs
INSERT INTO netflix_watch_history VALUES 
(8001, 901, 's2', '2026-01-10 21:00:00', 45, 'Smart TV'),
(8002, 901, 's3', '2026-01-11 22:30:00', 145, 'Smart TV'),
(8003, 902, 's1', '2026-01-11 18:15:00', 30, 'Mobile'),
(8004, 902, 's1', '2026-01-12 19:00:00', 90, 'Mobile'),
(8005, 903, 's3', '2026-01-15 14:00:00', 120, 'Laptop'),
(8006, 904, 's2', '2026-01-16 23:10:00', 50, 'Tablet'),
(8007, 901, 's4', '2026-01-20 20:00:00', 15, 'Mobile'),
(8008, 902, 's5', '2026-01-22 17:00:00', 60, 'Smart TV');
