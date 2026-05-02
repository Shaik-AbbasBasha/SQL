CREATE DATABASE Allcodes;

USE Allcodes;

CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    address VARCHAR(100)
);
 
 
INSERT INTO student (id, name, age, address)
VALUES 
(1, 'Abbas', 23, 'Vizag'),
(2, 'pavan', 22, 'Mcl'),
(3,'Ganesh',21,'Pdrl'),
(4,'Vivek',20,'Vizag'),
(5,'rakesh',24,'guntur'),
(6,'sai',25,'nrt');


#selection types
SELECT * FROM student;
SELECT * FROM student WHERE id = 1;
SELECT * FROM student WHERE name = 'Abbas';
SELECT * FROM student WHERE age = 22;
SELECT * FROM student WHERE address = 'Vizag';


#update
UPDATE student SET age = 21 WHERE id = 5;
SELECT * FROM student WHERE id = 5;


#delete
DELETE FROM student WHERE id = 6;
SELECT * FROM student WHERE id = 6;


#Truncate
TRUNCATE TABLE student;


#Drop database
DROP DATABASE college;


#Drop table
DROP TABLE student;


#Drop column
ALTER TABLE student DROP COLUMN marks;



#Where Clause
#Arithmetic Operators
SELECT 10 + 5;
SELECT 10 - 5;
SELECT 10 * 5;
SELECT 10 / 5;
SELECT 10 % 3;

#Comparison Operators
SELECT * FROM student WHERE age = 22;
SELECT * FROM student WHERE age != 22;
SELECT * FROM student WHERE age > 20;
SELECT * FROM student WHERE age >= 21;
SELECT * FROM student WHERE age < 25;
SELECT * FROM student WHERE age <= 22;


#Logical Operators
SELECT * FROM student WHERE age > 20 AND address = 'Guntur';            #All conditions must be TRUE
SELECT * FROM student WHERE address = 'Guntur' OR address = 'NRT';      #Any one condition can be TRUE
SELECT * FROM student WHERE NOT age = 22;                               #Reverses the condition
SELECT * FROM student WHERE age BETWEEN 20 AND 25;
SELECT * FROM student WHERE address IN ('Guntur', 'NRT', 'Vizag');


#Limit Clause
SELECT * FROM student LIMIT 5;

#Order By Clause
SELECT * FROM student ORDER BY name ASC;


#Aggregate Functions
SELECT COUNT(*) FROM student;    #Counts total students
SELECT MAX(age) FROM student;    #Finds highest value
SELECT MIN(age) FROM student;    #Finds lowest value
SELECT SUM(age) FROM student;    #Adds all values
SELECT AVG(age) FROM student;    #Finds average value


#Group By Clause
SELECT name, address, COUNT(*) 
FROM student
GROUP BY name, address;

#Having Clause
SELECT address, COUNT(*) 
FROM student
GROUP BY address
HAVING COUNT(*) > 1;


#WHERE and  GROUP BY and HAVING
SELECT address, COUNT(*) 
FROM student
WHERE age > 18
GROUP BY address
HAVING COUNT(*) = 2;


#Table related Queries
ALTER TABLE student ADD COLUMN marks INT;
ALTER TABLE student DROP COLUMN marks;
ALTER TABLE student RENAME TO students;
ALTER TABLE student MODIFY age BIGINT;
ALTER TABLE student CHANGE COLUMN name full_name VARCHAR(100);




#joins 
CREATE TABLE stud (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);
INSERT INTO stud (id, name) VALUES
(1, 'Abbas'),
(2, 'Ravi'),
(3, 'Sai'),
(4, 'Rakesh');
SELECT * FROM stud;



CREATE TABLE course (
    id INT,
    course_name VARCHAR(100)
);
INSERT INTO course (id, course_name) VALUES
(1, 'Java'),
(2, 'Python'),
(3, 'SQL'),
(4, 'Spring boot');
SELECT * FROM course;

# join operations on stud and course

#INNER JOIN       Only matching records
SELECT s.id, s.name, c.course_name
FROM stud s
INNER JOIN course c
ON s.id = c.id;

#LEFT JOIN        All students + matching courses
SELECT s.id, s.name, c.course_name
FROM stud s
LEFT JOIN course c
ON s.id = c.id;

#RIGHT JOIN       All courses + matching students
SELECT s.id, s.name, c.course_name
FROM stud s
RIGHT JOIN course c
ON s.id = c.id;


#FULL JOIN        All records from both tables
SELECT s.id, s.name, c.course_name
FROM stud s
LEFT JOIN course c
ON s.id = c.id
UNION
SELECT s.id, s.name, c.course_name
FROM stud s
RIGHT JOIN course c
ON s.id = c.id;


#Self Join        Query Find student and their manager
SELECT s1.name AS student, s2.name AS manager
FROM stud s1
LEFT JOIN stud s2
ON s1.manager_id = s2.id;

#CROSS JOIN      Gives all possible combinations
SELECT s.id, s.name, c.course_name
FROM student s
CROSS JOIN course c;

