
CREATE TABLE accounts (
    user_id     serial PRIMARY KEY,
    username    VARCHAR ( 50 ) UNIQUE NOT NULL,
    password    VARCHAR ( 50 ) NOT NULL,
    email       VARCHAR ( 50 ) UNIQUE NOT NULL,
    created_on  TIMESTAMP NOT NULL,
    last_login  TIMESTAMP
);

INSERT INTO accounts (username, password, email, created_on)
VALUES ('user', 'pass', 'test@email.com', CURRENT_TIMESTAMP);
