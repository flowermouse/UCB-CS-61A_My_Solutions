CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS  
  SELECT parents.child FROM parents, dogs
    WHERE parents.parent = dogs.name
    ORDER BY dogs.height DESC;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size FROM dogs, sizes
    WHERE height > min AND height <= max;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child AS A, b.child AS B, ad.height as AH, bd.height as BH 
    FROM parents as a, parents as b, dogs as ad, dogs as bd
      WHERE a.parent = b.parent AND a.child < b.child
      AND a.child = ad.name AND b.child = bd.name;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT 'The two siblings, ' || A || ' and ' || B || ', have the same size: ' || size
    FROM siblings, sizes
      WHERE AH > min AND AH <= max AND BH > min AND BH <= max;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT dogs.fur, MAX(height) - MIN(height) FROM dogs 
    JOIN (SELECT fur, AVG(height) AS average FROM dogs GROUP BY fur) AS helper ON dogs.fur = helper.fur
    GROUP BY dogs.fur
      HAVING MIN(height) >= 0.7 * average AND MAX(height) <= 1.3 * average;