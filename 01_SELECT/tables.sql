-- world.sql: table definition for SQLZoo exercises

CREATE TABLE world (
    name VARCHAR(50) PRIMARY KEY,      -- The English name of the country
    continent VARCHAR(60),             -- Continent or similar grouping
    area DECIMAL(10,0),                -- Land area in square kilometers
    population DECIMAL(11,0),          -- Number of people living in the country
    gdp DECIMAL(14,0)                  -- Total annual GDP in US dollars
);

-- Insert example rows
INSERT INTO world (name, continent, area, population, gdp) VALUES
('Afghanistan', 'Asia', 652230, 25500100, 20343000000),
('Albania', 'Europe', 28748, 2831741, 12960000000),
('Algeria', 'Africa', 2381741, 37100000, 188681000000),
('Andorra', 'Europe', 468, 78115, 3712000000),
('Angola', 'Africa', 1246700, 20609294, 100990000000);
