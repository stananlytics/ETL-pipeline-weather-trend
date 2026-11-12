CREATE TABLE IF NOT EXISTS weather (
    id INT PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    temperature FLOAT NOT NULL,
    humidity INTEGER,
    weather_description TEXT,
    weather_date DATE
);

select * FROM weather;

SELECT city, temperature, humidity, weather_description, weather_date
FROM public.weather
ORDER BY city;






