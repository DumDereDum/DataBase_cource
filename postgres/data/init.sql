-- Создание таблицы
CREATE TABLE students (
    school VARCHAR(2),
    sex VARCHAR(1),
    age INTEGER,
    address VARCHAR(1),
    famsize VARCHAR(3),
    Pstatus VARCHAR(1),
    Medu INTEGER,
    Fedu INTEGER,
    Mjob VARCHAR(20),
    Fjob VARCHAR(20),
    reason VARCHAR(10),
    guardian VARCHAR(6),
    traveltime INTEGER,
    studytime INTEGER,
    failures INTEGER,
    schoolsup VARCHAR(3),
    famsup VARCHAR(3),
    paid VARCHAR(3),
    activities VARCHAR(3),
    nursery VARCHAR(3),
    higher VARCHAR(3),
    internet VARCHAR(3),
    romantic VARCHAR(3),
    famrel INTEGER,
    freetime INTEGER,
    goout INTEGER,
    Dalc INTEGER,
    Walc INTEGER,
    health INTEGER,
    absences INTEGER,
    G1 INTEGER,
    G2 INTEGER,
    G3 INTEGER
);

-- Загрузка данных из CSV-файла
COPY students FROM '/docker-entrypoint-initdb.d/student-dataset.csv' DELIMITER ',' CSV HEADER;
