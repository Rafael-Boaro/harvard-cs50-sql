CREATE TABLE cipher_keys (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sentence_id INTEGER,
    start_char INTEGER,
    length INTEGER
);

INSERT INTO cipher_keys (sentence_id, start_char, length)
VALUES
    (14, 98, 4),
    (114, 3, 5),
    (618, 72, 9),
    (630, 7, 3),
    (932, 12, 5),
    (2230, 50, 7),
    (2346, 44, 10),
    (3041, 14, 5);

CREATE VIEW message AS
SELECT substr(sentences.sentence, cipher_keys.start_char, cipher_keys.length) AS phrase
FROM cipher_keys
JOIN sentences ON cipher_keys.sentence_id = sentences.id
ORDER BY cipher_keys.id ASC;
