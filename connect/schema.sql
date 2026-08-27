CREATE TABLE users (
    id INTEGER,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE schools (
    id INTEGER,
    name TEXT NOT NULL,
    type TEXT NOT NULL,
    location TEXT NOT NULL,
    year_founded INTEGER NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE companies (
    id INTEGER,
    name TEXT NOT NULL,
    industry TEXT NOT NULL,
    location TEXT NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE user_connections (
    user1_id INTEGER,
    user2_id INTEGER,
    FOREIGN KEY(user1_id) REFERENCES users(id),
    FOREIGN KEY(user2_id) REFERENCES users(id)
);
CREATE TABLE school_connections (
    user_id INTEGER,
    school_id INTEGER,
    start_date DATE NOT NULL,
    end_date DATE,
    degree TEXT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(school_id) REFERENCES schools(id)
);
CREATE TABLE company_connections (
    user_id INTEGER,
    company_id INTEGER,
    start_date DATE NOT NULL,
    end_date DATE,
    title TEXT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(company_id) REFERENCES companies(id)
);
