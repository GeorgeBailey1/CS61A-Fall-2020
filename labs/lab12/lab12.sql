.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet 
  FROM students 
  WHERE color = "blue" AND pet = "dog";

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song 
  FROM students 
  WHERE color = "blue" AND pet = "dog";


CREATE TABLE smallest_int AS
  SELECT time, smallest                                                      -- Standard format to select from a table.
  FROM students 
  WHERE smallest > 2 
  ORDER BY smallest 
  LIMIT 20;


CREATE TABLE matchmaker AS
  SELECT a.pet, a.song, a.color, b.color                                    -- Tables may have overlapping column names, and so we need a method for disambiguating column names by table.  
  FROM students AS a, students AS b                                         -- A table may also be joined with itself, as in this case, so we need a method for disambiguating tables.
  WHERE a.pet = b.pet AND a.song = b.song AND a.time < b.time;              -- To do so, SQL allows us to give aliases to tables within a from clause 
                                                                            -- using the keyword as and to refer to a column within a particular table using a dot expression.





CREATE TABLE sevens AS
  SELECT a.seven
  FROM students AS a, numbers AS b
  WHERE a.number = 7 AND b.'7' = 'True' AND a.time = b.time;

