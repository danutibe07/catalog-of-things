------ ----Create Database -------------
CREATE TABLE my_catalog;

--------- Create book table ----------------
CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  publisher VARCHAR,
  cover_state VARCHAR,
  genre_id INT NULL REFERENCES genres(id), 
  author_id INT NULL REFERENCES authors(id),
  label_id INT NULL REFERENCES labels(id),
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL
);

----------- Create labels table ------------------
CREATE TABLE labels (
  id SERIAL PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  color VARCHAR(50) NOT NULL
);

----------- CREATE Genres Table ---------------------

CREATE TABLE genres (
  genre_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  items VARCHAR(255) NOT NULL
);

---------- Create music albums Table -----------------

CREATE TABLE music_albums (
  id SERIAL PRIMARY KEY,
  publish_date DATE NOT NULL DEFAULT DATE,
  on_spotify BOOLEAN,
  archived BOOLEAN,
  genre_id INT,
  label_id INT,
  author_id INT,
  CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
  CONSTRAINT fk_label FOREIGN KEY (label_id) REFERENCES label(label_id),
  CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors(author_id),
  PRIMARY KEY(id)
);

----------- Create games table ------------------
CREATE TABLE game (
  id SERIAL PRIMARY KEY,
  multiplayer BOOLEAN,
  last_played_at DATE,
  genre_id INT,
  label_id INT,
  publish_date DATE,
  author_id INT,
  CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
  CONSTRAINT fk_label FOREIGN KEY (label_id) REFERENCES label(label_id)
  CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors(author_id)
  PRIMARY KEY(id)
);

----------- Create author table ------------------
CREATE TABLE author (
    id SERIAL PRIMARY KEY,
    first_name  VARCHAR(100),
    last_name   VARCHAR(100)
);