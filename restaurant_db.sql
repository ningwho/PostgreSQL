CREATE TABLE restaurant(
  id serial PRIMARY KEY,
  name varchar,
  distance integer,
  stars integer,
  category varchar,
  favorite_dish varchar,
  does_takeout boolean,
  last_time_ate_there date
);

-- or you can write insert into restaurant values(default, )
-- or insert into restaurant
--(name, distance, stars, category, favorite_dish, does_takeout, last_time_ate_there)
--values
--('luvies etc')
--pg_dump db

delete from restaurant;
insert into restaurant values
  (default,'Luvies', 1, 4, 'BBQ','bbq pork', TRUE, '2017-02-22'),
  (default,'NaanStop', 2, 3, 'Indian food', 'tiki masala', TRUE, '2017-02-08'),
  (default,'Chipotle', 5, 5, 'Mexican', 'burrito bowl', FALSE, '2017-02-23');


--where clause is like a filter. values are like array
--echo prints out the question
\! echo "1.The names of the restaurants that you gave a 5 stars to"
  -- 1.The names of the restaurants that you gave a 5 stars to
  select * from restaurant where stars = 5;
  -- 2. The favorite dishes of all 5-star restaurants
  select favorite_dish from restaurant where stars = 5;
  -- 3.The the id of a restaurant by a specific restaurant name, say 'NaanStop'
  select id from restaurant where name = 'NaanStop';
  -- 4.restaurants in the category of 'BBQ'
  select name from restaurant where category = 'BBQ';
  -- 5.restaurants that do take out
  select name from restaurant where does_takeout = TRUE;
  -- 6.restaurants that do take out and is in the category of 'BBQ'
  select name from restaurant where does_takeout = TRUE and category = 'BBQ';
  -- 7.restaurants within 2 miles
  select name from restaurant where distance < 2;
  -- 8.restaurants you haven't ate at in the last week
  select name from restaurant where last_time_ate_there < '2017-3-20';
  --can also write it as select name from restaurant where last_time_ate_there between '2010-01-01' and '2017-3-20';
  -- 9. restaurants you haven't ate at in the last week and has 5 stars
  select name from restaurant where last_time_ate_there < '2017-3-20' and stars = 5;
