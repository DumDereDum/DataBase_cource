# Функции

## Синтаксис

```SQL
CREATE [ OR REPLACE ] FUNCTION function_name ( [ parameter_name parameter_type [, ...] ] )
RETURNS return_type
AS $$
DECLARE
   -- объявление переменных
BEGIN
   -- тело функции (логика)
END;
$$ LANGUAGE plpgsql;
```

* function_name: имя функции.
* parameter_name parameter_type: список параметров функции, включая их имена и типы данных.
* return_type: тип данных, который функция возвращает.
* DECLARE: блок, в котором объявляются переменные, используемые в теле функции.
* BEGIN и END: блок, содержащий тело функции, где располагается основная логика функции.

Возвращаемое значение:

* RETURNS return_type: указывает тип данных, который функция вернет после выполнения.

Язык функции:
* LANGUAGE plpgsql: указывает на использование языка PL/pgSQL. PostgreSQL также поддерживает другие языки программирования для написания функций, такие как PL/Python, PL/Perl, PL/Java и др.

Параметры функции:
* Параметры функции указываются в круглых скобках после имени функции. Они могут быть использованы в теле функции для выполнения операций.

Объявление переменных:
* В блоке DECLARE объявляются переменные, которые будут использоваться в теле функции.

Тело функции:
* Основная логика функции располагается между блоками BEGIN и END.

## Примеры

### Пример 1

```SQL
CREATE OR REPLACE FUNCTION add_numbers(a INT, b INT) RETURNS INT AS $$
DECLARE
    sum INT;
BEGIN
    sum := a + b;
    RETURN sum;
END;
$$ LANGUAGE plpgsql;
```
```
SELECT add_numbers(5, 3); -- Вернет 8
```

### Пример 2

```SQL
CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    sale_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO sales (product_name, sale_date, amount) VALUES
    ('Product A', '2024-02-20', 100.50),
    ('Product B', '2024-02-20', 200.75),
    ('Product A', '2024-02-21', 150.25),
    ('Product C', '2024-02-21', 300.00);
```

```SQL
CREATE OR REPLACE FUNCTION total_sales(start_date DATE, end_date DATE) RETURNS DECIMAL AS $$
DECLARE
    total_amount DECIMAL := 0.0;
    sale_record RECORD;
BEGIN
    FOR sale_record IN
        SELECT amount FROM sales
        WHERE sale_date BETWEEN start_date AND end_date
    LOOP
        total_amount := total_amount + sale_record.amount;
    END LOOP;

    RETURN total_amount;
END;
$$ LANGUAGE plpgsql;
```

```SQL
SELECT total_sales('2024-02-20', '2024-02-21');
```

В этом примере мы создали таблицу sales, которая хранит информацию о продажах. Затем мы написали функцию total_sales, которая принимает начальную и конечную даты, и возвращает общую сумму продаж за указанный период. В функции мы использовали внутреннюю переменную total_amount, чтобы хранить общую сумму продаж. После этого мы применили функцию к таблице sales для вычисления общей суммы продаж за период с 20 февраля 2024 года по 21 февраля 2024 года.

В предложенном примере мы не применяли функцию к таблице напрямую. Функция total_sales работает с данными из таблицы sales, но она сама по себе не применяется к таблице. Вместо этого, она выполняет запрос к таблице sales внутри своего тела, используя конструкцию SELECT ... FROM sales WHERE ....

### Пример 3

```SQL
CREATE TABLE numbers_table_1 (
    id SERIAL PRIMARY KEY,
    number_value INT
);
INSERT INTO numbers_table_1 (number_value) VALUES (10), (20), (30), (40), (50);

CREATE TABLE numbers_table_2 (
    id SERIAL PRIMARY KEY,
    number_value INT
);
INSERT INTO numbers_table_2 (number_value) VALUES (5), (15), (25), (35), (45);
```

```SQL
CREATE OR REPLACE FUNCTION calculate_sum(table_name TEXT, column_name TEXT) RETURNS INT AS $$
DECLARE
    total_sum INT := 0;
    row_record RECORD;
BEGIN
    FOR row_record IN EXECUTE 'SELECT ' || column_name || ' FROM ' || table_name LOOP
        total_sum := total_sum + row_record.number_value;
    END LOOP;

    RETURN total_sum;
END;
$$ LANGUAGE plpgsql;
```

```SQL
-- Применение к первой таблице
SELECT calculate_sum('numbers_table_1', 'number_value');

-- Применение ко второй таблице
SELECT calculate_sum('numbers_table_2', 'number_value');
```

Давайте разберем эту функцию по шагам:

1. CREATE OR REPLACE FUNCTION:
Оператор создания новой функции или обновления существующей.

2. calculate_sum:
Имя функции.

3. table_name TEXT, column_name TEXT:
Параметры функции: table_name - имя таблицы, column_name - имя столбца, сумму значений которого мы хотим вычислить.

4. RETURNS INT:
Указывает, что функция возвращает целое число (сумму чисел).

5. AS \$$:
Начало тела функции, при этом $$ - это обозначение начала и конца многострочной строки.

6. DECLARE:
Оператор для объявления переменных внутри блока.

7. total_sum INT := 0:
Объявление переменной total_sum, которая будет хранить общую сумму чисел. Начальное значение устанавливается равным 0.

8. row_record RECORD:
Объявление переменной row_record типа RECORD, которая будет хранить записи из таблицы.

9. BEGIN:
Начало блока кода функции.

10. FOR row_record IN EXECUTE 'SELECT ' || column_name || ' FROM ' || table_name LOOP:
Цикл, в котором выполняется запрос к таблице, выбирается указанный столбец (column_name) из указанной таблицы (table_name), и каждая запись последовательно обрабатывается внутри цикла.

11. total_sum := total_sum + row_record.number_value:
Добавляем значение из текущей записи к общей сумме.

12. END LOOP:
Завершение цикла.

13. RETURN total_sum:
Возврат общей суммы чисел.

14. END;:
Конец блока кода функции.

15. \$$ LANGUAGE plpgsql;:
Определение языка функции (PL/pgSQL).

Эта функция динамически выполняет запрос к таблице, получает данные из указанного столбца и вычисляет сумму чисел в этом столбце. Она может использоваться для любой таблицы и любого столбца, что делает ее универсальной для анализа данных в PostgreSQL.