# SQL

1. Query the average population for all cities in CITY, rounded down to the nearest integer.
2. Query the following two values from the STATION table:
   
   The sum of all values in LAT_N rounded to a scale of 2 decimal places.
   The sum of all values in LONG_W rounded to a scale of 2 decimal places.
3. Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. Truncate your answer to 4 decimal places. 
4. Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. Round your answer to 4 decimal places.  
5. Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.
   a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).  
   b happens to equal the minimum value in Western Longitude (LONG_W in STATION).  
   c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).  
   d happens to equal the maximum value in Western Longitude (LONG_W in STATION).  
   Query the Manhattan Distance between points P1 and P2 and round it to a scale of  decimal places.     
6. We define an employee's total earnings to be their monthly salary x months worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.
7. Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
8. Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.