#NATURAL JOIN    Automatically joins tables using same column name
SELECT *
FROM student
NATURAL JOIN course;



#number functions
SELECT ABS(-5);  -- 5              #ABS() Removes minus sign
SELECT SQRT(16);  -- 4             #SQRT() Square root
SELECT POWER(2,3);  -- 8           #POWER() Multiply number by itself (power)
SELECT MOD(10,3);  -- 1            #MOD() Gives remainder
SELECT CEIL(4.2);  -- 5            #CEIL() Rounds UP
SELECT FLOOR(4.9);  -- 4           #FLOOR() Rounds DOWN
SELECT ROUND(4.6);  -- 5           #ROUND() Normal rounding
SELECT TRUNCATE(4.9,0);  -- 4      #TRUNC() Cuts decimal (no rounding)
SELECT GREATEST(10,20,5);  -- 20   #GREATEST() Biggest number
SELECT LEAST(10,20,5);  -- 5       #LEAST() Smallest number



#Date functions
SELECT NOW();                                         	#current date + time
SELECT CURDATE();										#current date only
SELECT CURTIME();										#current time only
SELECT DATE(NOW());										#extracts only date from datetime
SELECT YEAR('2026-04-18');								#gives year: 2026
SELECT MONTH('2026-04-18');								#gives month: 4
SELECT DAY('2026-04-18');								#gives day: 18
SELECT DATEDIFF('2026-04-18', '2026-04-10');			#difference in days: 8
SELECT DATE_ADD('2026-04-18', INTERVAL 5 DAY);			#adds 5 days → 2026-04-23
SELECT DATE_SUB('2026-04-18', INTERVAL 5 DAY);			#subtracts 5 days → 2026-04-13
SELECT DATE_ADD('2026-04-18', INTERVAL 2 MONTH);		#adds 2 months → 2026-06-18
SELECT MONTHS_BETWEEN('2026-06-18', '2026-04-18');		#months difference → 2 (Oracle only)
SELECT DATE_ADD('2026-04-18', INTERVAL 1 DAY);			#next day → 2026-04-19
SELECT LAST_DAY('2026-04-18');							#last date of month → 2026-04-30



#character functions
SELECT UPPER('hello');                 -- converts to uppercase: HELLO
SELECT LOWER('HELLO');                 -- converts to lowercase: hello
SELECT INITCAP('hello world');         -- first letter capital: Hello World
SELECT LENGTH('Hello');                -- counts characters: 5
SELECT CONCAT('Hello', 'World');       -- joins strings: HelloWorld
SELECT SUBSTR('HelloWorld', 1, 5);     -- takes part of string: Hello
SELECT INSTR('HelloWorld', 'W');       -- finds position of W: 6
SELECT REPLACE('Hello World', 'World', 'SQL'); -- replaces text: Hello SQL
SELECT TRIM('   Hello   ');            -- removes spaces both sides: Hello
SELECT LTRIM('   Hello');              -- removes left spaces: Hello
SELECT RTRIM('Hello   ');              -- removes right spaces: Hello
SELECT LPAD('Hello', 10, '*');         -- adds * on left: *****Hello
SELECT RPAD('Hello', 10, '*');         -- adds * on right: Hello*****




#TCL = Transaction Control Language
START TRANSACTION;
INSERT INTO student VALUES (1, 'Abbas');
SAVEPOINT s1;
INSERT INTO student VALUES (2, 'Ravi');
SAVEPOINT s2;
INSERT INTO student VALUES (3, 'Sai');
ROLLBACK TO s2;
ROLLBACK TO s1;
COMMIT;




#DCL (Data Control Language) commands.
GRANT SELECT ON student TO user1;       -- Give permission to read table
SELECT * FROM student;                  -- user1 can read data
REVOKE SELECT ON student FROM user1;    -- Remove permission to read table
SELECT * FROM student;                  -- user1 cannot read data (access denied)





#View

CREATE VIEW stud_v1 AS             -- SIMPLE VIEW (based on one table)
SELECT id, name FROM student;      -- shows selected columns from student table

CREATE VIEW course_v2 AS           -- COMPLEX VIEW (based on multiple tables)
SELECT s.id, s.name, c.course_name
FROM student s
JOIN course c ON s.id = c.id;      -- combines data from student + course tables

-- DROP VIEW
DROP VIEW student_view;
DROP VIEW student_course_view;





#subquery
-- SELECT in subquery (single value)
SELECT name,
       (SELECT MAX(age) FROM student) AS max_age
FROM student;


-- FROM subquery (derived table)
SELECT t.name, t.age
FROM (SELECT name, age FROM student WHERE age > 20) t;


-- WHERE subquery (most common use)
SELECT name
FROM student
WHERE age = (SELECT MAX(age) FROM student);

SELECT name
FROM student
WHERE age IN (SELECT age FROM student WHERE age > 20);

SELECT name
FROM student s
WHERE age > (SELECT AVG(age) FROM student WHERE address = s.address);



