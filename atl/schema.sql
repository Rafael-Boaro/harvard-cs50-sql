CREATE TABLE passengers (
    id INTEGER,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    age INTEGER NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE airlines (
    id INTEGER,
    name TEXT NOT NULL UNIQUE,
    PRIMARY KEY(id)
);
CREATE TABLE concourses (
    airline_id INTEGER,
    concourse TEXT NOT NULL,
    FOREIGN KEY(airline_id) REFERENCES airlines(id)
);
CREATE TABLE flights (
    id INTEGER,
    flight_number INTEGER NOT NULL,
    airline_id INTEGER,
    departing_from TEXT NOT NULL,
    heading_to TEXT NOT NULL,
    expected_departure DATETIME NOT NULL,
    expected_arrival DATETIME NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(airline_id) REFERENCES airlines(id)
);
CREATE TABLE check_ins (
    id INTEGER,
    passenger_id INTEGER,
    flight_id INTEGER,
    check_in_time DATETIME NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(passenger_id) REFERENCES passengers(id),
    FOREIGN KEY(flight_id) REFERENCES flights(id)
);
