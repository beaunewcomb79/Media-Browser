DROP DATABASE IF EXISTS media;
CREATE DATABASE media;
use media;

CREATE TABLE titles(
    title_id        SERIAL PRIMARY KEY,
    imdb_id         VARCHAR(9) NOT NULL,
    title           VARCHAR(128) NOT NULL,
    year            VARCHAR(4) NOT NULL,
    kind            VARCHAR(16),
    ratio           VARCHAR(32),
    rating          VARCHAR(192),
    cover           VARCHAR(256),
    story           TEXT,
    tagline         TEXT,
    UNIQUE KEY imdb_id (imdb_id)
);
CREATE INDEX titles_idx_title ON titles( title );
CREATE INDEX titles_idx_year ON titles( year );

CREATE TABLE files(
    file_id         SERIAL PRIMARY KEY,
    file_name       VARCHAR(128) NOT NULL,
    title_id        bigint(20) unsigned NOT NULL,
    UNIQUE KEY file_name (file_name)
);
CREATE INDEX files_idx_title_id ON files( title_id );

CREATE TABLE genres(
    genre_id        SERIAL PRIMARY KEY,
    genre_name      VARCHAR(16) NOT NULL,
    UNIQUE KEY genre_name (genre_name)
);
CREATE INDEX genres_idx_genre_name ON genres( genre_name );

CREATE TABLE genre_xref(
    genre_xref_id   SERIAL PRIMARY KEY,
    genre_id        bigint(20) unsigned NOT NULL,
    title_id        bigint(20) unsigned NOT NULL,
    UNIQUE KEY title_genre (title_id,genre_id)
);
CREATE INDEX genre_xref_idx_title_id ON genre_xref( title_id );
CREATE INDEX genre_xref_idx_genre_id ON genre_xref( genre_id );

CREATE TABLE people(
    person_id       SERIAL PRIMARY KEY,
    imdb_id         VARCHAR(9) NOT NULL,
    person_name     VARCHAR(64) NOT NULL,
    UNIQUE KEY imdb_id (imdb_id)
);
CREATE INDEX people_idx_person_name ON people( person_name );

CREATE TABLE roles(
    role_id         SERIAL PRIMARY KEY,
    role_name       VARCHAR(16) NOT NULL,
    UNIQUE KEY role_name (role_name)
);
INSERT INTO roles(role_name) values('director');
INSERT INTO roles(role_name) values('writer');

CREATE TABLE role_xref(
    role_xref_id    SERIAL PRIMARY KEY,
    role_id         bigint(20) unsigned NOT NULL,
    person_id       bigint(20) unsigned NOT NULL,
    title_id        bigint(20) unsigned NOT NULL,
    UNIQUE KEY role_person_title (role_id, person_id, title_id)
);
CREATE INDEX role_xref_idx_title_id ON role_xref( title_id );
CREATE INDEX role_xref_idx_person_id ON role_xref( person_id );
CREATE INDEX role_xref_idx_role_id ON role_xref( role_id );
CREATE INDEX role_xref_idx_title_role_id ON role_xref( title_id, role_id );

CREATE TABLE durations(
    duation_id      SERIAL PRIMARY KEY,
    duration        VARCHAR(32) NOT NULL,
    title_id        bigint(20) unsigned NOT NULL,
    UNIQUE KEY title_duration (title_id,duration)
);
CREATE INDEX durations_idx_title_id ON durations( title_id );
