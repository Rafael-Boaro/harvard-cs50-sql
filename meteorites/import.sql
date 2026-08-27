CREATE TABLE meteorites_temp (
    name TEXT,
    id INTEGER,
    nametype TEXT,
    class TEXT,
    mass REAL,
    discovery TEXT,
    year INTEGER,
    lat REAL,
    long REAL
);
.mode csv
.import meteorites.csv meteorites_temp

DELETE FROM meteorites_temp WHERE name = 'name';

UPDATE meteorites_temp SET mass = NULL WHERE mass = '';
UPDATE meteorites_temp SET year = NULL WHERE year = '';
UPDATE meteorites_temp SET lat = NULL WHERE lat = '';
UPDATE meteorites_temp SET long = NULL WHERE long = '';

UPDATE meteorites_temp SET mass = ROUND(mass, 2) WHERE mass IS NOT NULL;
UPDATE meteorites_temp SET lat = ROUND(lat, 2) WHERE lat IS NOT NULL;
UPDATE meteorites_temp SET long = ROUND(long, 2) WHERE long IS NOT NULL;

DELETE FROM meteorites_temp WHERE nametype = 'Relict';

CREATE TABLE meteorites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    class TEXT,
    mass REAL,
    discovery TEXT,
    year INTEGER,
    lat REAL,
    long REAL
);

INSERT INTO meteorites (name, class, mass, discovery, year, lat, long)
SELECT name, class, mass, discovery, year, lat, long
FROM meteorites_temp
ORDER BY year ASC, name ASC;

DROP TABLE meteorites_temp;
