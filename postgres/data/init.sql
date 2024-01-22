-- Создание таблицы
CREATE TABLE my_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

-- Загрузка данных из CSV-файла
COPY my_table(id, name, age) FROM '/docker-entrypoint-initdb.d/my_dataset.csv' DELIMITER ',' CSV HEADER;
