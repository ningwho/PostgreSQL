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

CREATE TABLE artist(
  id serial PRIMARY KEY,
  name varchar
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
	duration desc
limit 1;

--other option
select
	song.name,
	duration
from
	track
inner join
	song on song.id = track.song_id -- side with the many will be on the left.
order by
	duration desc
limit 1;

--4.What are the albums released in the 60s? 70s? 80s? 90s?
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

---What is the title of each artist's latest album? *Hint: try using a combination of order by, a subselect, and a distinct on*

select
	distinct on (artist.id)
	album.name,
	album.release_date

from
	album,
	artist
where
	album.artist_id = artist.id

order by
	artist.id,
	album.release_date

--List all albums along with its total duration based on summing the duration of its tracks.
select
	album.name,
	sum(track.duration)
from
	album,
	track
where
	track.album_id = album.id
group by
	album.name;

--What is the album with the longest duration?
select
	album.name,
	sum(track.duration)
from
	album,
	track
where
	track.album_id = album.id
group by
	album.name limit 1

--Who are the 5 most prolific artists based on the number of albums they have recorded?
select
	artist.name,
	count(album.id)
from
	album,
	artist
where
	album.artist_id = artist.id
group by
	artist.name
order by
	count(album.id) desc limit 5;
-- alt
select
  artist.name,
  count(album.title)
from
  artist
left outer join
  album on artist.id = album.artist_id
group by
  artist.id
order by
  count desc
limit
  5;

--What are all the tracks a given artist has recorded?
select
	song.name
from
	track,
	album,
	artist,
	song
where
	track.song_id = song.id
  and track.album_id = album.id
  and album.artist_id = artist.id
  and artist.name = 	'Whitney Houston';


--What are the top 5 most often recorded songs?
select
	song.name,
	count(track.song_id) as song_count
from
	track,
	song
where
	track.song_id = song.id
group by
	song.name order by song_count desc limit 5;

--Who are the top 5 song writers whose songs have been most often recorded?

select
songwriter.name,
count(song.songwriter_id) as songwriter_count
from
song,
songwriter
where
song.songwriter_id = songwriter.id
group by
songwriter.name order by songwriter_count desc limit 5;

--Who is the most prolific song writer based on the number of songs he has written?

select
  songwriter.*,
	count(song.id) as songs_written
from
	song,
	songwriter
where
	song.songwriter_id = songwriter.id
group by
	songwriter.id

order by
 	songs_written desc limit 1;

--What songs has a given artist recorded?
select
	artist.id,
	artist.name,
	song.id,
	song.name
from
	song,
	track,
	album,
	artist
where
	album.artist_id = artist.id and track.album_id = album.id and track.song_id = song.id and artist.name = 'Michael Jackson';

--Who are the song writers whose songs a given artist has recorded?
select
	songwriter.id,
	songwriter.name as songwriter_name,
	song.id,
	song.name,
	artist.id,
	artist.name as artist_name

from
	song,
	track,
	album,
	artist,
	songwriter
where
	song.songwriter_id = songwriter.id and album.artist_id = artist.id and track.album_id = album.id and 			track.song_id = song.id and artist.id = 1;

--Who are the artists who have recorded a given song writer's songs?
select
	songwriter.id,
	songwriter.name as songwriter_name,
	song.id,
	song.name,
	artist.id,
	artist.name as artist_name

from
	song,
	track,
	album,
	artist,
	songwriter
where
	song.songwriter_id = songwriter.id and album.artist_id = artist.id and track.album_id = album.id and 			track.song_id = song.id and song.id = 4;

  --
select
  distinct(songwriter.name)
from
  artist
inner join
  album on album.artist_id = artist.id
inner join
  track on track.album_id = album.id
inner join
  song on track.song_id = song.id
inner join
  songwriter on song.songwriter_id = songwriter.id
where artist.name = 'Michael Jackson';
