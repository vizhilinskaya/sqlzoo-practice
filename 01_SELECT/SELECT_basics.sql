-- 1 task: [Read the notes about this table.](01_SELECT/tables.sql) Observe the result of running this SQL command to show the name, continent and population of all countries.
SELECT name, continent, population 
FROM world;

-- 2 task: Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
SELECT name
FROM world
WHERE population > 200000000;

-- 3 task: Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name, gdp/population AS per_capita_GDP
FROM world
WHERE population > 200000000;

-- 4 task: Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
SELECT name, population/1000000
FROM world
WHERE continent LIKE 'South America';

-- 5 task: Show the name and population for France, Germany, Italy.
SELECT name, population 
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- 6 task: Show the countries which have a name that includes the word 'United'.
SELECT name
FROM world
WHERE name LIKE '%United%';

/*7 task: Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.
Show the countries that are big by area or big by population. Show name, population and area.*/
SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000;

/*8 task:Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.

Australia has a big area but a small population, it should be included.
Indonesia has a big population but a small area, it should be included.
China has a big population and big area, it should be excluded.
United Kingdom has a small population and a small area, it should be excluded.*/
SELECT name, population, area
FROM world
WHERE (area > 3000000 AND population < 250000000) OR (area < 3000000 AND population > 250000000);

/*9 task: Show the name and **population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.
For Americas show population in millions and GDP in billions both to 2 decimal places.*/
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America';

-- 10 task: Show the countries in Europe with a per capita GDP greater than 'United Kingdom'. The per capita GDP is the gdp/population.
SELECT name
FROM world
WHERE continent = 'Europe'
  AND gdp / population > (
    SELECT gdp / population
    FROM world
    WHERE name = 'United Kingdom'
  );

-- 11 task: List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent
FROM world
WHERE continent IN (
    SELECT continent
    FROM world
    WHERE name IN ('Argentina', 'Australia')
)
ORDER BY name;

-- 12 task: Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.
SELECT name, population
FROM world
WHERE population > (
    SELECT population
    FROM world
    WHERE name = 'United Kingdom'
)
AND population < (
    SELECT population
    FROM world
    WHERE name = 'Germany'
);

/*13 task: Germany (population roughly 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
The format should be Name, Percentage for example:
name	percentage
Albania	3%
Andorra	0%
Austria	11%
...	...*/

SELECT name,
       CONCAT(CAST(ROUND(100*population / (
           SELECT population
           FROM world
           WHERE name = 'Germany'
       ),0) as int), '%') AS percentage
FROM world
WHERE continent = 'Europe';

-- 14 task: Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values).
SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe'  AND gdp IS NOT NULL)

/*15 task: Find the largest country (by area) in each continent, show the continent, the name and the area:
The above example is known as a correlated or synchronized sub-query.*/
SELECT continent, name, area
FROM world AS w1
WHERE area >= ALL(SELECT area
               FROM world AS w2
               WHERE w2.continent = w1.continent
               AND w2.area IS NOT NULL
);

-- 16 task:List each continent and the name of the country that comes first alphabetically.
SELECT continent, name
FROM world w1
WHERE name = (
    SELECT MIN(name)
    FROM world w2
    WHERE w2.continent = w1.continent
);

-- 17 task:Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population
FROM world w1
WHERE 25000000 >= ALL (
    SELECT population
    FROM world w2
    WHERE w1.continent = w2.continent
);

-- 18 task: Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent
FROM world w1
WHERE population > ALL (
    SELECT 3 * population
    FROM world w2
    WHERE w1.continent = w2.continent
      AND w1.name <> w2.name
);



