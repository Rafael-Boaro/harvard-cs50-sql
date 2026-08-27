CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(128) NOT NULL
);
CREATE TABLE schools (
   id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(150) NOT NULL
   type ENUM('Primary','Secondary','Higher Education') NOT NULL,
   location VARCHAR(150) NOT NULL,
   year_founded YEAR NOT NULL
);
CREATE TABLE companies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    industry ENUM('Technology','Education','Business') NOT NULL,
    location VARCHAR(150) NOT NULL
);
CREATE TABLE user_connections (
    user_id_1 INT,
    user_id_2 INT,
    PRIMARY KEY (user_id_1, user_id_2)
    FOREIGN KEY (user_id_1) REFERENCES users(id),
    FOREIGN KEY (user_id_2) REFERENCES users(id)
);
CREATE TABLE school_connections (
    user_id INT,
    school_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    degree VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (school_id) REFERENCES schools(id)
);
CREATE TABLE company_connections (
    user_id INT,
    company_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    title VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (company_id) REFERENCES companies(id)
);
