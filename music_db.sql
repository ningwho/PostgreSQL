CREATE TABLE songwriter (
  id serial PRIMARY KEY,
  name varchar
);

CREATE TABLE song (
  id serial PRIMARY KEY,
  name varchar,
  songwriter_id integer REFERENCES songwriter(id)
);

CREATE TABLE album (
  id serial PRIMARY KEY,
  name varchar,
  release_date date,
  artist_id integer REFERENCES artist(id)
);

CREATE TABLE track (
  id serial PRIMARY KEY,
  song_id integer REFERENCES song(id),
  album_id integer REFERENCES album(id),
  duration time
);


--1. What are tracks for a given album?
select
 song.name
from
 song
left outer join
	track on track.song_id = song.id
left outer join
	album on album.id = track.id
where
	album.name = 'Spice';
--What are the albums produced by a given artist?
select
	album.name

from
	artist

inner join
	album on album.artist_id = artist.id
where
	artist.name = 'Michael Jackson';

--What is the track with the longest duration?
select
	song.name,
	duration
from
	track,
	song
where
	track.song_id = song.id
order by
	duration desc limit 1;

--What are the albums released in the 60s? 70s? 80s? 90s?
select
	album.name,
	album.release_date
from
	album
where
	release_date < '1980-01-01';

--How many albums did a given artist produce in the 90s?
select
	count(ninties)
from
	(select
		album.name as album_name,
		album.release_date,
		artist.name as artist_name
	from
		album
	inner join
		artist on album.artist_id = artist.id

	where
		release_date between '1990-01-01' and '2000-01-01') as ninties
where
	ninties.artist_name = 'Spice Girls';




CREATE TABLE artist(
  id serial PRIMARY KEY,
  name varchar
);
